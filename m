From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/4] ARM: dts: OMAP4: Fix broken pbias device creation
Date: Mon, 27 Jul 2015 17:46:39 +0530
Message-ID: <1437999401-3519-3-git-send-email-kishon@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437999401-3519-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, grygorii.strashko@ti.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, stable@vger.kernel.org, kishon@ti.com, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

commit <7415b0b4c645> ("ARM: dts: omap4: add minimal l4 bus layout
with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
omap4_padconf_global. After this device for pbias_regulator
is not created.

Fix it by adding "simple-bus" compatible property to
omap4_padconf_global dt node.

Fixes: 7415b0b4c645 ("ARM: dts: omap4: add minimal l4 bus layout
with control module support")

Cc: <stable@vger.kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 7d31c6f..abc4473 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -191,7 +191,8 @@
 				};
 
 				omap4_padconf_global: omap4_padconf_global@5a0 {
-					compatible = "syscon";
+					compatible = "syscon",
+						     "simple-bus";
 					reg = <0x5a0 0x170>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-- 
1.7.9.5
