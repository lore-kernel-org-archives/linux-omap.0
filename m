From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv6 01/45] CLK: TI: Add DPLL clock support
Date: Tue, 10 Sep 2013 15:09:08 -0700
Message-ID: <20130910220908.11074.36005@quantum>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
 <1377782197-10611-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:58066 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3IJWJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 18:09:13 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so8318853pdi.27
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 15:09:12 -0700 (PDT)
In-Reply-To: <1377782197-10611-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Quoting Tero Kristo (2013-08-29 06:15:53)
> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Tero,

Overall this patch is really great. Some minor comments below.

> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> new file mode 100644
> index 0000000..83c21c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> @@ -0,0 +1,68 @@
> +Binding for Texas Instruments DPLL clock.
> +
> +This binding uses the common clock binding[1].  It assumes a
> +register-mapped DPLL with usually two selectable input clocks
> +(reference clock and bypass clock), with digital phase locked
> +loop logic for multiplying the input clock to a desired output
> +clock. This clock also typically supports different operation
> +modes (locked, low power stop etc.) This binding has several
> +sub-types, which effectively result in slightly different setup
> +for the actual DPLL clock.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of:
> +               "ti,omap4-dpll-x2-clock",
> +               "ti,omap3-dpll-clock",
> +               "ti,omap3-dpll-core-clock",
> +               "ti,omap3-dpll-per-clock",
> +               "ti,omap3-dpll-per-j-type-clock",
> +               "ti,omap4-dpll-clock",
> +               "ti,omap4-dpll-core-clock",
> +               "ti,omap4-dpll-m4xen-clock",
> +               "ti,omap4-dpll-j-type-clock",
> +               "ti,omap4-dpll-no-gate-clock",
> +               "ti,omap4-dpll-no-gate-j-type-clock",
> +
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : link phandles of parent clocks, first entry lists reference clock
> +  and second entry bypass clock
> +- reg : address and length of the register set for controlling the DPLL.
> +  It contains the information of registers in the same order as described by
> +  reg-names.
> +- reg-names : array of the register names for controlling the device, sorted
> +  in the same order as the reg property.
> +       "control" - contains the control register base address
> +        "idlest" - contains the idle status register base address
> +        "autoidle" - contains the autoidle register base address
> +        "mult-div1" - contains the multiplier / divider register base address
> +
> +Optional properties:
> +- ti,modes : available modes for the DPLL, bitmask of:
> +  0x02 - DPLL supports low power stop mode
> +  0x20 - DPLL can be put to low power bypass mode
> +  0x80 - DPLL can be put to lock mode (running)

Any particular reason to use a bitmask here versus flags/DT properties?
Something like

Optional properties:
low-power-stop : DPLL supports low power stop mode, gating output
low-power-bypass : DPLL output matches rate of parent bypass clock
lock : DPLL locks in programmed rate

Is there ever a time when a DPLL does not support the locked state? We
can probably remove that from binding entirely.

> +  Other values currently unsupported.
> +- ti,clkdm-name : clockdomain name for the DPLL

What does this mean? I thought that the clockdomain data would not go
into the clock binding?

> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> new file mode 100644
> index 0000000..3f4236d
> --- /dev/null
> +++ b/drivers/clk/ti/dpll.c
> @@ -0,0 +1,476 @@
> +/*
> + * OMAP DPLL clock support
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + *
> + * Tero Kristo <t-kristo@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk/ti.h>
> +
> +static const struct clk_ops dpll_m4xen_ck_ops = {
> +       .enable         = &omap3_noncore_dpll_enable,
> +       .disable        = &omap3_noncore_dpll_disable,
> +       .recalc_rate    = &omap4_dpll_regm4xen_recalc,
> +       .round_rate     = &omap4_dpll_regm4xen_round_rate,
> +       .set_rate       = &omap3_noncore_dpll_set_rate,
> +       .get_parent     = &omap2_init_dpll_parent,
> +};
> +
> +static const struct clk_ops dpll_core_ck_ops = {
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .get_parent     = &omap2_init_dpll_parent,
> +};
> +
> +static const struct clk_ops omap3_dpll_core_ck_ops = {
> +       .init           = &omap2_init_clk_clkdm,
> +       .get_parent     = &omap2_init_dpll_parent,
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .round_rate     = &omap2_dpll_round_rate,
> +};
> +
> +static const struct clk_ops dpll_ck_ops = {
> +       .enable         = &omap3_noncore_dpll_enable,
> +       .disable        = &omap3_noncore_dpll_disable,
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .round_rate     = &omap2_dpll_round_rate,
> +       .set_rate       = &omap3_noncore_dpll_set_rate,
> +       .get_parent     = &omap2_init_dpll_parent,
> +       .init           = &omap2_init_clk_clkdm,
> +};
> +
> +static const struct clk_ops dpll_no_gate_ck_ops = {
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .get_parent     = &omap2_init_dpll_parent,
> +       .round_rate     = &omap2_dpll_round_rate,
> +       .set_rate       = &omap3_noncore_dpll_set_rate,
> +};
> +
> +static const struct clk_ops omap3_dpll_ck_ops = {
> +       .init           = &omap2_init_clk_clkdm,
> +       .enable         = &omap3_noncore_dpll_enable,
> +       .disable        = &omap3_noncore_dpll_disable,
> +       .get_parent     = &omap2_init_dpll_parent,
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .set_rate       = &omap3_noncore_dpll_set_rate,
> +       .round_rate     = &omap2_dpll_round_rate,
> +};
> +
> +static const struct clk_ops omap3_dpll_per_ck_ops = {
> +       .init           = &omap2_init_clk_clkdm,
> +       .enable         = &omap3_noncore_dpll_enable,
> +       .disable        = &omap3_noncore_dpll_disable,
> +       .get_parent     = &omap2_init_dpll_parent,
> +       .recalc_rate    = &omap3_dpll_recalc,
> +       .set_rate       = &omap3_dpll4_set_rate,
> +       .round_rate     = &omap2_dpll_round_rate,
> +};
> +
> +static const struct clk_ops dpll_x2_ck_ops = {
> +       .recalc_rate    = &omap3_clkoutx2_recalc,
> +};

No .set_parent ops for any of the DPLLs? How do you handle bypassing
them? Are you using another mux clock that is the parent of the DPLL, or
just open-coding the bypass stuff?

Regards,
Mike
