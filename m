From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Thu, 6 Dec 2018 08:31:54 -0800
Message-ID: <20181206163154.GK6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181206132256.GT30658@n2100.armlinux.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Russell King - ARM Linux <linux@armlinux.org.uk> [181206 13:23]:
> It looks very much like a receive problem - in that the board is not
> always aware of a packet having been received until it attempts to
> transmit (eg, in the case of TFTP, when it re-sends the ACK after a
> receive timeout, it _then_ notices that there's a packet waiting.)
> 
> I'm not quite sure when this cropped up as I no longer regularly
> update and run my nightly boot tests, but I think 4.18 was fine.

Sounds like it's some gpio or PM related issue. If it's not caused
by commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and
use cpu_pm instead"), then maybe the changes to probe devices
with ti-sysc interconnect target module driver caused it. Below
is a revert for mcspi that would help in that case.

Also I guess it could be caused by drivers/spi/spi-omap2-mcspi.c
changes since v4.18.

Care to post output of /sys/kernel/debug/pm_debug/count for
a working and non-working kernels?

Regards,

Tony

8< -------------------
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -2050,25 +2050,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x98000 0x1000>;
-
-			mcspi1: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <4>;
-				dmas = <&sdma 35>,
-				       <&sdma 36>,
-				       <&sdma 37>,
-				       <&sdma 38>,
-				       <&sdma 39>,
-				       <&sdma 40>,
-				       <&sdma 41>,
-				       <&sdma 42>;
-				dma-names = "tx0", "rx0", "tx1", "rx1",
-					    "tx2", "rx2", "tx3", "rx3";
-			};
+			status = "disabled";
 		};
 
 		target-module@9a000 {			/* 0x4809a000, ap 51 2c.0 */
@@ -2089,20 +2071,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x9a000 0x1000>;
-
-			mcspi2: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <2>;
-				dmas = <&sdma 43>,
-				       <&sdma 44>,
-				       <&sdma 45>,
-				       <&sdma 46>;
-				dma-names = "tx0", "rx0", "tx1", "rx1";
-			};
+			status = "disabled";
 		};
 
 		target-module@9c000 {			/* 0x4809c000, ap 53 36.0 */
@@ -2290,17 +2259,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xb8000 0x1000>;
-
-			mcspi3: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <2>;
-				dmas = <&sdma 15>, <&sdma 16>;
-				dma-names = "tx0", "rx0";
-			};
+			status = "disabled";
 		};
 
 		target-module@ba000 {			/* 0x480ba000, ap 71 32.0 */
@@ -2321,17 +2280,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0xba000 0x1000>;
-
-			mcspi4: spi@0 {
-				compatible = "ti,omap4-mcspi";
-				reg = <0x0 0x200>;
-				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				ti,spi-num-cs = <1>;
-				dmas = <&sdma 70>, <&sdma 71>;
-				dma-names = "tx0", "rx0";
-			};
+			status = "disabled";
 		};
 
 		target-module@d1000 {			/* 0x480d1000, ap 73 44.0 */
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -193,6 +193,66 @@
 			#gpio-cells = <2>;
 		};
 
+		mcspi1: spi@48098000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x48098000 0x200>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
+		};
+
+		mcspi2: spi@4809a000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x4809a000 0x200>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+		};
+
+		mcspi3: spi@480b8000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480b8000 0x200>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>, <&sdma 16>;
+			dma-names = "tx0", "rx0";
+		};
+
+		mcspi4: spi@480ba000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480ba000 0x200>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
+		};
+
+
 		mmu_dsp: mmu@4a066000 {
 			compatible = "ti,omap4-iommu";
 			reg = <0x4a066000 0x100>;
-- 
2.19.2
