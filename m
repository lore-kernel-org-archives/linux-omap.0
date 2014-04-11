From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP3: Fix voltage control for deeper idle
 states
Date: Fri, 11 Apr 2014 08:14:45 -0700
Message-ID: <20140411151445.GA5350@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47712 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbaDKPOu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 11:14:50 -0400
Content-Disposition: inline
In-Reply-To: <1397173639-29587-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

* Tony Lindgren <tony@atomide.com> [140410 16:52]:
> @@ -220,8 +220,18 @@ static inline u32 omap_usec_to_32k(u32 usec)
>  	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
>  }
>  
> +struct omap3_vc_config {
> +	u32 clksetup;
> +	u32 voltsetup1;
> +	u32 voltsetup2;
> +	u32 voltctrl;
> +};

It seems we can keep just voltsetup1 and voltsetup2 here. The
others need to be initialized just once it seems.

>  static void omap3_set_off_timings(struct voltagedomain *voltdm)
>  {
> +	struct omap3_vc_config *c = omap3_vc_timings;
> +	u32 tstart, tshut, voltoffset;
> +
> +	if (c->clksetup)
> +		return;
> +
> +	omap_pm_get_oscillator(&tstart, &tshut);
> +	if (tstart == ULONG_MAX) {
> +		pr_debug("PM: oscillator start-up time not initialized, using 10ms\n");
> +		c->clksetup = omap_usec_to_32k(10000);
> +	} else {
> +		c->clksetup = omap_usec_to_32k(tstart);
> +	}
> +
> +	/*
> +	 * For twl4030 errata 27, we need to allow minimum ~488.32 us wait to
> +	 * switch from HFCLKIN to internal oscillator. That means timings
> +	 * have voltoffset fixed to 0xa in rounded up 32 KiHz cycles. And
> +	 * that means we can calculate the value based on the oscillator
> +	 * start-up time since voltoffset2 = clksetup - voltoffset.
> +	 */
> +	voltoffset = omap_usec_to_32k(488);
> +	c->voltsetup2 = c->clksetup - voltoffset;
> +	voltdm->write(voltoffset, OMAP3_PRM_VOLTOFFSET_OFFSET);

And here we're missing a write to clksetup, without that the off idle
timings are not correct.. Below is an incremental diff on top of this
patch.

Regards,

Tony

8< -------------------------------
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -221,10 +221,8 @@ static inline u32 omap_usec_to_32k(u32 usec)
 }
 
 struct omap3_vc_config {
-	u32 clksetup;
 	u32 voltsetup1;
 	u32 voltsetup2;
-	u32 voltctrl;
 };
 
 static struct omap3_vc_config omap3_vc_timings[2];
@@ -368,17 +366,17 @@ static void omap3_set_i2c_timings(struct voltagedomain *voltdm)
 static void omap3_set_off_timings(struct voltagedomain *voltdm)
 {
 	struct omap3_vc_config *c = omap3_vc_timings;
-	u32 tstart, tshut, voltoffset;
+	u32 tstart, tshut, clksetup, voltoffset;
 
-	if (c->clksetup)
+	if (c->voltsetup2)
 		return;
 
 	omap_pm_get_oscillator(&tstart, &tshut);
 	if (tstart == ULONG_MAX) {
 		pr_debug("PM: oscillator start-up time not initialized, using 10ms\n");
-		c->clksetup = omap_usec_to_32k(10000);
+		clksetup = omap_usec_to_32k(10000);
 	} else {
-		c->clksetup = omap_usec_to_32k(tstart);
+		clksetup = omap_usec_to_32k(tstart);
 	}
 
 	/*
@@ -389,7 +387,8 @@ static void omap3_set_off_timings(struct voltagedomain *voltdm)
 	 * start-up time since voltoffset2 = clksetup - voltoffset.
 	 */
 	voltoffset = omap_usec_to_32k(488);
-	c->voltsetup2 = c->clksetup - voltoffset;
+	c->voltsetup2 = clksetup - voltoffset;
+	voltdm->write(clksetup, OMAP3_PRM_CLKSETUP_OFFSET);
 	voltdm->write(voltoffset, OMAP3_PRM_VOLTOFFSET_OFFSET);
 }
 
