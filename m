From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap iommu: fix wrong argument in flush_cache_vmap()
Date: Tue, 11 Aug 2009 12:25:10 +0300
Message-ID: <1249982710-31681-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23767 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZHKMIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 08:08:54 -0400
Received: from mgw-mx06.nokia.com (mgw-mx06.nokia.com [192.100.122.233])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7B9i6QC023046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 12:44:08 +0300
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7B9OwSf018637
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 12:25:05 +0300
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7B9P5s9013152
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2009 12:25:07 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The second argument should be the end address, not the
length. Actually there will not be any effect on the behavior of this
driver since flush_cache_vmap() calls flush_cache_all() in the end.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index e1b03b9..18ef59a 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -194,7 +194,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 		va += bytes;
 	}
 
-	flush_cache_vmap(new->addr, total);
+	flush_cache_vmap(new->addr, new->addr + total);
 	return new->addr;
 
 err_out:
-- 
1.6.0.4

