From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for am43x-epos-evm
Date: Fri, 6 Jun 2014 11:47:34 +0530
Message-ID: <1402035454-25676-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM437x EPOS evm use external clock for RMII interface.
Enable the same in DT. 

Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 19f1f7e..90098f9 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -319,6 +319,10 @@
 	phy-mode = "rmii";
 };
 
+&phy_sel {
+	rmii-clock-ext;
+};
+
 &i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
