From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap iommu: fix wrong condition check for SUPERSECTION
Date: Mon, 12 Oct 2009 11:03:04 +0300
Message-ID: <1255334584-27916-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47688 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbZJLIEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 04:04:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: srinivas.pulukuru@ti.com, pparveen@ti.com, saaguirre@ti.com, x0055901@ti.com, nikhil@ti.com, subramani.venkatesh@windriver.com, muthu@ti.com, s-miesen@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

A bit (2 << 0) is set both on SECTION and SUPERSECTION. To identify
SUPERSECTION correctly, other bits should be compared too.

Reported-by: "Srinivas Pulukuru" <srinivas.pulukuru@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 4b60127..94584f1 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -664,7 +664,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		nent = 1; /* for the next L1 entry */
 	} else {
 		bytes = IOPGD_SIZE;
-		if (*iopgd & IOPGD_SUPER) {
+		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
 			nent *= 16;
 			/* rewind to the 1st entry */
 			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
-- 
1.6.0.4

