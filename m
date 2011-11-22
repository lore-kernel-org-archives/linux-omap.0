From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v3 4/5] clk: basic gateable and fixed-rate clks
Date: Tue, 22 Nov 2011 10:03:16 -0500
Message-ID: <1321974200.2412.25.camel@deneb.redhat.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	 <1321926047-14211-5-git-send-email-mturquette@linaro.org>
	 <201111221311.00117.arnd.bergmann@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201111221311.00117.arnd.bergmann@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Mike Turquette <mturquette@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, eric.miao@linaro.org, richard.zhao@linaro.org, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-11-22 at 13:11 +0000, Arnd Bergmann wrote:
> On Tuesday 22 November 2011, Mike Turquette wrote:
> > +static void clk_hw_gate_set_bit(struct clk *clk)
> > +{
> > +       struct clk_hw_gate *gate = to_clk_hw_gate(clk);
> > +       u32 reg;
> > +
> > +       reg = __raw_readl(gate->reg);
> > +       reg |= BIT(gate->bit_idx);
> > +       __raw_writel(reg, gate->reg);
> > +}
> 
> You cannot rely on __raw_readl() to do the right thing, especially
> in architecture independent code. The safe (but slightly inefficient)
> solution would be readl/writel. For ARM-only code, it would be best
> to use readl_relaxed()/writel_relaxed(), but most architectures do
> not implement that. We can probably add a set of helpers in asm-generic/
> to define them to the default functions, like "#define readl_relaxed(x)
> readl(x)", which I think is a good idea anyway.
> 

readl/writel won't work for big endian CPU when the registers are on a
bus that does the endian swabbing in hardware.

--Mark
