From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 21/30] sound/soc/omap: limit to omap2plus
Date: Sun,  2 Oct 2011 16:45:51 +0200
Message-ID: <1317566760-25681-22-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

These drivers do not build correctly on omap1, so only allow
selecting them on omap2 or higher.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 sound/soc/omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fe83d0d..493733e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,6 +1,6 @@
 config SND_OMAP_SOC
 	tristate "SoC Audio for the Texas Instruments OMAP chips"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP2PLUS
 
 config SND_OMAP_SOC_MCBSP
 	tristate
-- 
1.7.5.4
