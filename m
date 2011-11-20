From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 02/11] arm:omap:am33xx: Integrate voltage domain data
Date: Sun, 20 Nov 2011 22:49:06 +0530
Message-ID: <1321809555-13833-3-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab1KTRTl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Nov 2011 12:19:41 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Hook up AM33XX voltage domain info to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 ++
 arch/arm/mach-omap2/io.c     |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b33a85f..d4a9a61 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -95,6 +95,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
 					   voltagedomains2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(voltagedomain-common) \
+					   voltagedomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e958c04..b67d2ca 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -465,6 +465,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
+	am33xx_voltagedomains_init();
 	omap3xxx_clk_init();
 }
 #endif
--
1.7.0.4

