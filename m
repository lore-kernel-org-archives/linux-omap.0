From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH v2 1/5] OMAP: Add in helper macros for the SDRAM timings
Date: Tue,  6 Apr 2010 10:31:12 -0700
Message-ID: <1270575072-3768-1-git-send-email-lwalkera@ieee.org>
References: <20100406171713.GA24981@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og115.obsmtp.com ([64.18.2.217]:44384 "HELO
	exprod7og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756620Ab0DFRfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:35:50 -0400
In-Reply-To: <20100406171713.GA24981@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>

Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
---
 arch/arm/plat-omap/include/plat/sdrc.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 7b76f50..c74d1e7 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -124,6 +124,29 @@ struct omap_sdrc_params {
 	u32 mr;
 };
 
+/* Helper macros and defines for the omap_sdrc_params registers */
+#define ACTIM_TRFC(a)		(((a) & 0x1f) << 27)
+#define ACTIM_TRC(a)		(((a) & 0x1f) << 22)
+#define ACTIM_TRAS(a)		(((a) & 0xf) << 18)
+#define ACTIM_TRP(a)		(((a) & 0x3) << 15)
+#define ACTIM_TRCD(a)		(((a) & 0x3) << 12)
+#define ACTIM_TRRD(a)		(((a) & 0x3) << 9)
+#define ACTIM_TDPL(a)		(((a) & 0x3) << 6)
+#define ACTIM_TDAL(a)		(((a) & 0x1f) << 0)
+
+#define ACTIM_TWTR(a)		(((a) & 0x3) << 16)
+#define ACTIM_TCKE(a)		(((a) & 0x7) << 12)
+#define ACTIM_TXP(a)		(((a) & 0x7) << 8)
+#define ACTIM_TXSR(a)		(((a) & 0xff) << 0)
+
+#define RFR_CTRL_ARCV(a)	(((a) & 0xffff) << 8)
+#define RFR_CTRL_ARE(a)	(((a) & 0x3) << 0)
+
+#define MR_WBST(a)		(((a) & 0x1) << 9)
+#define MR_CASL(a)		(((a) & 0x7) << 4)
+#define MR_BL(a)		(((a) & 0x7) << 0)
+
+
 void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 			    struct omap_sdrc_params *sdrc_cs1);
 int omap2_sdrc_get_params(unsigned long r,
-- 
1.6.3.3

