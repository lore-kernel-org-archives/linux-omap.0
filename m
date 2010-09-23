From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 10:52:37 -0700
Message-ID: <87zkv81h5m.fsf@deeprootsystems.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com>
	<20100923064910.GF2563@legolas.emea.dhcp.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D9EB@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863DD49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58439 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab0IWRwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 13:52:40 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD49@dbde02.ent.ti.com>
	(Hema Kalliguddi's message of "Thu, 23 Sep 2010 21:07:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

"Kalliguddi, Hema" <hemahk@ti.com> writes:

[...]

>>>>
>>>> static u64 musb_dmamask = DMA_BIT_MASK(32);
>>>>@@ -80,6 +89,7 @@ void __init usb_musb_init(struct omap_mu
>>>> 	const char *oh_name = "usb_otg_hs";
>>>> 	struct musb_hdrc_platform_data *pdata;
>>>>
>>>>+	core_pwrdm = pwrdm_lookup("per_pwrdm");
>>>
>>>per or core ???
>>>
>>Oh! It should be core. Now I understand why save/restore 
>>counts were not matching with
>>Core-off counts.
>>Thanks for pointing this out.
>
> If I call pm_runtime_put_sync and pm_runtime_get_sync based on the core domain state then
> the USB connect/reset interrupt is not triggered once the core hits off.
>
> In omap3_enter_idle_bm() there is no core next state being programmed to PRCM register,
>
> but the drivers functions which are called from omap3_device_idle are suppose to read the
> core next state from the PRCM register.
> I am missing something here?

Ah, this is indeed a big problem.  Good catch.

Both the CORE and MPU states are programmed in omap3_enter_idle(), but
that doesn't happen until after omap3_device_idle().  hmmm....

> If I use the per_pwrdm states to save the context and restore everything works fine.

Yes, because PER is programmed in omap3_enter_idle_bm() so it's
available already in the registers.

I've updated my "idle reorg" series which creates omap3_device_idle &
_resume (and enables interrupts in CPUidle.)   I updated it to
not call omap3_device_idle until the MPU & CORE registers are
programmed (diff below.)  This is in my pm-wip/idle-reorg branch, which
is based on pm-core.

Thanks,

Kevin

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index cf4207f..51fef17 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -125,14 +125,16 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
 	current_cx_state = *cx;
 
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
+	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
+	pwrdm_set_next_pwrst(core_pd, core_state);
+
+	omap3_device_idle();
 
 	local_irq_disable();
 	local_fiq_disable();
 
-	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
-	pwrdm_set_next_pwrst(core_pd, core_state);
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
 
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
@@ -157,6 +159,8 @@ return_sleep_time:
 	local_irq_enable();
 	local_fiq_enable();
 
+	omap3_device_resume();
+
 	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
 }
 
