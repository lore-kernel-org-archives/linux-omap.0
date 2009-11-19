From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 8/8] Additional file for Always Innovating OMAP3-based Touch Book
Date: Thu, 19 Nov 2009 09:18:11 -0800
Message-ID: <1258651091-31727-9-git-send-email-gregoire@gentil.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <1258651091-31727-4-git-send-email-gregoire@gentil.com>
 <1258651091-31727-5-git-send-email-gregoire@gentil.com>
 <1258651091-31727-6-git-send-email-gregoire@gentil.com>
 <1258651091-31727-7-git-send-email-gregoire@gentil.com>
 <1258651091-31727-8-git-send-email-gregoire@gentil.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:36031 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZKSRSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 12:18:47 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2860846fga.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 09:18:53 -0800 (PST)
In-Reply-To: <1258651091-31727-8-git-send-email-gregoire@gentil.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Gregoire Gentil <gregoire@gentil.com>, Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 034d990..6d32d1b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,11 @@ config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP3_TOUCHBOOK
+	bool "OMAP3 Touch Book"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select BACKLIGHT_CLASS_DEVICE
+
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..b6b5c7f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,8 @@ obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
+					   mmc-twl4030.o
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
-- 
1.6.0.4

