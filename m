From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 26 Jul 2012 07:14:34 +0000
Message-ID: <201207260714.34540.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343284960.1726.8978.camel@vkoul-udesk3>
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

On Thursday 26 July 2012, Vinod Koul wrote:
> > > But from a client POV it makes sense as with the given direction you
> > > would need a specific request line for a channel. So this is right.
> > > But direction is something I don't expect to be used for "give me a
> > > channel" 
> > 
> > Ok. The thought was that the user would have the following means of
> > requesting a channel ...
> > 
> > 1. By name
> Bare name maynot be enough. In a dmac we have many channels which one to
> choose?

The name is what is associated with the property in the client device
node, which describes everything the dmac driver needs to know.
If the dmac needs to pick a specific channel, it can find out from the
"dmas" property in combination with that name. If it is allowed to
pick any channel, it doesn't need to bother.

> > 2. By a filter parameter (flags)
> Even with direction same problem can arise

Again this is just identifying which dma specifier from the "dmas"
property to pick. The use case is the very common one that there
is at most one "read" and one "write" channel. In this case all
the client has to know is that it wants a channel that fits the
description given in DT for the direction it's looking for.

> > 3. By name and a filter parameter
> Additionally we need to say which channel, or making dmaengine already
> aware will help here.

The channel is still described in the specifier, the client should
not care about it.

	Arnd
