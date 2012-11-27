From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Tue, 27 Nov 2012 17:26:36 +0530
Message-ID: <50B4AA74.1090300@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com> <1353663278.25248.4.camel@sokoban> <50B310D3.9050202@ti.com> <50B35D0E.6000509@ti.com> <50B4A2B7.9080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52860 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112Ab2K0L5M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 06:57:12 -0500
In-Reply-To: <50B4A2B7.9080806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Tuesday 27 November 2012 04:53 PM, Tomi Valkeinen wrote:
> On 2012-11-26 14:14, Archit Taneja wrote:
>
>> So Rajendra and I found the problem.
>>
>> The function _omap4_update_context_lost() reads the register
>> RM_DSS_DSS_CONTEXT for all DSS hwmods, and increments the count if we
>> read a non zero value. The issue is that the DSS's parent platform
>> device (tied to dss_core hwmod) is called first when resuming, it
>> correctly reads the register and observes that DSS lost context, and
>> then clears the register.
>>
>> When the children hwmods are enabled, the see that the registers are
>> cleared, and hence never increment their count.
>>
>> One option is to make the DSS driver use the context lost count of the
>> hwmod corresponding to the parent platform device. It sort of makes a
>> bit of sense as all the DSS platform devices belong to the same power
>> domain, so considering only the parent's context lost count is not so bad.
>>
>> The second option would be to have some usecounting mechanism in
>> omap_hwmod where different hwmods belonging to the same power domain
>> don't have their PM_CONTEXT registers cleared until all the hwmods are
>> enabled.
>>
>> The first option is easier to implement, here is a patch for the DISPC
>> driver:
>>
>>
>>  From 619276fa0e62b90875475eb345a310f1223e82f6 Mon Sep 17 00:00:00 2001
>> From: Archit Taneja <archit@ti.com>
>> Date: Mon, 26 Nov 2012 17:22:27 +0530
>> Subject: [PATCH] OMAPDSS: DISPC: Use DISPC's parent device to get context
>>   lost count
>>
>> When enabling a hwmod, omap_hwmod refers to the register mentioned in the
>> hwmod struct's member 'prcm.omap4.context_offs' to see whether context was
>> lost or not. It increments the context lost count for the hwmod and then
>> clears
>> the register.
>>
>> All the DSS hwmods have the same register(RM_DSS_DSS_CONTEXT) as
>> context_offs.
>> When DSS is enabled, the first hwmod to be enabled is the "dss_core"
>> hwmod since
>> it's the parent platform device. The dss_core hwmod updates it's context
>> lost
>> count correctly and clears the register. When the hwmods corresponding
>> to the
>> children platform devices are enabled. They see that the register is
>> clear, and
>> don't increment their context lost count. Therefore, all the children
>> platfrom
>> devices never report a change in context.
>>
>> The DISPC driver currently gets the context lost count for DSS from it's
>> corresponsing platform device instance. The DISPC platform device is one
>> of the
>> child devices, and doesn't report the context lost count correctly.
>>
>> Make the DISPC driver get the context lost count from it's parent. The
>> parent
>> platform device's hwmod is the only one which correctly updates the
>> context lost
>> count.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dispc.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c
>> b/drivers/video/omap2/dss/dispc.c
>> index a5ab354..d9dfc4ad 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -374,7 +374,7 @@ static void dispc_save_context(void)
>>       if (dss_has_feature(FEAT_CORE_CLK_DIV))
>>           SR(DIVISOR);
>>
>> -    dispc.ctx_loss_cnt = dss_get_ctx_loss_count(&dispc.pdev->dev);
>> +    dispc.ctx_loss_cnt = dss_get_ctx_loss_count(dispc.pdev->dev.parent);
>>       dispc.ctx_valid = true;
>>
>>       DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
>> @@ -389,7 +389,7 @@ static void dispc_restore_context(void)
>>       if (!dispc.ctx_valid)
>>           return;
>>
>> -    ctx = dss_get_ctx_loss_count(&dispc.pdev->dev);
>> +    ctx = dss_get_ctx_loss_count(dispc.pdev->dev.parent);
>>
>>       if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
>>           return;
>
> Hmm, well this feels like a hack. DISPC driver doesn't know how the DSS
> modules are arranged, which module belongs to which power domain, etc.
>
> If it cannot be fixed in the arch code, I guess we could just have
> dss_get_ctx_loss_count(void) function which always returns the
> dss_core's ctx loss count, and define that on all the platforms omapdss
> is used, the dss_core's ctx loss count is the same as ctx loss count for
> all the dss submodules.
>
> I think the above is true for all OMAPs. But it feels like a hack too,
> but not as bad as the above patch.

Yes, a function taking in no platform device in dss's core.c would be 
less hacky. I guess we would need this for now, because a solution in 
omap_hwmod would be more complex and it may not be ready by the merge 
window.

Archit

