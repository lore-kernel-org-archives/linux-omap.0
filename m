From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 0/3] USB: OMAP: Tahvo USB support for 770
Date: Mon, 10 Jun 2013 01:40:03 +0300
Message-ID: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
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

Tested (peripheral mode, host mode, vbus detection) with 3.10-rc4.

Aaro Koskinen (3):
  ARM: OMAP1: nokia770: enable Tahvo
  USB: OMAP: add omap-otg
  USB: OMAP: Tahvo USB transceiver driver

 arch/arm/mach-omap1/board-nokia770.c |   10 +
 drivers/usb/phy/Kconfig              |   24 ++
 drivers/usb/phy/Makefile             |    2 +
 drivers/usb/phy/phy-omap-otg.c       |  126 ++++++++++
 drivers/usb/phy/phy-tahvo.c          |  429 ++++++++++++++++++++++++++++++++++
 include/linux/usb/omap-otg.h         |   19 ++
 6 files changed, 610 insertions(+)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/usb/omap-otg.h

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
