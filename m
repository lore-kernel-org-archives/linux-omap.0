From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] omap: &&/|| confusion in iommu_put()
Date: Wed, 06 Jan 2010 16:19:11 -0800
Message-ID: <20100107001911.21352.93513.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53197 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab0AGATL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:19:11 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

obj can't be both NULL and be an error pointer.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

