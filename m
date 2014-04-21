From: Joel Fernandes <joelf@ti.com>
Subject: Re: L3 custom error from dmtimer.c
Date: Mon, 21 Apr 2014 11:44:45 -0500
Message-ID: <53554AFD.5070504@ti.com>
References: <CAGhQ9VwTqsxYk2f7dhH-M+afHJiFNdeUTK=5EYw-OCN3s88z9Q@mail.gmail.com>	<53553BD7.5090907@ti.com> <CAGhQ9VwqmDMJcJbzFA4MHSHdw2nbdNNwdL6SmEH+W4+1VEAe-A@mail.gmail.com> <535548FE.3030808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbaDUQou (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 12:44:50 -0400
In-Reply-To: <535548FE.3030808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/21/2014 11:36 AM, Joel Fernandes wrote:
> On 04/21/2014 10:57 AM, Joachim Eastwood wrote:
>> On 21 April 2014 17:40, Joel Fernandes <joelf@ti.com> wrote:
>>> On 04/19/2014 05:25 PM, Joachim Eastwood wrote:
>>>> Hello,
>>>>
>>>> Playing around with an old OMAP pwm driver from NeilBrown. I get the
>>>> following warning:
>>>> [ 0.979522] omap-pwm omap-pwm.14: omap_dm_timer_set_load
>>>> [ 0.979553] ------------[ cut here ]------------
>>>> [ 0.979583] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
>>>> l3_interrupt_handler+0xf4/0x154()
>>>> [ 0.979583] L3 custom error: MASTER:MPU TARGET:L4 PER2
>>>> [ 0.979614] Modules linked in:
>>>> [ 0.979614] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>>>> 3.15.0-rc1-00370-gd9d79f4b7b7d-dirty #65
>>>> [ 0.979644] [<c0014f48>] (unwind_backtrace) from [<c0011c2c>]
>>>> (show_stack+0x10/0x14)
>>>> [ 0.979675] [<c0011c2c>] (show_stack) from [<c05ad3bc>] (dump_stack+0x84/0x94)
>>>> [ 0.979705] [<c05ad3bc>] (dump_stack) from [<c0036ba8>]
>>>> (warn_slowpath_common+0x70/0x8c)
>>>> [ 0.979705] omap-pwm omap-pwm.14: omap_dm_timer_set_match
>>>> [ 0.979736] [<c0036ba8>] (warn_slowpath_common) from [<c0036bf4>]
>>>> (warn_slowpath_fmt+0x30/0x40)
>>>> [ 0.979736] [<c0036bf4>] (warn_slowpath_fmt) from [<c0286c90>]
>>>> (l3_interrupt_handler+0xf4/0x154)
>>>> [ 0.979766] [<c0286c90>] (l3_interrupt_handler) from [<c0085d1c>]
>>>> (handle_irq_event_percpu+0x54/0x1cc)
>>>> [ 0.979766] [<c0085d1c>] (handle_irq_event_percpu) from [<c0085ed0>]
>>>> (handle_irq_event+0x3c/0x5c)
>>>> [ 0.979797] [<c0085ed0>] (handle_irq_event) from [<c0088ed0>]
>>>> (handle_fasteoi_irq+0xac/0x1a0)
>>>> [ 0.979797] [<c0088ed0>] (handle_fasteoi_irq) from [<c00853fc>]
>>>> (generic_handle_irq+0x2c/0x3c)
>>>> [ 0.979827] [<c00853fc>] (generic_handle_irq) from [<c000eb20>]
>>>> (handle_IRQ+0x40/0x90)
>>>> [ 0.979827] [<c000eb20>] (handle_IRQ) from [<c0008594>]
>>>> (gic_handle_irq+0x2c/0x5c)
>>>> [ 0.979858] [<c0008594>] (gic_handle_irq) from [<c05b4a44>]
>>>> (__irq_svc+0x44/0x58)
>>>> [ 0.979858] Exception stack(0xc0889f58 to 0xc0889fa0)
>>>> [ 0.979858] 9f40: 00000001 00000001
>>>> [ 0.979888] 9f60: 00000000 c0893678 c0888000 c0888000 c08e75a4
>>>> c0890548 c0888000 ee7ffc00
>>>> [ 0.979888] omap-pwm omap-pwm.14: load value: 0xfffd11fe (-192002),
>>>> match value: 0xfffffffe (-2)
>>>> [ 0.979888] 9f80: c08904e0 c05bdcec 00000000 c0889fa0 c007a190
>>>> c000ee48 20000113 ffffffff
>>>> [ 0.979919] [<c05b4a44>] (__irq_svc) from [<c000ee48>] (arch_cpu_idle+0x24/0x30)
>>>> [ 0.979919] [<c000ee48>] (arch_cpu_idle) from [<c0071950>]
>>>> (cpu_startup_entry+0x138/0x204)
>>>> [ 0.979949] [<c0071950>] (cpu_startup_entry) from [<c0822b10>]
>>>> (start_kernel+0x370/0x37c)
>>>> [ 0.979980] [<c0822b10>] (start_kernel) from [<80008074>] (0x80008074)
>>>> [ 0.979980] omap-pwm omap-pwm.14: omap_dm_timer_set_pwm
>>>> [ 0.980010] omap-pwm omap-pwm.14: omap_pwm_enable
>>>> [ 0.980010] omap-pwm omap-pwm.14: omap_dm_timer_start
>>>> [ 0.980010] omap-pwm omap-pwm.14: omap_dm_timer_write_counter
>>>> [ 0.980041] ---[ end trace 5d002a14ec98c2ad ]---
>>>>
>>>> This seems to be caused by the call into omap_dm_timer_set_load.
>>>>
>>>
>>> Are you talking about this?
>>> https://lkml.org/lkml/2012/12/12/51
>>>
>>> It doesn't seem to be in mainline though.
>>
>> No, it isn't. I am trying to revive it and get it upstream.
>>
>>> I'll add a check for the enable/disable, thanks.
>>
>> Note that the warning I got might be cause by the pwm-omap and it's
>> use of dmtimer api. I will investigate further.
>>
>> But either way add a check to enable/disable is a good idea.
>>
> 
> Sure, I added the check. The patch depends on a few other pending
> patches so I just zipped all together. It would be great if you could
> apply them and confirm it fixes the problem, then I can add your
> tested-by and include it in the next series.

Lost track that the mailing list was CC'd so included the latest patch
(check for pm_runtime_get_sync) inline below. Dependent patches are at [1].

Regards,
  -Joel

[1] https://lkml.org/lkml/2014/4/16/737

---8<----------
>From b5884b869a21ffe5472edc59bd07d58b104284b9 Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joelf@ti.com>
Date: Mon, 21 Apr 2014 11:05:10 -0500
Subject: [PATCH 10/10] ARM: OMAP: dmtimer: Check return of
 pm_runtime_get_sync

omap_timer_enable doesn't check return value, this can lead to nasty bus
errors. Add a check and report issues.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   61
+++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/dmtimer.h |    2 +-
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1fd30fa..9403d450 100644
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
@@ -375,11 +377,15 @@ int omap_dm_timer_free(struct omap_dm_timer *timer)
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
+		pr_err("%s: timer could not be get_synced.\n", __func__);
+		return err;
+	}

 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		if (timer->get_context_loss_count) {
@@ -392,6 +398,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 			omap_timer_restore_context(timer);
 		}
 	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_enable);

@@ -432,11 +439,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
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
@@ -534,11 +544,15 @@ int omap_dm_timer_set_load(struct omap_dm_timer
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
@@ -560,11 +574,14 @@ int omap_dm_timer_set_load_start(struct
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
@@ -588,11 +605,15 @@ int omap_dm_timer_set_match(struct omap_dm_timer
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
@@ -613,11 +634,15 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer
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
@@ -637,11 +662,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
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
@@ -659,10 +688,15 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
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
@@ -683,11 +717,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
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


