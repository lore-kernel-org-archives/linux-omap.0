From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 5/5] Regulator: Renaming the supplies used in MMC driver
Date: Thu, 5 Nov 2009 23:17:17 +0200
Message-ID: <f870da180911051317r7693dce2l8e6a345d2055198@mail.gmail.com>
References: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:41478 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbZKEVRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 16:17:12 -0500
Received: by iwn10 with SMTP id 10so359444iwn.4
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2009 13:17:17 -0800 (PST)
In-Reply-To: <1257439189-29594-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> wr=
ote:
> Supply names are renamed from vmmc -> mmc and vmmc_aux -> mmc_aux.
> This is done to have simple supply names both in the driver
> and in the board-evm file.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0arch/arm/mach-omap2/mmc-twl4030.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/=
mmc-twl4030.c
> index 3403914..af3b1be 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -109,9 +109,9 @@ static int twl_mmc_late_init(struct device *dev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].mmc =3D mmc;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get(d=
ev, "vmmc");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get(d=
ev, "mmc");

It will break all existing OMAP3 boards.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(dev, "vmmc regulator missing\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(dev, "mmc regulator missing\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HAC=
K: until fixed.c regulator is usable,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we =
don't require a main regulator
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * for=
 MMC2 or MMC3
> @@ -126,7 +126,7 @@ static int twl_mmc_late_init(struct device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->slots[0].ocr_mask=
 =3D mmc_regulator_get_ocrmask(reg);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* allow an aux regula=
tor */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get(d=
ev, "vmmc_aux");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D regulator_get(d=
ev, "mmc_aux");

ditto.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hsmmc[i].vcc_aux =3D I=
S_ERR(reg) ? NULL : reg;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* UGLY HACK: =A0worka=
round regulator framework bugs.
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
