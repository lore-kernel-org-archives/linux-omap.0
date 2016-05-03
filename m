From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] HSI: omap-ssi: add COMMON_CLK dependency
Date: Tue,  3 May 2016 17:16:20 +0200
Message-ID: <1462288586-584690-2-git-send-email-arnd@arndb.de>
References: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Enabling the omap ssi driver without COMMON_CLK results in a build failure:

drivers/hsi/controllers/omap_ssi_core.c: In function 'ssi_clk_event':
drivers/hsi/controllers/omap_ssi_core.c:304:7: error: 'PRE_RATE_CHANGE' undeclared (first use in this function)

This adds a Kconfig dependency to avoid the invalid configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4bcf7414528a ("HSI: omap-ssi: add clk change support")
---
 drivers/hsi/controllers/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/Kconfig b/drivers/hsi/controllers/Kconfig
index 084ec97eec64..48e4eda186cc 100644
--- a/drivers/hsi/controllers/Kconfig
+++ b/drivers/hsi/controllers/Kconfig
@@ -5,7 +5,8 @@ comment "HSI controllers"
 
 config OMAP_SSI
 	tristate "OMAP SSI hardware driver"
-	depends on HSI && OF && (ARCH_OMAP3 || (ARM && COMPILE_TEST))
+	depends on HSI && OF && ARM && COMMON_CLK
+	depends on ARCH_OMAP3 || COMPILE_TEST
 	---help---
 	  SSI is a legacy version of HSI. It is usually used to connect
 	  an application engine with a cellular modem.
-- 
2.7.0
