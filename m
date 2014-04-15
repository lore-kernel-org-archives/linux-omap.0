From: Nishanth Menon <nm@ti.com>
Subject: Re: L3 custom error on OMAP4460 (AES/DES)
Date: Tue, 15 Apr 2014 09:01:37 -0500
Message-ID: <20140415140137.GA11840@kahuna>
References: <CAGhQ9Vy-hKBiW0_g3Ht4gqmg0w5WX8H+aqWAkeEhPnHh5AN68A@mail.gmail.com>
 <534BE4D1.4080104@ti.com>
 <CAGhQ9Vxp6_OvFRnd1KL+oAX3xR72vWHgiWBmoqjfSXk1DwAusg@mail.gmail.com>
 <534C34BD.6060109@ti.com>
 <CAGhQ9Vz0Yj8Qz1x9tLH9=jkNEvmsrKBH2=QbYBUYUgoqxGuHAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44137 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbaDOOBj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Apr 2014 10:01:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9Vz0Yj8Qz1x9tLH9=jkNEvmsrKBH2=QbYBUYUgoqxGuHAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, "Fernandes, Joel" <joelf@ti.com>

On 22:36-20140414, Joachim Eastwood wrote:
> On 14 April 2014 21:19, Nishanth Menon <nm@ti.com> wrote:
> > On 04/14/2014 02:15 PM, Joachim Eastwood wrote:
> >> On 14 April 2014 15:38, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >>> On Saturday 12 April 2014 05:06 PM, Joachim Eastwood wrote:
> >>>> Hi,
> >>>>
> >>>> I getting the following error on Linus master right now.
> >>>>
> >>>> [ 2.166320] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
> >>>> l3_interrupt_handler+0xf4/0x154()
> >>>> [ 2.166320] L3 custom error: MASTER:MPU TARGET:L4 PER2
> >>>> [ 2.166320] Modules linked in:
> >
> > [...]
> >>>> The hardware is a VAR-STK-OM44 dev kit. I got one patch on top of
> >>>> Linus master which is the DT support patch which I posted a couple of
> >>>> hours ago.
> >>>>
> >>> Have you tried removing AES from the build ? Probably worth a
> >>> try.
> >>
> >> Removing the aes driver makes the warning from omap_l3_noc disappear.
> >>
> >> I also tried tried the omap_l3_noc patches from Nishanth Menon that
> >> was just posted but it had the same error when the aes driver was
> >> built-in.
> > Yeah - it better :).. Good to know that driver continues to report bad
> > accesses by drivers to targets that are not active yet. will be great
> > if you could provide a "Tested-by" tag on my series :).
> 
> Sure. The patch set booted fine on my VAR-STK-OM44 (OMAP4460).
> Tested-by: Joachim Eastwood <manabian@gmail.com>
> 
> > Btw, I just finished testing on PandaBoard ES and SDP4430 and I dont
> > see the error that you see on var som. I wonder why?
> >
> > pandaboard-es:  Boot PASS: http://slexy.org/raw/s21Hsq97mt
> > sdp4430:  Boot PASS: http://slexy.org/raw/s2ZQJUqjrP
> 
> hmm. Maybe it's a combination of different config options.
> 
> I have attached the complete dmesg and config from my board. Maybe you
> could try the config out.
> 
> I noticed from your PandaBoard ES log that you only get this line:
> [ 0.555480] platform 4b501000.aes: Cannot lookup hwmod 'aes'
> 
> While on my board I first get the "Cannot lookup" message and then
> some other messages:
> [ 0.512847] platform 4b501000.aes: Cannot lookup hwmod 'aes'
> [ 2.341125] omap-aes 4b501000.aes: _od_fail_runtime_resume: FIXME:
> missing hwmod/omap_dev info
> [ 2.350219] omap-aes 4b501000.aes: omap_aes_probe: failed to get_sync(-19)
> [ 2.357482] omap-aes 4b501000.aes: initialization failed.

Yep, I was able to reproduce the error:
pandaboard-es-before: http://slexy.org/raw/s21rGPFnKl
pandaboard-es-after:  http://slexy.org/raw/s2A4UFQVna

Key was "omap-des 480a5000.des: OMAP DES hw accel rev: 0.0" in the log.

Please try the following patch:
--8<--
>From a5c1b5645eef74c88ea22f6ec99054ec0e9a2502 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Tue, 15 Apr 2014 08:55:44 -0500
Subject: [PATCH] crypto: omap-des - handle error of pm_runtime_get_sync

pm_runtime_get_sync may not always succeed depending on SoC involved. So
handle the error appropriately.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on v3.15-rc1

 drivers/crypto/omap-des.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index ec5f131..c2d362f 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -223,12 +223,18 @@ static void omap_des_write_n(struct omap_des_dev *dd, u32 offset,
 
 static int omap_des_hw_init(struct omap_des_dev *dd)
 {
+	int err;
+
 	/*
 	 * clocks are enabled when request starts and disabled when finished.
 	 * It may be long delays between requests.
 	 * Device might go to off mode to save power.
 	 */
-	pm_runtime_get_sync(dd->dev);
+	err = pm_runtime_get_sync(dd->dev);
+	if (err < 0) {
+		dev_err(dd->dev, "failed to get_sync(%d)\n", err);
+		return err;
+	}
 
 	if (!(dd->flags & FLAGS_INIT)) {
 		dd->flags |= FLAGS_INIT;
@@ -1083,7 +1089,11 @@ static int omap_des_probe(struct platform_device *pdev)
 	dd->phys_base = res->start;
 
 	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	err = pm_runtime_get_sync(dev);
+	if (err < 0) {
+		dev_err(dd->dev, "failed to get_sync(%d)\n", err);
+		goto err_get;
+	}
 
 	omap_des_dma_stop(dd);
 
@@ -1148,6 +1158,7 @@ err_algs:
 err_irq:
 	tasklet_kill(&dd->done_task);
 	tasklet_kill(&dd->queue_task);
+err_get:
 	pm_runtime_disable(dev);
 err_res:
 	dd = NULL;
@@ -1191,8 +1202,7 @@ static int omap_des_suspend(struct device *dev)
 
 static int omap_des_resume(struct device *dev)
 {
-	pm_runtime_get_sync(dev);
-	return 0;
+	return pm_runtime_get_sync(dev);
 }
 #endif
 
-- 
1.7.9.5



-- 
Regards,
Nishanth Menon
