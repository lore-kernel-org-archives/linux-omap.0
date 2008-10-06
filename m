From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
Date: Mon, 6 Oct 2008 17:18:49 +0100
Message-ID: <20081006161849.GC27466@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48516 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYJFQTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 12:19:04 -0400
Content-Disposition: inline
In-Reply-To: <20081002163751.15385.31321.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Oct 02, 2008 at 10:37:52AM -0600, Paul Walmsley wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> Remove OMAP_PRM_REGADDR and OMAP_CM_REGADDR.  Use
> prm_read/write_mod_reg() or cm_read/write_mod_reg() instead.  For
> assembly, use OMAPXXXX_PRM_REGADDR or OMAPXXXX_CM_REGADDR macros.

I do have concerns about this patch as well - hating those casts
that are required to store an offset in 'enable_reg', which then
have to be un-casted to add the correct base address.

I've been trying to work out if there's a better way to do this
using the existing structures.  How about:

struct clk {
	...
	void __iomem	*base;
	struct clk	*other_clk;	/* associated func/interface clock */
	u16		enable_offset;
	u16		idlest_offset;
	u16		clksel_offset;
	u8		enable_bit;
	u8		idlest_bit;
	...
	int		(*enable)(struct clk *);
	void		(*disable)(struct clk *);
	...
};

(or use u8 if the offsets always fit.)

The setup of apll96_ck becomes:

static struct clk apll96_ck = {
	.name		= "apll96_ck",
	.parent 	= &sys_ck,
	.rate		= 96000000,
	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
	.clkdm_name	= "wkup_clkdm",

	.enable_offset	= CM_REG_OFFSET(PLL_MOD, CM_CLKEN),
	.idlest_offset	= CM_REG_OFFSET(PLL_MOD, CM_IDLEST),

	.enable_bit	= OFFSET_OF_BIT(EN_APLL_LOCKED << OMAP24XX_EN_96M_PLL_SHIFT),
	.idlest_bit	= OFFSET_OF_BIT(OMAP24XX_ST_96M_APLL),

	.enable 	= clkll_enable32_and_wait,
	.disable	= clkll_disable32,

	.recalc 	= &propagate_rate,
};

(replacing OFFSET_OF_BIT() with the appropriate real bit position number).

You register all such clocks thusly:

void clk_register_offset_clks(void __iomem *base, struct clk **clks, size_t num)
{
	size_t i;
	for (i = 0; i < num; i++) {
		struct clk *clk = clks[i];

		clk->base = base;
		clk_register(clk);
	}
}

static struct clk cm_clks[] = {
	&apll96_ck,
};

	clk_register_offset_clks(cm_base, cm_clks, ARRAY_SIZE(cm_clks);

and, eg, the accesses to the enable register become:

int clkll_enable32(struct clk *clk)
{
	u32 val, mask = 1 << clk->enable_bit;

	val = __raw_readl(clk->base + clk->enable_offset);
	if (clk->flags & INVERT_ENABLE)
		val &= ~mask;
	else
		val |= mask;
	__raw_writel(val, clk->base + clk->enable_offset);
	wmb();
	return 0;
}

void clkll_disable32(struct clk *clk)
{
	u32 val, mask = 1 << clk->enable_bit;

	val = __raw_readl(clk->base + clk->enable_offset);
	if (clk->flags & INVERT_ENABLE)
		val |= mask;
	else
		val &= ~mask;
	__raw_writel(val, clk->base + clk->enable_offset);
	wmb();
}

int clkll_is_running32(struct clk *clk)
{
	u32 val, mask = 1 << clk->enable_bit;
	val = __raw_readl(clk->base + clk->enable_offset) & mask;
	return clk->flags & INVERT_ENABLE ? !val : !!val;
}

int clkll_enable32_and_wait(struct clk *clk)
{
	u32 mask, result, val;
	unsigned int tries = 0;

	if (!clkll_is_running32(clk))
		clkll_enable32(clk);

	/* check if other clock, if any, is running */
	if (clk->other_clk && !clkll_is_running32(clk->other_clk))
		return 0;

	val = mask = 1 << clk->idlest_bit;
	if (inverted_on_this_cpu)
		val = 0;

	for (tries = 0; tries < MAX_CLOCK_ENABLE_WAIT; tries++, udelay(1)) {
		result = __raw_readl(clk->base + clk->idlest_offset) & mask;
		if (result == val)
			break;
	}

	if (result == val)
		pr_debug("Clock %s stable after %uus\n", clk->name, tries);
	else
		pr_err("Clock %s failed to stablize after %uus\n",
			clk->name, tries);

	return result == val ? 0 : -ETIMEDOUT;
}

Then, you use clkll_enable32() if you don't need to wait for the clock
to stablize, or clkll_enable32_and_wait() if you do.

If you need 16-bit, which I think I've seen, obviously create the
corresponding versions.
