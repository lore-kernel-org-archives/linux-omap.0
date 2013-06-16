From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v2 0/5] USB: OMAP1: Tahvo USB support for 770
Date: Sun, 16 Jun 2013 16:35:07 +0300
Message-ID: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Tested (peripheral mode, host mode, vbus detection) with 3.10-rc6.

History:
	v2: Use extcon framework to trigger OTG driver mode changes.
	v1: http://marc.info/?l=linux-omap&m=137081763029385&w=2

Earlier RFC versions:
	http://marc.info/?l=linux-omap&m=136553710000679&w=2
	http://marc.info/?l=linux-omap&m=136266725827698&w=2

Aaro Koskinen (5):
  ARM: OMAP1: USB: move omap_usb_config to platform data
  USB: OMAP1: add extcon to platform data
  USB: OMAP1: OTG controller driver
  USB: OMAP1: Tahvo USB transceiver driver
  ARM: OMAP1: nokia770: enable Tahvo

 arch/arm/mach-omap1/board-nokia770.c    |  11 +
 arch/arm/mach-omap1/include/mach/usb.h  |  38 +--
 drivers/usb/phy/Kconfig                 |  24 ++
 drivers/usb/phy/Makefile                |   2 +
 drivers/usb/phy/phy-omap-otg.c          | 171 ++++++++++++
 drivers/usb/phy/phy-tahvo.c             | 448 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/usb-omap1.h |  53 ++++
 7 files changed, 710 insertions(+), 37 deletions(-)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/platform_data/usb-omap1.h

-- 
1.8.3.1

A.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
