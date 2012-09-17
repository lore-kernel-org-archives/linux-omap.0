From: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Mon, 17 Sep 2012 16:06:15 -0700
Message-ID: <20120917230615.GA26502@codeaurora.org>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
 <20120915001431.GB12445@n2100.arm.linux.org.uk>
 <201209172042.11860.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201209172042.11860.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 17, 2012 at 08:42:11PM +0000, Arnd Bergmann wrote:
> On Saturday 15 September 2012, Russell King - ARM Linux wrote:
> > 
> > On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
> > > 3. Supporting legacy devices not using DMA Engine
> > > 
> > >    These devices present a problem, as there may not be a uniform way to easily
> > >    support them with regard to device tree. Ideally, these should be migrated
> > >    to DMA engine. However, if this is not possible, then they should still be
> > >    able to use this binding, the only constaint imposed by this implementation
> > >    is that when requesting a DMA channel via of_dma_request_slave_channel(), it
> > >    will return a type of dma_chan.
> > 
> > As far as devices not using DMA engine, the answer is we don't support
> > their specification in the DT model.  Note that the legacy OMAP DMA
> > API is scheduled for removal next year, so it's not going to be around
> > that much longer.
> 
> There are a few platforms using the ISA DMA API (rpc, h720x, shark, footbridge),
> and I agree that they are unlikely to see OF support, although if they did, it
> wouldn't be unreasonable to encode their DMA channels using the same binding.
> 
> The other ones that are currently around with their own DMA implementation are
> 
> bcmring --> platform is going away
> samsung --> gradually getting moved to dmaengine, already has its own binding
>             that needs to be replaced with this one, so best do it at the same
>             time.
> tegra   --> old dma code gone in 3.7
> pxa/mmp --> dmaengine implementation being worked on, should wait for that.
> msm     --> dma implementation only used by two drivers (serial and mmc). 
> 
> Outside of arch/arm, at least sh, cris, unicore32 and blackfin have their
> own dma APIs based on the ISA interfaces. I don't currently see any of them
> moving towards DT, but it's definitely possible. 
> 
> Among the above MSM seems to be the most likely candidate to use the binding
> before moving to DT. The msm_sdcc driver is (like much of the msm platform
> code) lagging far behind the internel version that qualcomm have, and the
> device tree binding they are using is incompatible with the common MMC
> binding (and of course the DMA binding here) as well. For getting MSM up
> to speed compared with the other platforms, they have to use proper DT
> bindings as well as proper DMA engine support. Between those two, I'd prefer
> fixing the DT binding first, in order to limit the amount of changes that
> have to be done to external device tree files.

There is also a lot of similarity between the mmci hardware and the
msm_sdcc hardware.  Enough so, that it is probably better for us to
make the mmci driver work with our hardware, rather than trying to
keep msm_sdcc going.

There is also an MSM nand device that appears to have not made it in.
It is heavily dependent on the weird features of the DMA hardware.  I
don't have any current plans to support this device, since most boards
using MSMs these days are using mmc/sd instead of bare NAND.

Our DMA hardware is really weird, but should be a bit reasonable.  It
is also being gradually replaced in newer chips with a different DMA
framework.

As far as I'm concerned, I consider making our DMA driver(s) use the
DMA engine API to be part of getting these platforms working with DT.

It is planned, but there are quite a few things that need to be
tackled first.

David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
