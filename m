From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2xxx EAC: fix build breakage due to recent IO changes
Date: Thu, 4 Sep 2008 22:39:07 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809042237470.25143@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43391 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYIEEjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 00:39:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Commit f228a725b975832ac5771ab2fc86d06bd694cdb3 breaks the build for this
driver; fix by using OMAP2_IO_ADDRESS.

Compile-tested only.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 sound/arm/omap/eac.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index 9fe8d74..cb042e6 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -254,7 +254,7 @@
 /* internal structure of the EAC driver */
 struct omap_eac {
 	struct mutex			mutex;
-	void __iomem *			base;
+	u32				base;
 	struct platform_device *	pdev;
 	struct eac_platform_data *	pdata;
 	struct snd_card *		card;
@@ -279,12 +279,12 @@ MODULE_PARM_DESC(id, "ID string for OMAP24xx EAC");
 
 static inline void eac_write_reg(struct omap_eac *eac, int idx, u16 val)
 {
-	__raw_writew(val, eac->base + idx);
+	__raw_writew(val, OMAP2_IO_ADDRESS(eac->base + idx));
 }
 
 static inline u16 eac_read_reg(struct omap_eac *eac, int idx)
 {
-	return __raw_readw(eac->base + idx);
+	return __raw_readw(OMAP2_IO_ADDRESS(eac->base + idx));
 }
 
 static int eac_get_clocks(struct omap_eac *eac)
@@ -707,7 +707,7 @@ static int __devinit eac_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto err1;
 	}
-	eac->base = (void __iomem *)io_p2v(res->start);
+	eac->base = res->start;
 	eac->pdata = pdata;
 
 	/* pre-initialize EAC hw */
