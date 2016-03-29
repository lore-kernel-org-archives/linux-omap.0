From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/8] ARM: OMAP2+: Only select TWL4030_POWER for OMAP3
Date: Tue, 29 Mar 2016 21:22:18 +0200
Message-ID: <1459279341-17389-5-git-send-email-contact@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

The TWL4030 is generally used with the OMAP3, not with OMAP4.
The TWL6030 is generally used with the OMAP4 instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ada4c7a1..6ffa7f1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -125,7 +125,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	select TWL_CORE if ARCH_OMAP3 || ARCH_OMAP4
-	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select TWL4030_POWER if ARCH_OMAP3
 	select VFP
 	help
 	  Compile a kernel suitable for booting most boards
-- 
2.7.4
