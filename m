From: Eric Witcher <ewitcher@mindspring.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
Date: Tue, 25 Aug 2009 23:20:29 -0400 (GMT-04:00)
Message-ID: <17586781.1251256830061.JavaMail.root@elwamui-hybrid.atl.sa.earthlink.net>
Reply-To: Eric Witcher <ewitcher@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:59024 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756619AbZHZDU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Aug 2009 23:20:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


-----Original Message-----
>From: Felipe Balbi <felipe.balbi@nokia.com>
>Sent: Aug 19, 2009 9:40 AM
>To: ext Tony Lindgren <tony@atomide.com>
>Cc: Eric Witcher <ewitcher@mindspring.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
>Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
>
>Hi,
>
>On Sun, Aug 16, 2009 at 05:42:00PM +0200, ext Tony Lindgren wrote:
>> From f9356c9b5ca663feb3a985b42d0409da5625d537 Mon Sep 17 00:00:00 2001
>> From: Paul Walmsley <paul@pwsan.com>
>> Date: Sun, 16 Aug 2009 18:29:49 +0300
>> Subject: [PATCH] OMAP3: update OMAP3 Beagle defconfig
>> 
>> Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
>> Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
>> rev C2.
>> 
>> Patch updated to enable PM and OTG options as suggested by
>> Eric Witcher <ewitcher@mindspring.com>.
>> 
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Jason Kridner <jkridner@beagleboard.org>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
>Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
>
>now that we have REGULATOR and TWL4030_USB it will work.
>
Hi everyone,

I just tested this again at the top of for-next at
 6e083649e19ba4aa3b8a65d75f394ab8a06feb78
and we are still short 2 changes in order to get a working
boot using omap3_beagle_defconfig.

The changes are shown below.

The code deltas were discussed before
but I didn't follow how the twl4030-usb.c change was going to make
it into the tree.

With respect to the .config change, it was shown in my earlier post
but it didn't get put into the commit at
OMAP3: update OMAP3 Beagle defconfig
af9d536a65251a547864e3be87f53a22a6966b7a

In that check-in configuration CONFIG_USB_M66592 overrides
CONFIG_USB_GADGET_MUSB_HDRC and we fail during compile.

Eric

---
 arch/arm/configs/omap3_beagle_defconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index b213e3b..51c0fa8 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -899,8 +899,8 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA25X is not set
-CONFIG_USB_GADGET_M66592=y
-CONFIG_USB_M66592=y
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_M66592 is not set
 # CONFIG_USB_GADGET_PXA27X is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
-- 
1.6.2.2

---
 arch/arm/mach-omap2/serial.c  |    1 -
 drivers/usb/otg/twl4030-usb.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 021130d..1cf8078 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -475,7 +475,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->padconf = 0;
 	}
 
-	p->irqflags |= IRQF_SHARED;
 	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..d1852d4 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
 {
 	return platform_driver_register(&twl4030_usb_driver);
 }
-subsys_initcall(twl4030_usb_init);
+subsys_initcall_sync(twl4030_usb_init);
 
 static void __exit twl4030_usb_exit(void)
 {
-- 
1.6.2.2



>-- 
>balbi
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

