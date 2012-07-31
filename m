From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 31 Jul 2012 16:36:52 +0530
Message-ID: <1343732812.1726.14412.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
 <201207260714.34540.arnd@arndb.de>
 <1343302083.1726.9027.camel@vkoul-udesk3>  <5011680A.6040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5011680A.6040400-l0cyMroinI0@public.gmane.org>
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
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2012-07-26 at 10:53 -0500, Jon Hunter wrote:
> On 07/26/2012 06:28 AM, Vinod Koul wrote:
> > On Thu, 2012-07-26 at 07:14 +0000, Arnd Bergmann wrote:
> >> On Thursday 26 July 2012, Vinod Koul wrote:
> >>>>> But from a client POV it makes sense as with the given direction you
> >>>>> would need a specific request line for a channel. So this is right.
> >>>>> But direction is something I don't expect to be used for "give me a
> >>>>> channel" 
> >>>>
> >>>> Ok. The thought was that the user would have the following means of
> >>>> requesting a channel ...
> >>>>
> >>>> 1. By name
> >>> Bare name maynot be enough. In a dmac we have many channels which one to
> >>> choose?
> >> The name is what is associated with the property in the client device
> >> node, which describes everything the dmac driver needs to know.
> >> If the dmac needs to pick a specific channel, it can find out from the
> >> "dmas" property in combination with that name. If it is allowed to
> >> pick any channel, it doesn't need to bother.
> > dmac doesn't pick a channel. They don't come into picture till dmaengine
> > and client have agreed on channel. And then channel callback in invoked,
> > still it doesn't know which client.
> 
> I think what Arnd meant was that dmaengine (not the dmac) would use the
> DT node and name information to extract the dma mapping information from
> the device tree and provide a channel back to the client. So yes the
> dmac is not involved here.
Ok good that was main concern :)
> 
> By the way, when I said "by name" above (and probably this was not
> clear) but it should have been "DT node and name". So really a channel
> is requested by ...
> 
> 1. DT node and a name
> 2. DT node and a filter parameter (flags)
> 3. DT node, a name and a filter parameter (flags)
> 
> The DT node points us to the specific device in the DT, say an MMC node,
> and the MMC node then contains the DMA mapping info. The device node may
> have the mapping information have one or more DMA requests/channels and
> so then the name and/or flags is used to determine which the client needs.
> 
> Sorry hope that this is a little clearer.
It is...

-- 
~Vinod
