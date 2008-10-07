From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/10] ARM: OMAP2: Remove OMAP_PRM_REGADDR,
 OMAP_CM_REGADDR
Date: Tue, 7 Oct 2008 06:54:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810070546410.9923@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002163751.15385.31321.stgit@localhost.localdomain> <20081006161849.GC27466@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33954 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbYJGMyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 08:54:13 -0400
In-Reply-To: <20081006161849.GC27466@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Russell,

On Mon, 6 Oct 2008, Russell King - ARM Linux wrote:

> On Thu, Oct 02, 2008 at 10:37:52AM -0600, Paul Walmsley wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > Remove OMAP_PRM_REGADDR and OMAP_CM_REGADDR.  Use
> > prm_read/write_mod_reg() or cm_read/write_mod_reg() instead.  For
> > assembly, use OMAPXXXX_PRM_REGADDR or OMAPXXXX_CM_REGADDR macros.
> 
> I do have concerns about this patch as well - hating those casts
> that are required to store an offset in 'enable_reg', which then
> have to be un-casted to add the correct base address.

Agreed - that code has been removed already, but the patches haven't
been posted for your review yet.  They are queued for a future merge
window with you (they are currently part of Tony's tree).  Those
patches can be posted now for your review, if you'd prefer.  The
current struct clk is similar to what you propose:

struct clk {
	...
	s16             prcm_mod;
	u32		enable_reg;
	u16		clksel_reg;
	u8		enable_bit;
	u8		idlest_bit;
        ...
	int		(*enable)(struct clk *);
	void		(*disable)(struct clk *);
	...
};

The *_reg fields should be called *_offset, as in your example.  Those
are computed as CM_BASE + prcm_mod + enable_reg (as an example).

(enable_reg is temporarily a u32 until OMAP1 clock code is revised.
For OMAP2/3 it can be a u16.)

We currently use the following code for clock register loads and stores
in mach-omap2/clock.c:


/*
 * _omap2_clk_read_reg - read a clock register
 * @clk: struct clk *
 *
 * Given a struct clk *, returns the value of the clock's register.
 */
static u32 _omap2_clk_read_reg(u16 reg_offset, struct clk *clk)
{
	if (clk->prcm_mod & CLK_REG_IN_SCM)
		return omap_ctrl_readl(reg_offset);
	else if (clk->prcm_mod & CLK_REG_IN_PRM)
		return prm_read_mod_reg(clk->prcm_mod & PRCM_MOD_ADDR_MASK,
					reg_offset);
	else
		return cm_read_mod_reg(clk->prcm_mod, reg_offset);
}

/*
 * _omap2_clk_write_reg - write a clock's register
 * @v: value to write to the clock's enable_reg
 * @clk: struct clk *
 *
 * Given a register value @v and struct clk * @clk, writes the value
 * of @v to the clock's enable register.  No return value.
 */
static void _omap2_clk_write_reg(u32 v, u16 reg_offset,
                                 struct clk *clk)
{
	if (clk->prcm_mod & CLK_REG_IN_SCM)
		omap_ctrl_writel(v, reg_offset);
	else if (clk->prcm_mod & CLK_REG_IN_PRM)
		prm_write_mod_reg(v, clk->prcm_mod & PRCM_MOD_ADDR_MASK,
				  reg_offset);
	else
		cm_write_mod_reg(v, clk->prcm_mod, reg_offset);
}


Does this look reasonable?


- Paul
