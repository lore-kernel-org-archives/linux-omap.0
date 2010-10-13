From: csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org
Subject: [RFC: WL1271 DC supprot on OMAP3EVM 0/5]
Date: Wed, 13 Oct 2010 16:27:14 +0530
Message-ID: <1286967439-705-1-git-send-email-csanjay@mistralsolutions.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>


Sanjay Kumar Champati (5):
  ARM: Supported MMC 2 features for OMAP3EVM
  ARM: Supported for Standard SDIO driver on OMAP3EVM for WL1271 DC
  ARM: Supported for BT enable on OMAP3EVM for WL1271 DC
  ARM: Added ALSA audio support for WL1271 DC over the PCM interface
    (OMAP37XX)
  Supported BT and WLAN configuration for WL1271 over the OMAP37XX

 arch/arm/configs/omap3_evm_defconfig |   27 +++++++-
 arch/arm/mach-omap2/board-omap3evm.c |   28 ++++++++-
 arch/arm/mach-omap2/mmc-twl4030.c    |    1 +
 arch/arm/mach-omap2/mmc-twl4030.h    |    2 +
 drivers/bluetooth/Kconfig            |    7 ++
 drivers/char/tty_io.c                |  110 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio_ops.c          |    7 ++-
 drivers/net/wireless/Kconfig         |   11 ++++
 sound/soc/omap/Kconfig               |    6 ++
 sound/soc/omap/Makefile              |    2 +
 sound/soc/omap/omap3evm.c            |   81 ++++++++++++++++++++++++-
 sound/soc/omap/wl1271bt.c            |   59 ++++++++++++++++++
 sound/soc/omap/wl1271bt.h            |   16 +++++
 13 files changed, 350 insertions(+), 7 deletions(-)
 create mode 100644 sound/soc/omap/wl1271bt.c
 create mode 100644 sound/soc/omap/wl1271bt.h

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
