From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] Add missing macro argument for devm_release_* family
Date: Tue,  2 Sep 2008 12:06:24 +0300
Message-ID: <1220346384-15792-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56370 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYIBJGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 05:06:50 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8296Rol032282
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 12:06:47 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8296Od6031504
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 12:06:25 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 include/linux/ioport.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 22d2115..c813c63 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -158,9 +158,9 @@ extern struct resource * __devm_request_region(struct device *dev,
 				struct resource *parent, resource_size_t start,
 				resource_size_t n, const char *name);
 
-#define devm_release_region(start,n) \
+#define devm_release_region(dev,start,n) \
 	__devm_release_region(dev, &ioport_resource, (start), (n))
-#define devm_release_mem_region(start,n) \
+#define devm_release_mem_region(dev,start,n) \
 	__devm_release_region(dev, &iomem_resource, (start), (n))
 
 extern void __devm_release_region(struct device *dev, struct resource *parent,
-- 
1.5.5.1.357.g1af8b

