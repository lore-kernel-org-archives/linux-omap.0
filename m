From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] ARM: OMAP2+: fix build breakage introduced by commit
 b7754452b3e27716347a528b47b0a1083af32520
Date: Fri, 26 Oct 2012 14:08:26 -0600
Message-ID: <20121026200824.16521.51522.stgit@dusk.lan>
References: <20121026200413.16521.88985.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40888 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966361Ab2JZUJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:09:02 -0400
In-Reply-To: <20121026200413.16521.88985.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>

Commit b7754452b3e27716347a528b47b0a1083af32520 ("mtd: onenand: omap:
use pdata info instead of cpu_is") broke an OMAP3+4 build and an N800
multi-OMAP2xxx build here:

drivers/built-in.o: In function `omap2_onenand_probe':
drivers/mtd/onenand/omap2.c:742: undefined reference to `omap2_onenand_read_bufferram'
drivers/mtd/onenand/omap2.c:743: undefined reference to `omap2_onenand_write_bufferram'
drivers/mtd/onenand/omap2.c:742: undefined reference to `omap2_onenand_read_bufferram'
drivers/mtd/onenand/omap2.c:743: undefined reference to `omap2_onenand_write_bufferram'

...

drivers/built-in.o: In function `omap2_onenand_probe':
drivers/mtd/onenand/omap2.c:788: undefined reference to `omap3_onenand_read_bufferram'
drivers/mtd/onenand/omap2.c:788: undefined reference to `omap3_onenand_write_bufferram'

Fix by declaring static functions for the missing symbols, rather than
just prototypes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Afzal Mohammed <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/mtd/onenand/omap2.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 53069ae..99f96e1 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -445,13 +445,19 @@ out_copy:
 
 #else
 
-int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
-				 unsigned char *buffer, int offset,
-				 size_t count);
+static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	return -ENOSYS;
+}
 
-int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
-				  const unsigned char *buffer,
-				  int offset, size_t count);
+static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
+					 const unsigned char *buffer,
+					 int offset, size_t count)
+{
+	return -ENOSYS;
+}
 
 #endif
 
@@ -549,13 +555,19 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 
 #else
 
-int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
-				 unsigned char *buffer, int offset,
-				 size_t count);
+static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	return -ENOSYS;
+}
 
-int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
-				  const unsigned char *buffer,
-				  int offset, size_t count);
+static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
+					 const unsigned char *buffer,
+					 int offset, size_t count)
+{
+	return -ENOSYS;
+}
 
 #endif
 


