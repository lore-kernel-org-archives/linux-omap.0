From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Sun, 10 Jan 2010 10:46:35 +0200
Message-ID: <1263113195.7315.129.camel@localhost.localdomain>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	 <20091223174429.GD3512@atomide.com>
	 <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	 <5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
	 <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48248 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab0AJIqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jan 2010 03:46:39 -0500
Received: by fxm25 with SMTP id 25so13718221fxm.21
        for <linux-omap@vger.kernel.org>; Sun, 10 Jan 2010 00:46:38 -0800 (PST)
In-Reply-To: <ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Thu, 2009-12-31 at 17:50 +0530, Vimal Singh wrote:
> There is a bug in nand prefetch read routine, which comes into effect
> only if nand device is a 16-bit device (as we have in zoom boards).
> This bug is effective only with below combination of conditions:
> 1. nand deivce, in use, is a 16 bit device
> 2. nand driver supports 'subpage' read
> 3. SW ECC is in use
>=20
> This was not seen old  kernel (ex: .23), because when, in early days,
> we tested this (nand prefetch read in LDP boards) there was no
> 'subpage read' support.
> Later when we had subpage read in (.27) kernel, we had hw ecc enabled
> always in our internal tree. So, we missed this bug.
>=20
> Here is a patch to fix this issue:
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..75004fe 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
>  	u32 *p =3D (u32 *)buf;
>=20
>  	/* take care of subpage reads */
> -	for (; len % 4 !=3D 0; ) {
> -		*buf++ =3D __raw_readb(info->nand.IO_ADDR_R);
> -		len--;
> +	if (len % 4) {
> +		if (info->nand.options & NAND_BUSWIDTH_16)
> +			omap_read_buf16(mtd, buf, len % 4);
> +		else
> +			omap_read_buf8(mtd, buf, len % 4);
> +		p =3D (u32 *) (buf + len % 4);
> +		len -=3D len % 4;
>  	}
> -	p =3D (u32 *) buf;
>=20
>  	/* configure and start prefetch transfer */
>  	ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);

Pushed this patch to my l2-mtd-2.6.git/dunno.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
