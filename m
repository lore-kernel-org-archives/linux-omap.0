From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 00:25:06 +0100
Message-ID: <20120503232506.GA4181@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA30604.1030401@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA30604.1030401-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 03, 2012 at 04:26:12PM -0600, Stephen Warren wrote:
> On 04/30/2012 03:17 PM, Jon Hunter wrote:
> > +Example:
> > +
> > +	sdma: dmaengine@48000000 {
> > +		compatible = "ti,omap4-sdma"
> > +		reg = <0x48000000 0x1000>;
> > +		interrupts = <4>;
> > +		#dma-cells = <2>;
> > +		#dma-channels = <32>;
> > +		#dma-requests = <127>;
> > +	};
> > +
> > +
> > +* DMA client
> > +
> > +Client drivers should specify the DMA property using a phandle to the controller
> > +followed by the number of DMA request/channel and the transfer type of the
> 
> What exactly is "request/channel"? Is it a request ID, a channel ID,
> both packed into a single integer (which bits are used for each field),
> etc.?

Agreed - because with this definition, applied to the PL08x found on
Versatile platforms, it will be impossible to describe the DMA bindings
due to intervening MUX hardware.

> > +channel (eg. device-to-memory, memory-to-device, memory-to-memory, etc). Drivers
> > +should use the DMA Engine enum dma_transfer_direction (eg. DMA_DEV_TO_MEM,
> > +DMA_MEM_TO_DEV, etc) for specifying the transfer type.
> 
> The binding document should stand alone; you shouldn't need to go look
> up values in any particular OS/driver's source code. In other words,
> this should explicitly enumerate the values for DMA_DEV_TO_MEM etc.
> here. That said, I'm not sure it's appropriate to mandate that every DMA
> controller's DMA specifier actually include this information in DT (a
> controller might only support DEV_TO_MEM for example, and hence not need
> this information in DT at all).
> 
> The DMA client's binding should specify how many entries it needs in the
> dma property and what they mean, e.g. it should know that dma property
> index 0 is the TX DMA specifier, and index 1 is the RX specifier.

(Mostly to Jon)

Also bear in mind that as far as DMA engine is concerned, every channel
is _potentially_ bidirectional without it having to be released and
reacquired.  We have some drivers setup to behave like that too.  So
stuffing stuff like the transfer type into the selection adds
restrictions.

On platforms where the DMA transfer type does matter (such as OMAP),
that's normally because one DMA request signal is associated with a
particular DMA direction.  That makes it a property of the DMA request
signal, not of the requested channel.
