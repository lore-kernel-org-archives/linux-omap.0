From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH RESEND] omap : nand : fix subpage ecc issue with prefetch
Date: Wed, 11 May 2011 19:54:57 +0530
Message-ID: <1305123897-11371-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, stable@kernel.org, dedekind1@gmail.com
Cc: Vimal Singh <vimal.newwork@gmail.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-omap@vger.kernel.org

When reading/writing a subpage (When HW ECC is not available/enabled)
for number of bytes not aligned to 4, the mis-aligned bytes are handled
first (by cpu copy method) before enabling the Prefetch engine to/from
'p'(start of buffer 'buf'). Then it reads/writes rest of the bytes with
the help of Prefetch engine, if available, or again using cpu copy method.
Currently, reading/writing of rest of bytes, is not done correctly since
its trying to read/write again to/from begining of buffer 'buf',
overwriting the mis-aligned bytes.

Read & write using prefetch engine got broken in commit '2c01946c'.
We never hit a scenario of not getting 'gpmc_prefetch_enable' call
success. So, problem did not get caught up.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
---
 drivers/mtd/nand/omap2.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index da9a351..2c8040f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -263,11 +263,10 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
-			omap_read_buf16(mtd, buf, len);
+			omap_read_buf16(mtd, (u_char *)p, len);
 		else
-			omap_read_buf8(mtd, buf, len);
+			omap_read_buf8(mtd, (u_char *)p, len);
 	} else {
-		p = (u32 *) buf;
 		do {
 			r_count = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
 			r_count = r_count >> 2;
@@ -293,7 +292,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 						struct omap_nand_info, mtd);
 	uint32_t w_count = 0;
 	int i = 0, ret = 0;
-	u16 *p;
+	u16 *p = (u16 *)buf;
 	unsigned long tim, limit;
 
 	/* take care of subpage writes */
@@ -309,11 +308,10 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
 		if (info->nand.options & NAND_BUSWIDTH_16)
-			omap_write_buf16(mtd, buf, len);
+			omap_write_buf16(mtd, (u_char *)p, len);
 		else
-			omap_write_buf8(mtd, buf, len);
+			omap_write_buf8(mtd, (u_char *)p, len);
 	} else {
-		p = (u16 *) buf;
 		while (len) {
 			w_count = gpmc_read_status(GPMC_PREFETCH_FIFO_CNT);
 			w_count = w_count >> 1;
-- 
1.7.4.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
