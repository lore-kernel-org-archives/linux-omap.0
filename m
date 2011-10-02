From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 24/30] ARM: omap2+: ensure that one of omap2/3/4 is selected
Date: Sun,  2 Oct 2011 16:45:54 +0200
Message-ID: <1317566760-25681-25-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

Random configurations can fail if none of the omap families
in mach-omap2 is selected. This patch automatically selects
omap2 if the user has not made any other choice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4deeade..3c9fb89 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -51,6 +51,16 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
 
+config ARCH_OMAP2_AUTO
+	bool
+	depends on !ARCH_OMAP3 && !ARCH_OMAP4
+	select ARCH_OMAP2
+	default y
+	help
+	  At least one of OMAP2/OMAP3/OMAP4 needs to be enabled, this
+	  selects OMAP2 if nothing else gets selected, to avoid non-building
+	  configurations.
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
-- 
1.7.5.4
