From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/10] OMAP powerdomain: rearrange struct powerdomain to save
	some memory
Date: Mon, 11 Jan 2010 18:05:42 -0700
Message-ID: <20100112010540.6275.80664.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45296 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab0ALBQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:16:22 -0500
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch rearranges the order of structure members in struct powerdomain
to avoid wasting memory due to alignment restrictions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index c590e2f..87e13f8 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -73,12 +73,12 @@ struct powerdomain {
 	/* Powerdomain name */
 	const char *name;
 
-	/* the address offset from CM_BASE/PRM_BASE */
-	const s16 prcm_offs;
-
 	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
 
+	/* the address offset from CM_BASE/PRM_BASE */
+	const s16 prcm_offs;
+
 	/* Possible powerdomain power states */
 	const u8 pwrsts;
 


