From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/8] ARM: dts: dra7: Enable 1.5 GHz operation for the CPU
Date: Tue, 19 Dec 2017 09:24:21 -0600
Message-ID: <1513697066-27732-4-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

After ti-opp-supply driver is in place to provide AVS Class0 and abb
regulator scaling support let's enable 1.5GHz for the cpu.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 33004e7f1ee9..eb68da74f777 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -116,6 +116,13 @@
 
 			opp-supported-hw = <0xFF 0x02>;
 		};
+
+		opp_high@1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1210000 950000 1250000>,
+					<1210000 950000 1250000>;
+			opp-supported-hw = <0xFF 0x04>;
+		};
 	};
 
 	/*
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
