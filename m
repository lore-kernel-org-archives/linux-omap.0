From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/RFC/PATCH 00/13] CBUS meets GENIRQ
Date: Wed, 9 Feb 2011 18:43:49 -0800
Message-ID: <20110210024349.GI20795@atomide.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14660 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1BJCoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 21:44:18 -0500
Content-Disposition: inline
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110203 02:20]:
> Hi Tony,
> 
> When you have some extra time, could you run these on N810
> to check whether I'm on the right path ? After these patches
> all CBUS drivers are using standard request_threaded_irq()
> calls. It's one step closer into getting those in mainline.

Cool sorry it took a while, this is starting to look like
it will be pretty close to be posted for merging :)

I guess we should move files around to have:

drivers/mfd/cbus-retu.c
drivers/mfd/cbus-tahvo.c

drivers/rtc/rtc-cbus-retu.c
...

Anything else remaining to do?

Also the following patch was needed to get this to boot
with interrupts working. Maybe you have a better plan
for getting the retu irq_base?

Anyways, since n8x0 boots and stays up, we know it's
working, so I've pushed them all to the cbus branch.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 9 Feb 2011 18:36:16 -0800
Subject: [PATCH] cbus: Fix nested interrupts for retu

We need to add the retu irq base number to the interrupt
number for children.

This could be done by passing the interrupt base for
children in platform_data also I guess.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -258,7 +258,7 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	setup_timer(&hs->detect_timer, retu_headset_detect_timer,
 		    (unsigned long) hs);
 
-	r = request_threaded_irq(RETU_INT_HOOK, NULL,
+	r = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_HOOK, NULL,
 			retu_headset_hook_interrupt, 0, "hookdet", hs);
 	if (r != 0) {
 		dev_err(&pdev->dev, "hookdet IRQ not available\n");
@@ -290,7 +290,7 @@ static int retu_headset_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_enable_det);
 	retu_headset_disable(hs);
 	retu_headset_det_disable(hs);
-	free_irq(RETU_INT_HOOK, hs);
+	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_HOOK, hs);
 	input_unregister_device(hs->idev);
 	input_free_device(hs->idev);
 
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -83,7 +83,7 @@ static int __init retubutton_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	pwr->irq = RETU_INT_PWR;
+	pwr->irq = CBUS_RETU_IRQ_BASE + RETU_INT_PWR;
 	platform_set_drvdata(pdev, pwr);
 
 	ret = request_threaded_irq(pwr->irq, NULL, retubutton_irq, 0,
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -88,15 +88,15 @@ static int retu_rtc_init_irq(struct retu_rtc *rtc)
 {
 	int ret;
 
-	ret = request_threaded_irq(RETU_INT_RTCS, NULL, retu_rtc_interrupt,
+	ret = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, NULL, retu_rtc_interrupt,
 			0, "RTCS", rtc);
 	if (ret != 0)
 		return ret;
 
-	ret = request_threaded_irq(RETU_INT_RTCA, NULL, retu_rtc_interrupt,
+	ret = request_threaded_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, NULL, retu_rtc_interrupt,
 			0, "RTCA", rtc);
 	if (ret != 0) {
-		free_irq(RETU_INT_RTCS, rtc);
+		free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
 		return ret;
 	}
 
@@ -235,8 +235,8 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
-	free_irq(RETU_INT_RTCS, rtc);
-	free_irq(RETU_INT_RTCA, rtc);
+	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
+	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, rtc);
 
 err1:
 	kfree(rtc);
@@ -249,8 +249,8 @@ static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 	struct retu_rtc		*rtc = platform_get_drvdata(pdev);
 
-	free_irq(RETU_INT_RTCS, rtc);
-	free_irq(RETU_INT_RTCA, rtc);
+	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCS, rtc);
+	free_irq(CBUS_RETU_IRQ_BASE + RETU_INT_RTCA, rtc);
 	rtc_device_unregister(rtc->rtc);
 	kfree(rtc);
 
