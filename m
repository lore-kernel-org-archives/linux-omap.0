From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 03/04] OMAP3: PM: Fix I2C voltage levels send to T2 for different Power modes
Date: Tue, 16 Jun 2009 17:22:33 +0530
Message-ID: <1245153154-1876-3-git-send-email-rnayak@ti.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
 <1245153154-1876-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbZFPLwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 07:52:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBqddO009207
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:52:45 -0500
In-Reply-To: <1245153154-1876-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dderrick@ti.com, r-woodruff2@ti.com, Rajendra Nayak <rnayak@ti.com>

The ONLP and ONOFF values programed for both VDD1
and VDD2 were not optimal.

New values used are
VDD1
ON - 1.2v
ONLP - 1.0v
ONRET - .975v
ONOFF - .6v

VDD2
ON - 1.15v
ONLP - 1.0v
ONRET - .975v
ONOFF - .6v

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d4225b4..c2d8b09 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -87,14 +87,14 @@ static struct prm_setup_vc prm_setup = {
 	.voltsetup_time2 = 0xfff,
 	.voltoffset = 0xff,
 	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,
-	.vdd0_onlp = 0x1e,
-	.vdd0_ret = 0x1e,
-	.vdd0_off = 0x30,
-	.vdd1_on = 0x2c,
-	.vdd1_onlp = 0x1e,
-	.vdd1_ret = 0x1e,
-	.vdd1_off = 0x2c,
+	.vdd0_on = 0x30,	/* 1.2v */
+	.vdd0_onlp = 0x20,	/* 1.0v */
+	.vdd0_ret = 0x1e,	/* 0.975v */
+	.vdd0_off = 0x00,	/* 0.6v */
+	.vdd1_on = 0x2c,	/* 1.15v */
+	.vdd1_onlp = 0x20,	/* 1.0v */
+	.vdd1_ret = 0x1e,	/* .975v */
+	.vdd1_off = 0x00,	/* 0.6v */
 };
 
 static inline void omap3_per_save_context(void)
-- 
1.5.4.7

