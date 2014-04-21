From: Joel Fernandes <joelf@ti.com>
Subject: Re: L3 custom error from dmtimer.c
Date: Mon, 21 Apr 2014 14:33:28 -0500
Message-ID: <53557288.4030505@ti.com>
References: <CAGhQ9VwTqsxYk2f7dhH-M+afHJiFNdeUTK=5EYw-OCN3s88z9Q@mail.gmail.com>	<53553BD7.5090907@ti.com>	<CAGhQ9VwqmDMJcJbzFA4MHSHdw2nbdNNwdL6SmEH+W4+1VEAe-A@mail.gmail.com>	<535548FE.3030808@ti.com> <CAGhQ9VwW3PSXZrtap55PDf54naTPjYmVXU8NTO=f0tTWKSN5Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDUTdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 15:33:32 -0400
In-Reply-To: <CAGhQ9VwW3PSXZrtap55PDf54naTPjYmVXU8NTO=f0tTWKSN5Gg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 04/21/2014 12:04 PM, Joachim Eastwood wrote:
[..]
>>> Note that the warning I got might be cause by the pwm-omap and it's
>>> use of dmtimer api. I will investigate further.
>>>
>>> But either way add a check to enable/disable is a good idea.
>>>
>>
>> Sure, I added the check. The patch depends on a few other pending
>> patches so I just zipped all together. It would be great if you could
>> apply them and confirm it fixes the problem, then I can add your
>> tested-by and include it in the next series.
> 
> Thanks for zip-file, Joel.
> 
> I can confirm that the pwm-omap driver still works with dmtimer after
> applying your patch set.
> So feel free to add: Tested-by: Joachim Eastwood <manabian@gmail.com>
> 
> Have just a small comment on the "dmtimer: Check return of
> pm_runtime_get_sync". I see that you use pr_err, but since you have a
> dev pointer available maybe you should use dev_err instead.

Thanks, I fixed it up to use the dev pointer and added your Tested-by.

  -Joel

---->8--------
>From f2c5a92f42da56266cc4da1a15a1cea4b9dabb49 Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joelf@ti.com>
Date: Mon, 21 Apr 2014 11:05:10 -0500
Subject: [PATCH] ARM: OMAP: dmtimer: Check return of pm_runtime_get_sync

omap_timer_enable doesn't check return value, this can lead to nasty bus
errors. Add a check and report issues.

Tested-by: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   62
+++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 +-
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1fd30fa..a897d6d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -164,7 +164,9 @@ static int omap_dm_timer_prepare(struct
omap_dm_timer *timer)
 		}
 	}

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if(rc)
+		return rc;

 	if (timer->capability & OMAP_TIMER_NEEDS_RESET) {
 		rc = omap_dm_timer_reset(timer);
@@ -375,11 +377,16 @@ int omap_dm_timer_free(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_free);

-void omap_dm_timer_enable(struct omap_dm_timer *timer)
+int omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	int c;
+	int c, err;

-	pm_runtime_get_sync(&timer->pdev->dev);
+	err = pm_runtime_get_sync(&timer->pdev->dev);
+	if (err < 0) {
+		dev_err(&timer->pdev->dev, "%s: pm_runtime_get_sync failed (err=%d).",
+			__func__, err);
+		return err;
+	}

 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		if (timer->get_context_loss_count) {
@@ -392,6 +399,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 			omap_timer_restore_context(timer);
 		}
 	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);

@@ -432,11 +440,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
 int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;

 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
@@ -534,11 +545,15 @@ int omap_dm_timer_set_load(struct omap_dm_timer
*timer, int autoreload,
 			    unsigned int load)
 {
 	u32 mask = ~0, val = 0;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;
+
 	if (autoreload)
 		val |= OMAP_TIMER_CTRL_AR;
 	else
@@ -560,11 +575,14 @@ int omap_dm_timer_set_load_start(struct
omap_dm_timer *timer, int autoreload,
                             unsigned int load)
 {
 	u32 l;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;

 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	if (autoreload) {
@@ -588,11 +606,15 @@ int omap_dm_timer_set_match(struct omap_dm_timer
*timer, int enable,
 			     unsigned int match)
 {
 	u32 mask = ~0, val = 0;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;
+
 	if (enable)
 		val |= OMAP_TIMER_CTRL_CE;
 	else
@@ -613,11 +635,15 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer
*timer, int def_on,
 			   int toggle, int trigger)
 {
 	u32 mask = ~0, val = 0;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;
+
 	mask &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
 	if (def_on)
@@ -637,11 +663,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
 int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
 {
 	u32 mask = ~0, val = 0;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;
+
 	mask &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
 		val |= OMAP_TIMER_CTRL_PRE;
@@ -659,10 +689,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
+	int rc;
+
 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;
+
 	__omap_dm_timer_int_enable(timer, value);

 	/* Save the context */
@@ -683,11 +718,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 {
 	u32 l = mask;
+	int rc;

 	if (unlikely(!timer))
 		return -EINVAL;

-	omap_dm_timer_enable(timer);
+	rc = omap_dm_timer_enable(timer);
+	if (rc)
+		return rc;

 	if (timer->revision == 1)
 		l = __raw_readl(timer->irq_ena) & ~mask;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h
b/arch/arm/plat-omap/include/plat/dmtimer.h
index fe3780a..6b6fbd2 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -130,7 +130,7 @@ struct omap_dm_timer
*omap_dm_timer_request_specific(int timer_id);
 struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
 struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node
*np);
 int omap_dm_timer_free(struct omap_dm_timer *timer);
-void omap_dm_timer_enable(struct omap_dm_timer *timer);
+int omap_dm_timer_enable(struct omap_dm_timer *timer);
 void omap_dm_timer_disable(struct omap_dm_timer *timer);

 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
-- 
1.7.9.5

