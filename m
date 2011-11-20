From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 04/11] arm:omap:am33xx: Integrate powerdomain to OMAP power framework
Date: Sun, 20 Nov 2011 22:49:08 +0530
Message-ID: <1321809555-13833-5-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38613 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab1KTRTz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Nov 2011 12:19:55 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Hook up AM33XX power domain to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 arch/arm/mach-omap2/io.c     |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d4a9a61..b5f20d2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -81,6 +81,7 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= prminst33xx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
@@ -110,6 +111,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common) \
 					   powerdomain2xxx_3xxx.o \
 					   powerdomains3xxx_data.o \
 					   powerdomains2xxx_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= powerdomain33xx.o \
+					   powerdomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomain44xx.o \
 					   powerdomains44xx_data.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b67d2ca..7ea23d8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -466,6 +466,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
+	am33xx_powerdomains_init();
 	omap3xxx_clk_init();
 }
 #endif
--
1.7.0.4

