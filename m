From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/5] ARM: configs: omap2plus_defconfig: enable TPS65218 configs
Date: Thu, 3 Jul 2014 19:15:02 +0530
Message-ID: <1404395102-21469-6-git-send-email-j-keerthy@ti.com>
References: <1404395102-21469-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404395102-21469-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable TPS65218 config options.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 536a137..f650f00 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -180,6 +180,7 @@ CONFIG_TWL4030_WATCHDOG=y
 CONFIG_MFD_SYSCON=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -188,6 +189,7 @@ CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
+CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_PBIAS=y
-- 
1.7.9.5
