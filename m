From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 6 Nov 2013 19:38:02 -0300
Message-ID: <20131106223801.GA20184@localhost>
References: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131030191414.GA16668@norris.computersforpeace.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA2D41D@DBDE04.ent.ti.com>
 <20131030231956.GA2489@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA31B19@DBDE04.ent.ti.com>
 <20131106211833.GB12624@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA31BB3@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48344 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729Ab3KFWh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 17:37:58 -0500
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA31BB3@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>

On Wed, Nov 06, 2013 at 10:00:09PM +0000, Gupta, Pekon wrote:
> > From: Ezequiel Garcia
> [...]
>=20
> > But: on the other hand, I'd really like you to convince me as to
> > why is it so bad to require the DTB to have the proper GPMC bus wid=
th.
> >=20
> No its not at all bad, all I want is either of the one way (not mixtu=
re of both).
> - Either depend on DT completely (which is current case for all drive=
rs)
> - OR depend on ONFI and nand_flash_id[] for bus-width detection.
>=20
>=20
> > Once again:
> > 1. the NAND devices aren't hot-pluggable
> > 2. the "user" (who is actually an engineer, not some regular dummy =
user)
> > knows perfectly well the width of the device.
> >=20
> > What's the problem with describing the hardware in the DT and savin=
g us
> > lots of runtime re-configuration trouble?
>=20
> I agree with both your arguments above.
> So shouldn't we kill NAND_BUSWIDTH_AUTO ?
> And probably therefore  NAND_BUSWIDTH_AUTO isn't that popular.
>=20
> Now what remains is ONFI probe, which should always happen in x8 mode=
=2E
> So for that below patch should be sufficient ..
>=20

Hm.. that might work. Maybe you should submit this as RFC/PATCH to catc=
h
the attention of some more people. And we can keep discussing on this
new idea...

I should get an 8-bit module for the BBB, so this means I'll be able
to run 8-bit and 16-bit tests.

> ----------------------
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_bas=
e.c
> index ec1db1e..d1220fb 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -2942,14 +2942,8 @@ static int nand_flash_detect_onfi(struct mtd_i=
nfo *mtd, struct nand_chip *chip,
>                 chip->read_byte(mtd) !=3D 'F' || chip->read_byte(mtd)=
 !=3D 'I')
>                 return 0;
>=20
> -       /*
> -        * ONFI must be probed in 8-bit mode or with NAND_BUSWIDTH_AU=
TO, not
> -        * with NAND_BUSWIDTH_16
> -        */
> -       if (chip->options & NAND_BUSWIDTH_16) {
> -               pr_err("ONFI cannot be probed in 16-bit mode; abortin=
g\n");
> -               return 0;
> -       }
> +       /* ONFI must be probed in 8-bit mode only */
> +       nand_set_defaults(chip, 0);
>=20
>         chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
>         for (i =3D 0; i < 3; i++) {
> @@ -2962,7 +2956,7 @@ static int nand_flash_detect_onfi(struct mtd_in=
fo *mtd, struct nand_chip *chip,
>=20
>         if (i =3D=3D 3) {
>                 pr_err("Could not find valid ONFI parameter page; abo=
rting\n");
> -               return 0;
> +               goto return_error;
>         }
>=20
>         /* Check version */
> @@ -2980,7 +2974,7 @@ static int nand_flash_detect_onfi(struct mtd_in=
fo *mtd, struct nand_chip *chip,
>=20
>         if (!chip->onfi_version) {
>                 pr_info("%s: unsupported ONFI version: %d\n", __func_=
_, val);
> -               return 0;
> +               goto return_error;
>         }
>=20
>         sanitize_string(p->manufacturer, sizeof(p->manufacturer));
> @@ -3033,6 +3027,12 @@ static int nand_flash_detect_onfi(struct mtd_i=
nfo *mtd, struct nand_chip *chip,
>         }
>=20
>         return 1;
> +
> +return_error:
> +       /* revert original bus-width */
> +       nand_set_defaults( chip->options & NAND_BUSWIDTH_16);
> +       return 0;
> +
>  }
>=20
>  /*
> -------------------------=20
>=20
>=20
> with regards, pekon

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
