From: "Pais, Allen" <allen.pais@ti.com>
Subject: [PATCH 2/2] Accomodate the board file change in Kconfig
Date: Mon, 26 Oct 2009 13:13:24 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFDFA7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43929 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776AbZJZHio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 03:38:44 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9Q7ckMQ020721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 02:38:49 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9Q7ckpO015401
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 13:08:46 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 0599ed35fde00cd84681e5d8f9a57a797fae1270 Mon Sep 17 00:00:00 2001
From: Allen Pais <allen.pais@ti.com>
Date: Mon, 26 Oct 2009 12:51:02 +0530
Subject: [PATCH 2/2] Accomodate the board file change in Kconfig


Signed-off-by: Allen Pais <allen.pais@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    4 ++++
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index aad194f..f555c18 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,10 @@ config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_3630SDP
+	bool "OMAP 3630 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_NOKIA_N800
        bool
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6b7702f..d6afc01 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
-- 
1.5.4.3
