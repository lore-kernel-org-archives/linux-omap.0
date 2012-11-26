From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Mon, 26 Nov 2012 17:44:06 +0530
Message-ID: <50B35D0E.6000509@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com> <1353663278.25248.4.camel@sokoban> <50B310D3.9050202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58364 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab2KZMOp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 07:14:45 -0500
In-Reply-To: <50B310D3.9050202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

On Monday 26 November 2012 12:18 PM, Archit Taneja wrote:
> On Friday 23 November 2012 03:04 PM, Tero Kristo wrote:
>> On Thu, 2012-11-22 at 16:44 +0200, Tomi Valkeinen wrote:
>>> On 2012-11-22 16:34, Tero Kristo wrote:
>>>
>>>> I guess you checked that DSS pwrdm is switching between RET and ON in
>>>> your setup?
>>>
>>> Yes:
>>>
>>> # cat /debug/pm_debug/count |grep dss
>>> [   35.356567] pwrdm state mismatch(l3init_pwrdm) 3 != 1
>>> [   35.361938] pwrdm state mismatch(cam_pwrdm) 3 != 0
>>> [   35.366973] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
>>> [   35.372253] pwrdm state mismatch(tesla_pwrdm) 3 != 1
>>> [   35.377532] pwrdm state mismatch(abe_pwrdm) 3 != 1
>>> dss_pwrdm
>>> (RET),OFF:1,RET:11,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
>>> l3_dss_clkdm->dss_pwrdm (0)
>>>
>>> then I load and unload the dss modules, and then:
>>>
>>> # cat /debug/pm_debug/count |grep dss
>>> [   60.813629] pwrdm state mismatch(l3init_pwrdm) 3 != 1
>>> [   60.819000] pwrdm state mismatch(cam_pwrdm) 3 != 0
>>> [   60.824127] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
>>> [   60.829376] pwrdm state mismatch(tesla_pwrdm) 3 != 1
>>> [   60.834625] pwrdm state mismatch(abe_pwrdm) 3 != 1
>>> dss_pwrdm
>>> (ON),OFF:1,RET:21,INA:0,ON:22,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
>>> l3_dss_clkdm->dss_pwrdm (0)
>>>
>>>>> Does the pwrdm mistakenly think that in RET state the DSS still keeps
>>>>> the register contents?
>>>>
>>>> This might be the case, however the pwrdm code should be generic and
>>>> handle all domains properly. What is the tree / branch / commit you are
>>>> using for testing this stuff? I can take a look at this also.
>>>
>>> arm-soc/for-next
>>
>> I guess this is caused because some of the patches are still not in the
>> for-next branch, it looks like at least this is missing:
>>
>> https://patchwork.kernel.org/patch/1608901/
>>
>> ...or the latest update done by Paul to that one.
>>
>> The patch I posted appears to have a small merge induced bug, it is
>> registering the context loss soc_ops for am33xx when it should actually
>> register those for omap4. This might explain another bug I've been
>> looking at in a different branch recently... The update Paul posted does
>> not seem to have this problem, but I haven't tested it myself.
>
>
> Applying the patch above, and registering the soc_ops for omap4 instead
> of am33xx doesn't seem to help. The context lost count now always
> returns 0.
>
> And to verify Tomi's observation, if we don't rely on the context lost
> count, and restore the registers always, we don't see the problem.

So Rajendra and I found the problem.

The function _omap4_update_context_lost() reads the register 
RM_DSS_DSS_CONTEXT for all DSS hwmods, and increments the count if we 
read a non zero value. The issue is that the DSS's parent platform 
device (tied to dss_core hwmod) is called first when resuming, it 
correctly reads the register and observes that DSS lost context, and 
then clears the register.

When the children hwmods are enabled, the see that the registers are 
cleared, and hence never increment their count.

One option is to make the DSS driver use the context lost count of the 
hwmod corresponding to the parent platform device. It sort of makes a 
bit of sense as all the DSS platform devices belong to the same power 
domain, so considering only the parent's context lost count is not so bad.

The second option would be to have some usecounting mechanism in 
omap_hwmod where different hwmods belonging to the same power domain 
don't have their PM_CONTEXT registers cleared until all the hwmods are 
enabled.

The first option is easier to implement, here is a patch for the DISPC 
driver:


 From 619276fa0e62b90875475eb345a310f1223e82f6 Mon Sep 17 00:00:00 2001
From: Archit Taneja <archit@ti.com>
Date: Mon, 26 Nov 2012 17:22:27 +0530
Subject: [PATCH] OMAPDSS: DISPC: Use DISPC's parent device to get context
  lost count

When enabling a hwmod, omap_hwmod refers to the register mentioned in the
hwmod struct's member 'prcm.omap4.context_offs' to see whether context was
lost or not. It increments the context lost count for the hwmod and then 
clears
the register.

All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as 
context_offs.
When DSS is enabled, the first hwmod to be enabled is the "dss_core" 
hwmod since
it's the parent platform device. The dss_core hwmod updates it's context 
lost
count correctly and clears the register. When the hwmods corresponding 
to the
children platform devices are enabled. They see that the register is 
clear, and
don't increment their context lost count. Therefore, all the children 
platfrom
devices never report a change in context.

The DISPC driver currently gets the context lost count for DSS from it's
corresponsing platform device instance. The DISPC platform device is one 
of the
child devices, and doesn't report the context lost count correctly.

Make the DISPC driver get the context lost count from it's parent. The 
parent
platform device's hwmod is the only one which correctly updates the 
context lost
count.

Signed-off-by: Archit Taneja <archit@ti.com>
---
  drivers/video/omap2/dss/dispc.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c 
b/drivers/video/omap2/dss/dispc.c
index a5ab354..d9dfc4ad 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -374,7 +374,7 @@ static void dispc_save_context(void)
  	if (dss_has_feature(FEAT_CORE_CLK_DIV))
  		SR(DIVISOR);

-	dispc.ctx_loss_cnt = dss_get_ctx_loss_count(&dispc.pdev->dev);
+	dispc.ctx_loss_cnt = dss_get_ctx_loss_count(dispc.pdev->dev.parent);
  	dispc.ctx_valid = true;

  	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
@@ -389,7 +389,7 @@ static void dispc_restore_context(void)
  	if (!dispc.ctx_valid)
  		return;

-	ctx = dss_get_ctx_loss_count(&dispc.pdev->dev);
+	ctx = dss_get_ctx_loss_count(dispc.pdev->dev.parent);

  	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
  		return;
-- 
1.7.9.5

