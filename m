From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Setting OMAP DSS fck
Date: Thu, 1 Dec 2011 09:58:43 +0100
Message-ID: <4ED741C3.9010904@ti.com>
References: <1322727382.16429.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab1LAI6r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 03:58:47 -0500
In-Reply-To: <1322727382.16429.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap mailing list <linux-omap@vger.kernel.org>, "Turquette, Mike" <mturquette@ti.com>

Hi Tomi,

On 12/1/2011 9:16 AM, Tomi Valkeinen wrote:
> Hi,
>
> Why is it that the rate of DSS functional clock (dss_dss_clk on OMAP4)
> cannot be set, but we need to get the parent of the fck, and set the
> rate of that? The same is on OMAP3.

This is a limitation of the clock fmwk, you cannot change the rate if 
you do not have a .set_rate function in your clock node. It is not 
propagated automatically to the parent.

In your case, here is the parent:

static struct clk dpll_per_m5x2_ck = {
	.name		= "dpll_per_m5x2_ck",
	.parent		= &dpll_per_x2_ck,
	.clksel		= dpll_per_m2x2_div,
	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_PER,
	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
	.ops		= &clkops_omap4_dpllmx_ops,
	.recalc		= &omap2_clksel_recalc,
	.round_rate	= &omap2_clksel_round_rate,
	.set_rate	= &omap2_clksel_set_rate,
};

And here is the child you are trying to set the rate to.

static struct clk dss_dss_clk = {
	.name		= "dss_dss_clk",
	.ops		= &clkops_omap2_dflt,
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
	.clkdm_name	= "l3_dss_clkdm",
	.parent		= &dpll_per_m5x2_ck,
	.recalc		= &followparent_recalc,
};

Propagating a set_rate to a parent is not a simple task because the fmwk 
do not have a clue about the siblings you might potentially have. And 
changing the parent will have an impact on every potential children.

In this case, it seems that there is only one child, so it might be 
possible.

I know this kind of issue was discussed during the new common clock fmwk 
discussion.

I'm Cc'ing Mike who will know the status of such feature.

>  From driver's perspective I think this only makes things more complex,
> as the driver is not interested in the parent, only about the dss fck.

Fully agree. It should transparent for the driver.

Regards,
Benoit
