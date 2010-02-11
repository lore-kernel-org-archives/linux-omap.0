From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/17] omap: iommu: fix incorrect address for supersection 1st
	entry
Date: Wed, 10 Feb 2010 19:35:41 -0800
Message-ID: <20100211033541.1624.42854.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58138 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0BKDfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:35:01 -0500
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Hari Nagalla <hnagalla@ti.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was a potential risk that the following "memset" could override
its range if a given address was not the 1st entry of a
supersection. This is not the case for "iovmm".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 463d638..e748119 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -667,7 +667,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
+			iopgd = iopgd_offset(obj, (da & IOSUPER_MASK));
 		}
 		bytes *= nent;
 	}

