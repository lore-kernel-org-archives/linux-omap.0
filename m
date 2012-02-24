From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: OMAP2+: Fix Kconfig dependencies for
 USB_ARCH_HAS_EHCI
Date: Thu, 23 Feb 2012 16:54:04 -0800
Message-ID: <20120224005403.16794.15077.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48264 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2BXAyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:06 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we get:

warning: (ARCH_OMAP3 && ARCH_OMAP4) selects USB_ARCH_HAS_EHCI
which has unmet direct dependencies (USB_SUPPORT)

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..337f98d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -32,7 +32,7 @@ config ARCH_OMAP3
 	depends on ARCH_OMAP2PLUS
 	default y
 	select CPU_V7
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
@@ -52,7 +52,7 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
-	select USB_ARCH_HAS_EHCI
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
 
 comment "OMAP Core Type"

