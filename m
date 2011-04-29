From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/3] omap : nand : fix omap2 module reinsertion
Date: Fri, 29 Apr 2011 21:24:47 +0530
Message-ID: <BANLkTikETiqOUYcyBDy8_JSpQq7Uh4OgEw@mail.gmail.com>
References: <1304073070-24526-1-git-send-email-bdefaria@adeneo-embedded.com> <1304073070-24526-3-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42968 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756876Ab1D2PzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 11:55:08 -0400
Received: by wya21 with SMTP id 21so2941736wya.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 08:55:07 -0700 (PDT)
In-Reply-To: <1304073070-24526-3-git-send-email-bdefaria@adeneo-embedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Cc: linux-omap@vger.kernel.org, jjhiblot@adetelgroup.com, linux-mtd@lists.infradead.org

On Fri, Apr 29, 2011 at 4:01 PM, Bryan DE FARIA
<bdefaria@adeneo-embedded.com> wrote:
> When the module is removed, a reinsertion will fail with a -16 error.
>
> Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index da9a351..eab51da 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1138,6 +1138,7 @@ static int omap_nand_remove(struct platform_dev=
ice *pdev)
>
> =A0 =A0 =A0 =A0/* Release NAND device, its internal structures and pa=
rtitions */
> =A0 =A0 =A0 =A0nand_release(&info->mtd);
> + =A0 =A0 =A0 release_mem_region(info->phys_base, NAND_IO_SIZE);

I think using 'release_resource' would be better here. And you should
better do this after below 'iounmap' is done.

> =A0 =A0 =A0 =A0iounmap(info->nand.IO_ADDR_R);
> =A0 =A0 =A0 =A0kfree(&info->mtd);
> =A0 =A0 =A0 =A0return 0;
> --

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
