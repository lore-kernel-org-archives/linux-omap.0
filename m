From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ARM: OMAP1: Remove unsafe clock values from omap1_defconfig
Date: Thu,  1 Dec 2011 21:30:39 +0100
Message-ID: <1322771439-31031-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <20111201194609.GX31337@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111201194609.GX31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

DPLL1 reprogramming to a different rate is actually blocked inside
omap1_select_table_rate(), resulting in the defalut rate of 60 MHz
always used instead of the one selected in .config. OTOH, in
omap1_defconfig we currently rely on Kconfig options for the supported
MHz rates in case of boards which boot with dpll1 not set correctly by
their boot loaders.

This means that before we allow for reprogramming of dpll1 rate, we
should remove all unsafe clock selections from omap1_defconfig,
otherwise it will stop booting on boards with imperfect boot loaders,
as it would always try to change to 216MHz.

Keep only one safe clock rate per each supported xtal frequency, i.e.
60MHZ dpll1 for 12MHz xtal and 182MHz dpll1 for 13MHz xtal.

BTW, this change goes into the direction of removing all OMAP1 clock
rate options, planned for next merge window.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Resending with commit summary tagged correctly and commit message
updated with info about next merge window planned direction.

 arch/arm/configs/omap1_defconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index a7e7775..945a34f 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -48,12 +48,7 @@ CONFIG_MACH_SX1=y
 CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
 CONFIG_MACH_OMAP_GENERIC=y
-CONFIG_OMAP_ARM_216MHZ=y
-CONFIG_OMAP_ARM_195MHZ=y
-CONFIG_OMAP_ARM_192MHZ=y
 CONFIG_OMAP_ARM_182MHZ=y
-CONFIG_OMAP_ARM_168MHZ=y
-# CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_ARM_THUMB is not set
 CONFIG_PCCARD=y
 CONFIG_OMAP_CF=y
-- 
1.7.3.4
