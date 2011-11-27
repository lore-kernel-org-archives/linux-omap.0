From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
Date: Sun, 27 Nov 2011 08:09:39 +0800
Message-ID: <20111127000938.GE19025@S2100-06.ap.freescale.net>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-5-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:47612
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755045Ab1KZX5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Nov 2011 18:57:24 -0500
Content-Disposition: inline
In-Reply-To: <1321926047-14211-5-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, Mike Turquette <mturquette@linaro.org>

One comment was missed.

On Mon, Nov 21, 2011 at 05:40:46PM -0800, Mike Turquette wrote:
[...]
> +struct clk_hw_ops clk_hw_gate_set_enable_ops = {

const?

> +	.enable = clk_hw_gate_enable_set,
> +	.disable = clk_hw_gate_disable_clear,
> +	.recalc_rate = clk_hw_gate_recalc_rate,
> +	.get_parent = clk_hw_gate_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_hw_gate_set_enable_ops);
> +
> +static int clk_hw_gate_enable_clear(struct clk *clk)
> +{
> +	clk_hw_gate_clear_bit(clk);
> +
> +	return 0;
> +}
> +
> +static void clk_hw_gate_disable_set(struct clk *clk)
> +{
> +	clk_hw_gate_set_bit(clk);
> +}
> +
> +struct clk_hw_ops clk_hw_gate_set_disable_ops = {

ditto

Regards,
Shawn

> +	.enable = clk_hw_gate_enable_clear,
> +	.disable = clk_hw_gate_disable_set,
> +	.recalc_rate = clk_hw_gate_recalc_rate,
> +	.get_parent = clk_hw_gate_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_hw_gate_set_disable_ops);

