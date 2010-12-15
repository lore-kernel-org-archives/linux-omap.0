From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Thu, 16 Dec 2010 06:35:10 +1300
Message-ID: <201012160635.11024.manningc2@actrix.gen.nz>
References: <LD5JNC$C40D8861A973796B25CD03BFFD0B4CA1@aruba.it> <201012151713.43028.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:41534 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752777Ab0LORfO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 12:35:14 -0500
In-Reply-To: <201012151713.43028.manningc2@actrix.gen.nz>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-omap@vger.kernel.org, notasas@gmail.com

On Wednesday 15 December 2010 17:13:42 Charles Manning wrote:
> On Thursday 09 December 2010 21:30:48 Luca Ceresoli wrote:
> > Charles Manning wrote:
> > > Luca, I have been having similar problems on a hacked Overo kernel.
> > >
> > > I have no problems with 2.6.35.
> > >
> > > I tried just commenting out the define and disabling PREFETCH and did
> > > not get a good boot due to ubi not finding the volume info.
> > >
> > > Are you loading up a UBI image with uboot?
> > >
> > > Are you using the ubi volume as rootfs?
> >
> > To make it work again, I did from u-boot:
> > - nand scrub (*completely* wipe the NAND)
> > - ubi part nand0,3 (recreate partitions)
> > - ubi create rootfs 400000
> > - ...create other partitions...
> > - ubi write ... (to rewrite rootfs)
> > - finally, boot with the kernel having the define commented and PREFETCH
> > off.
> >
> > Not all of these may be needed, but this way I got the board up and
> > running again.
> >
> > Luca
>
> What branch are you working from?
>
> I tried working from a reasonably recent master on
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
> I found that reads via the  prefetch eengine work, but reads via
>         ioread16_rep(nand->IO_ADDR_R, buf, len / 2)
> do not.
>
> Perhaps this is due to the address not being set up properly. Any clues?
>
> I found that I can make everything work by realigning all accesses in
> nand_base.c to be 4-byte aligned.
>

This change does what I need.

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

Charles


