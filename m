From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 00/15] Add basic suspend-resume support for AM33XX
Date: Fri, 2 Nov 2012 18:02:31 +0530
Message-ID: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39660 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760789Ab2KBMeV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

This patch series adds support for suspend-resume on AM33XX.

AM33XX family has a Cortex-M3 (WKUP_M3) which assists the
MPU in DeepSleep0 entry and exit. WKUP_M3 takes care of the
clockdomain and powerdomain transitions based on targeted
intended low power state. MPU needs to load the appropriate
WKUP_M3 binary onto the WKUP_M3 memory space before it can
leverage any of the PM features.

The various low power modes and the overall s/w sequence is
 documented in section 8.1.4.3 of the AM335x TRM available
on the TI website[1].

DeepSleep0 mode offers the lowest power mode with limited
wakeup sources without a complete reboot and is mapped as
the suspend state in the kernel. In this state, MPU and PER
domains are turned off with the internal RAM held in retention
to facilitate resume process.

The IPC mechanism between MPU and WKUP_M3 uses a mailbox
sub-module and 8 IPC registers in the Control module. MPU
populates the IPC registers for the payload and uses the
assigned Mailbox for issuing an interrupt to WKUP_M3 which
then goes and checks the IPC registers for the payload.
WKUP_M3 has the ability to trigger on interrupt to MPU by
executing the "sev" instruction.

In the current implementation when the suspend process
is initiated MPU interrupts the WKUP_M3 to let about the
intent of entering DeepSleep0 and waits for an ACK. When
the ACK is received, MPU continues with its suspend process
to suspend all the drivers and then jumps to assembly code
in OCMC RAM to put the PLLs in bypass, put the external RAM
in self-refresh mode and then finally execute the WFI
instruction. The WFI instruction triggers another interrupt
to the WKUP_M3 which then continues wiht the power down
sequence wherein the clockdomain and powerdomain transition
takes place. As part of the sleep sequence, WKUP_M3 unmasks
the interrupt lines for the wakeup sources. When WKUP_M3
executes WFI, the hardware disables the main oscillator.

When a wakeup event occurs, WKUP_M3 starts the power-up
sequence by switching on the power domains and finally
enabling the clock to MPU. Since the MPU gets powered down
as part of the sleep sequence, in the resume path ROM code
starts executing. The ROM code detects a wakeup from sleep
and then jumps to the resume location in OCMC which was
populated in one of the IPC registers as part of the suspend
sequence.

The first patch adds an API in the OMAP mailbox code to
enable the MPU to clear the FIFO since WKUP_M3 does not
have any access to the mailbox module. Minimal support
for AM33XX family is added in the 2nd patch and the 3rd
patch changes the initcall level of the mailbox code since
the PM init happens very early in the boot process.

The fourth patch updates the reset API for AM33XX to reflect
the fact that there is a reset status bit to be checked.

The next four patches are update the AM33XX hwmod data
to register OCMCRAM, WKUP_M3 and fix up a couple of issues
related to TPTC and CPGMAC data.

The next patch gets rid of some header files included in
the AM33XX code and also adds the appropriate macro to ensure
that the files can be included in assembly code.

Some control module registers which are required in the assembly
code are added in the next patch.

The next two patches are related to the timer code. First the
clocksource and clockevent timers are interchanged to ensure that
have a free-running counter in suspend and then suspend-resume
support for the clockevent timers added.

The device tree data for AM33XX is updated to register the OCMC
and WKUP_M3 modules and then OMAP2 defconfig updated to include
mailbox support which is required by the PM code.

The last patch builds upon all the work done in the other
patches to implement suspend-resume functionality.

These patches apply on top the current linux-omap master branch
cc2b5d5 + the HWMOD patch for CPSW [3] and has been tested
on the AM335x EVM and the BeagleBone. Some of the patches will need
minor rework to address the changes to the header files
being done by Tony and the timer changes done by Jon Hunter.

With these dependencies met, the PM code uses the firmware interface
and expects the userspace to load the WKUP_M3 binary before the
suspend-resume functionality is made available. The binary file (and
the source-code for WKUP_M3) can be obtained from the HEAD of the
master branch at [2].

A sample usage of the suspend-resume process is shown below...
(the binary from [2] is renamed to binary_blob and is included in the
ramdisk used for booting)

[    0.000000] Booting Linux on physical CPU 0
...
[    1.873005] Power Management for AM33XX family
[    1.878365] Trying to load am335x-pm-firmware.bin
[    1.883264] ThumbEE CPU extension supported.
[    1.900231] clock: disabling unused clocks to save power
[    1.913804] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.924564] RAMDISK: gzip image found at block 0
[    2.397241] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.404341] Freeing init memory: 324K
mount: mounting none on /var/shm failed: No such file or directory
  ::
  :: Enabling hot-plug  : [SUCCESS]
  ::
  ::
   : Populating /dev    : [SUCCESS]
