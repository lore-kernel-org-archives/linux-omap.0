From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3.0-rc1 v2] OMAP: fix compilation error
Date: Tue, 31 May 2011 00:44:31 +0200
Message-ID: <201105310044.31746.jkrzyszt@tis.icnet.pl>
References: <201105302344.01530.jkrzyszt@tis.icnet.pl> <20110530222107.GA21753@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47802 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545Ab1E3WrH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 18:47:07 -0400
In-Reply-To: <20110530222107.GA21753@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

Forward-declare platform_device structure in
arch/arm/plat-omap/include/plat/flash.h, otherwise compilation may break 
with:

In file included from arch/arm/mach-omap1/flash.c:15:
arch/arm/plat-omap/include/plat/flash.h:14: warning: 'struct platform_device' declared inside parameter list
arch/arm/plat-omap/include/plat/flash.h:14: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-omap1/flash.c:16: warning: 'struct platform_device' declared inside parameter list
arch/arm/mach-omap1/flash.c:17: error: conflicting types for 'omap1_set_vpp'
arch/arm/plat-omap/include/plat/flash.h:14: error: previous declaration of 'omap1_set_vpp' was here

Detected and corrected while building for Amstrad Delta, confirmed with 
omap1_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v1 -> v2 change requested by Russell King (thanks!):
- no need to add to the complexities of header file inclusion

 arch/arm/plat-omap/include/plat/flash.h |    1 +
 1 file changed, 1 insertion(+)

--- git/arch/arm/plat-omap/include/plat/flash.h.orig	2011-05-31 00:29:36.000000000 +0200
+++ git/arch/arm/plat-omap/include/plat/flash.h	2011-05-31 00:30:50.000000000 +0200
@@ -11,6 +11,7 @@
 
 #include <linux/mtd/map.h>
 
+struct platform_device;
 extern void omap1_set_vpp(struct platform_device *pdev, int enable);
 
 #endif
