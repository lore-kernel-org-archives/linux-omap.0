From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH v4 5/6] clk: basic gateable and fixed-rate clks
Date: Wed, 14 Dec 2011 16:15:01 +1100
Message-ID: <4EE830D5.5070305@gmail.com>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org> <1323834838-2206-6-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323834838-2206-6-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@ti.com, andrew@lunn.ch, Jamie Iles <jamie@jamieiles.com>
List-Id: linux-omap@vger.kernel.org

On 14/12/11 14:53, Mike Turquette wrote:

> Many platforms support simple gateable clks and fixed-rate clks that
> should not be re-implemented by every platform.
> 
> This patch introduces a gateable clk with a common programming model of
> gate control via a write of 1 bit to a register.  Both set-to-enable and
> clear-to-enable are supported.
> 
> Also introduced is a fixed-rate clk which has no reprogrammable aspects.
> 
> The purpose of both types of clks is documented in drivers/clk/basic.c.
> 
> TODO: add support for a simple divider, simple mux and a dummy clk for
> stubbing out platform support.
> 
> Based on original patch by Jeremy Kerr and contribution by Jamie Iles.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Jamie Iles <jamie@jamieiles.com>

<snip>

> +int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
> +		struct clk *fixed_parent, void __iomem *reg, u8 bit_idx,
> +		int set_to_enable)
> +{
> +	struct clk_hw_gate *gclk;
> +	struct clk *clk;
> +
> +	gclk = kmalloc(sizeof(struct clk_hw_gate), GFP_KERNEL);
> +
> +	if (!gclk) {
> +		pr_err("%s: could not allocate gated clk\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	clk = &gclk->clk;
> +
> +	/* struct clk_hw_gate assignments */
> +	gclk->fixed_parent = fixed_parent;
> +	gclk->reg = reg;
> +	gclk->bit_idx = bit_idx;
> +
> +	/* struct clk assignments */
> +	clk->name = name;
> +	clk->flags = flags;
> +
> +	if (set_to_enable)
> +		clk->ops = &clk_hw_gate_set_enable_ops;
> +	else
> +		clk->ops = &clk_hw_gate_set_disable_ops;


You could avoid having two sets of operations if you stored the
set_to_enable value in struct clk_hw_gate. It might be useful to store
additional information in struct clk_hw_gate if you also want to extend
to supporting non-32bit registers (readb, etc), clocks with write only
registers, or support clocks which require more than one bit to be set
or cleared to enable them, etc. See the basic mmio gpio driver for a
similar case.

~Ryan
