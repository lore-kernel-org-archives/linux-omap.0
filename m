From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Wed, 23 Dec 2009 15:03:41 +0530
Message-ID: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51406 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZLWJeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 04:34:05 -0500
Received: by bwz27 with SMTP id 27so4616881bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 23 Dec 2009 01:34:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

In omap nand driver we used to do 32-bit reads (in function
omap_read_buf_pref, using 'ioread32_rep' i.e.: __raw_readsl), and it
was working fine till some time back. But now, somehow, this has got
some problem. Reads are not being done successfully, and driver gives
lots for error reprot like below:

td->read(0x604 bytes from 0x1fc) returned ECC error
uncorrectable error :
uncorrectable error :
uncorrectable error :
uncorrectable error :
uncorrectable error :
uncorrectable error :
mtd->read(0x520 bytes from 0x2e0) returned ECC error

While if we change 32-bit reads to 16-bit reads (using 'ioread16_rep'
i.e.: __raw_readwl) makes it working fine. (A patch to do this is
listed below at the bottom of this mail.)

I have not seen any change in routine '__raw_readsl'.
So, could someone help me find out the root cause the issue?

Thanks for any input.

-- 
Regards,
Vimal Singh

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index aaef170..dc493f5 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -288,14 +288,14 @@ static void omap_read_buf_pref(struct mtd_info
 						struct omap_nand_info, mtd);
 	uint32_t pfpw_status = 0, r_count = 0;
 	int ret = 0;
-	u32 *p = (u32 *)buf;
+	u16 *p = (u16 *)buf;

 	/* take care of subpage reads */
-	for (; len % 4 != 0; ) {
+	for (; len % 2 != 0; ) {
 		*buf++ = __raw_readb(info->nand.IO_ADDR_R);
 		len--;
 	}
-	p = (u32 *) buf;
+	p = (u16 *) buf;

 	/* configure and start prefetch transfer */
 	ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
@@ -308,10 +308,10 @@ static void omap_read_buf_pref(struct mtd_info
*mtd, u_char *buf, int len)
 	} else {
 		do {
 			pfpw_status = gpmc_prefetch_status();
-			r_count = ((pfpw_status >> 24) & 0x7F) >> 2;
-			ioread32_rep(info->nand_pref_fifo_add, p, r_count);
+			r_count = ((pfpw_status >> 24) & 0x7F) >> 1;
+			ioread16_rep(info->nand_pref_fifo_add, p, r_count);
 			p += r_count;
-			len -= r_count << 2;
+			len -= r_count << 1;
 		} while (len);

 		/* disable and stop the PFPW engine */
