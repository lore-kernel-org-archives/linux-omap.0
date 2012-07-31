From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Tue, 31 Jul 2012 15:56:37 -0500
Message-ID: <50184685.9010608@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55289 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab2GaU4j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 16:56:39 -0400
In-Reply-To: <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Paul,

On 07/12/2012 04:17 PM, Paul Walmsley wrote:

[snip]

> @@ -170,6 +201,18 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & (CLKDM_MISSING_IDLE_REPORTING |
> +			    CLKDM_CAN_FORCE_WAKEUP)) {
> +		(cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
> +			omap3_clkdm_wakeup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);

I think that the above needs to be ...

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index e5bb219..d2b081d 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -253,8 +253,8 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
         * more details on the unpleasant problem this is working
         * around
         */
-       if (clkdm->flags & (CLKDM_MISSING_IDLE_REPORTING |
-                           CLKDM_CAN_FORCE_WAKEUP)) {
+       if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
+                               (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
                omap3_clkdm_wakeup(clkdm);
                return 0;

... otherwise I see other clkdm such as MPU being put in force-wakeup state 
although they don't have CLKDM_MISSING_IDLE_REPORTING set.

Cheers
Jon
