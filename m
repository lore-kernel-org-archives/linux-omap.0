From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/13] omap2/3: id: fix sparse warning
Date: Thu, 08 Jul 2010 16:54:43 +0300
Message-ID: <20100708135443.26276.42605.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59946 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab0GHNyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 09:54:46 -0400
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

omap24xx_check_revision, omap3_check_features,
omap3_check_revision, omap4_check_revision, omap3_cpuinfo
are not used elsewhere, it should be static

Also fixes the following sparse warnings:
arch/arm/mach-omap2/id.c:105:13: warning: symbol 'omap24xx_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:167:13: warning: symbol 'omap3_check_features'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:189:13: warning: symbol 'omap3_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:270:13: warning: symbol 'omap4_check_revision'
was not declared. Should it be static?
arch/arm/mach-omap2/id.c:300:13: warning: symbol 'omap3_cpuinfo'
was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..c7bf0e1 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,7 +102,7 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
-void __init omap24xx_check_revision(void)
+static void __init omap24xx_check_revision(void)
 {
 	int i, j;
 	u32 idcode, prod_id;
@@ -164,7 +164,7 @@ void __init omap24xx_check_revision(void)
 		omap3_features |= OMAP3_HAS_ ##feat;			\
 	}
 
-void __init omap3_check_features(void)
+static void __init omap3_check_features(void)
 {
 	u32 status;
 
@@ -186,7 +186,7 @@ void __init omap3_check_features(void)
 	 */
 }
 
-void __init omap3_check_revision(void)
+static void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -267,7 +267,7 @@ void __init omap3_check_revision(void)
 	}
 }
 
-void __init omap4_check_revision(void)
+static void __init omap4_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
@@ -297,7 +297,7 @@ void __init omap4_check_revision(void)
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
 
-void __init omap3_cpuinfo(void)
+static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
 	char cpu_name[16], cpu_rev[16];

