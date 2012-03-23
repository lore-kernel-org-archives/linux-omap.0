From: mathieu.poirier@linaro.org
Subject: [PATCH 9/9] ARM: omap: select CPU_FREQ_TABLE where needed
Date: Fri, 23 Mar 2012 11:13:56 -0600
Message-ID: <1332522836-29517-10-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The omap platform requires CPU_FREQ_TABLE support to be enabled for its
CPU_FREQ implementations, so automatically select that when CPU_FREQ
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/plat-omap/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index aa59f42..1983d16 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -207,6 +207,11 @@ config OMAP_PM_NOOP
 
 endchoice
 
+config OMAP_CPU_FREQ
+	def_bool "y"
+	depends on CPU_FREQ
+	select CPU_FREQ_TABLE
+
 endmenu
 
 endif
-- 
1.7.5.4
