From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5] ARM: dts: am572x-idk: Enable relevant IPU and DSP MMU nodes
Date: Mon, 21 Aug 2017 18:51:57 -0500
Message-ID: <20170821235158.4968-5-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170821235158.4968-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The MMU nodes for the remote processors IPU1, IPU2, DSP1 and
DSP2 have all been enabled. All these nodes are relevant and
valid for the AM572x IDK board.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am572x-idk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index a578fe97ba3b..0f3be0de82b7 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -127,3 +127,27 @@
 		status = "okay";
 	};
 };
+
+&mmu0_dsp1 {
+	status = "okay";
+};
+
+&mmu1_dsp1 {
+	status = "okay";
+};
+
+&mmu0_dsp2 {
+	status = "okay";
+};
+
+&mmu1_dsp2 {
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
-- 
2.13.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
