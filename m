From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 1/3] USB: musb: All each platform to have power hooks
Date: Sat, 5 Sep 2009 07:11:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD07FCF6@dbde02.ent.ti.com>
References: <1252105484-18966-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60819 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934360AbZIEBlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 21:41:53 -0400
In-Reply-To: <1252105484-18966-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

All the platform suspend/resume routines that have been separated out looks same. What about introducing .psuspend, .presume fields in struct musb and then from within musb_suspend() do the following? This way code duplication is reduced.

     if (musb->psuspend) 
         musb->suspend();

      if (musb->set_clock)
               musb->set_clock(musb->clock, 0);
       else
               clk_disable(musb->clock);
        spin_unlock_irqrestore(&musb->lock, flags);
       return 0;


________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Pandita, Vikram
Sent: Saturday, September 05, 2009 4:34 AM
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org; david-b@pacbell.net; Gupta, Ajay Kumar; Gadiyar, Anand; felipe.balbi@nokia.com; Pandita, Vikram
Subject: [PATCH 1/3] USB: musb: All each platform to have power hooks

This patch allows each MUSB platform (Davinci/TUSB/OMAP/Blackfin)
to have their own musb_platform_suspend/musb_platform_resume hooks

Each platform has its own power handling requirements and hence
distribute the suspend/resume functionality per platform

No new functionality is added for other platforms (blackfin/davinci/tusb)
In future these platforms can optimize their suspend/resume routines for
power.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/blackfin.c  |   15 +++++++++++++++
 drivers/usb/musb/davinci.c   |   24 ++++++++++++++++++++++++
 drivers/usb/musb/musb_core.c |   15 +++------------
 drivers/usb/musb/omap2430.c  |    4 +---
 drivers/usb/musb/tusb6010.c  |   24 ++++++++++++++++++++++++
 include/linux/usb/musb.h     |    5 +++++
 6 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index f2f66eb..9a716b2 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -305,11 +305,26 @@ int __init musb_platform_init(struct musb *musb)

 int musb_platform_suspend(struct musb *musb)
 {
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 0);
+       else
+               clk_disable(musb->clock);
+
        return 0;
 }

 int musb_platform_resume(struct musb *musb)
 {
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 1);
+       else
+               clk_enable(musb->clock);
        return 0;
 }

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index e16ff60..684e769 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -499,3 +499,27 @@ int musb_platform_exit(struct musb *musb)

        return 0;
 }
+
+int musb_platform_suspend(struct musb *musb)
+{
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 0);
+       else
+               clk_disable(musb->clock);
+       return 0;
+}
+
+int musb_platform_resume(struct musb *musb)
+{
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 1);
+       else
+               clk_enable(musb->clock);
+       return 0;
+}
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c7c1ca0..ef97a0c 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2186,13 +2186,9 @@ static int musb_suspend(struct platform_device *pdev, pm_message_t message)
                 * they will even be wakeup-enabled.
                 */
        }
-
-       if (musb->set_clock)
-               musb->set_clock(musb->clock, 0);
-       else
-               clk_disable(musb->clock);
        spin_unlock_irqrestore(&musb->lock, flags);
-       return 0;
+
+       return musb_platform_suspend(musb);
 }

 static int musb_resume_early(struct platform_device *pdev)
@@ -2202,16 +2198,11 @@ static int musb_resume_early(struct platform_device *pdev)
        if (!musb->clock)
                return 0;

-       if (musb->set_clock)
-               musb->set_clock(musb->clock, 1);
-       else
-               clk_enable(musb->clock);
-
        /* for static cmos like DaVinci, register values were preserved
         * unless for some reason the whole soc powered down or the USB
         * module got reset through the PSC (vs just being disabled).
         */
-       return 0;
+       return musb_platform_resume(musb);
 }

 #else
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3487520..b957575 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -188,8 +188,6 @@ static void omap_set_vbus(struct musb *musb, int is_on)
                musb_readb(musb->mregs, MUSB_DEVCTL));
 }

-static int musb_platform_resume(struct musb *musb);
-
 int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 {
        u8      devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
@@ -281,7 +279,7 @@ int musb_platform_suspend(struct musb *musb)
        return 0;
 }

-static int musb_platform_resume(struct musb *musb)
+int musb_platform_resume(struct musb *musb)
 {
        u32 l;

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 88b587c..7da5272 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1169,3 +1169,27 @@ int musb_platform_exit(struct musb *musb)
        usb_nop_xceiv_unregister();
        return 0;
 }
+
+int musb_platform_suspend(struct musb *musb)
+{
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 0);
+       else
+               clk_disable(musb->clock);
+       return 0;
+}
+
+int musb_platform_resume(struct musb *musb)
+{
+       if (!musb->clock)
+               return 0;
+
+       if (musb->set_clock)
+               musb->set_clock(musb->clock, 1);
+       else
+               clk_enable(musb->clock);
+       return 0;
+}
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..ede653f 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -105,4 +105,9 @@ extern int tusb6010_platform_retime(unsigned is_refclk);

 #endif /* OMAP2 */

+/* All MUSB platforms should export their suspend/resume functions */
+struct musb;
+extern int musb_platform_suspend(struct musb *musb);
+extern int musb_platform_resume(struct musb *musb);
+
 #endif /* __LINUX_USB_MUSB_H */
--
1.6.3.3.334.g916e1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

