From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Omap mux changes for v2.6.33 merge window, v2
Date: Wed, 02 Dec 2009 16:21:08 -0800
Message-ID: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58092 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbZLCAVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:21:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

I've updated this series to only map GPIO pins to mux registers
if CONFIG_OMAP_MUX is not set. Those are needed for dynamic muxing
for off-idle.

I've also added omap36xx support, which I have not been able to
test. People with 36xx boards, please give it a try.

Also fixed several checkpatch.pl warnings.

Again big thanks for Benoit Cousson <b-cousson@ti.com> and
Paul Walmsley <paul@pwsan.com> for help in getting the mux
data generated!

Regards,

Tony

Here are some instructions on how to use:

To see what got muxed during init, edit the kernel
CMDLINE to have debug in it:

# dmesg | grep mux
mux: Setting signal i2c2_scl.i2c2_scl 0x0100 -> 0x0100
mux: Setting signal i2c2_sda.i2c2_sda 0x0100 -> 0x0100
mux: Setting signal i2c3_scl.i2c3_scl 0x0100 -> 0x0100
mux: Setting signal i2c3_sda.i2c3_sda 0x0100 -> 0x0100
mux: Setting signal gpmc_ncs3.gpio54 0x410c -> 0x010c
...

Looks like the gpmc_ncs3.gpio54 muxing in the kernel
has a bug where we should have OMAP_WAKEUP_EN set for
board_smc91x_init for board-rx51? :)

To override bootloader mux settings, edit the kernel CMDLINE:

omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100

Note that this only changes the bootloader settings, not
what might be muxed from the board-*.c files.

With CONFIG_DEBUG_FS set:

# mount -t sysfs sys /sys
# mount -t debugfs debug /sys/kernel/debug

# ls /sys/kernel/debug/omap_mux/i2c
i2c2_scl  i2c2_sda  i2c3_scl  i2c3_sda  i2c4_scl  i2c4_sda

# cat /sys/kernel/debug/omap_mux/i2c2_scl
name: i2c2_scl.i2c2_scl (0x480021be/0x18e = 0x0100), b af15, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: i2c2_scl | NA | NA | NA | gpio_168 | NA | NA | safe_mode

---

Mike Rapoport (1):
      omap2: mux: intoduce omap_mux_{read,write}

Tony Lindgren (8):
      omap: mux: Add new style pin multiplexing code for omap3
      omap: mux: Add new style pin multiplexing data for 34xx
      omap: mux: Add new style init functions to omap3 board-*.c files
      omap: mux: Add debugfs support for new mux code
      omap: Split i2c platform init for mach-omap1 and mach-omap2
      omap: mux: Replace omap_cfg_reg() with new style signal or gpio functions
      omap: mux: Remove old mux code for 34xx
      omap: mux: Add 36xx CBP package support


 Documentation/kernel-parameters.txt          |    5 
 arch/arm/mach-omap1/Makefile                 |    3 
 arch/arm/mach-omap1/i2c.c                    |   33 
 arch/arm/mach-omap2/Kconfig                  |   24 
 arch/arm/mach-omap2/Makefile                 |    6 
 arch/arm/mach-omap2/board-3430sdp.c          |   15 
 arch/arm/mach-omap2/board-3630sdp.c          |   14 
 arch/arm/mach-omap2/board-am3517evm.c        |   11 
 arch/arm/mach-omap2/board-cm-t35.c           |   14 
 arch/arm/mach-omap2/board-igep0020.c         |   11 
 arch/arm/mach-omap2/board-ldp.c              |   10 
 arch/arm/mach-omap2/board-omap3beagle.c      |   21 
 arch/arm/mach-omap2/board-omap3evm.c         |   21 
 arch/arm/mach-omap2/board-omap3pandora.c     |   15 
 arch/arm/mach-omap2/board-overo.c            |   14 
 arch/arm/mach-omap2/board-rx51-peripherals.c |    7 
 arch/arm/mach-omap2/board-rx51.c             |   16 
 arch/arm/mach-omap2/board-zoom2.c            |   10 
 arch/arm/mach-omap2/board-zoom3.c            |   10 
 arch/arm/mach-omap2/devices.c                |   62 +
 arch/arm/mach-omap2/i2c.c                    |   56 +
 arch/arm/mach-omap2/io.c                     |    1 
 arch/arm/mach-omap2/mux.c                    | 1061 +++++++++----
 arch/arm/mach-omap2/mux.h                    |  163 ++
 arch/arm/mach-omap2/mux34xx.c                | 2099 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux34xx.h                |  398 +++++
 arch/arm/mach-omap2/usb-ehci.c               |  166 +-
 arch/arm/plat-omap/i2c.c                     |   44 -
 arch/arm/plat-omap/include/plat/common.h     |   14 
 arch/arm/plat-omap/include/plat/i2c.h        |   39 
 arch/arm/plat-omap/include/plat/mux.h        |  226 ---
 arch/arm/plat-omap/mux.c                     |    8 
 32 files changed, 3850 insertions(+), 747 deletions(-)
 create mode 100644 arch/arm/mach-omap1/i2c.c
 create mode 100644 arch/arm/mach-omap2/i2c.c
 create mode 100644 arch/arm/mach-omap2/mux.h
 create mode 100644 arch/arm/mach-omap2/mux34xx.c
 create mode 100644 arch/arm/mach-omap2/mux34xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/i2c.h

-- 
Signature
