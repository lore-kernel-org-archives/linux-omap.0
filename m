From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap updates
Date: Mon, 23 Mar 2009 21:01:29 -0700
Message-ID: <20090324040128.GT29546@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyqLL/JqMvClXZi1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49485 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZCXEB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 00:01:29 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

Here's a git pull request for you for all the patch sets posted here
earlier and queued up into my for-next branch.

In addition to 2.6.29, these patches should also merge cleanly on
top of your omap-clks3 branch. Something like the attached patch
will be needed to keep all the boards compiling after omap-clks3
has been merged.

For reference, here are the various patch sets in this branch:

[PATCH 00/10] arm: omap mailbox: add omap3 support with some fixes
http://lkml.org/lkml/2009/1/16/62

[PATCH 00/13] Omap header clean-up for next merge window
http://marc.info/?l=linux-arm-kernel&m=123569296029804&w=2

OMAP850 Support
http://lists.arm.linux.org.uk/lurker/message/20090124.191501.a3b6ced3.en.html

[PATCH 0/7] Updates for common omap code for next merge window
http://marc.info/?l=linux-omap&m=123620324620623&w=2

[PATCH 00/12] Omap3 updates for the merge window after 2.6.29
http://marc.info/?l=linux-arm-kernel&m=123671932726070&w=2

[PATCH 0/4] Omap board updates for merge window after 2.6.29
http://marc.info/?l=linux-arm-kernel&m=123698463009579&w=2

Regards,

Tony

--oyqLL/JqMvClXZi1
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-fix-compile.patch"

>From 6ad0f9876c94660cfee18ab4bad0cab594a94583 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Mar 2009 15:28:42 -0700
Subject: [PATCH] ARM: OMAP: Fix compile for omap2_init_common_hw()

