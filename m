From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ARM: DTS: dra7: fix DCAN node addresses
Date: Mon, 21 May 2018 13:08:32 -0700
Message-ID: <20180521200832.24213-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, rogerq@ti.com
Cc: ktouil@baylibre.com, linux-arm-kernel@lists.infradead.org, dlewin@baylibre.com
List-Id: linux-omap@vger.kernel.org

Fix the DT node addresses to match the reg property addresses,
which were verified to match the TRM:
http://www.ti.com/lit/pdf/sprui30

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f4ddd86f2c77..8b423eacf76b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1895,7 +1895,7 @@
 			};
 		};
 
-		dcan1: can@481cc000 {
+		dcan1: can@4ae3c000 {
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan1";
 			reg = <0x4ae3c000 0x2000>;
@@ -1905,7 +1905,7 @@
 			status = "disabled";
 		};
 
-		dcan2: can@481d0000 {
+		dcan2: can@48480000 {
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan2";
 			reg = <0x48480000 0x2000>;
-- 
2.11.0
