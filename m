From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
Date: Fri, 23 Sep 2011 14:57:36 +0530
Message-ID: <CAC83Zv+Vd4r2Ja-KQo956WigoxV0mhoygJwi0aQjmY6Dw9L2qA@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<20110922005930.GN2937@atomide.com>
	<CAC83Zv+aFu6u7TezD0NA3UHf9DMtW0AsP15jB1FFn8avEwY7CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:55667 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752231Ab1IWJ1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 05:27:39 -0400
Received: by bke11 with SMTP id 11so3674541bke.20
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 02:27:37 -0700 (PDT)
In-Reply-To: <CAC83Zv+aFu6u7TezD0NA3UHf9DMtW0AsP15jB1FFn8avEwY7CQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tony,
[...]
>> I've applied these into dmtimer branch with some changes to simplify
>> things further. I've also merged it into linux-omap master branch
>> for further testing.
>>
>> I'll reply to your patches with the changes I've done. Care give the
>> dmtimer branch a try and see if I've missed something?
> Sure, I will go through the changes and do testing on it.
Please find the missing/correction in the patch below.
You can include them as part of patch 9.
Thanks.
--
Tarun

>From 98cb7949054214684d7361eed2e382fa716ab0da Mon Sep 17 00:00:00 2001
From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Date: Fri, 23 Sep 2011 14:48:56 +0530
Subject: [correction] [PATCH 09/12] OMAP: dmtimer: low-power mode support

These are some missing content as well as correction to this patch.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index de7896f..81a2305 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -79,9 +79,9 @@ static void omap_dm_timer_write_reg(struct
omap_dm_timer *timer, u32 reg,

 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
-				timer->context.tiocp_cfg);
-	if (timer->revision > 1)
+	__raw_writel(timer->context.tiocp_cfg,
+			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+	if (timer->revision == 1)
 		__raw_writel(timer->context.tistat, timer->sys_stat);

 	__raw_writel(timer->context.tisr, timer->irq_stat);
@@ -356,6 +356,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)

 	__omap_dm_timer_stop(timer, timer->posted, rate);

+	if (timer->loses_context) {
+		if (timer->get_context_loss_count)
+			timer->ctx_loss_count =
+			timer->get_context_loss_count(&timer->pdev->dev);
+	}
+
+	/*
+	 * Since the register values are computed and written within
+	 * __omap_dm_timer_stop, we need to use read to retrieve the
+	 * context.
+	 */
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.tisr = __raw_readl(timer->irq_stat);
+	omap_dm_timer_disable(timer);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
-- 
1.7.0.4
