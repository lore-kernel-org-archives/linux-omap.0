From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 5/5] ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() varients
Date: Tue, 29 Apr 2014 16:35:13 +0530
Message-ID: <1398769513-8736-6-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964813AbaD2LHb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 07:07:31 -0400
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com, Rajendra Nayak <rnayak@ti.com>

Use the corresponding compatibles to identify the devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/soc.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 30abcc8..5ff724e 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -245,6 +245,8 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_omap54xx()		0
 #define soc_is_omap543x()		0
 #define soc_is_dra7xx()			0
+#define soc_is_dra74x()			0
+#define soc_is_dra72x()			0
 
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
@@ -393,7 +395,12 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_SOC_DRA7XX)
 #undef soc_is_dra7xx
+#undef soc_is_dra74x
+#undef soc_is_dra72x
 #define soc_is_dra7xx()	(of_machine_is_compatible("ti,dra7"))
+#define soc_is_dra74x()	(of_machine_is_compatible("ti,dra74"))
+#define soc_is_dra72x()	(of_machine_is_compatible("ti,dra72"))
+
 #endif
 
 /* Various silicon revisions for omap2 */
-- 
1.7.9.5

