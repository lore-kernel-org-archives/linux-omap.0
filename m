From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [RFC PATCH 0/4] USB: OMAP: Tahvo USB support for 770
Date: Thu,  7 Mar 2013 16:40:17 +0200
Message-ID: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

These patches add support for Tahvo USB transceiver and allow use both
host and peripheral modes on Nokia 770.

Patches work with 3.9-rc1, but the following fixes must be also applied:

	ARM: OMAP1: fix USB host on 1710
	http://marc.info/?l=linux-omap&m=135906630828618&w=2

	usb: gadget: fix omap_udc build errors
	http://marc.info/?l=linux-arm-kernel&m=136252187712475&w=2

	ARM: OMAP1: fix omap_udc registration
	http://marc.info/?l=linux-omap&m=136266305725974&w=2

Test cases were roughly following:

	- CONFIG_USB_OTG, CONFIG_TAHVO_USB_HOST_BY_DEFAULT
		- ohci-hcd, omap_udc, g_ether loaded as modules during boot
		- check host mode functionality after boot with USB keyboard
		- switch to peripheral mode and check functionality with ssh
		- switch back to host mode

	- CONFIG_USB_OTG, !CONFIG_TAHVO_USB_HOST_BY_DEFAULT
		- ohci-hcd, omap_udc, g_ether loaded as modules during boot
		- check peripheral mode after boot with ssh
		- switch to host mode and check with USB keyboard
		- switch back to peripheral mode

	- !CONFIG_USB_OTG, CONFIG_USB_OMAP
		- check peripheral mode after boot by logging with ssh

	- !CONFIG_USB_OTG, !CONFIG_USB_OMAP
		- (not currently supported by ohci-hcd)

	- other
		- check USB cable on/off detection (Tahvo vbus interrupt)

Please review and comment. Thanks,

A.

Aaro Koskinen (4):
  retu-mfd: support also Tahvo
  ARM: OMAP1: nokia770: enable Tahvo
  USB: OMAP: move omap-otg out from isp1301_omap
  USB: OMAP: Tahvo USB transceiver driver

 arch/arm/mach-omap1/board-nokia770.c |   10 +
 drivers/mfd/Kconfig                  |    6 +-
 drivers/mfd/retu-mfd.c               |   95 ++++-
 drivers/usb/otg/Kconfig              |   21 ++
 drivers/usb/otg/Makefile             |    2 +
 drivers/usb/otg/isp1301_omap.c       |   78 +----
 drivers/usb/otg/omap-otg.c           |   99 ++++++
 drivers/usb/otg/tahvo-usb.c          |  643 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/retu.h             |    8 +-
 include/linux/usb/omap-otg.h         |   30 ++
 10 files changed, 900 insertions(+), 92 deletions(-)
 create mode 100644 drivers/usb/otg/omap-otg.c
 create mode 100644 drivers/usb/otg/tahvo-usb.c
 create mode 100644 include/linux/usb/omap-otg.h

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