ARM: OMAP: Fix compile for omap2_init_common_hw()

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 11fd882..87d20f6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -212,7 +212,7 @@ static inline void __init sdp3430_init_smc91x(void)
 
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp3430_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 16e2128..402f09c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -118,7 +118,7 @@ static int __init omap3pandora_i2c_init(void)
 
 static void __init omap3pandora_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4d03b70..97e80d1 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -235,7 +235,7 @@ static int __init overo_i2c_init(void)
 
 static void __init overo_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 6a3c5e5..3a0daac 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -62,7 +62,7 @@ static struct omap_board_config_kernel rx51_config[] = {
 
 static void __init rx51_init_irq(void)
 {
-	omap2_init_common_hw();
+	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }

--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
  Linus Torvalds (1):
        Linux 2.6.29

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git for-next

Adrian Hunter (3):
      ARM: OMAP3: mmc-twl4030 fix name buffer length, v2
      ARM: OMAP3: mmc-twl4030 add cover switch
      ARM: OMAP3: mmc-twl4030 allow arbitrary slot names, v3

David Brownell (3):
      ARM: OMAP3: mmc-twl4030 voltage cleanup
      ARM: OMAP3: mmc-twl4030 init passes device nodes back, v2
      ARM: OMAP3: mmc-twl4030 fix for vmmc = 0

Felipe Balbi (2):
      ARM: OMAP: get rid of OMAP_TAG_USB, v2
      ARM: OMAP3: MUSB initialization for omap hw, v2

Grazvydas Ignotas (1):
      ARM: OMAP3: mmc-twl4030 add MMC3 support, v2

Hiroshi DOYU (10):
      omap mailbox: cleanup omap2 register definition with macro
      omap mailbox: add initial omap3 support
      omap mailbox: print hardware revision at startup
      omap mailbox: fix empty struct device for omap_mbox
      omap mailbox: fix empty struct device for omap1
      omap mailbox: fix empty struct device for omap2
      omap mailbox: add save_/restore_ctx() for PM
      omap mailbox: move mailbox.h into mailbox.c
      omap mailbox: convert sequence bit checking to module paramter
      omap mailbox: remove unnecessary header file inclusion

Jarkko Nikula (4):
      ARM: OMAP: Add documentation for function omap_register_i2c_bus
      ARM: OMAP: Add command line option for I2C bus speed, v2
      ARM: OMAP: Add method to register additional I2C busses on the command line, v2
      ARM: OMAP3: Remove unused CONFIG_I2C2_OMAP_BEAGLE

Lauri Leukkunen (1):
      ARM OMAP3: Initial support for Nokia RX-51, v3

Santosh Shilimkar (2):
      ARM: OMAP: Get available DMA channels from cmdline
      ARM: OMAP: Dispatch only relevant DMA interrupts

Steve Sakoman (1):
      ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform, v3

Syed Mohammed Khasim (1):
      ARM: OMAP3: Add support for 3430 SDP, v4

Timo Kokkonen (1):
      ARM: OMAP: Export dmtimer functions

Tony Lindgren (15):
      ARM: OMAP: No need to include board-perseus2.h or board-fsample.h from hardware.h
      ARM: OMAP: No need to include board-h2.h from hardware.h
      ARM: OMAP: No need to include board-h3.h from hardware.h
      ARM: OMAP: No need to include board-innovator.h from hardware.h
      ARM: OMAP: No need to include board-osk.h from hardware.h
      ARM: OMAP: No need to include board-palm*.h from hardware.h
      ARM: OMAP: No need to include board-omap2430sdp.h from hardware.h
      ARM: OMAP: No need to include board-apollon.h from hardware.h
      ARM: OMAP: No need to include board-h4.h from hardware.h
      ARM: OMAP: No need to include board-ldp.h from hardware.h
      ARM: OMAP: No need to include board-overo.h from hardware.h
      ARM: OMAP: No need to include board-nokia.h from hardware.h
      ARM: OMAP: Remove remaining board-*.h includes from hardware.h
      ARM: OMAP3: Add more GPIO mux options
      ARM: OMAP3: Add base address definitions and resources for OMAP 3 IS, v2

Zebediah C. McClure (5):
      [OMAP850] Add base support for omap850 cpu
      [OMAP850] Changes to base IO subsystem, v2
      [OMAP850] Changes to memory subsystem
      [OMAP850] IRQ related changes
      [OMAP850] Build system changes

 Documentation/kernel-parameters.txt                |    6 +
 arch/arm/configs/omap_3430sdp_defconfig            | 2061 ++++++++++++++++++++
 arch/arm/configs/rx51_defconfig                    | 1821 +++++++++++++++++
 arch/arm/mach-omap1/Kconfig                        |   23 +-
 arch/arm/mach-omap1/board-ams-delta.c              |    2 +-
 arch/arm/mach-omap1/board-fsample.c                |   34 +-
 arch/arm/mach-omap1/board-generic.c                |    5 +-
 arch/arm/mach-omap1/board-h2-mmc.c                 |    2 +
 arch/arm/mach-omap1/board-h2.c                     |    7 +-
 .../include/mach => mach-omap1}/board-h2.h         |    5 +-
 arch/arm/mach-omap1/board-h3-mmc.c                 |    2 +
 arch/arm/mach-omap1/board-h3.c                     |    7 +-
 .../include/mach => mach-omap1}/board-h3.h         |    5 +-
 arch/arm/mach-omap1/board-innovator.c              |    8 +-
 arch/arm/mach-omap1/board-nokia770.c               |    9 +-
 arch/arm/mach-omap1/board-osk.c                    |   17 +-
 arch/arm/mach-omap1/board-palmte.c                 |   17 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    9 +-
 arch/arm/mach-omap1/board-palmz71.c                |   12 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                |    1 +
 arch/arm/mach-omap1/board-sx1.c                    |    3 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    2 +-
 arch/arm/mach-omap1/devices.c                      |    2 +-
 arch/arm/mach-omap1/id.c                           |    4 +-
 arch/arm/mach-omap1/io.c                           |   23 +
 arch/arm/mach-omap1/irq.c                          |   19 +-
 arch/arm/mach-omap1/mailbox.c                      |   29 +-
 arch/arm/mach-omap1/mux.c                          |   24 +
 arch/arm/mach-omap1/serial.c                       |    7 +
 arch/arm/mach-omap2/Kconfig                        |   10 +-
 arch/arm/mach-omap2/Makefile                       |    8 +
 arch/arm/mach-omap2/board-2430sdp.c                |   15 +-
 arch/arm/mach-omap2/board-3430sdp.c                |  542 +++++
 arch/arm/mach-omap2/board-apollon.c                |    3 +-
 arch/arm/mach-omap2/board-h4.c                     |   38 +-
 arch/arm/mach-omap2/board-ldp.c                    |   12 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    5 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    9 +
 arch/arm/mach-omap2/board-overo.c                  |   70 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  419 ++++
 arch/arm/mach-omap2/board-rx51.c                   |   96 +
 arch/arm/mach-omap2/devices.c                      |  147 ++-
 arch/arm/mach-omap2/mailbox.c                      |  195 ++-
 arch/arm/mach-omap2/mmc-twl4030.c                  |  187 ++-
 arch/arm/mach-omap2/mmc-twl4030.h                  |    6 +-
 arch/arm/mach-omap2/mux.c                          |   27 +
 arch/arm/mach-omap2/usb-musb.c                     |  187 ++
 arch/arm/plat-omap/Kconfig                         |    8 +
 arch/arm/plat-omap/devices.c                       |    3 +
 arch/arm/plat-omap/dma.c                           |   28 +-
 arch/arm/plat-omap/dmtimer.c                       |   26 +
 arch/arm/plat-omap/gpio.c                          |  111 +-
 arch/arm/plat-omap/i2c.c                           |  104 +-
 arch/arm/plat-omap/include/mach/board-2430sdp.h    |   41 -
 arch/arm/plat-omap/include/mach/board-apollon.h    |   46 -
 arch/arm/plat-omap/include/mach/board-fsample.h    |   51 -
 arch/arm/plat-omap/include/mach/board-h4.h         |   38 -
 arch/arm/plat-omap/include/mach/board-innovator.h  |   52 -
 arch/arm/plat-omap/include/mach/board-ldp.h        |   39 -
 arch/arm/plat-omap/include/mach/board-nokia.h      |   54 -
 .../arm/plat-omap/include/mach/board-omap3beagle.h |   33 -
 arch/arm/plat-omap/include/mach/board-osk.h        |   47 -
 arch/arm/plat-omap/include/mach/board-overo.h      |   26 -
 arch/arm/plat-omap/include/mach/board-palmte.h     |   32 -
 arch/arm/plat-omap/include/mach/board-palmtt.h     |   23 -
 arch/arm/plat-omap/include/mach/board-palmz71.h    |   26 -
 arch/arm/plat-omap/include/mach/board-perseus2.h   |   39 -
 arch/arm/plat-omap/include/mach/board-voiceblue.h  |    1 -
 arch/arm/plat-omap/include/mach/board.h            |    4 -
 arch/arm/plat-omap/include/mach/cpu.h              |   35 +-
 arch/arm/plat-omap/include/mach/gpio.h             |    3 +-
 arch/arm/plat-omap/include/mach/hardware.h         |   74 -
 arch/arm/plat-omap/include/mach/irqs.h             |   83 +-
 arch/arm/plat-omap/include/mach/mailbox.h          |   27 +-
 arch/arm/plat-omap/include/mach/mmc.h              |    2 +
 arch/arm/plat-omap/include/mach/mux.h              |   65 +-
 arch/arm/plat-omap/include/mach/omap34xx.h         |   28 +
 arch/arm/plat-omap/include/mach/omap850.h          |  102 +
 arch/arm/plat-omap/include/mach/system.h           |    2 +
 arch/arm/plat-omap/include/mach/usb.h              |   10 +
 arch/arm/plat-omap/mailbox.c                       |  152 ++-
 arch/arm/plat-omap/mailbox.h                       |  100 -
 arch/arm/plat-omap/sram.c                          |    2 +-
 arch/arm/plat-omap/usb.c                           |   25 +-
 84 files changed, 6644 insertions(+), 1040 deletions(-)
 create mode 100644 arch/arm/configs/omap_3430sdp_defconfig
 create mode 100644 arch/arm/configs/rx51_defconfig
 rename arch/arm/{plat-omap/include/mach => mach-omap1}/board-h2.h (90%)
 rename arch/arm/{plat-omap/include/mach => mach-omap1}/board-h3.h (90%)
 create mode 100644 arch/arm/mach-omap2/board-3430sdp.c
 create mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 create mode 100644 arch/arm/mach-omap2/board-rx51.c
 create mode 100644 arch/arm/mach-omap2/usb-musb.c
 delete mode 100644 arch/arm/plat-omap/include/mach/board-2430sdp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-apollon.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-fsample.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-h4.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-innovator.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-ldp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-nokia.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-omap3beagle.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-osk.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-overo.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmte.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmtt.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-palmz71.h
 delete mode 100644 arch/arm/plat-omap/include/mach/board-perseus2.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap850.h
 delete mode 100644 arch/arm/plat-omap/mailbox.h

--oyqLL/JqMvClXZi1--
