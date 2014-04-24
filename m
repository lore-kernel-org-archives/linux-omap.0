From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 1/4] ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
Date: Thu, 24 Apr 2014 15:36:24 +0530
Message-ID: <1398333987-19454-2-git-send-email-rnayak@ti.com>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398333987-19454-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"ti,dra752" is neither documented nor correct, since the device is actually a
dra742 device as rightly documented in dt bindings.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 arch/arm/boot/dts/dra7-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..7807429 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "TI DRA7";
-	compatible = "ti,dra7-evm", "ti,dra752", "ti,dra7";
+	compatible = "ti,dra7-evm", "ti,dra7";
 
 	memory {
 		device_type = "memory";
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
