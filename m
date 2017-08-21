From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: am571x-idk: Enable relevant IPU and DSP MMU nodes
Date: Mon, 21 Aug 2017 18:51:58 -0500
Message-ID: <20170821235158.4968-6-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170821235158.4968-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The MMU nodes for the remote processors IPU1, IPU2 and DSP1
have all been enabled. All these nodes are relevant and valid
for the AM571x IDK board. DSP2 MMU nodes are not present on
AM571x SoCs.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am571x-idk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index debf9464403e..ea9f695e1282 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -91,6 +91,22 @@
 	};
 };
 
+&mmu0_dsp1 {
+	status = "okay";
+};
+
+&mmu1_dsp1 {
+	status = "okay";
+};
+
+&mmu_ipu1 {
+	status = "okay";
+};
+
+&mmu_ipu2 {
+	status = "okay";
+};
+
 &pcie1_rc {
 	status = "okay";
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-- 
2.13.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
