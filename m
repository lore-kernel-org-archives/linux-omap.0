From: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] twl: usb: Add the resume() and suspend() methods to
 twl4030-usb.c (re)
Date: Thu, 26 Feb 2009 08:54:38 +0900
Message-ID: <49A5DA3E.6040608@samsung.com>
References: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, q1.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The MPU module can be waked up by the unexpected USB
interrupt(HSUSB_MC_NINT). For instance, if the MUSB is working as
peripheral mode and connected to a host PC, it can never enter the low
power mode due to interrupts from the host PC. This patch added the
feature that a board specific file can determines that TWL4030
supplies the USB power or not in the low power mode. Disabling the USB
power may save the power consumption.

Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kim Kyuwon <chammoru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/otg/twl4030-usb.c |   25 +++++++++++++++++++++++++
 include/linux/i2c/twl4030.h   |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 416e441..b725be2 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -256,6 +256,7 @@ struct twl4030_usb {
 	u8			linkstat;
 	u8			asleep;
 	bool			irq_enabled;
+	bool			suspend_enabled;
 };
 
 /* internal define on top of container_of */
@@ -618,6 +619,7 @@ static int __init twl4030_usb_probe(struct platform_device *pdev)
 	twl->otg.set_suspend	= twl4030_set_suspend;
 	twl->usb_mode		= pdata->usb_mode;
 	twl->asleep		= 1;
+	twl->suspend_enabled	= pdata->suspend_enabled;
 
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
@@ -694,9 +696,32 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+int twl4030_usb_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct twl4030_usb *twl = platform_get_drvdata(pdev);
+
+	if (!twl->suspend_enabled)
+		return 0;
+
+	otg_set_suspend(&twl->otg, 1);
+
+	return 0;
+}
+
+int twl4030_usb_resume(struct platform_device *pdev)
+{
+	struct twl4030_usb *twl = platform_get_drvdata(pdev);
+
+	otg_set_suspend(&twl->otg, 0);
+
+	return 0;
+}
+
 static struct platform_driver twl4030_usb_driver = {
 	.probe		= twl4030_usb_probe,
 	.remove		= __exit_p(twl4030_usb_remove),
+	.suspend	= twl4030_usb_suspend,
+	.resume		= twl4030_usb_resume,
 	.driver		= {
 		.name	= "twl4030_usb",
 		.owner	= THIS_MODULE,
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index c89d33b..0b12509 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -325,6 +325,7 @@ enum twl4030_usb_mode {
 
 struct twl4030_usb_data {
 	enum twl4030_usb_mode	usb_mode;
+	bool suspend_enabled;
 };
 
 struct twl4030_ins {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
