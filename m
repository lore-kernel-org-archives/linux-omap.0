From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/07] ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code
Date: Thu, 9 Oct 2008 15:37:55 +0100
Message-ID: <20081009143755.GF435@flint.arm.linux.org.uk>
References: <1223035009-23866-1-git-send-email-tony@atomide.com> <1223035009-23866-2-git-send-email-tony@atomide.com> <1223035009-23866-3-git-send-email-tony@atomide.com> <1223035009-23866-4-git-send-email-tony@atomide.com> <1223035009-23866-5-git-send-email-tony@atomide.com> <1223035009-23866-6-git-send-email-tony@atomide.com> <1223035009-23866-7-git-send-email-tony@atomide.com> <1223035009-23866-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57809 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYJIOiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 10:38:10 -0400
Content-Disposition: inline
In-Reply-To: <1223035009-23866-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Fri, Oct 03, 2008 at 02:56:49PM +0300, Tony Lindgren wrote:
> Fix sparse warnings in mach-omap2/irq.c. Fix by defining
> intc_bank_write_reg() and intc_bank_read_reg(), and convert INTC module
> register access to use them rather than __raw_{read,write}l.

This is not a fix.
> +/* INTC bank register get/set */
> +
> +static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
> +{
> +	__raw_writel(val, (__force void __iomem *)(bank->base_reg + reg));
> +}
> +
> +static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
> +{
> +	return __raw_readl((__force void __iomem *)(bank->base_reg + reg));

Because it uses __force here.  In my tree, bank->base_reg is defined
to be:

        void __iomem *base_reg;

So these cases are entirely unnecessary.  As I've said before, use of
__force is generally a sure sign of doing something wrong.
