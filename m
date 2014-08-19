From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: DRA7: Add PMU nodes
Date: Tue, 19 Aug 2014 08:54:00 -0500
Message-ID: <1408456440-30171-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Lucas Weaver <l-weaver-l0cyMroinI0@public.gmane.org>

DRA74x and DRA72x family of processors vary slightly in the number
of CPUs. So, add different instances of PMU for each of these processor
groups. Further, since the interrupts bypass crossbar and are directly
connected to GIC, mark the dts nodes with relevant information.

Tested with perf utility.

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lucas Weaver <l-weaver-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72x.dtsi |    5 +++++
 arch/arm/boot/dts/dra74x.dtsi |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index f1ec22f..e5a3d23 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -22,4 +22,9 @@
 			reg = <0>;
 		};
 	};
+
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index a4e8bb9..3be544c 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -38,4 +38,10 @@
 			reg = <1>;
 		};
 	};
+
+	pmu {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
