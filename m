From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/07] usb: rework musb suspend()/resume_early()
Date: Wed, 24 Jun 2009 18:24:00 +0900
Message-ID: <20090624092400.14276.94490.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset-/W6D1AVitZKvog7CDwlRTrNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-l3A5Bk7waGM@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

This patch reworks platform driver power management code
for musb from legacy callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend() -> suspend()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- 0001/drivers/usb/musb/musb_core.c
+++ work/drivers/usb/musb/musb_core.c	2009-06-01 15:27:12.000000000 +0900
@@ -2168,8 +2168,9 @@ static int __devexit musb_remove(struct 
 
 #ifdef	CONFIG_PM
 
-static int musb_suspend(struct platform_device *pdev, pm_message_t message)
+static int musb_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	unsigned long	flags;
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
@@ -2196,8 +2197,9 @@ static int musb_suspend(struct platform_
 	return 0;
 }
 
-static int musb_resume_early(struct platform_device *pdev)
+static int musb_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
 	if (!musb->clock)
@@ -2215,9 +2217,14 @@ static int musb_resume_early(struct plat
 	return 0;
 }
 
+static struct dev_pm_ops musb_dev_pm_ops = {
+	.suspend	= musb_suspend,
+	.resume_noirq	= musb_resume_noirq,
+};
+
+#define MUSB_DEV_PM_OPS (&musb_dev_pm_ops)
 #else
-#define	musb_suspend	NULL
-#define	musb_resume_early	NULL
+#define	MUSB_DEV_PM_OPS	NULL
 #endif
 
 static struct platform_driver musb_driver = {
@@ -2225,11 +2232,10 @@ static struct platform_driver musb_drive
 		.name		= (char *)musb_driver_name,
 		.bus		= &platform_bus_type,
 		.owner		= THIS_MODULE,
+		.pm		= MUSB_DEV_PM_OPS,
 	},
 	.remove		= __devexit_p(musb_remove),
 	.shutdown	= musb_shutdown,
-	.suspend	= musb_suspend,
-	.resume_early	= musb_resume_early,
 };
 
 /*-------------------------------------------------------------------------*/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
