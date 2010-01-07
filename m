From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/3][NAND][OMAP]: Fixing issue in oamp nand driver in
	prefetch mode read
Date: Thu, 7 Jan 2010 12:16:26 +0530
Message-ID: <ce9ab5791001062246n23420337g3fb8d3eb365083b0@mail.gmail.com>
References: <ce9ab5791001060606w46483e93o753913c01752a4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57036 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0AGGqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 01:46:48 -0500
Received: by bwz27 with SMTP id 27so11205603bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 22:46:46 -0800 (PST)
In-Reply-To: <ce9ab5791001060606w46483e93o753913c01752a4b6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>
Cc: linux-omap@vger.kernel.org

On Wed, Jan 6, 2010 at 7:36 PM, Vimal Singh <vimal.newwork@gmail.com> w=
rote:
> From 3700088e8da8c890d9e4c6eb626e18287d149b97 Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 5 Jan 2010 16:37:03 +0530
> Subject: [PATCH] NAND: OMAP: Fixing issue in oamp nand driver in
> prefetch mode read
>
> There is a bug in nand prefetch read routine, which comes into effect
> only if nand device is a 16-bit device (as we have in zoom boards).
> This bug is effective only with below combination of conditions:
> 1. nand deivce, in use, is a 16 bit device
> 2. nand driver supports 'subpage' read
> 3. SW ECC is in use
>
> This was not seen old =A0kernel (ex: .23), because when, in early day=
s,
> we tested this (nand prefetch read in LDP boards) there was no
> 'subpage read' support.
> Later when we had subpage read in (.27) kernel, we had hw ecc enabled
> always in our internal tree. So, we missed this bug.
>
> This patch fixes the issue.
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 11 +++++++----
> =A01 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 16120e2..7df303a 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct mtd_info
> *mtd, u_char *buf, int len)
> =A0 =A0 =A0 =A0u32 *p =3D (u32 *)buf;
>
> =A0 =A0 =A0 =A0/* take care of subpage reads */
> - =A0 =A0 =A0 for (; len % 4 !=3D 0; ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D __raw_readb(info->nand.IO_AD=
DR_R);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 len--;
> + =A0 =A0 =A0 if (len % 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (info->nand.options & NAND_BUSWIDTH_=
16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, bu=
f, len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf=
, len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) (buf + len % 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D len % 4;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 p =3D (u32 *) buf;
>
> =A0 =A0 =A0 =A0/* configure and start prefetch transfer */
> =A0 =A0 =A0 =A0ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, =
0x0);
> --
> 1.5.5
>

Above patch was line wrapped. Here is the correct one:


=46rom 3700088e8da8c890d9e4c6eb626e18287d149b97 Mon Sep 17 00:00:00 200=
1
=46rom: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 5 Jan 2010 16:37:03 +0530
Subject: [PATCH] NAND: OMAP: Fixing issue in oamp nand driver in
prefetch mode read

There is a bug in nand prefetch read routine, which comes into effect
only if nand device is a 16-bit device (as we have in zoom boards).
This bug is effective only with below combination of conditions:
1. nand deivce, in use, is a 16 bit device
2. nand driver supports 'subpage' read
3. SW ECC is in use

This was not seen old  kernel (ex: .23), because when, in early days,
we tested this (nand prefetch read in LDP boards) there was no
'subpage read' support.
Later when we had subpage read in (.27) kernel, we had hw ecc enabled
always in our internal tree. So, we missed this bug.

This patch fixes the issue.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 16120e2..7df303a 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
 	u32 *p =3D (u32 *)buf;

 	/* take care of subpage reads */
-	for (; len % 4 !=3D 0; ) {
-		*buf++ =3D __raw_readb(info->nand.IO_ADDR_R);
-		len--;
+	if (len % 4) {
+		if (info->nand.options & NAND_BUSWIDTH_16)
+			omap_read_buf16(mtd, buf, len % 4);
+		else
+			omap_read_buf8(mtd, buf, len % 4);
+		p =3D (u32 *) (buf + len % 4);
+		len -=3D len % 4;
 	}
-	p =3D (u32 *) buf;

 	/* configure and start prefetch transfer */
 	ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
--=20
1.5.5
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
