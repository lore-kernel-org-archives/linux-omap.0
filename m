From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH RFC] OMAP2PLUS: Enable HIGHMEM
Date: Thu, 2 Jun 2011 17:36:21 +0530
Message-ID: <1307016381-21878-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45108 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906Ab1FBMG2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jun 2011 08:06:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p52C6Oow006711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 2 Jun 2011 07:06:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

HIGMEM support is kernel is quite mature now and we have boards
like ZOOM, PANDA, SDP where 1 GB memories are installed.

Enable HIGMEM to make use of the additional memory.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
This won't boards which doesn't have excess memory. Tested
on OMAP4430 SDP

 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 19d5891..25e819e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -19,6 +19,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select HIGHMEM 
 	help
 	  Compile a kernel suitable for booting most boards
 
-- 
1.6.0.4

