From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] omap2/3: id: fix sparse warning
Date: Thu, 08 Jul 2010 12:37:50 +0300
Message-ID: <20100708093750.16352.22544.stgit@baageli.muru.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53369 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab0GHJhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:37:54 -0400
In-Reply-To: <20100708093405.16352.11814.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

From: Nishanth Menon <nm@ti.com>

omap24xx_check_revision, omap3_check_features,
omap3_check_revision, omap4_check_revision, omap3_cpuinfo
are not used elsewhere, it should be static

Also fixes the following sparse warnings:
arch/arm/mach-omap2/id.c:105:13: warning: symbol 'omap24xx_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:167:13: warning: symbol 'omap3_check_features' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:189:13: warning: symbol 'omap3_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:270:13: warning: symbol 'omap4_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:300:13: warning: symbol 'omap3_cpuinfo' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 16dbb9e..fd1904b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -112,7 +112,7 @@ void omap_get_die_id(struct omap_die_id *odi)
 	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
 }
 
-void __init omap24xx_check_revision(void)
+static void __init omap24xx_check_revision(void)
 {
 	int i, j;
 	u32 idcode, prod_id;
@@ -172,7 +172,7 @@ void __init omap24xx_check_revision(void)
 		omap3_features |= OMAP3_HAS_ ##feat;			\
 	}
 
-void __init omap3_check_features(void)
+static void __init omap3_check_features(void)
 {
 	u32 status;
 
@@ -196,7 +196,7 @@ void __init omap3_check_features(void)
 	 */
 }
 
-void __init omap3_check_revision(void)
+static void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -277,7 +277,7 @@ void __init omap3_check_revision(void)
 	}
 }
 
-void __init omap4_check_revision(void)
+static void __init omap4_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
@@ -307,7 +307,7 @@ void __init omap4_check_revision(void)
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
 
-void __init omap3_cpuinfo(void)
+static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
 	char cpu_name[16], cpu_rev[16];

