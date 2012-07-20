From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 20 Jul 2012 08:39:23 +0000
Message-ID: <201207200839.24259.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342756850.1726.74.camel@vkoul-udesk3>
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
To: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 20 July 2012, Vinod Koul wrote:
> > Required property:
> >     dmas: list of one or more dma specifiers, each consisting of
> >      - phandle pointing to dma controller node
> >      - flags word, a bit map that can hold these flags
> >        * 0x00000001 channel can be used for transfer from device
> >        * 0x00000002 channel can be user for transfer to device
>
> Is this for identifying which channel is for TX and RX? If not I am not
> sure I understood it well

Yes, but we can potentially add more flags here.

The argument we had when coming up with this was roughly:

* we need to identify which specifiers are referring to the same
  conceptual channel and can be used as alternatives
* this could be done just using the dma-names property, but making
  dma-names mandatory adds complexity for everyone.
* Most devices have just one or two channels, and if they have two,
  there is usually one input and one output.

=> if the common dmaengine code can find out whether a channel is
  input or output without looking at the dmac driver specific configuration,
  we don't need to add dma-names in most cases, but just let the client
  driver ask for "give me a channel with these flags".

> > 4. A dma controller requiring complex configuration:
> > 
> >        dma: dmaengine@48000000 {
> >                compatible = "foo,foo-sdma"
> >                reg = <0x48000000 0x1000>;
> >                interrupts = <4>;
> >                #dma-cells = <6>; /* phandle, flag, request, channel,
> >                                        input-width, output-width */
>
> Why would we want the widths to be here?
> Assuming a DMA from System memory to a peripheral, source width should
> be system memory width and destination the peripheral width. IMO these
> should not be in dma property even if we need these

I was just trying to come up with an example of something we might put
into the additional configuration fields. This may or may not be a
realistic one, I have no idea. If you know something else that one
of the dma controllers might want to put in there, we should change the
example.

I took the example of data width from 'struct stedma40_chan_cfg', which
is used in some places to configure this from platform data. My
impression was that if we want to move that data from board files into
the device tree, it has to be here, but it can well be that there is
a better place for it, e.g. in the global (channel independent)
configuration of the dmac.

	Arnd
