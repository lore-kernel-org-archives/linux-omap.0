From: Charles Manning <manningc2@actrix.gen.nz>
Subject: OMAP NAND redux
Date: Fri, 17 Dec 2010 11:01:09 +1300
Message-ID: <201012171101.09244.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:46433 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756104Ab0LPWBL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 17:01:11 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

Hello All

Over the last while I have been working on getting ubifs working on omap3530 
using 16-bit NAND with the latest 2.6.37 prefetch code. This is basically a 
tweaked Overo kernel.

 Here is what I found:

After initial exploration I found that there were three problem:

* ECC bytes not being read correctly during sub-page reads.
* Disabling prefetch meant that the flash was not being read at all. 
* NAND access seems to have slowed down significantly.

Both these boiled down to one root cause. After the prefetch changes, 
nand->IO_ADDR_R is set to an address that only works within the context of 
the prefetch code. It no longer works if prefetch is disabled. Execution of:
 static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
{
 	struct nand_chip *nand = mtd->priv;

        ioread16_rep(nand->IO_ADDR_R, buf, len / 2);
} 


Even if prefetch is enabled, subpage reads that are not 32-bit aligned call 
the above function which means the ECC does not read correctly - resulting in 
ECC errors. 

I managed to work around this by applying the following patch to force all 
buffer reads to u32 alignment:
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -245,6 +245,18 @@ static void omap_read_buf_pref(struct mtd_info *mtd, 
u_char *buf, int len)
        int ret = 0;
        u32 *p = (u32 *)buf;
 
+       /* u32 align the buffer and read */
+       /* NB: This assumes the buf ptr can be aligned *down* which is a 
valid.
+        * Assumption when dealing with ecc buffers etc.
+        */
+       u32 addr = (u32)p;
+
+       int diff = addr & 3;
+       addr -= diff;
+       len += diff;
+       len = (len + 3) & ~3;
+       p = (u32 *)addr;
+
        /* take care of subpage reads */
        if (len % 4) {
                if (info->nand.options & NAND_BUSWIDTH_16)

Yeah I know that is ugly, but it works!

Prefetch is enabled, dma is disabled. ECC is done in software.

OK, that gives me a working UBIFS, but I found something else...

NAND access has got way, way slower since 2.6.34.

I created a 2MB file foo then do the following:

sync; date; cp foo bar; sync; date

In 2.6.34 the time between the two dates was 3 seconds.
In 2.6.37 this now takes 14 seconds!


Now question time:

1) How well has the prefetch code been tested?
2) Does it work with prefetch disabled?
3) Has it been performance tested?
4) What should the value in nand->IO_ADDR_R be?


Thanks

Charles

