From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2 1/6] arm: dts: omap3-igep: Update OneNAND node
Date: Wed, 8 Nov 2017 08:42:49 +0100
Message-ID: <20171108074249.og32u5axaeuqojku@lenoch>
References: <20171108074024.vwcfnqizvd7jajnh@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171108074024.vwcfnqizvd7jajnh@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Update node timings to be compatible with actual chip used
(gpmc_cs_show_timings utilized to dump values)
Also specify correct compatible property for upcoming MTD driver
DTfication.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: none

 arch/arm/boot/dts/omap3-igep.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 4929ba1cb9d3..d7f060514144 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -138,38 +138,38 @@
 	};
 
 	onenand@0,0 {
-		compatible = "ti,omap2-onenand";
+		compatible = "ti,omap3-onenand";
 		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
 		gpmc,sync-write;
 		gpmc,burst-length = <16>;
-		gpmc,burst-read;
 		gpmc,burst-wrap;
+		gpmc,burst-read;
 		gpmc,burst-write;
 		gpmc,device-width = <2>; /* GPMC_DEVWIDTH_16BIT */
 		gpmc,mux-add-data = <2>; /* GPMC_MUX_AD */
 		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <87>;
-		gpmc,cs-wr-off-ns = <87>;
+		gpmc,cs-rd-off-ns = <96>;
+		gpmc,cs-wr-off-ns = <96>;
 		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <10>;
-		gpmc,adv-wr-off-ns = <10>;
-		gpmc,oe-on-ns = <15>;
-		gpmc,oe-off-ns = <87>;
+		gpmc,adv-rd-off-ns = <12>;
+		gpmc,adv-wr-off-ns = <12>;
+		gpmc,oe-on-ns = <18>;
+		gpmc,oe-off-ns = <96>;
 		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <87>;
-		gpmc,rd-cycle-ns = <112>;
-		gpmc,wr-cycle-ns = <112>;
-		gpmc,access-ns = <81>;
-		gpmc,page-burst-access-ns = <15>;
+		gpmc,we-off-ns = <96>;
+		gpmc,rd-cycle-ns = <114>;
+		gpmc,wr-cycle-ns = <114>;
+		gpmc,access-ns = <90>;
+		gpmc,page-burst-access-ns = <12>;
 		gpmc,bus-turnaround-ns = <0>;
 		gpmc,cycle2cycle-delay-ns = <0>;
 		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <5>;
+		gpmc,clk-activation-ns = <6>;
 		gpmc,wr-data-mux-bus-ns = <30>;
-		gpmc,wr-access-ns = <81>;
-		gpmc,sync-clk-ps = <15000>;
+		gpmc,wr-access-ns = <90>;
+		gpmc,sync-clk-ps = <12000>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
