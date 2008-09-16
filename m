From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] OMAP2 PRCM: fix CM_IDLEST bits incorrectly marked as
	2xxx-common
Date: Tue, 16 Sep 2008 08:58:32 -0600
Message-ID: <20080916145830.1470.50264.stgit@localhost.localdomain>
References: <20080916145747.1470.51591.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbYIPPPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:15:10 -0400
In-Reply-To: <20080916145747.1470.51591.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch fixes a few OMAP2xxx CM_IDLEST bits that were incorrectly
marked as being OMAP2xxx-wide, when they were actually 2420-specific.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm-regbits-24xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index 1098ecf..36a32a6 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -117,8 +117,8 @@
 #define OMAP24XX_ST_FAC					(1 << 25)
 #define OMAP2420_ST_EAC					(1 << 24)
 #define OMAP24XX_ST_HDQ					(1 << 23)
-#define OMAP24XX_ST_I2C2				(1 << 20)
-#define OMAP24XX_ST_I2C1				(1 << 19)
+#define OMAP2420_ST_I2C2				(1 << 20)
+#define OMAP2420_ST_I2C1				(1 << 19)
 #define OMAP24XX_ST_MCBSP2				(1 << 16)
 #define OMAP24XX_ST_MCBSP1				(1 << 15)
 #define OMAP24XX_ST_DSS					(1 << 0)


