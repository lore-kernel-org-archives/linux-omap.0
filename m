From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/6] usb: musb: charger detection
Date: Thu, 15 Sep 2011 19:49:57 +0530
Message-ID: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This provides a series of patches contributed by several people to
do correct charger detection and solve issues that came along with
the charger detection implementation.

USB_EVENT_NONE notification is sent only when a PC cable/CDP cable or
a device connected to MUSB is detached.

USB_EVENT_VBUS notification is sent only when a PC cable/CDP cable or
a device is connected to MUSB.

Developed on:
git://github.com/torvalds/linux.git
commit id: cc39c6a9bbdebfcf1a7dee64d83bf302bc38d941

This patch series is developed and tested on top of Heikki Krogerus
patch series (version4) [1]

Basic Testing:
Tested with gadget zero enabled for charger detection (PC/DCP). Data transfer testing
is done on both omap4 and omap3 with ./testusb. Tested for device enumeration when a
device is connected to MUSB.

[1] http://www.spinics.net/lists/linux-usb/msg51038.html

Balaji T K (2):
  OMAP4: TWL6030: add USB charger detection
  twl6030: set charger current to be used by battery charging module

Kishon Vijay Abraham I (2):
  usb: musb: omap: Configure OTG_INTERFSEL for proper charger detection
  usb: musb: omap4430_phy_power to enable/disable clocks and power
    up/down phy

Sergii Postulga (1):
  OMAP4: PHY internal: Add msleep_interruptible to charger detection
    function

Viswanath Puttagunta (1):
  MUSB Charger Type Detection: Fix DCP detect during boot.

 arch/arm/mach-omap2/omap_phy_internal.c |   67 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 drivers/usb/musb/omap2430.c             |   50 +++++++++++++++++++----
 drivers/usb/otg/twl6030-usb.c           |   64 +++++++++++++++++++++++------
 4 files changed, 159 insertions(+), 23 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
