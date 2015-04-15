From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 26/35] ARM: OMAP2+: build: add support for hwmod data modules
Date: Wed, 15 Apr 2015 15:53:13 +0300
Message-ID: <1429102402-5276-27-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52099 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438AbbDOMxO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:14 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

New Kconfig option added, OMAP_HWMOD_DATA_MODULES, which builds hwmod
data as modules if enabled. By default, the data is built-in to kernel
image for ease of use. Makefile is also changed to support building of
the new hwmod data modules.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e477..a543dfe 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -299,6 +299,15 @@ config OMAP4_ERRATA_I688
 	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
 	  IO barrier ensure that there is no synchronisation loss on initiators
 	  operating on both interconnect port simultaneously.
+
+config OMAP_HWMOD_DATA_MODULES
+	bool "OMAP hardware module data built to modules"
+	default n
+	help
+	  Select whether hwmod data shall be built as modules, or built
+	  in to kernel. By default, this option is n, which means all the
+	  hwmod data will be built-in to kernel image.
+
 endmenu
 
 endif
-- 
1.7.9.5

