From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/8] ARM: dts: dra72-evm-tps65917: Add cpu0 vdd supply
Date: Tue, 19 Dec 2017 09:24:24 -0600
Message-ID: <1513697066-27732-7-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add vdd-supply as smps12_reg for cpu0.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
index 57bfe5caf5e4..47bb90f41f3f 100644
--- a/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-tps65917.dtsi
@@ -148,3 +148,7 @@
 &mmc1 {
 	vqmmc-supply = <&ldo1_reg>;
 };
+
+&cpu0 {
+	vdd-supply = <&smps1_reg>;
+};
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
