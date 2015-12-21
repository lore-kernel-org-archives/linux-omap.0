From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Mon, 21 Dec 2015 14:43:18 +0530
Message-ID: <1450689201-16973-2-git-send-email-kishon@ti.com>
References: <1450689201-16973-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450689201-16973-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, kishon@ti.com, robh+dt@kernel.org, galak@codeaurora.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fe99231..9ab7b6a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -155,6 +155,11 @@
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
 				};
+
+				scm_conf_pcie: scm_conf@1c24 {
+					compatible = "syscon";
+					reg = <0x1c24 0x0024>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
-- 
1.7.9.5
