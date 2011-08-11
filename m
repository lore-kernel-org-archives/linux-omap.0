From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/3] twl4030-madc: copy the device pointer
Date: Thu, 11 Aug 2011 12:50:08 +0300
Message-ID: <CANOLnOMrQ7R6X+7WPjjrSZZ_3YJ2M=aaGsz_450XE2qVV2MNzA@mail.gmail.com>
References: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
	<1313033272-16774-2-git-send-email-kyle@kylemanna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:50569 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab1HKJuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 05:50:09 -0400
Received: by iye16 with SMTP id 16so977432iye.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 02:50:08 -0700 (PDT)
In-Reply-To: <1313033272-16774-2-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle Manna <kyle@kylemanna.com>
Cc: linux-omap@vger.kernel.org

You need to send this one to mfd maintainer, separate from this series
perhaps (see MAINTAINERS or just use ./scripts/get_maintainer.pl).

On Thu, Aug 11, 2011 at 6:27 AM, Kyle Manna <kyle@kylemanna.com> wrote:
> Worst case this fixes the following error:
> [ =C2=A0 72.086212] (NULL device *): conversion timeout!
>
> Best case it prevents a crash
>
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> ---
> =C2=A0drivers/mfd/twl4030-madc.c | =C2=A0 =C2=A05 ++++-
> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> index b5d598c..8ef7801 100644
> --- a/drivers/mfd/twl4030-madc.c
> +++ b/drivers/mfd/twl4030-madc.c
> @@ -706,6 +706,9 @@ static int __devinit twl4030_madc_probe(struct pl=
atform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!madc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM=
;
>
> + =C2=A0 =C2=A0 =C2=A0 /* Copy the pointer to device struct */
> + =C2=A0 =C2=A0 =C2=A0 madc->dev =3D &pdev->dev;
> +

This comment is not useful, it's already clear you are copying a pointe=
r.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Phoenix provides 2 interrupt lines. The=
 first one is connected to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the OMAP. The other one can be connecte=
d to the other processor such
> @@ -733,7 +736,7 @@ static int __devinit twl4030_madc_probe(struct pl=
atform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D twl_i2c_write_u8(TWL4030_MODULE_MA=
IN_CHARGE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval, TWL4030_BCI_BCICTL1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "unable to write reg BCI Ctl1 0x%X\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "unable to write reg BCI CTL1 0x%X\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0TWL4030_BCI_BCICTL1);

Stray change (no mention in commit message), should not be part of this=
 patch.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_i2c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
