From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] omap : nand : fix subpage ecc issue with prefetch
Date: Thu, 5 May 2011 19:50:40 +0530
Message-ID: <BANLkTimfXSOTKPpxFG8+JpCxvpzd14aBOQ@mail.gmail.com>
References: <1304334638-2198-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38148 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab1EEOkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 10:40:42 -0400
Received: by wya21 with SMTP id 21so1667077wya.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 07:40:41 -0700 (PDT)
In-Reply-To: <1304334638-2198-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, bdefaria@adeneo-embedded.com

Hi Artem,

Can you please give a look on this patch?
This patch fixes is required for anyone who wants to use this driver
without using HW ECC.

-- Vimal

On Mon, May 2, 2011 at 4:40 PM, Kishore Kadiyala
<kishore.kadiyala@ti.com> wrote:
> For prefetch engine, read and write =A0got broken in commit '2c01946c=
'.
> We never hit a scenario of not getting 'gpmc_prefetch_enable'
> call success.
> When reading/writing a subpage with a non divisible by 4 ecc number
> of bytes, the mis-aligned bytes gets handled first before enabling
> the Prefetch engine, then it reads/writes rest of the bytes.
>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 12 +++++-------
> =A01 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index da9a351..2c8040f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -263,11 +263,10 @@ static void omap_read_buf_pref(struct mtd_info =
*mtd, u_char *buf, int len)
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PFPW engine is busy, use cpu copy m=
ethod */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->nand.options & NAND_BUSWIDTH=
_16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, bu=
f, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, (u=
_char *)p, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf=
, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, (u_=
char *)p, len);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) buf;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r_count =3D gpmc_read_=
status(GPMC_PREFETCH_FIFO_CNT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r_count =3D r_count >>=
 2;
> @@ -293,7 +292,7 @@ static void omap_write_buf_pref(struct mtd_info *=
mtd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0struct omap_nand_info, mtd);
> =A0 =A0 =A0 =A0uint32_t w_count =3D 0;
> =A0 =A0 =A0 =A0int i =3D 0, ret =3D 0;
> - =A0 =A0 =A0 u16 *p;
> + =A0 =A0 =A0 u16 *p =3D (u16 *)buf;
> =A0 =A0 =A0 =A0unsigned long tim, limit;
>
> =A0 =A0 =A0 =A0/* take care of subpage writes */
> @@ -309,11 +308,10 @@ static void omap_write_buf_pref(struct mtd_info=
 *mtd,
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PFPW engine is busy, use cpu copy m=
ethod */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->nand.options & NAND_BUSWIDTH=
_16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf16(mtd, b=
uf, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf16(mtd, (=
u_char *)p, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf8(mtd, bu=
f, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf8(mtd, (u=
_char *)p, len);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u16 *) buf;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w_count =3D gpmc_read_=
status(GPMC_PREFETCH_FIFO_CNT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w_count =3D w_count >>=
 1;
> --
> 1.7.4.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
