From: "Arun KS" <getarunks@gmail.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 12:55:34 +0530
Message-ID: <dfeb90390809040025p4f8048bmed486112d32fed46@mail.gmail.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
	 <200809031418.44929.david-b@pacbell.net>
	 <13B9B4C6EF24D648824FF11BE8967162036545FC7D@dlee02.ent.ti.com>
	 <200809031506.00261.david-b@pacbell.net>
	 <20080903225654.GO19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:48680 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYIDHZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 03:25:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1885242tic.23
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 00:25:35 -0700 (PDT)
In-Reply-To: <20080903225654.GO19980@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi Russel,

Sorry for late reply.

I applied the patch and tested, but it didn't resolves my problem.

I found that  code hangs at this point.
File : arch/arm/plat-omap/mcbsp.c
Function: omap_mcbsp_request

if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
                mcbsp->pdata->ops->request(id);

I am requesting mcbsp1.

Arun KS

On Thu, Sep 4, 2008 at 4:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 03, 2008 at 03:05:59PM -0700, David Brownell wrote:
>> According to Mr. Grep, there are at least 10 ARMs that work
>> like that in mainline.  Maybe Russell can recommend one of
>> them as a preferred model.
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
>
> diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
> index 826010d..b6ffbab 100644
> --- a/arch/arm/mach-omap1/mcbsp.c
> +++ b/arch/arm/mach-omap1/mcbsp.c
> @@ -184,7 +184,7 @@ static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
>  #ifdef CONFIG_ARCH_OMAP15XX
>  static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>        {
> -               .virt_base      = OMAP1510_MCBSP1_BASE,
> +               .virt_base      = io_p2v(OMAP1510_MCBSP1_BASE),
>                .dma_rx_sync    = OMAP_DMA_MCBSP1_RX,
>                .dma_tx_sync    = OMAP_DMA_MCBSP1_TX,
>                .rx_irq         = INT_McBSP1RX,
> @@ -201,7 +201,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>                .ops            = &omap1_mcbsp_ops,
>        },
>        {
> -               .virt_base      = OMAP1510_MCBSP3_BASE,
> +               .virt_base      = io_p2v(OMAP1510_MCBSP3_BASE),
>                .dma_rx_sync    = OMAP_DMA_MCBSP3_RX,
>                .dma_tx_sync    = OMAP_DMA_MCBSP3_TX,
>                .rx_irq         = INT_McBSP3RX,
> @@ -219,7 +219,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
>  #ifdef CONFIG_ARCH_OMAP16XX
>  static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
>        {
> -               .virt_base      = OMAP1610_MCBSP1_BASE,
> +               .virt_base      = io_p2v(OMAP1610_MCBSP1_BASE),
>                .dma_rx_sync    = OMAP_DMA_MCBSP1_RX,
>                .dma_tx_sync    = OMAP_DMA_MCBSP1_TX,
>                .rx_irq         = INT_McBSP1RX,
> @@ -236,7 +236,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
>                .ops            = &omap1_mcbsp_ops,
>        },
>        {
> -               .virt_base      = OMAP1610_MCBSP3_BASE,
> +               .virt_base      = io_p2v(OMAP1610_MCBSP3_BASE),
>                .dma_rx_sync    = OMAP_DMA_MCBSP3_RX,
>                .dma_tx_sync    = OMAP_DMA_MCBSP3_TX,
>                .rx_irq         = INT_McBSP3RX,
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index d084405..5245a2a 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -651,7 +651,7 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
>        omap_set_dma_dest_params(mcbsp[id].dma_tx_lch,
>                                 src_port,
>                                 OMAP_DMA_AMODE_CONSTANT,
> -                                mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1,
> +                                io_v2p(mcbsp[id].io_base + OMAP_MCBSP_REG_DXR1),
>                                 0, 0);
>
>        omap_set_dma_src_params(mcbsp[id].dma_tx_lch,
> @@ -712,7 +712,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
>        omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
>                                src_port,
>                                OMAP_DMA_AMODE_CONSTANT,
> -                               mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1,
> +                               io_v2p(mcbsp[id].io_base + OMAP_MCBSP_REG_DRR1),
>                                0, 0);
>
>        omap_set_dma_dest_params(mcbsp[id].dma_rx_lch,
>
>
>
