From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP NAND driver issue with subpage reads
Date: Wed, 24 Oct 2012 09:20:03 -0700
Message-ID: <20121024162003.GE5605@atomide.com>
References: <CAKvrXUpJDuCgeZwuhtcxn0POSntWCm_Lc3YgqF9uVAU6=SjwKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64319 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933959Ab2JXQUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 12:20:07 -0400
Content-Disposition: inline
In-Reply-To: <CAKvrXUpJDuCgeZwuhtcxn0POSntWCm_Lc3YgqF9uVAU6=SjwKg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Juha Kuikka <juha.kuikka@gmail.com> [121023 13:40]:
> Hi,
> 
> There seems to be an issue in the omap nand driver
> (drivers/mtd/nand/omap2.c) concerning sub-page reads (visible when
> using 16bit LP NAND,  SOFT_ECC and UBI).
> 
> Problem is caused by the omap_read_buf_pref() function using 32bit
> reads from the pre-fetch engine. It takes care of the mis-aligned
> length but not a mis-aligned buffer pointer. Combined with how the
> nand_read_subpage() function aligns the pointer and length to NAND
> width (8 or 16 bits) this can lead to situation where the handling of
> the mis-aligned length in omap_read_buf_pref() causes the pointer to
> not be aligned to 32bits and the data gets corrupted in the read. This
> of course leds to ECC issues.
> 
> The way I see is there are several ways to fix this:
> 
> 1. Change nand_read_subpage() to be more strict about alignment
> 2. Change omap_read_buf_pref() to handle any reads (len % 4) || (buf %
> 4) with omap_read_bufX() completely
> 3. Change omap_read_buf_pref() to use ioread16_rep() since buffer and
> length are already aligned for us.
> 
> I'm leaning towards #2 because, assuming that the nand driver cannot
> make assumptions of alignment, we need to be able to handle them all
> anyway. The common case of reading big chunks of page data would still
> be fast (since reads are always sub-page aligned) but the special case
> of reading small OOB chunks would be handled gracefully.
> 
> Something like this:
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5c8978e..8a929cf 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -334,13 +334,12 @@ static void omap_read_buf_pref(struct mtd_info
> *mtd, u_char *buf, int len)
>         u32 *p = (u32 *)buf;
> 
>         /* take care of subpage reads */
> -       if (len % 4) {
> +       if (len % 4 || (unsigned long) buf % 4) {
>                 if (info->nand.options & NAND_BUSWIDTH_16)
>                         omap_read_buf16(mtd, buf, len % 4);
>                 else
>                         omap_read_buf8(mtd, buf, len % 4);
> -               p = (u32 *) (buf + len % 4);
> -               len -= len % 4;
> +               return;
>         }
> 
>         /* configure and start prefetch transfer */
> 
> Comments?

Seems OK to me, but please cc the MTD list as this is more in the
MTD driver area.

Regards,

Tony
