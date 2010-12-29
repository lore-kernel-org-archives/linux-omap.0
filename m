From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: OMAP NAND redux
Date: Wed, 29 Dec 2010 19:45:00 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A495001@dbde02.ent.ti.com>
References: <201012171101.09244.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50880 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab0L2OPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 09:15:11 -0500
In-Reply-To: <201012171101.09244.manningc2@actrix.gen.nz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>



> -----Original Message-----
> From: Charles Manning [mailto:manningc2@actrix.gen.nz]
> Sent: Friday, December 17, 2010 3:31 AM
> To: linux-omap@vger.kernel.org
> Cc: Ghorai, Sukumar; Grazvydas Ignotas
> Subject: OMAP NAND redux
> 
> Hello All
> 
> Over the last while I have been working on getting ubifs working on
> omap3530
> using 16-bit NAND with the latest 2.6.37 prefetch code. This is basically
> a
> tweaked Overo kernel.
> 
>  Here is what I found:
> 
> After initial exploration I found that there were three problem:
> 
> * ECC bytes not being read correctly during sub-page reads.
> * Disabling prefetch meant that the flash was not being read at all.
> * NAND access seems to have slowed down significantly.
> 
> Both these boiled down to one root cause. After the prefetch changes,
> nand->IO_ADDR_R is set to an address that only works within the context of
> the prefetch code. It no longer works if prefetch is disabled. Execution
> of:
>  static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
> {
>  	struct nand_chip *nand = mtd->priv;
> 
>         ioread16_rep(nand->IO_ADDR_R, buf, len / 2);
> }
> 
> 
> Even if prefetch is enabled, subpage reads that are not 32-bit aligned
> call
> the above function which means the ECC does not read correctly - resulting
> in
> ECC errors.
[Ghorai] please give a try with CONFIG_MTD_NAND_OMAP_HWECC enable; 
i.e. NAND_ECC_HW; by this I did not see this issue

> 
> I managed to work around this by applying the following patch to force all
> buffer reads to u32 alignment:
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -245,6 +245,18 @@ static void omap_read_buf_pref(struct mtd_info *mtd,
> u_char *buf, int len)
>         int ret = 0;
>         u32 *p = (u32 *)buf;
> 
> +       /* u32 align the buffer and read */
> +       /* NB: This assumes the buf ptr can be aligned *down* which is a
> valid.
> +        * Assumption when dealing with ecc buffers etc.
> +        */
> +       u32 addr = (u32)p;
> +
> +       int diff = addr & 3;
> +       addr -= diff;
> +       len += diff;
> +       len = (len + 3) & ~3;
> +       p = (u32 *)addr;
> +
>         /* take care of subpage reads */
>         if (len % 4) {
>                 if (info->nand.options & NAND_BUSWIDTH_16)
> 
> Yeah I know that is ugly, but it works!
> 
> Prefetch is enabled, dma is disabled. ECC is done in software.
[Ghorai] please give a try with CONFIG_MTD_NAND_OMAP_HWECC enable


> OK, that gives me a working UBIFS, but I found something else...
> 
> NAND access has got way, way slower since 2.6.34.
> 
> I created a 2MB file foo then do the following:
> 
> sync; date; cp foo bar; sync; date
> 
> In 2.6.34 the time between the two dates was 3 seconds.
> In 2.6.37 this now takes 14 seconds!
> 
> 
> Now question time:
> 
> 1) How well has the prefetch code been tested?
[Ghorai] yes, its enable by default even in 2.6.34 onwards
And many omap products using this.

> 2) Does it work with prefetch disabled?
[Ghorai] yes. 

> 3) Has it been performance tested?
[Ghorai] yes. I did not remember the numbers.

> 4) What should the value in nand->IO_ADDR_R be?
[Ghorai] this could be the same as IO_ADDR_W
And you can refer Section in TRM: Global Memory Space Mapping

> 
> 
> Thanks
> 
> Charles

