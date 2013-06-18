From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v3 0/4] USB: OMAP1: Tahvo USB support for 770
Date: Tue, 18 Jun 2013 20:06:57 +0300
Message-ID: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Tested (peripheral mode, host mode, vbus detection) with 3.10-rc6.

History:
	v3: Delete accidental #include <mach/usb.h> from patch 3.
	    Drop board file changes, already queued to linux-omap.
	v2: http://marc.info/?l=linux-omap&m=137138976406242&w=2
	    Use extcon framework to trigger OTG driver mode changes.
	v1: http://marc.info/?l=linux-omap&m=137081763029385&w=2

Earlier RFC versions:
	http://marc.info/?l=linux-omap&m=136553710000679&w=2
	http://marc.info/?l=linux-omap&m=136266725827698&w=2

Aaro Koskinen (4):
  ARM: OMAP1: USB: move omap_usb_config to platform data
  USB: OMAP1: add extcon to platform data
  USB: OMAP1: OTG controller driver
  USB: OMAP1: Tahvo USB transceiver driver

 arch/arm/mach-omap1/include/mach/usb.h  |  38 +--
 drivers/usb/phy/Kconfig                 |  24 ++
 drivers/usb/phy/Makefile                |   2 +
 drivers/usb/phy/phy-omap-otg.c          | 169 ++++++++++++
 drivers/usb/phy/phy-tahvo.c             | 448 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/usb-omap1.h |  53 ++++
 6 files changed, 697 insertions(+), 37 deletions(-)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/platform_data/usb-omap1.h

A.

-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
