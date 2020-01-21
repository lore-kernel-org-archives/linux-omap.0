From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 15/20] ARM: omap2plus: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
Date: Tue, 21 Jan 2020 11:37:17 +0100
Message-ID: <20200121103722.1781-15-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Support for TI AM43x SoCs depends on ARCH_MULTI_V7, which selects
ARCH_MULTI_V6_V7.
As the latter selects MIGHT_HAVE_CACHE_L2X0, there is no need for
SOC_AM43XX to select MIGHT_HAVE_CACHE_L2X0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-omap2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dca7d06c0b938619..ea23205bf70f4df6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -66,7 +66,6 @@ config SOC_AM43XX
 	select ARCH_OMAP2PLUS
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
-	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select HAVE_ARM_TWD
-- 
2.17.1
