From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v1 3/9] OMAP2420: hwmod data: add system DMA]
Date: Wed, 15 Dec 2010 08:39:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012150833530.15971@utopia.booyaka.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com> <1291434246-30716-4-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1012141922550.15971@utopia.booyaka.com> <20101215110917.GD11931@GLPP-machine> <20101215121558.GE11931@GLPP-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41236 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab0LOPjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 10:39:41 -0500
In-Reply-To: <20101215121558.GE11931@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 15 Dec 2010, G, Manjunath Kondaiah wrote:

> On Wed, Dec 15, 2010 at 04:39:17PM +0530, G, Manjunath Kondaiah wrote:
> > On Tue, Dec 14, 2010 at 07:25:23PM -0700, Paul Walmsley wrote:
> > > On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> > > 
> > > > Add OMAP2420 DMA hwmod data and also add required
> > > > DMA device attributes.
> > > > 
> > > > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > >
> > > > +/* dma_system -> L3 */
> > > > +static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
> > > > +	.master		= &omap2420_dma_system_hwmod,
> > > > +	.slave		= &omap2420_l3_main_hwmod,
> > > > +	.clk		= "l3_div_ck",
> > > 
> > > This clock does not exist on OMAP2420.  Did you test this patch on 2420?
> > 
> > ok. will be replaced with "sdma_ick". I don't have 2420 for testing. I
> > tested it on 2430. My understanding is that, DMA clock interface is same
> > for 2420 and 2430. Correct me if am wrong.
> 
> Looking into omap3/omap4 structures, this entry takes core l3 clock.
> 
> This should be "sdma_fck" since it's parent is core_l3_ck.

The OMAP2xxx SDMA data can use either sdma_fck or core_l3_ck for its 
functional clock.  At some point we will probably remove sdma_fck from the 
2xxx data.  That's a relic of the pre-clkdev days, so you might as well 
just use core_l3_ck.  Maybe just stick with sdma_ick for the interface 
clock for right now.


- Paul
