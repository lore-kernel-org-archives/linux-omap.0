From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Sun, 25 Nov 2018 11:11:05 +0000
Message-ID: <20181125111105.GT6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
 <20181124200942.GS6920@n2100.armlinux.org.uk>
 <20181125010717.GJ53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125010717.GJ53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 24, 2018 at 05:07:17PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [181124 20:10]:
> > On Fri, Nov 23, 2018 at 08:52:15PM +0200, Aaro Koskinen wrote:
> > > Hi,
> > > 
> > > On Fri, Nov 23, 2018 at 02:35:04PM +0200, Peter Ujfalusi wrote:
> > > > On 22/11/2018 17.12, Russell King - ARM Linux wrote:
> > > > > I'm also not sure about this:
> > > > > 
> > > > >         if (cpu_is_omap15xx())
> > > > >                 end++;
> > > > > 
> > > > > in dma_dest_len() - is that missing from the omap-dma driver?  It looks
> > > > > like a work-around for some problem on OMAP15xx, but I can't make sense
> > > > > about why it's in the UDC driver rather than the legacy DMA driver.
> > > > 
> > > > afaik no other legacy drivers were doing similar thing, this must be
> > > > something which is needed for the omap_udc driver to fix up something?
> > > 
> > > Here's the patch that added it: https://marc.info/?l=linux-omap&m=119634396324221&w=2
> > > 
> > > "Make DMA-OUT behave on the 1510 ... the 1510 CPC register was just
> > > off-by-one with respect to the 1611 CDAC"
> > 
> > ... which suggests that's a problem with the CPC register itself, and
> > we should fix that in the DMAengine driver rather than the USB gadget
> > driver.
> > 
> > Tony, any input on this?
> 
> Yeah that sounds like some hardware work-around for 15xx as described
> in the DMA_DEST_LAST macro reading CSAC on 15xx instead of CDAC. Seems
> like it should be done in the dmaengine driver.. My guess is that other
> dma users never needed to read CSAC register?

Hmm, reading the OMAP1510 TRM for the CPC register, it seems that
omap-dma won't handle this particularly well.  The fact that the
register only updates after the last request in an element or frame
means that if we try to use this value as the current source /
destination address before the first transfer, it can be wildly
wrong.

Saving the current value at the beginning of a request, and detecting
if it's changed (like omap_udc) isn't going to work well in the
generic case.  If, say, the register happens to contain 0x0004, and
our next transfer is using 32-bit elements in element sync mode
starting at address with lsb 16 bits as 0, it would mean we'd see
0x0004 in this register after the _second_ element has been
transferred, and we'd assume that the register hasn't yet changed -
but we would have in reality transferred two elements.

However, omap-dma.c zeros the CPC register before each transfer,
which is interesting, because in one place the OMAP1510 TRM says
that the CPC register is read/write, but in the actual description
of this register, it says it's read-only.

What it also means is that, in such a case, after the 2nd element has
been transferred, where the register contains 0x0004, the address
we'd be looking for (to calculate the residual) should be 0x0008,
not 0x0005, so we actually need to be adding the number of bytes
according to element size.

Looking at omap-dma.c, someone has added support for the residue
granularity:

        if (__dma_omap15xx(od->plat->dma_attr))
                od->ddev.residue_granularity =
                                DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
        else
                od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

If OMAP15xx is truely descriptor granularity, then we can't use
omap-dma for omap_udc, because omap_udc needs to know exactly
how many bytes were transferred.

So... hmm, OMAP15xx DMA looks like a complete mess, and the only
way to know what would and wouldn't work is to actually have the
hardware.

I think we're better off leaving omap-udc well alone, and if it's
now broken with DMA, then that's unfortunate - it would require
someone with the hardware to diagnose the problem and fix it.  I
think trying to convert it to dmaengine would be risking way more
problems than its worth.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
