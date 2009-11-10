From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 1/3] Fixing compilation warning for 'nand/omap2.c'
Date: Tue, 10 Nov 2009 16:20:27 +0200
Message-ID: <1257862827.21596.760.camel@localhost>
References: <ce9ab5790910292321nf230810v353c23f9c1ce1931@mail.gmail.com>
	 <ce9ab5790910300142s615c7d59h15bb2d46d4f76574@mail.gmail.com>
	 <1257236323.21596.56.camel@localhost>
	 <ce9ab5790911030038p31bb69cfs1ba86cd70b243e4c@mail.gmail.com>
	 <1257237728.21596.65.camel@localhost>
	 <ce9ab5790911030101t256e49e8iaf26c733e6472157@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46166 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbZKJOUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 09:20:47 -0500
In-Reply-To: <ce9ab5790911030101t256e49e8iaf26c733e6472157@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Tue, 2009-11-03 at 14:31 +0530, Vimal Singh wrote:
> >> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> >> index 090ab87..92573d5 100644
> >> --- a/drivers/mtd/nand/omap2.c
> >> +++ b/drivers/mtd/nand/omap2.c
> >> @@ -501,11 +501,13 @@ static void omap_read_buf_dma_pref(struct
> >> mtd_info *mtd, u_char
> >
> > :-) It is the same again.
> >
> > Try to send the e-mail to yourself, then save it and apply with git=
-am.
> > If it works, send to the mailing list.
>=20
> Below patch applies. Sorry for noise... :(
>=20
> Thanks,
> vimal
>=20
>=20
> From eebbd81141b196af2dc3f7a2650ce16b6b0d76ae Mon Sep 17 00:00:00 200=
1
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Fri, 30 Oct 2009 11:31:34 +0530
> Subject: [PATCH] Fixing compilation warning for 'nand/omap2.c'
>=20
> Fixing below warning in compilation:
> drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
> drivers/mtd/nand/omap2.c:508: warning: passing argument 2 of
> 'omap_nand_dma_transfer' discards qualifiers from pointer target type
>=20
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  drivers/mtd/nand/omap2.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 090ab87..92573d5 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -501,11 +501,13 @@ static void omap_read_buf_dma_pref(struct
>  static void omap_write_buf_dma_pref(struct mtd_info *mtd,
>  					const u_char *buf, int len)
>  {
> +	u_char *p =3D (u_char *)buf;
> +
>  	if (len <=3D mtd->oobsize)
> -		omap_write_buf_pref(mtd, buf, len);
> +		omap_write_buf_pref(mtd, p, len);
>  	else
>  		/* start transfer in DMA mode */
> -		omap_nand_dma_transfer(mtd, buf, len, 0x1);
> +		omap_nand_dma_transfer(mtd, p, len, 0x1);
>  }

I think that you should instead remove the 'const' modifier from the
'omap_write_buf_dma_pref()' function. Indeed, if it has the 'const'
modifier, it should never change the bugger.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
