From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v4 16/16] ARM: dts: Nokia: Use R/B pin
Date: Tue, 14 Nov 2017 23:46:29 +0100
Message-ID: <20171114224629.ybnpoleepgdzbqka@lenoch>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212939.jcf26v3w26bd7sn7@lenoch>
 <20171114214256.GG28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171114214256.GG28152@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 14, 2017 at 01:42:56PM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171111 21:31]:
> > Enable use of R/B pin. This is just experimental placeholder patch
> > as it lacks pinmux settings.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Changes:
> >  -v4: new patch
> > 
> >  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 +---
> >  arch/arm/boot/dts/omap3-n900.dts            | 1 +
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> > index 843f6a2f5e29..cfe5d02ea0ed 100644
> > --- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> > +++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
> > @@ -42,14 +42,12 @@
> >  
> >  &gpmc {
> >  	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
> > -
> > -	/* gpio-irq for dma: 26 */
> > -
> >  	onenand@0,0 {
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> >  		compatible = "ti,omap2-onenand";
> >  		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> > +		rb-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> >  
> >  		gpmc,sync-read;
> >  		gpmc,burst-length = <16>;
> 
> 
> This should be then <&gpio1 26 GPIO_ACTIVE_HIGH>, there is no &gpio0. This
> will produce a build error too.

Argh, you're right. Fixed bellow.

> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> > index aa5b1a439564..718116d9f4ac 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -840,6 +840,7 @@
> >  		#size-cells = <1>;
> >  		compatible = "ti,omap2-onenand";
> >  		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
> > +		rb-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
> >  
> >  		gpmc,sync-read;
> >  		gpmc,sync-write;
> 
> This worked for me on n900, I'm currently unable to test n8x0.
> But might be worth double checking if &gpio3 is correct here?

I hope so. This is what original platform data used and what was in 
omap3-n900.dts comment prior to e2c5eb78a3cc. Also see i2c0 node in
omap2420-n8x0-common.dtsi.

Here's quick update, v5 will follow after receiving some more testing.
And of course thanks a lot for testing!

---
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 +---
 arch/arm/boot/dts/omap3-n900.dts            | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 843f6a2f5e29..80cbbe0ee844 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -42,14 +42,12 @@
 
 &gpmc {
 	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
-
-	/* gpio-irq for dma: 26 */
-
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
+		rb-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>; /* gpio_26 for R/B */
 
 		gpmc,sync-read;
 		gpmc,burst-length = <16>;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index aa5b1a439564..669899fd080b 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -834,12 +834,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpmc_pins>;
 
-	/* sys_ndmareq1 could be used by the driver, not as gpio65 though */
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
+		rb-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;	/* gpio_65 for R/B */
 
 		gpmc,sync-read;
 		gpmc,sync-write;
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
