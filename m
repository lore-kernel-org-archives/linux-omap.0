From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: am335x-chilisom: Enable poweroff PMIC sequence using RTC signal
Date: Wed, 13 Apr 2016 10:44:17 +0200
Message-ID: <1460537057-23513-4-git-send-email-m.niestroj@grinn-global.com>
References: <1460537057-23513-1-git-send-email-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460537057-23513-1-git-send-email-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ChiliSOM has TPS65217's PWR_EN pin connected to AM335x PMIC_POWER_EN
pin. Processor's PMIC_POWER_EN is controlled by it's internal RTC, hence
RTC subsystem is responsible for proper board poweroff sequence.

This change enables complete poweroff sequence for ChiliBoard, switching
PMIC's state from ACTIVE to SLEEP.

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
---
 arch/arm/boot/dts/am335x-chilisom.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 5276399..bc0880d 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -122,6 +122,10 @@
 	};
 };
 
+&rtc {
+	system-power-controller;
+};
+
 /* NAND Flash */
 &elm {
 	status = "okay";
-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
