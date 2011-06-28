From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 8/8] OMAP2+: hwmod: Follow the recommended PRCM module enable sequence
Date: Mon, 27 Jun 2011 17:11:53 -0700
Message-ID: <87iprq4xx2.fsf@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
	<1309191103-8817-9-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57416 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755002Ab1F1AL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 20:11:59 -0400
Received: by mail-pv0-f182.google.com with SMTP id 11so4119618pvg.41
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 17:11:58 -0700 (PDT)
In-Reply-To: <1309191103-8817-9-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 27 Jun 2011 18:11:43 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, toddpoynor@google.com

Benoit Cousson <b-cousson@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> On OMAP4, the PRCM recommended sequence for enabling
> a module after power-on-reset is:
> -1- Force clkdm to SW_WKUP
> -2- Enabling the clocks
> -3- Configure desired module mode to "enable" or "auto"
> -4- Wait for the desired module idle status to be FUNC
> -5- Program clkdm in HW_AUTO(if supported)
>
> This sequence applies to all older OMAPs' as well,
> however since they use autodeps, it makes sure that
> no clkdm is in IDLE, and hence not requiring a force
> SW_WKUP when a module is being enabled.
>
> OMAP4 does not need to support autodeps, because
> of the dyanamic dependency feature, wherein
> the HW takes care of waking up a clockdomain from
> idle and hence the module, whenever an interconnect
> access happens to the given module.
>
> Implementing the sequence for OMAP4 requires
> the clockdomain handling that is currently done in
> clock framework to be done as part of hwmod framework
> since the step -4- above to "Wait for the desired
> module idle status to be FUNC" is done as part of
> hwmod framework.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 3eef106..3538805 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1360,6 +1360,7 @@ static int _reset(struct omap_hwmod *oh)
>  static int _enable(struct omap_hwmod *oh)
>  {
>  	int r;
> +	int hwsup = 0;
>  
>  	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
>  	    oh->_state != _HWMOD_STATE_IDLE &&
> @@ -1378,6 +1379,19 @@ static int _enable(struct omap_hwmod *oh)
>  		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>  
>  	_add_initiator_dep(oh, mpu_oh);
> +
> +	/*
> +	 * A clockdomain must be in SW_SUP before enabling completely the
> +	 * module. The clockdomain can be set in HW_AUTO only when the module
> +	 * become ready.
> +	 */
> +	hwsup = clkdm_allows_idle(oh->clkdm);
> +	r = clkdm_hwmod_enable(oh->clkdm, oh);
> +	if (r) {
> +		WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
> +		     oh->name, oh->clkdm->name, r);
> +		return r;
> +	}

If oh->clkdm == NULL (as it is on OMAP3 since the hwmod data has no
clkdms yet), this hangs trying to dereference oh->clkdm->name.

Simple fix below, but probably better is to not call any of these
functions if oh->clkdm == NULL, otherwise this is very noisy on OMAP3
since that WARN is printed for every hwmod.

Is anyone planning to add the clkdms to OMAP3 hwmod data?

Kevin


diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 51a13f3..4bcffca 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1391,9 +1391,10 @@ static int _enable(struct omap_hwmod *oh)
 	r = clkdm_hwmod_enable(oh->clkdm, oh);
 	if (r) {
 		WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
-		     oh->name, oh->clkdm->name, r);
+		     oh->name, oh->clkdm ? oh->clkdm->name : "none", r);
 		return r;
 	}
+
 	_enable_clocks(oh);
 	_enable_module(oh);
 
