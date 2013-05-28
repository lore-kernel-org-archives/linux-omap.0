From: Lars Poeschel <larsi@wh2.tu-dresden.de>
Subject: [PATCH] dts: am33xx: Correct properties on gpmc node
Date: Tue, 28 May 2013 10:24:57 +0200
Message-ID: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de>
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
To: poeschel@lemonage.de, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The gpmc driver is actually looking for "gpmc,num-cs" and
"gpmc,num-waitpins" properties in DT. The binding doc also states
this.
Correct the properties in the dts to provide the right values for the
gpmc driver.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 arch/arm/boot/dts/am33xx.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1460d9b..8e1248f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -409,8 +409,8 @@
 			ti,hwmods = "gpmc";
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
-			num-cs = <7>;
-			num-waitpins = <2>;
+			gpmc,num-cs = <7>;
+			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			status = "disabled";
-- 
1.7.10.4
