From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/4] ARM: dts: dra7: fix address translation for pbias
Date: Thu, 3 Sep 2015 16:57:53 +0530
Message-ID: <1441279673-28105-5-git-send-email-kishon@ti.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441279673-28105-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

commit <d919501feffa> ("ARM: dts: dra7: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
scm_conf. Since scm_conf doesn't have the 'ranges'
property, address translation fails while trying to convert the
address to resource. Fix it here.

Fixes: d919501feffa ("ARM: dts: dra7: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d6bc6db..5896896 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -120,6 +120,7 @@
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x0 0x1400>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-dra7", "ti,pbias-omap";
-- 
1.7.9.5
