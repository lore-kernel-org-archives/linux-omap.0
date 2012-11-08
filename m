From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer and Counter DT Updates for v3.8
Date: Thu, 8 Nov 2012 11:19:44 -0600
Message-ID: <509BE9B0.5040608@ti.com>
References: <50941812.2070501@ti.com> <20121107004703.GS6801@atomide.com> <20121107234403.GS6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab2KHRTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 12:19:53 -0500
In-Reply-To: <20121107234403.GS6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>


On 11/07/2012 05:44 PM, Tony Lindgren wrote:
> Hi Jon,
> 
> * Tony Lindgren <tony@atomide.com> [121106 16:48]:
>> * Jon Hunter <jon-hunter@ti.com> [121102 12:01]:
>>>
>>>   git@github.com:jonhunter/linux.git dev-dt-timer
>>
>> Thanks pulling into omap-for-v3.8/dt branch.
> 
> Looks like omap-for-v3.8/dt boots OK on blaze when booted
> with device tree, but then current omap-for-v3.8/tmp-merge
> oopses.

That's a bugger. I completely missed your patch last week sorry (I will blame the Danish
beer) and had clearly not folded in to my testing!

> I guess we should apply the following fix somewhere or
> do we need to check other places too?

I will re-test your master branch today and put it through my dmtimer tests to double check.
However, in general I did ensure that we checked pdata was not NULL before accessing when 
I introduced the dt stuff. In my changelog [1] I had ...

"5. When device-tree is present the platform_data structure will be NULL and so check for
this."

I just need to make sure that get_context_loss_count() is not called before checking it is
populated.  
 
> Regards,
> 
> Tony
> 
> [<c04e3d30>] (omap_dm_timer_probe+0x110/0x310) from [<c0334a18>] (platform_drv_probe+0x1c/0x24)
> [<c0334a18>] (platform_drv_probe+0x1c/0x24) from [<c03335d4>] (really_probe+0x60/0x1f4)
> [<c03335d4>] (really_probe+0x60/0x1f4) from [<c033379c>] (driver_probe_device+0x34/0x50)
> [<c033379c>] (driver_probe_device+0x34/0x50) from [<c033384c>] (__driver_attach+0x94/0x98)
> [<c033384c>] (__driver_attach+0x94/0x98) from [<c0331df8>] (bus_for_each_dev+0x60/0x8c)
> [<c0331df8>] (bus_for_each_dev+0x60/0x8c) from [<c03326c4>] (bus_add_driver+0x18c/0x254)
> [<c03326c4>] (bus_add_driver+0x18c/0x254) from [<c0333e44>] (driver_register+0x5c/0x150)
> [<c0333e44>] (driver_register+0x5c/0x150) from [<c0008868>] (do_one_initcall+0x2c/0x178)
> [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c06df2a0>] (do_basic_setup+0x94/0xd0)
> [<c06df2a0>] (do_basic_setup+0x94/0xd0) from [<c06df358>] (kernel_init_freeable+0x7c/0x124)
> [<c06df358>] (kernel_init_freeable+0x7c/0x124) from [<c04e1810>] (kernel_init+0x8/0x1a8)
> [<c04e1810>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
> 
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -803,8 +803,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>  
>  	timer->irq = irq->start;
>  	timer->pdev = pdev;
> -	timer->capability = pdata->timer_capability;
> -	timer->get_context_loss_count = pdata->get_context_loss_count;
> +
> +	if (pdata) {
> +		timer->capability = pdata->timer_capability;

You don't need this it is already handled a few lines before.

> +		timer->get_context_loss_count = pdata->get_context_loss_count;

We could probably move this too. For example ...

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 38c12ef..9dca23e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -799,12 +799,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
                timer->id = pdev->id;
                timer->capability = pdata->timer_capability;
                timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
+               timer->get_context_loss_count = pdata->get_context_loss_count;
        }
 
        timer->irq = irq->start;
        timer->pdev = pdev;
-       timer->capability = pdata->timer_capability;
-       timer->get_context_loss_count = pdata->get_context_loss_count;
 
        /* Skip pm_runtime_enable for OMAP1 */
        if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=135065877008624&w=2
