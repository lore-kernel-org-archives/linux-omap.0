From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 23 Jun 2012 00:12:22 +0100
Message-ID: <20120622231222.GB2426@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206090004.10086.arnd@arndb.de> <4FD914F6.6000402@ti.com>
 <201206141148.20371.arnd@arndb.de> <4FE4F718.3080204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FE4F718.3080204-l0cyMroinI0@public.gmane.org>
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
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Before this goes much further... one fairly obvious and important point
must be made.

You're designing an API here.  You're designing it *WITHOUT* involving
the two most important people in its design that there are.  The
DMA engine maintainers.  Is this how we go about designing APIs - behind
maintainers backs and then presenting it to the maintainers as a fait
accompli?

There's 86 messages in this thread, none of which have been copied to
them in any way.  Why aren't they involved?

On Fri, Jun 22, 2012 at 05:52:08PM -0500, Jon Hunter wrote:
> Hi Arnd,
> 
> On 06/14/2012 06:48 AM, Arnd Bergmann wrote:
> 
> [snip]
> 
> > This would let us handle the following cases very easily:
> > 
> > 1. one read-write channel
> > 
> > 	dmas = <&dmac 0x3 match>;
> > 
> > 2. a choice of two read-write channels:
> > 
> > 	dmas = <&dmacA 0x3 matchA>, <&dmacB 0x3 matchB>;
> > 
> > 3. one read-channel, one write channel:
> > 
> > 	dmas = <&dmac 0x1 match-read>, <&dmac 0x2 match-write>;
> > 
> > 4. a choice of two read channels and one write channel:
> > 
> > 	dmas = <&dmacA 0x1 match-readA>, <&dmacA 0x2 match-write> 
> > 			<&dmacB match-readB>;
> > 
> > And only the cases where we have more multiple channels that differ
> > in more aspects would require named properties:
> > 
> > 5. two different channels
> > 
> > 	dmas = <&dmac 0x3 match-rwdata>, <&dmac 0x1 match-status>;
> > 	dma-names = "rwdata", "status";
> > 
> > 6. same as 5, but with a choice of channels:
> > 
> > 	dmas = <&dmacA 0x3 match-rwdataA>, <&dmacA 0x1 match-status>;
> > 		<dmacB 0x3 match-rwdataB>;
> > 	dma-names = "rwdata", "status", "rwdata";
> > 
> > 
> > With a definition like that, we can implement a very simple device
> > driver interface for the common cases, and a slightly more complex
> > one for the more complex cases:
> > 
> > 1. chan = of_dma_request_channel(dev->of_node, 0);
> > 2. chan = of_dma_request_channel(dev->of_node, 0);
> > 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> >    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> >    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> >    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> > 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> >    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> 
> In the above examples, did you imply that the of_dma_request_channel()
> function would return a type of "struct dma_chan" and so be calling
> dma_request_channel() underneath?
> 
> I am been prototyping something, but wanted to make sure I am completely
> aligned on this :-)
> 
> Cheers
> Jon
