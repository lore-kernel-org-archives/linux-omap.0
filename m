From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH v5 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Fri, 15 Dec 2017 13:24:22 +0100
Message-ID: <20171215122422.GA17105@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171115162458.rtompijrsaobdemk@lenoch>
 <20171130112544.5509ca1b@bbrezillon>
 <20171130130907.GA16809@lenoch>
 <23d7ad3c-e6cd-3ba6-269a-1788371d13c3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <23d7ad3c-e6cd-3ba6-269a-1788371d13c3-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Roger,

On Fri, Dec 15, 2017 at 12:18:59PM +0200, Roger Quadros wrote:
> Ladislav,
> 
> On 30/11/17 15:09, Ladislav Michl wrote:
> > On Thu, Nov 30, 2017 at 11:25:44AM +0100, Boris Brezillon wrote:
> >> +Rob and the DT ML
> >>
> >> On Wed, 15 Nov 2017 17:24:58 +0100
> >> Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> wrote:
> >>
> >>> Compatible property is required for OMAP2+ mtd driver. Also
> >>> add INT pin gpio description and delete unused dma-channel
> >>> property.
> >>>
> >>> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> >>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> >>> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >>> ---
> >>>
> >>> Changes in v5:
> >>> - renamed R/B pin to INT pin
> >>>
> >>> Changes in v4:
> >>> - new patch
> >>>
> >>> Changes in v3: None
> >>> Changes in v2: None
> >>>
> >>>  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
> >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >>> index b6e8bfd024f4..e9f01a963a0a 100644
> >>> --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> >>> @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
> >>>  
> >>>  Required properties:
> >>>  
> >>> + - compatible:		"ti,omap2-onenand"
> >>
> >> Don't you break backward compat by adding this new requirement?
> > 
> > I was told it is okay in this case as OneNAND conversion to DT is unfinished.
> > There was compat fixup code in earlier versions of patchset and it was dropped
> > later. If others see it opposite way I can add it back.
> > 
> 
> If it is possible not to break backward compatibility then we shouldn't.
> Only if things are getting real messy because of the poor way the earlier DT
> implementation was done we can consider it as an exception.

Well, it is possible to reintroduce fixup. Based on other posts on linux-omap
mailing list, it seems that n900, etc. support is still under heavy development,
so people are updating both kernel and dtb. That's why I happily agreed on
removing fixup.

Of course I'd like to hear opinion from n8x0 and n900 people and also would be
very happy if someone could finally test on OMAP2 device.

> I thought we rely on GPMC timings entirely from the DT now and so things don't
> work with older DT nodes?

Well, they do work as long as DT contains correct timings. Mainline driver just
ignores them a does calculations on its own, so it works even with wrong DT
timings as long as bootloader configured something reasonable (otherwise it
doe not work at all).

This is no longer the case. Now, driver is expecting reasonable timings, enough
good to get device probed. Driver then calculates optimized timings based on
actual OneNAND chip ised.

Thank you,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
