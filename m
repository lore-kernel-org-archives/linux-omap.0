From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v5 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Thu, 30 Nov 2017 14:09:07 +0100
Message-ID: <20171130130907.GA16809@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
 <20171115162458.rtompijrsaobdemk@lenoch>
 <20171130112544.5509ca1b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171130112544.5509ca1b@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Rob Herring <robh@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 30, 2017 at 11:25:44AM +0100, Boris Brezillon wrote:
> +Rob and the DT ML
> 
> On Wed, 15 Nov 2017 17:24:58 +0100
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > Compatible property is required for OMAP2+ mtd driver. Also
> > add INT pin gpio description and delete unused dma-channel
> > property.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Acked-by: Roger Quadros <rogerq@ti.com>
> > ---
> > 
> > Changes in v5:
> > - renamed R/B pin to INT pin
> > 
> > Changes in v4:
> > - new patch
> > 
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > index b6e8bfd024f4..e9f01a963a0a 100644
> > --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
> >  
> >  Required properties:
> >  
> > + - compatible:		"ti,omap2-onenand"
> 
> Don't you break backward compat by adding this new requirement?

I was told it is okay in this case as OneNAND conversion to DT is unfinished.
There was compat fixup code in earlier versions of patchset and it was dropped
later. If others see it opposite way I can add it back.

> >   - reg:			The CS line the peripheral is connected to
> > - - gpmc,device-width	Width of the ONENAND device connected to the GPMC
> > + - gpmc,device-width:	Width of the ONENAND device connected to the GPMC
> >  			in bytes. Must be 1 or 2.
> >  
> >  Optional properties:
> >  
> > - - dma-channel:		DMA Channel index
> > + - int-gpios:		GPIO specifier for the INT pin.
> >  
> >  For inline partition table parsing (optional):
> >  
> > @@ -35,6 +36,7 @@ Example for an OMAP3430 board:
> >  		#size-cells = <1>;
> >  
> >  		onenand@0 {
> > +			compatible = "ti,omap2-onenand";
> >  			reg = <0 0 0>; /* CS0, offset 0 */
> >  			gpmc,device-width = <2>;
> >  

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
