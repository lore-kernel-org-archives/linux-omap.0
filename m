From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v1 3/9] OMAP2420: hwmod data: add system DMA
Date: Wed, 15 Dec 2010 16:39:17 +0530
Message-ID: <20101215110917.GD11931@GLPP-machine>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
 <1291434246-30716-4-git-send-email-manjugk@ti.com>
 <alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57265 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753077Ab0LOLIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 06:08:14 -0500
Received: by gyg13 with SMTP id 13so903438gyg.16
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 03:08:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Dec 14, 2010 at 07:25:23PM -0700, Paul Walmsley wrote:
> Manju
> 
> On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> 
> > Add OMAP2420 DMA hwmod data and also add required
> > DMA device attributes.
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> > +/* dma_system -> L3 */
> > +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> > +	.master		= &omap2420_dma_system_hwmod,
> > +	.slave		= &omap2420_l3_main_hwmod,
> > +	.clk		= "l3_div_ck",
> 
> This clock does not exist on OMAP2420.  Did you test this patch on 2420?

ok. will be replaced with "sdma_ick". I don't have 2420 for testing. I
tested it on 2430. My understanding is that, DMA clock interface is same
for 2420 and 2430. Correct me if am wrong.

> 
> > +/* l4_cfg -> dma_system */
> > +static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
> > +	.master		= &omap2420_l4_core_hwmod,
> > +	.slave		= &omap2420_dma_system_hwmod,
> > +	.clk		= "l4_div_ck",
> 
> Nor does this clock exist on OMAP2420.

ok. Will replace with "sdma_ick"
> 
> > +static struct omap_hwmod omap2420_dma_system_hwmod = {
> > +	.name		= "dma",
> > +	.class		= &omap2420_dma_hwmod_class,
> > +	.mpu_irqs	= omap2420_dma_system_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dma_system_irqs),
> > +	.main_clk	= "l3_div_ck",
> 
> And neither does this one.

This will be replaced with "sdma_fck"
> 
> Please fix these and test on OMAP2420 before sending the fixed patches.

I don't have setup to test this. I will do the changes and test it on
2430SDP which has similar change.


-Manjunath
