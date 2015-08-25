From: Vishal Mahaveer <vishalm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: DRA7: fix a typo in ethernet
Date: Tue, 25 Aug 2015 16:50:50 -0500
Message-ID: <1440539450-8393-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Register address in name of the node is wrong

Signed-off-by: Vishal Mahaveer <vishalm-l0cyMroinI0@public.gmane.org>
Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1e29ccf..9a20d46 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1398,7 +1398,7 @@
 			ti,irqs-safe-map = <0>;
 		};
 
-		mac: ethernet@4a100000 {
+		mac: ethernet@48484000 {
 			compatible = "ti,cpsw";
 			ti,hwmods = "gmac";
 			clocks = <&dpll_gmac_ck>, <&gmac_gmii_ref_clk_div>;
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
