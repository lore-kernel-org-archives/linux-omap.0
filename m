From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 17:28:45 -0700
Message-ID: <20080904002844.GL23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200809031418.44929.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE8967162036545FC7D@dlee02.ent.ti.com> <200809031506.00261.david-b@pacbell.net> <20080903225654.GO19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53170 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbYIDA25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 20:28:57 -0400
Content-Disposition: inline
In-Reply-To: <20080903225654.GO19980@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 15:57]:
> On Wed, Sep 03, 2008 at 03:05:59PM -0700, David Brownell wrote:
> > According to Mr. Grep, there are at least 10 ARMs that work
> > like that in mainline.  Maybe Russell can recommend one of
> > them as a preferred model.
> 
> As I've been trying to say, I see this as a separate issue for the near
> future.  At the moment, I'm trying to concentrate on one aspect only.
> 
> That is, getting OMAP to the point that we're using the compiler to
> warn us when we do something silly, like passing a virtual address
> to a function which takes a physical address, and fixing the places
> which are currently wrong.
> 
> Anything else like changing the ioremap behaviour is actually
> completely orthogonal to that, and *is* a distraction.  Rather than
> actually fixing the mcbsp.c issue, I've spent the last hour or so
> composing various replies to Richard's emails, and then postponing
> them, reading more of this thread, creating more replies, postponing
> those as well, etc.
> 
> Anyway, what I've done now is committed the minimal set of fixes so
> far to go into mainline for the current -rc so we can at least improve
> the situation there.  That's not to say that the other patch won't be
> going in - it will in some form or other.
> 
> It can also be applied to the omap tree by saving this message as
> "whateverpatchfile", running:
> 
> sed -i 's,\[id\]\.,->,' whateverpatchfile
> 
> and then applying "whateverpatchfile".  Expect some offsets.
> 
> Arun - can you please test this patch on your 5912 OSK board to see if
> it resolves your problem please?

Audio still works with n810 after this patch, so I'll apply it also
to l-o tree.

Can anybody from TI confirm that the DMA is using only 28 bits of the
src/dest address? At least that's the best explanation so far why it
was working earlier even without this patch.

Acked-by: Tony Lindgren <tony@atomide.com> 


> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
> index 826010d..b6ffbab 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -184,7 +184,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
>  #ifdef CONFIG_ARCH_OMAP15XX
>  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>  	{
> -		.virt_base	= OMAP1510_MCBSP1_BASE,
> +		.virt_base	= io_p2v(OMAP1510_MCBSP1_BASE),
>  		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
>  		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
>  		.rx_irq		= INT_McBSP1RX,
> @@ -201,7 +201,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>  		.ops		= &omap1_mcbsp_ops,
>  	},
>  	{
> -		.virt_base	= OMAP1510_MCBSP3_BASE,
> +		.virt_base	= io_p2v(OMAP1510_MCBSP3_BASE),
>  		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
>  		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
>  		.rx_irq		= INT_McBSP3RX,
> @@ -219,7 +219,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>  #ifdef CONFIG_ARCH_OMAP16XX
>  static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
>  	{
> -		.virt_base	= OMAP1610_MCBSP1_BASE,
> +		.virt_base	= io_p2v(OMAP1610_MCBSP1_BASE),
>  		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
>  		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
>  		.rx_irq		= INT_McBSP1RX,
> @@ -236,7 +236,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
>  		.ops		= &omap1_mcbsp_ops,
>  	},
>  	{
> -		.virt_base	= OMAP1610_MCBSP3_BASE,
> +		.virt_base	= io_p2v(OMAP1610_MCBSP3_BASE),
>  		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
>  		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
>  		.rx_irq		= INT_McBSP3RX,
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index d084405..5245a2a 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -651,7 +651,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>  	omap_set_dma_dest_params(mcbsp[id].dma_tx_lch,
>  				 src_port,
>  				 OMAP_DMA_AMODE_CONSTANT,
> -				 mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1,
> +				 io_v2p(mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1),
>  				 0, 0);
>  
>  	omap_set_dma_src_params(mcbsp[id].dma_tx_lch,
> @@ -712,7 +712,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>  	omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
>  				src_port,
>  				OMAP_DMA_AMODE_CONSTANT,
> -				mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1,
> +				io_v2p(mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1),
>  				0, 0);
>  
>  	omap_set_dma_dest_params(mcbsp[id].dma_rx_lch,
> 
> 
