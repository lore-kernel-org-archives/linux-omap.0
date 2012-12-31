From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 00/18] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Mon, 31 Dec 2012 18:36:53 +0530
Message-ID: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52011 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab2LaNHz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 08:07:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>

Hi,

This is the second version of the patch series for adding suspend-resume
support for AM33XX. Based on the feedback received on the previous patch
series [1] almost all the patches have undergone a bit a rework.

The 1st two patches depend on the changes for mailbox code migration
from arch/arm/*-omap*/ to drivers/mailbox/ [2].

The patch series also depends on recent changes to the OMAP PM framework
by Paul Walmsley.

I found it easiest to apply the AM33XX suspend-resume patches on top of
Paul's TEST_pwrdm_post_fpwrst_devel_a_3.9 branch + the patches @ [2].

With these dependencies met, the PM code uses the firmware interface
and expects the userspace to load the WKUP_M3 binary before the
suspend-resume functionality is made available. The binary file (and
the source-code for WKUP_M3) can be obtained from the 'next' branch at
[3]. The WKUP_M3 binary can either be loaded post bootup via
the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or
it can be included in the kernel image as part of the build process.

DDR3 specific changes have been skipped for now since mainline U-Boot
exhibited stability issues on all the DDR3 based AM335x boards that i could
lay my hands on.

I have done basic testing along with power measurments on the different
power rails on the AM335x EVM. PER domain transition on the BeagleBone fails
if the CPSW driver is included in the kernel and is yet to be root caused.
Along with this issue more extensive testing on other OMAP platforms is also
pending right now.

For more details on the AM335x suspend-resume support please refer to the
changelog in the different patches.

Regards,
Vaibhav

[1] http://marc.info/?l=linux-arm-kernel&m=135185970731607&w=4
[2] http://marc.info/?l=linux-omap&m=135583648827089&w=4
[3] http://arago-project.org/git/projects/?p=am33x-cm3.git;a=shortlog;h=refs/heads/next

Vaibhav Bedia (18):
  mailbox: OMAP2+: Add support for AM33XX
  mailbox: Add an API for flushing the FIFO
  memory: emif: Move EMIF related header file to include/linux/
  ARM: OMAP2+: AM33XX: CM: Get rid of unncessary header inclusions
  ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
  ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
  ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
  ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
  ARM: OMAP2+: AM33XX: Update the hardreset API
  ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset
    status bit
  ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
  ARM: OMAP2+: timer: Add suspend-resume callbacks for clockevent
    device
  ARM: OMAP2+: AM33XX: timer: Interchance clkevt and clksrc timers
  ARM: OMAP2+: AM33XX: control: Add some control module registers and
    APIs
  ARM: OMAP2+: AM33XX: Add assembly code for PM operations
  ARM: OMAP2+: AM33XX: Basic suspend resume support
  ARM: OMAP2+: AM33XX: Select Mailbox when PM is enabled
  ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into OMAP builds

 .../devicetree/bindings/arm/omap/timer.txt         |    2 +
 arch/arm/boot/dts/am33xx.dtsi                      |   12 +
 arch/arm/mach-omap2/Kconfig                        |    4 +-
 arch/arm/mach-omap2/Makefile                       |    2 +
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/cm33xx.h                       |   10 +-
 arch/arm/mach-omap2/common.h                       |   10 +
 arch/arm/mach-omap2/control.c                      |   20 +
 arch/arm/mach-omap2/control.h                      |   41 ++
 arch/arm/mach-omap2/io.c                           |    7 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    5 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   50 +-
 arch/arm/mach-omap2/pm.h                           |    7 +
 arch/arm/mach-omap2/pm33xx.c                       |  469 ++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h                       |   56 ++
 arch/arm/mach-omap2/prm33xx.c                      |   11 +-
 arch/arm/mach-omap2/prm33xx.h                      |    5 +-
 arch/arm/mach-omap2/sleep33xx.S                    |  584 +++++++++++++++++++
 arch/arm/mach-omap2/sram.c                         |   10 +-
 arch/arm/mach-omap2/sram.h                         |    2 +
 arch/arm/mach-omap2/timer.c                        |   39 ++-
 drivers/mailbox/mailbox-omap2.c                    |   54 ++-
 drivers/mailbox/mailbox.c                          |   36 ++
 drivers/mailbox/mailbox.h                          |    3 +
 drivers/memory/emif.c                              |    2 +-
 drivers/memory/emif.h                              |  589 --------------------
 include/linux/mailbox.h                            |    1 +
 include/linux/ti_emif.h                            |  589 ++++++++++++++++++++
 28 files changed, 1989 insertions(+), 632 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/pm33xx.h
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 delete mode 100644 drivers/memory/emif.h
 create mode 100644 include/linux/ti_emif.h

