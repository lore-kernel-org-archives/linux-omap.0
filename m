From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 1/7] memory: omap-gpmc: Refactor OneNAND support
Date: Thu, 9 Nov 2017 23:26:18 +0100
Message-ID: <20171109222618.xnygkw5slxxlnnkj@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091253.lvrzi5kbaykkxlcb@lenoch>
 <20171109175626.GD28152@atomide.com>
 <20171109181004.g55vx4iveo5sulpt@lenoch>
 <20171109182645.GE28152@atomide.com>
 <20171109183408.xbc4bacawv7li54l@lenoch>
 <20171109184828.GF28152@atomide.com>
 <20171109191028.6r5bmg65gcz7ovv2@lenoch>
 <20171109215953.GH28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171109215953.GH28152@atomide.com>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 01:59:53PM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [171109 19:12]:
> > On Thu, Nov 09, 2017 at 10:48:28AM -0800, Tony Lindgren wrote:
> > > Well don't we still need the related dts changes posted
> > > and merged first?
> > 
> > Well, except Roger's feedback, there were complete silence so far.
> > Note that simple fix was posted in February, this was rejected as
> > we should aim towards clean DT only driver. And here we are with
> > some doubts.
> > 
> > As I have no hardware nor any special knowledge going prior
> > initial driver commit it is rather hard to send "related dts changes"
> > given simple fact, that I'm unsure whenever we need to distinguish
> > between OMAP2 and OMAP3. Based on that we need either one or
> > two compatible strings.
> > 
> > Having two is safe, but u-boot will be unable to bring onenand equipped
> > igep up.
> 
> Well if you have a complete series with proposed dts changes for
> n8x0 and n900, I can try to test those. My n800 seems to have stopped
> booting today.. Maybe I need to reflash it after playing with onenand.

Okay, here's quick dts patch. Other than that you need:
https://patchwork.kernel.org/patch/10043259/

If you possibly get it working, we can try enable DMA, which is where
things start to be interesting. Once we get DMA working on both
OMAP2 and OMAP3, we are safe to provide only one compatible string.
But that seems to be very long run as even original driver author
left DMA disabled for OMAP2 :-(

Another option is to just ignore OMAP2 DMA which is rather easy:
just omit gpio in dts.

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 1de80c7886ab..843f6a2f5e29 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -48,6 +48,7 @@
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 4acd32a1c4ef..aa5b1a439564 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -838,6 +838,7 @@
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 1b0bd72945f2..cb3c7b2fce52 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -367,6 +367,7 @@
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "ti,omap2-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index d50a105c9dc6..ed65795ccc62 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -155,6 +155,7 @@
 		linux,mtd-name= "samsung,kfm2g16q2m-deb8";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "ti,omap2-onenand";
 		reg = <2 0 0x20000>;	/* CS2, offset 0, IO size 4 */
 
 		gpmc,device-width = <2>;

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
