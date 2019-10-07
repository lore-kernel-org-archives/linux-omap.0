From: Adam Ford <aford173@gmail.com>
Subject: [PATCH 1/2] configs: ARM: omap2plus: Enable OMAP3_THERMAL
Date: Mon,  7 Oct 2019 17:05:39 -0500
Message-ID: <20191007220540.30690-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: adam.ford@logicpd.com, hns@goldelico.com, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The some in the OMAP3 family have a bandgap thermal sensor, but
omap2plus has it disabled.

This patch enables the OMAP3_THERMAL by default like the rest of
the OMAP family.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8f1c2b6f9e56..7e14a8c8bb29 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -292,6 +292,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
 CONFIG_CPU_THERMAL=y
 CONFIG_TI_THERMAL=y
+CONFIG_OMAP3_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y
-- 
2.17.1
