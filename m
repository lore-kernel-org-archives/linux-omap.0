From: Satish Patel <satish.patel@ti.com>
Subject: [PATCH v3 4/5] ARM: dts: AM43xx: DT entries added for ti-usim
Date: Wed, 28 May 2014 14:27:16 +0530
Message-ID: <1401267437-22489-5-git-send-email-satish.patel@ti.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, rob@landley.net, tony@atomide.com
Cc: grant.likely@linaro.org, Satish Patel <satish.patel@ti.com>, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

SoC specific DT entries added for TI's USIM - smart card controller of AM43xx
platfrom.

Signed-off-by: Satish Patel <satish.patel@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d1f8707..fe830dd 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -735,6 +735,18 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		usim0: usim@48034000 {
+			compatible = "ti,usim";
+			reg = <0x48034000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "usim0";
+			clocks = <&usim0_opt_fck>, <&usim0_opt_fck32>,
+				 <&dpll_per_m2_div4_ck>;
+			clock-names = "opt_fck", "opt_fck32", "fck";
+			status = "disabled";
+		};
+
 	};
 };
 
-- 
1.7.9.5
