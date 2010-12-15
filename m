From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v1 4/9] OMAP2430: hwmod data: add system DMA
Date: Wed, 15 Dec 2010 08:14:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012150814250.15971@utopia.booyaka.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com> <1291434246-30716-5-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1012141925300.15971@utopia.booyaka.com> <20101215105953.GC11931@GLPP-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56290 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LOPPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 10:15:00 -0500
In-Reply-To: <20101215105953.GC11931@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 15 Dec 2010, G, Manjunath Kondaiah wrote:

> On Tue, Dec 14, 2010 at 07:27:33PM -0700, Paul Walmsley wrote:
> > On Sat, 4 Dec 2010, G, Manjunath Kondaiah wrote:
> > 
> > > Add OMAP2430 DMA hwmod data and also add required
> > > DMA device attributes.
> > 
> > ...
> > 
> > > +/* dma_system -> L3 */
> > > +static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
> > > +	.master		= &omap2430_dma_system_hwmod,
> > > +	.slave		= &omap2430_l3_main_hwmod,
> > > +	.clk		= "l3_div_ck",
> > 
> > This clock does not exist on OMAP2430.  Did you test this on OMAP2430?
> 
> Yes. I have tested this on SDP2430. For confirmation, I tested again now.
> It boots up without any issues and all DMA test cases are passing.

Don't you see warnings in the boot messages that this clock cannot be 
found?



- Paul
