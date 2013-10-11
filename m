From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 5/6] ARM: dts: AM33xx: updated default ECC scheme in
 nand-ecc-opt
Date: Fri, 11 Oct 2013 19:06:42 +0530
Message-ID: <1381498603-15715-6-git-send-email-pekon@ti.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1381498603-15715-1-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: devicetree@vger.kernel.org, Pawel.Moll@arm.com, arnd@arndb.de, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, Pekon Gupta <pekon@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

Updated DTS to replace deprecated binding with newer values
Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts   | 3 +--
 arch/arm/boot/dts/omap3430-sdp.dts | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e8ec875..1aee6ac 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -269,7 +269,6 @@
 				reg = <0 0 0>; /* CS0, offset 0 */
 				nand-bus-width = <8>;
 				ti,nand-ecc-opt = "bch8";
-				gpmc,device-nand = "true";
 				gpmc,device-width = <1>;
 				gpmc,sync-clk-ps = <0>;
 				gpmc,cs-on-ns = <0>;
@@ -296,7 +295,7 @@
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-				elm_id = <&elm>;
+				ti,elm-id = <&elm>;
 
 				/* MTD partition table */
 				partition@0 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index e2249bc..501f863 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -105,7 +105,7 @@
 		reg = <1 0 0x08000000>;
 		nand-bus-width = <8>;
 
-		ti,nand-ecc-opt = "sw";
+		ti,nand-ecc-opt = "ham1";
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <36>;
 		gpmc,cs-wr-off-ns = <36>;
-- 
1.8.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
