From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 06/14] mtd: onenand: omap: use pdata info instead of
 cpu_is
Date: Fri, 26 Oct 2012 05:04:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210260411140.27963@utopia.booyaka.com>
References: <cover.1349672877.git.afzal@ti.com> <860ba92c34cbb490beccd5442087087c1751a6a2.1349672877.git.afzal@ti.com> <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39031 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab2JZFEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 01:04:12 -0400
In-Reply-To: <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Jon Hunter <jon-hunter@ti.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org

On Fri, 26 Oct 2012, Paul Walmsley wrote:

> On Mon, 8 Oct 2012, Afzal Mohammed wrote:
> 
> > platform data now contains a field to indicate whether
> > soc belongs to omap34xx family, use it instead of
> > cpu_is_* check.
> > 
> > This helps in removing dependency of platform specific
> > header file - cpu.h
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> This one breaks an N800 multi-OMAP build here:

It also breaks an OMAP3+4 config:

drivers/built-in.o: In function `omap2_onenand_probe':
/home/paul/test_build/temp/test_cleanup_prcm_8634155e_with_fixes/20121025214236/linux/drivers/mtd/onenand/omap2.c:742: 
undefined reference to `omap2_onenand_read_bufferram'
/home/paul/test_build/temp/test_cleanup_prcm_8634155e_with_fixes/20121025214236/linux/drivers/mtd/onenand/omap2.c:743: 
undefined reference to `omap2_onenand_write_bufferram'
/home/paul/test_build/temp/test_cleanup_prcm_8634155e_with_fixes/20121025214236/linux/drivers/mtd/onenand/omap2.c:742: 
undefined reference to `omap2_onenand_read_bufferram'
/home/paul/test_build/temp/test_cleanup_prcm_8634155e_with_fixes/20121025214236/linux/drivers/mtd/onenand/omap2.c:743: 
undefined reference to `omap2_onenand_write_bufferram'

Fix below.


- Paul

---
 drivers/mtd/onenand/omap2.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index f87cf39..99f96e1 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -555,13 +555,19 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 
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
 
-- 
1.7.10.4
