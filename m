From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 04/41] CLK: TI: Add DPLL clock support
Date: Tue, 17 Dec 2013 08:37:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170835080.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3LQIh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 03:37:57 -0500
In-Reply-To: <1385453182-24421-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> +/*
> + * struct clk_hw_omap.flags possibilities
> + *
> + * XXX document the rest of the clock flags here
> + *
> + * ENABLE_REG_32BIT: (OMAP1 only) clock control register must be accessed
> + *     with 32bit ops, by default OMAP1 uses 16bit ops.
> + * CLOCK_IDLE_CONTROL: (OMAP1 only) clock has autoidle support.
> + * CLOCK_NO_IDLE_PARENT: (OMAP1 only) when clock is enabled, its parent
> + *     clock is put to no-idle mode.
> + * ENABLE_ON_INIT: Clock is enabled on init.
> + * INVERT_ENABLE: By default, clock enable bit behavior is '1' enable, '0'
> + *     disable. This inverts the behavior making '0' enable and '1' disable.
> + * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
> + *     bits share the same register.  This flag allows the
> + *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
> + *     should be used.  This is a temporary solution - a better approach
> + *     would be to associate clock type-specific data with the clock,
> + *     similar to the struct dpll_data approach.
> + * REGMAP_ADDRESSING: Use regmap addressing to access clock registers.
> + */

Nice work adding the additional flag documentation here.


- Paul
