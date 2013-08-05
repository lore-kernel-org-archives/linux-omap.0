From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 07/31] CLK: TI: add omap4 clock init file
Date: Mon, 5 Aug 2013 00:27:04 -0700
Message-ID: <20130805072704.GS7656@atomide.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47970 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab3HEH1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Aug 2013 03:27:07 -0400
Content-Disposition: inline
In-Reply-To: <1375460751-23676-8-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [130802 09:33]:
> clk-44xx.c now contains the clock init functionality for omap4, including
> DT clock registration and adding of static clkdev entries.

Few comments below from "boot new hardware with old kernels" point of
view that seems to be pretty close for clocks.
 
> --- /dev/null
> +++ b/drivers/clk/ti/clk-44xx.c
...

> +int __init omap4xxx_clk_init(void)
> +{
> +	int rc;
> +	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
> +
> +	/* FIXME register clocks from DT first */
> +	of_clk_init(NULL);
> +
> +	omap_dt_clocks_register(omap44xx_clks);
> +
> +	omap2_clk_disable_autoidle_all();
> +
> +	/*
> +	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
> +	 * state when turning the ABE clock domain. Workaround this by
> +	 * locking the ABE DPLL on boot.
> +	 * Lock the ABE DPLL in any case to avoid issues with audio.
> +	 */
> +	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
> +	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
> +	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
> +	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
> +	if (!rc)
> +		rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> +
> +	/*
> +	 * Lock USB DPLL on OMAP4 devices so that the L3INIT power
> +	 * domain can transition to retention state when not in use.
> +	 */
> +	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
> +	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure USB DPLL!\n", __func__);
> +
> +	return 0;
> +}

Maybe try to have a generic init function, then have SoC specific
quirk function pointers set up based on the DT compatible property?

Grep for varioius _of_match[] examples in the drivers.

That way you might be able to make clocks work for some new similar
hardware with just .dts change and patching in the quirks later on
as needed ;)

Regards,

Tony
