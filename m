From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/2] AM35xx: Define the AM3517EVM board
Date: Tue, 27 Oct 2009 19:32:40 +0530
Message-ID: <1256652160-5746-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59134 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbZJ0OCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 10:02:39 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9RE2fgP029766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2009 09:02:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Add support for the AM3517 EVM board. This EVM
supports AM3505 and AM3517 devices.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8685df5..c904580 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,10 @@ config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3517EVM
+	bool "OMAP3517/ AM3517 EVM board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
-- 
1.6.2.2

