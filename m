From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: &&/|| confusion in iommu_put()
Date: Sat, 19 Dec 2009 16:17:40 +0100
Message-ID: <4B2CEE94.3080800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41872 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbZLSPWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 10:22:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

obj can't be both NULL and be an error pointer.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index c0ff1e3..463d638 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -827,7 +827,7 @@ EXPORT_SYMBOL_GPL(iommu_get);
  **/
 void iommu_put(struct iommu *obj)
 {
-	if (!obj && IS_ERR(obj))
+	if (!obj || IS_ERR(obj))
 		return;
 
 	mutex_lock(&obj->iommu_lock);
