From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Wed,  3 Sep 2008 08:36:28 +0300
Message-ID: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29755 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYICFhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 01:37:08 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m835asDN030280
	for <linux-omap@vger.kernel.org>; Wed, 3 Sep 2008 00:37:04 -0500
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m835aS6B029368
	for <linux-omap@vger.kernel.org>; Wed, 3 Sep 2008 08:36:29 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mm/ioremap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index b81dbf9..9ad7614 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -161,7 +161,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 			/*
 			 * Free the page table, if there was one.
 			 */
-			if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
+			if ((pmd_table(pmd))
 				pte_free_kernel(&init_mm, pmd_page_vaddr(pmd));
 		}
 
-- 
1.5.5.1.357.g1af8b

