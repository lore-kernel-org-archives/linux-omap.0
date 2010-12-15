From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v1 4/9] OMAP2430: hwmod data: add system DMA
Date: Wed, 15 Dec 2010 16:29:53 +0530
Message-ID: <20101215105953.GC11931@GLPP-machine>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
 <1291434246-30716-5-git-send-email-manjugk@ti.com>
 <alpine.DEB.2.00.1012141925300.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49010 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753132Ab0LOK6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 05:58:52 -0500
Received: by mail-yx0-f181.google.com with SMTP id 39so1398097yxd.40
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 02:58:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012141925300.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Dec 14, 2010 at 07:27:33PM -0700, Paul Walmsley wrote:
> On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> 
> > Add OMAP2430 DMA hwmod data and also add required
> > DMA device attributes.
> 
> ...
> 
> > +/* dma_system -> L3 */
> > +static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
> > +	.master		= &omap2430_dma_system_hwmod,
> > +	.slave		= &omap2430_l3_main_hwmod,
> > +	.clk		= "l3_div_ck",
> 
> This clock does not exist on OMAP2430.  Did you test this on OMAP2430?

Yes. I have tested this on SDP2430. For confirmation, I tested again now.
It boots up without any issues and all DMA test cases are passing.

> 
> > +/* l4_cfg -> dma_system */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
> > +	.master		= &omap2430_l4_core_hwmod,
> > +	.slave		= &omap2430_dma_system_hwmod,
> > +	.clk		= "l4_div_ck",
> 
> This clock also does not exist on OMAP2430.

ok. I will replace with "sdma_ick" here.

> 
> > +static struct omap_hwmod omap2430_dma_system_hwmod = {
> > +	.name		= "dma",
> > +	.class		= &omap2430_dma_hwmod_class,
> > +	.mpu_irqs	= omap2430_dma_system_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dma_system_irqs),
> > +	.main_clk	= "l3_div_ck",
> 
> Nor does this one.

ok. will be replaced with "sdma_fck"

> 
> Please fix these and test on OMAP2430 before resending.

Thanks. I will test again with above changes on SDP2430.

-Manjunath

