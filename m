From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] arm: omap: remove OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF
Date: Sun, 16 Feb 2014 19:51:37 +0100
Message-ID: <1392576697.28866.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:59242 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbaBPSvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Feb 2014 13:51:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

The Kconfig symbols OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF were added in
v2.6.36. They have never been used. Setting them has no effect. These
symbols can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep".

A sort of related cleanup would be removing the preprocessoer defines of
OMAP_PACKAGE_ZAC and OMAP_PACKAGE_ZAF that are unused since v3.14-rc1.

 arch/arm/mach-omap2/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 7d4934e..bb51eeb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -165,12 +165,6 @@ config SOC_TI81XX
 	depends on ARCH_OMAP3
 	default y
 
-config OMAP_PACKAGE_ZAF
-       bool
-
-config OMAP_PACKAGE_ZAC
-       bool
-
 config OMAP_PACKAGE_CBC
        bool
 
@@ -280,7 +274,6 @@ config MACH_NOKIA_N8X0
 	default y
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
-	select OMAP_PACKAGE_ZAC
 
 config MACH_NOKIA_RX51
 	bool "Nokia N900 (RX-51) phone"
-- 
1.8.5.3

