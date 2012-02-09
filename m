From: Matt Porter <mporter@ti.com>
Subject: [PATCH 2/2] omap: build am3517crane board support by default
Date: Thu,  9 Feb 2012 15:16:26 -0500
Message-ID: <1328818586-7104-3-git-send-email-mporter@ti.com>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50210 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab2BIUQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:16:33 -0500
Received: by yhoo21 with SMTP id o21so1123602yho.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 12:16:32 -0800 (PST)
In-Reply-To: <1328818586-7104-1-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Set default to include support for the craneboard when
using the omap2plus_defconfig.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..678b8ac 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -206,6 +206,7 @@ config MACH_OMAP3517EVM
 config MACH_CRANEBOARD
 	bool "AM3517/05 CRANE board"
 	depends on ARCH_OMAP3
+	default y
 	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3_PANDORA
-- 
1.7.5.4

