From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/10] OMAP2420: CTRL: fix OMAP242X_CTRL_REGADDR macro
Date: Fri, 01 Oct 2010 15:34:54 -0600
Message-ID: <20101001213449.1408.30597.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49827 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab0JAVlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:24 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Conform the OMAP2420_CTRL_BASE macro name to the standard of the rest of the
OMAP*_CTRL_BASE macro names.  This fixes a bug in the OMAP2420 SCM code that
prevented OMAP242X_CTRL_REGADDR from working.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/common.c                |    2 +-
 arch/arm/plat-omap/include/plat/omap24xx.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 7d668b3..9200ea7 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -269,7 +269,7 @@ static struct omap_globals omap242x_globals = {
 	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
 	.sdrc	= OMAP2420_SDRC_BASE,
 	.sms	= OMAP2420_SMS_BASE,
-	.ctrl	= OMAP2420_CTRL_BASE,
+	.ctrl	= OMAP242X_CTRL_BASE,
 	.prm	= OMAP2420_PRM_BASE,
 	.cm	= OMAP2420_CM_BASE,
 	.uart1_phys	= OMAP2_UART1_BASE,
diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/plat-omap/include/plat/omap24xx.h
index 7055672..92df9e2 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/plat-omap/include/plat/omap24xx.h
@@ -40,7 +40,7 @@
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 
-#define OMAP2420_CTRL_BASE	L4_24XX_BASE
+#define OMAP242X_CTRL_BASE	L4_24XX_BASE
 #define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
 #define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
 #define OMAP2420_CM_BASE	(L4_24XX_BASE + 0x8000)


