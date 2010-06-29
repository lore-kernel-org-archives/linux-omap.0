From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] omap: Make omap specific features appear under Kconfig
	menu
Date: Tue, 29 Jun 2010 14:47:29 +0300
Message-ID: <20100629114729.16008.70219.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64232 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab0F2LrR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:47:17 -0400
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This will make Kconfig look nicer for selecting omap processor type

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Kconfig |    7 +++++++
 arch/arm/mach-omap2/Kconfig |    7 +++++++
 arch/arm/plat-omap/Kconfig  |    2 +-
 3 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index b18d7c2..c911cdb 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -1,3 +1,7 @@
+if ARCH_OMAP1
+
+menu "TI OMAP1 specific features"
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP1
 
@@ -237,3 +241,6 @@ config OMAP_ARM_30MHZ
 	help
           Enable 30MHz clock for OMAP CPU. If unsure, say N.
 
+endmenu
+
+endif
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f67f037..e94ee6b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,3 +1,7 @@
+if ARCH_OMAP2PLUS
+
+menu "TI OMAP2/3/4 Specific Features"
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
@@ -186,3 +190,6 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+endmenu
+
+endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 3e2e7a8..a4e8727 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,6 +1,6 @@
 if ARCH_OMAP
 
-menu "TI OMAP Implementations"
+menu "TI OMAP Common Features"
 
 config ARCH_OMAP_OTG
 	bool

