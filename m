From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff mode
Date: Mon, 4 Jul 2016 12:04:01 +0530
Message-ID: <1467614042-6838-3-git-send-email-j-keerthy@ti.com>
References: <1467614042-6838-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467614042-6838-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>

Without this, the memory will remain active during poweroff consuming
extra power.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index fba26c9..1cecc09 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -540,6 +540,9 @@
 			regulator-state-mem {
 				regulator-on-in-suspend;
 			};
+			regulator-state-disk {
+				regulator-off-in-suspend;
+			};
 		};
 
 		dcdc5: regulator-dcdc5 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
