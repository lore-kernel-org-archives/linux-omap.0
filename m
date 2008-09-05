From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/2] OMAP2xxx EAC: update per recent IO address changes
Date: Thu, 04 Sep 2008 23:51:15 -0600
Message-ID: <20080905055048.5272.89989.stgit@localhost.localdomain>
References: <20080905054959.5272.63450.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYIEF6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:58:54 -0400
In-Reply-To: <20080905054959.5272.63450.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Commit f228a725b975832ac5771ab2fc86d06bd694cdb3 breaks the build for this
driver; fix by using ioremap().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/devices.c |    4 ++--
 sound/arm/omap/eac.c          |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index bd49a0f..c7de03e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -270,12 +270,12 @@ static inline void omap_init_mcspi(void) {}
 
 #ifdef CONFIG_SND_OMAP24XX_EAC
 
-#define OMAP2_EAC_BASE			0x48090000
+#define OMAP2_EAC_BASE			(L4_24XX_BASE + 0x90000)
 
 static struct resource omap2_eac_resources[] = {
 	{
 		.start		= OMAP2_EAC_BASE,
-		.end		= OMAP2_EAC_BASE + 0x109,
+		.end		= OMAP2_EAC_BASE + 0xfff,
 		.flags		= IORESOURCE_MEM,
 	},
 };
diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index 9fe8d74..9752ece 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -707,7 +707,7 @@ static int __devinit eac_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto err1;
 	}
-	eac->base = (void __iomem *)io_p2v(res->start);
+	eac->base = ioremap(res->start, (res->end - res->start) + 1);
 	eac->pdata = pdata;
 
 	/* pre-initialize EAC hw */


