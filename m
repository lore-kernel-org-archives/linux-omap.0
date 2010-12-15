From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/2] arm: mach-omap2: Kconfig: devkit8000 should select needed options
Date: Wed, 15 Dec 2010 14:49:12 +0200
Message-ID: <1292417352-18082-2-git-send-email-aaro.koskinen@nokia.com>
References: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62779 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab0LOMsU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:48:20 -0500
In-Reply-To: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

It's not possible to compile a kernel for this board without I2C,
MFD_SUPPORT and TWL4030_CORE, so those should be selected. This will
prevent build errors when trying out different configurations.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index db20351..bb32f35 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -129,6 +129,10 @@ config MACH_DEVKIT8000
 	default y
 	select OMAP_PACKAGE_CUS
 	select OMAP_MUX
+	select I2C
+	select I2C_OMAP
+	select MFD_SUPPORT
+	select TWL4030_CORE
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
-- 
1.5.6.5

