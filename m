From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC] mtd: nand: Fix bad block identification issue
Date: Wed, 27 Apr 2011 18:45:47 +0300
Message-ID: <BANLkTi=sq5am1HKeOfYTmYHUm96O08N-jw@mail.gmail.com>
References: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58708 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab1D0Pps convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 11:45:48 -0400
Received: by vws1 with SMTP id 1so1408321vws.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Apr 2011 08:45:47 -0700 (PDT)
In-Reply-To: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>, "Saxena, Parth" <parth.saxena@ti.com>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Brian,

did you really intend to remove badblockbits? Maybe it should go back
to nand_base.c?

On Wed, Apr 27, 2011 at 3:09 PM, Saxena, Parth <parth.saxena@ti.com> wr=
ote:
> Commit e0b58d0 ("mtd: nand: add ->badblockbits for minimum number
> of set bits in bad block byte") by Maxim Levitsky added
> badblockbits to nand_chip to specify minimum number of set bits
> in bad block byte. The patch initialized badblockbits to 8 in
> nand_base.c, but later the initialization line got removed by commit
> c7b28e2("mtd: nand: refactor BB marker detection"). After this all
> NAND drivers with NAND_SKIP_BBTSCAN are forced to initialize it to 8.
> Otherwise bad block identification will fail.
>
> As a result, mounting of empty jffs2 file system on omap3evm
> (having bad blocks) failed giving the following error message -
>
> "mount: mounting /dev/mtdblock4 on /tmp failed: Input/output error"
>
> This patch solves the above issue for omap by initialising
> badblockbits. We are working further on this to find a generic fix
> to the problem in nand_base.c.
>
> Signed-off-by: Saxena, Parth <parth.saxena@ti.com>
> Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 454f90c..350c77f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1005,6 +1005,8 @@ static int __devinit omap_nand_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0info->nand.options =A0 =A0 =A0=3D pdata->devsize;
> =A0 =A0 =A0 =A0info->nand.options =A0 =A0 =A0|=3D NAND_SKIP_BBTSCAN;
>
> + =A0 =A0 =A0 info->nand.badblockbits =3D 8;
> +
> =A0 =A0 =A0 =A0/* NAND write protect off */
> =A0 =A0 =A0 =A0gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_WP, 0);
>
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
