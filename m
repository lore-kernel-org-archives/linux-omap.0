From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v4 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Wed, 15 Nov 2017 16:55:13 +0100
Message-ID: <20171115155513.3d4vvdry73y6knj7@lenoch>
References: <20171111211656.neoypp7gdyfasteg@lenoch>
 <20171115134339.jnvu6asy2srxsuko@earth>
 <20171115151206.g76k75lwq2jlezki@lenoch>
 <20171115154210.i3nbt2czpma6hi2w@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171115154210.i3nbt2czpma6hi2w@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 04:42:11PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Nov 15, 2017 at 04:12:06PM +0100, Ladislav Michl wrote:
> > On Wed, Nov 15, 2017 at 02:43:39PM +0100, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Sat, Nov 11, 2017 at 10:16:56PM +0100, Ladislav Michl wrote:
> > > > Compatible property is required for OMAP2+ mtd driver. Also
> > > > add R/B pin gpio description and delete unused dma-channel
> > > > property.
> > > > 
> > > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > > > ---
> > > >  Changes:
> > > >  -v4: new patch
> > > > 
> > > >  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > > index b6e8bfd024f4..9d7b1409deab 100644
> > > > --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > > +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > > @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
> > > >  
> > > >  Required properties:
> > > >  
> > > > + - compatible:		"ti,omap2-onenand"
> > > 
> > > I suggest to also add more specific compatible values (i.e.
> > > "ti,omap3-onenand") in case it is needed later. They don't
> > > hurt much and may prevent ugly hacks in the future.
> > 
> > We tried hard to avoid anything omap3 specific (it was present in earlier
> > versions of this patchset). And NAND driver is also okay with "ti,omap3-nand"
> > (I know it is a poor argument). So far all OMAP2/3 differences seems to come
> > from both devices unavailable to the person who did the code change.
> > 
> > While I agree it is in general good idea, I have personal problem with that
> > as there are devices in field with "ti,omap2-onenand" compatible and OMAP3530.
> > 
> > See this function:
> > http://git.denx.de/?p=u-boot.git;a=blob;f=board/isee/igep00x0/igep00x0.c;h=5c7f2567118a1e17bdb6f76f29a7161628776bf7;hb=HEAD#l158
> > Board comes either with NAND or OneNAND, bootloader detects that and
> > enables proper node. Updating bootloader is potentially dangerous, so I'd
> > like to avoid that.
> > 
> > However, if you insist on idea above, I'm okay with keeping some of tree
> > patches for a while...
> 
> The best practice for DT bindings is to have a specific compatible
> and a generic fallback. Something like
> 
> compatible = "ti,omap3-onenand", "ti,omap2-onenand";
> 
> You can just ignore the "ti,omap3-onenand" in the driver for now.
> Just add it to the bindings and the DTS files. Then it is there in
> case it is needed at some point.

I understood it, but it missed my point. I already have "ti,omap2-onenand"
in OMAP3 DTB. So once driver starts doing something different for OMAP2,
it will break my setup.

	ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
