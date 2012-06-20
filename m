From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 0/5] ARM: OMAP: TLL driver implementation for USB host driver
Date: Wed, 20 Jun 2012 17:31:44 +0530
Message-ID: <1340193709-26547-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The TLL configuration is removed from the UHH driver and implemented as
a seperate platform driver. Now, the UHH driver configures the TLL
through API's exported by the TLL platform driver. The TLL is an
has independent hardware mod structure for in OMAP3 and later chips,
hence an dedicated platform driver is created.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

In V2:
    - covered review comments from linux omap and usb community
    - rebased on top Russ dil's patch
       'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
       fixes an issue where the ULPI PHYs were not held in reset
       while initializing the EHCI controller

Keshava Munegowda (5):
  ARM: OMAP: USB: HOST TLL platform driver
  ARM: OMAP: USB: Build the USB HOST TLL omap device
  ARM: OMAP: USB: Remove TLL specific code
  ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
  ARM: OMAP: change the USB TLL clocks device name

 arch/arm/mach-omap2/clock3xxx_data.c  |    8 +-
 arch/arm/mach-omap2/clock44xx_data.c  |    4 +-
 arch/arm/mach-omap2/usb-host.c        |   31 ++-
 arch/arm/plat-omap/include/plat/usb.h |    7 +
 drivers/mfd/Kconfig                   |    2 +-
 drivers/mfd/Makefile                  |    2 +-
 drivers/mfd/omap-usb-host.c           |  238 ++---------------
 drivers/mfd/omap-usb-tll.c            |  471 +++++++++++++++++++++++++++++++++
 8 files changed, 523 insertions(+), 240 deletions(-)
 create mode 100644 drivers/mfd/omap-usb-tll.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
