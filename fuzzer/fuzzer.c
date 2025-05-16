// https://novafacing.github.io/practical-fuzzing/libfuzzer/kernel/windows/index.html
#include <stdio.h>
#include <windows.h>

// https://github.com/novafacing/HackSysExtremeVulnerableDriver/blob/master/Driver/HEVD/Windows/HackSysExtremeVulnerableDriver.h
#define HACKSYS_EVD_IOCTL_STACK_OVERFLOW \
	CTL_CODE(FILE_DEVICE_UNKNOWN, 0x800, METHOD_NEITHER, FILE_ANY_ACCESS)

const char g_devname[] = "\\\\.\\HackSysExtremeVulnerableDriver";
HANDLE g_device = INVALID_HANDLE_VALUE;
BOOL g_device_initialized = FALSE;

int LLVMFuzzerTestOneInput(const BYTE *data, size_t size)
{
	if (!g_device_initialized) {
		printf("Initializing device\n");

		if ((g_device = CreateFileA(
			     g_devname, GENERIC_READ | GENERIC_WRITE, 0, NULL,
			     OPEN_EXISTING, 0, NULL)) == INVALID_HANDLE_VALUE) {
			printf("Failed to initialize device\n");
			return -1;
		}
		printf("Initialized device\n");
		g_device_initialized = TRUE;
	}

	if (size > 2048) {
		printf("Overflowing buffer!\n");
	}

	DWORD size_returned = 0;

	BOOL is_ok = DeviceIoControl(g_device, HACKSYS_EVD_IOCTL_STACK_OVERFLOW,
				     (BYTE *)data, (DWORD)size,
				     NULL, //outBuffer -> None
				     0, //outBuffer size -> 0
				     &size_returned, NULL);

	if (!is_ok) {
		printf("Error in DeviceIoControl\n");
		return -1;
	}

	return 0;
}
