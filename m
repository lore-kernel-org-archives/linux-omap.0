From: "Gurav , Pramod" <pramod.gurav@ti.com>
Subject: RE: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Wed, 10 Mar 2010 11:03:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB3DC@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
 <4B94CC12.3000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56738 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab0CJFdt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 00:33:49 -0500
In-Reply-To: <4B94CC12.3000104@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Ambresh" <ambresh@ti.com>, "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>


Hi Ambresh,

> > +	clk_sel_regval = cm_read_mod_reg(PLL_MOD, CM_CLKSEL);
> 
> *clk already as reference to CM_CLKSEL:
> 
>   static struct clk dpll3_m2_ck = {
> [...]
>          .clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
>          .clksel_mask    = OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
> [...]
> 
> so please use .clksel_reg to read the register content.
> 

This will be done.

> > +	sys_clk_rate = clk_get_rate(clk_get(NULL, "osc_sys_ck"));
> 
> Should it be "sys_ck" instead of "osc_sys_ck"?
> 
> According to my understanding from trm, I guess CLKINP represents DPLL3
> reference clock (DPLL3_ALWON_FCLK) which is nothing but "sys_ck".
> 
> Should not make a difference when the sys_clk divisor is 1, but if it is
> 2, then sys_ck=osc_sys_ck/2.


Yes, it has to be sys_ck and it will be taken care.

> 
> > +	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> > +	nr1 = (4 * (core_dpll_div_n + 1) * 2 * core_dpll_clkoutdiv_m2 *
> > +							 core_dpll_mul_m);
> > +	nr2 = 8 * (core_dpll_div_n + 1);
> > +	nr = nr1 + nr2;
> > +
> > +	dr = 2 * sys_clk_rate * core_dpll_mul_m * core_dpll_clkoutdiv_m2;
> > +
> 
> I am not able to understand the calculations completely for
> (nr1 + nr2) / dr. and I guess you could simplify the calculation a bit
> by removing the redundant multiplications and divisions.
> And also may be you can use m, n & m2 instead of core_dpll_xxx_xx, to
> make code more readable.
> 
> 

I am restructuring the formula with appropriate variable names.


Thank you for your comments.

Regards,
Pramod
