From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 19:48:04 +0100
Message-ID: <20080903184804.GA1788@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50802 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYICSsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 14:48:16 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510809030833w6cbc7e42ye0e8f4fc49b5b046@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 11:33:51AM -0400, Eduardo Valentin wrote:
> > @@ -159,7 +159,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
> >  #ifdef CONFIG_ARCH_OMAP15XX
> >  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
> >        {
> > -               .virt_base      = OMAP1510_MCBSP1_BASE,
> > +               .virt_base      = OMAP1510_MCBSP1_BASE, /* FIXME: virtual or physical */
> AFAIK, OMAP1510_MCBSP1_BASE is physical. So, I'd say:
> +               .virt_base      = IO_ADDRESS(OMAP1510_MCBSP1_BASE),
> 
> Because, plat-omap/mcbsp.c expect .virt_base to be a virtual address.

Ok, I'll fix these which you've confirmed in my version for mainline.

> > @@ -701,6 +702,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
> >        omap_set_dma_dest_params(mcbsp->dma_tx_lch,
> >                                 src_port,
> >                                 OMAP_DMA_AMODE_CONSTANT,
> > +                                /* FIXME: this is a virtual address */
> >                                 mcbsp->io_base + OMAP_MCBSP_REG_DXR1,
> 
> yes, that's true. This is expected to be virtual (mcbsp->io_base).

Don't you mean that it is expected to be physical?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