[SUCCESS]
  ::
  ::
  :: Setting PATH
  ::
   : syslogd            : [SUCCESS]
   : telnetd            : [SUCCESS]

Please press Enter to activate this console.
  ::
  :: Setting shell environment ...
  ::
   : Path
   : Aliases
   : Touch Screen
  ::
  :: Done
  ::
[root@arago /]# echo 1 > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/loading
[root@arago /]# cat binary_blob > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/data
[root@arago /]# echo 0 > ./sys/devices/ocp.2/wkup_m3.4/firmware/am335x-pm-firmware.bin/loading
[   28.770356] Copied the M3 firmware to UMEM
[   28.778178] omap_hwmod: wkup_m3: _wait_target_disable failed
[root@arago /]# echo mem > /sys/power/state
[   32.959753] PM: Syncing filesystems ... done.
[   32.988434] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   33.016120] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   33.047607] Suspending console(s) (use no_console_suspend to debug)
[   33.070420] PM: suspend of devices complete after 11.538 msecs
[   33.074095] PM: late suspend of devices complete after 3.651 msecs
[   33.079135] PM: noirq suspend of devices complete after 5.011 msecs
[   33.079196] Disabling non-boot CPUs ...
[   33.083923] GFX domain entered low power state
[   33.083973] Successfully transitioned to low power state
[   33.087132] PM: noirq resume of devices complete after 2.663 msecs
[   33.090629] PM: early resume of devices complete after 2.346 msecs
[   33.097607] PM: resume of devices complete after 6.951 msecs
[   33.155869] Restarting tasks ... done.
[root@arago /]#

All the patches have been run through checkpatch and i have also
tried a few OMAP build configs that Paul uses to ensure that these
patches do not introduce any new build warnings/errors for the OMAP
family.

A few TODOs
0. Test all the patches on OMAP platforms like BeagleBoard
1. Add support for DDR3 in the assembly code
2. Update the DTB documentation for OCMCRAM and WKUP_M3 nodes.

Regards,
Vaibhav

[1] http://www.ti.com/litv/pdf/spruh73f
[2] http://arago-project.org/git/projects/?p=am33x-cm3.git;a=summary
[3] https://patchwork.kernel.org/patch/1661771/

Vaibhav Bedia (15):
  ARM: OMAP2+: mailbox: Add an API for flushing the FIFO
  ARM: OMAP2+: mailbox: Add support for AM33XX
  ARM: OMAP: mailbox: Convert to device_initcall
  ARM: OMAP2+: hwmod: Update the reset API for AM33XX
  ARM: OMAP2+: AM33XX: Update WKUP_M3 hwmod entry for reset status
  ARM: OMAP2+: hwmod: Enable OCMCRAM registration in AM33XX
  ARM: OMAP2+: hwmod: Update the hwmod data for TPTCs in AM33XX
  ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space for CPGMAC0
  ARM: OMAP: AM33XX: Remove unnecessary include and use __ASSEMBLER__
    macros
  ARM: OMAP2+: control: Add some AM33XX Control module registers
  ARM: OMAP: timer: Interchange clksrc and clkevt for AM33XX
  ARM: OMAP: timer: Add suspend-resume callbacks for clockevent device
  ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
  ARM: OMAP2+: omap2plus_defconfig: Enable Mailbox
  ARM: OMAP2+: AM33XX: Basic suspend resume support

 arch/arm/boot/dts/am33xx.dtsi              |   11 +
 arch/arm/configs/omap2plus_defconfig       |    2 +
 arch/arm/mach-omap2/Makefile               |    2 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/clock33xx_data.c       |    1 +
 arch/arm/mach-omap2/cm33xx.h               |   10 +-
 arch/arm/mach-omap2/common.h               |   10 +
 arch/arm/mach-omap2/control.h              |   29 ++
 arch/arm/mach-omap2/io.c                   |    7 +
 arch/arm/mach-omap2/mailbox.c              |   79 +++-
 arch/arm/mach-omap2/omap_hwmod.c           |    5 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   15 +-
 arch/arm/mach-omap2/pm.h                   |    7 +
 arch/arm/mach-omap2/pm33xx.c               |  429 +++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h               |  100 +++++
 arch/arm/mach-omap2/prm33xx.c              |   15 +-
 arch/arm/mach-omap2/prm33xx.h              |    4 +-
 arch/arm/mach-omap2/sleep33xx.S            |  571 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer.c                |   33 ++-
 arch/arm/plat-omap/include/plat/mailbox.h  |    3 +
 arch/arm/plat-omap/mailbox.c               |   35 ++
 arch/arm/plat-omap/sram.c                  |   10 +-
 arch/arm/plat-omap/sram.h                  |    2 +
 23 files changed, 1343 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/pm33xx.h
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S

