From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 1/2] mtd: Add nand_base feature to align subpage read
 buffers
Date: Tue, 18 Jan 2011 10:13:43 +0200
Message-ID: <1295338423.2470.54.camel@koala>
References: <1294277942-1252-1-git-send-email-cdhmanning@gmail.com>
	 <1294277942-1252-2-git-send-email-cdhmanning@gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64522 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab1ARINx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 03:13:53 -0500
Received: by fxm20 with SMTP id 20so6913498fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 00:13:52 -0800 (PST)
In-Reply-To: <1294277942-1252-2-git-send-email-cdhmanning@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <cdhmanning@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

would it please be possible improve comments and the commit message and
make them explain better which problem the patch solves, what is the
problem with the current code, how exactly you solve the problem, and
why your solution is the best among other alternative solutions?

I think the below commit messages is too short and does not explain
this.

On Thu, 2011-01-06 at 14:39 +1300, Charles Manning wrote:
> Some nand controllers (eg. omap2) need to have their buffers u32 alig=
ned
> to use high speed transfer mechanisms.
>=20
> This commit provides a way to plug in an alignment function and provi=
des a
> 32-bit algnment function.
>=20
> Signed-off-by: Charles Manning <cdhmanning@gmail.com>
> ---
>  drivers/mtd/nand/nand_base.c |   22 +++++++++++++++++++++-
>  include/linux/mtd/nand.h     |    5 +++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_bas=
e.c
> index 1f75a1b..e8c2432 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -1156,6 +1156,22 @@ static int nand_read_page_swecc(struct mtd_inf=
o *mtd, struct nand_chip *chip,
>  }
> =20
>  /**
> + * nand_align_subpage32 - function to align subpage read to 32-bits
> + * @mtd:	mtd info structure
> + * @buf:	pointer to pointer of buffer that needs to be aligned
> + * @len:	pointer to length that needs to be aligned.
> + */
> +
Why blank line here?
> +void nand_align_subpage32(uint8_t **buf, int *len)
> +{
> +	int diff =3D (int)(*buf) & 3;
> +	*buf =3D  *buf - diff;
It is really not obvious that this buffer does not come from user-space=
,
but it is some internal chip->buffers->databuf, so you actually can ste=
p
back. Cold you please put some comment about this?
> +	*len =3D *len + diff;
> +	*len =3D (*len + 3) & ~3;
> +}
> +EXPORT_SYMBOL(nand_align_subpage32);

In general, do you think it is a good thing that MTD NAND core always
reads to internal buffer first, then copies the data to the user buffer=
?
To me it looks like bad idea because we end up with unwanted overhead.
There is a benefit - if you read the same NAND page twice, you get the
data from the buffer the second time. But this does not work with
sub-pages, and I think this MTD core is wrong place for this. If someon=
e
wants caching, he could use the Linux page cache as a layer on top of
MTD core, instead of this castrated one NAND page cache.

Anyway, what I want to say is that the current architecture is bad, IMO=
=2E
Namely, this "always read to own buffer" thing is bad. But your patch
relays on this, so if some one some day wants to improve MTD NAND core
in this respect, he'll end up with more job.

Is it possible to invent some solution which does not rely on the fact
that you deal with an internal buffer, but instead, assumes that you ma=
y
be dealing with a user buffer?

> +
> +/**
>   * nand_read_subpage - [REPLACABLE] software ecc based sub-page read=
 function
>   * @mtd:	mtd info structure
>   * @chip:	nand chip info structure
> @@ -1169,6 +1185,7 @@ static int nand_read_subpage(struct mtd_info *m=
td, struct nand_chip *chip,
>  	int start_step, end_step, num_steps;
>  	uint32_t *eccpos =3D chip->ecc.layout->eccpos;
>  	uint8_t *p;
> +	uint8_t *b;

The current style prefers
uint8_t *p, *b;
for some reasons.
>  	int data_col_addr, i, gaps =3D 0;
>  	int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
>  	int busw =3D (chip->options & NAND_BUSWIDTH_16) ? 2 : 1;
> @@ -1222,7 +1239,10 @@ static int nand_read_subpage(struct mtd_info *=
mtd, struct nand_chip *chip,
> =20
>  		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
>  					mtd->writesize + aligned_pos, -1);
> -		chip->read_buf(mtd, &chip->oob_poi[aligned_pos], aligned_len);
> +		b =3D  &chip->oob_poi[aligned_pos];
> +		if(chip->align_subpage)
> +			chip->align_subpage(&b, &aligned_len);
> +		chip->read_buf(mtd, b, aligned_len);
>  	}
> =20
>  	for (i =3D 0; i < eccfrag_len; i++)
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 63e17d0..6ea6177 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -474,6 +474,7 @@ struct nand_buffers {
>   *			additional error status checks (determine if errors are
>   *			correctable).
>   * @write_page:		[REPLACEABLE] High-level page write function
> + * @align_subpage:	[OPTIONAL] Aligns subpage read buffer.
>   */

Would it please be possible to add more comments to the code about this
align_subpage stuff, for people who try to read it in the future?

--=20
Best Regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
