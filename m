From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP2xxx EAC: update per recent IO address changes
Date: Thu, 04 Sep 2008 23:24:22 -0600
Message-ID: <20080905052419.28183.16156.stgit@localhost.localdomain>
References: <20080905052312.28183.55601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbYIEF1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:27:00 -0400
In-Reply-To: <20080905052312.28183.55601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Commit f228a725b975832ac5771ab2fc86d06bd694cdb3 breaks the build for this
driver; fix by using OMAP2_IO_ADDRESS.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 sound/arm/omap/eac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index 9fe8d74..c97c293 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -707,7 +707,7 @@ static int __devinit eac_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto err1;
 	}
-	eac->base = (void __iomem *)io_p2v(res->start);
+	eac->base = OMAP2_IO_ADDRESS(res->start);
 	eac->pdata = pdata;
 
 	/* pre-initialize EAC hw */


