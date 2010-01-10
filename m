From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] omap2/3: mtd: fix compile warning
Date: Sun, 10 Jan 2010 10:48:21 +0200
Message-ID: <1263113301.7315.130.camel@localhost.localdomain>
References: <1262082892-5260-1-git-send-email-premi@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:51395 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab0AJIs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jan 2010 03:48:28 -0500
Received: by fxm25 with SMTP id 25so13718675fxm.21
        for <linux-omap@vger.kernel.org>; Sun, 10 Jan 2010 00:48:27 -0800 (PST)
In-Reply-To: <1262082892-5260-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 2009-12-29 at 16:04 +0530, Sanjeev Premi wrote:
> This patch fixes following compile warning:
>=20
> drivers/mtd/nand/omap2.c:508: warning: passing argumen
> t 2 of 'omap_nand_dma_transfer' discards qualifiers fr
> om pointer target type
>=20
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 1bb799f..08c193c 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -505,7 +505,7 @@ static void omap_write_buf_dma_pref(struct mtd_in=
fo *mtd,
>  		omap_write_buf_pref(mtd, buf, len);
>  	else
>  		/* start transfer in DMA mode */
> -		omap_nand_dma_transfer(mtd, buf, len, 0x1);
> +		omap_nand_dma_transfer(mtd, (void *)buf, len, 0x1);
>  }

Pushed this patch to my l2-mtd-2.6/dunno tree.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
