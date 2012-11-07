From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer and Counter DT Updates for v3.8
Date: Wed, 7 Nov 2012 15:44:04 -0800
Message-ID: <20121107234403.GS6801@atomide.com>
References: <50941812.2070501@ti.com>
 <20121107004703.GS6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752204Ab2KGXoH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 18:44:07 -0500
Content-Disposition: inline
In-Reply-To: <20121107004703.GS6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

Hi Jon,

* Tony Lindgren <tony@atomide.com> [121106 16:48]:
> * Jon Hunter <jon-hunter@ti.com> [121102 12:01]:
> > 
> >   git@github.com:jonhunter/linux.git dev-dt-timer
> 
> Thanks pulling into omap-for-v3.8/dt branch.

Looks like omap-for-v3.8/dt boots OK on blaze when booted
with device tree, but then current omap-for-v3.8/tmp-merge
oopses.

I guess we should apply the following fix somewhere or
do we need to check other places too?

Regards,

Tony

[<c04e3d30>] (omap_dm_timer_probe+0x110/0x310) from [<c0334a18>] (platform_drv_probe+0x1c/0x24)
[<c0334a18>] (platform_drv_probe+0x1c/0x24) from [<c03335d4>] (really_probe+0x60/0x1f4)
[<c03335d4>] (really_probe+0x60/0x1f4) from [<c033379c>] (driver_probe_device+0x34/0x50)
[<c033379c>] (driver_probe_device+0x34/0x50) from [<c033384c>] (__driver_attach+0x94/0x98)
[<c033384c>] (__driver_attach+0x94/0x98) from [<c0331df8>] (bus_for_each_dev+0x60/0x8c)
[<c0331df8>] (bus_for_each_dev+0x60/0x8c) from [<c03326c4>] (bus_add_driver+0x18c/0x254)
[<c03326c4>] (bus_add_driver+0x18c/0x254) from [<c0333e44>] (driver_register+0x5c/0x150)
[<c0333e44>] (driver_register+0x5c/0x150) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[<c0008868>] (do_one_initcall+0x2c/0x178) from [<c06df2a0>] (do_basic_setup+0x94/0xd0)
[<c06df2a0>] (do_basic_setup+0x94/0xd0) from [<c06df358>] (kernel_init_freeable+0x7c/0x124)
[<c06df358>] (kernel_init_freeable+0x7c/0x124) from [<c04e1810>] (kernel_init+0x8/0x1a8)
[<c04e1810>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)

--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -803,8 +803,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
 	timer->irq = irq->start;
 	timer->pdev = pdev;
-	timer->capability = pdata->timer_capability;
-	timer->get_context_loss_count = pdata->get_context_loss_count;
+
+	if (pdata) {
+		timer->capability = pdata->timer_capability;
+		timer->get_context_loss_count = pdata->get_context_loss_count;
+	}
 
 	/* Skip pm_runtime_enable for OMAP1 */
 	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
