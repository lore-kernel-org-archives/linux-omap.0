From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
Date: Wed, 29 Feb 2012 12:21:42 +0200
Message-ID: <1330510902.1934.76.camel@deskari>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1330505302-8258-2-git-send-email-tomi.valkeinen@ti.com>
	 <4F4DF801.3000905@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uP8Bth6b0E0tUihwuagM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57771 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757107Ab2B2KVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 05:21:46 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id f4so10823086lam.14
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 02:21:45 -0800 (PST)
In-Reply-To: <4F4DF801.3000905@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-uP8Bth6b0E0tUihwuagM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-29 at 10:03 +0000, Florian Tobias Schandinat wrote:
> On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> > panel-dvi uses i2c, but the Kconfig didn't have dependency on I2C. Add
> > it.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/omap2/displays/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2=
/displays/Kconfig
> > index 74d29b5..408a992 100644
> > --- a/drivers/video/omap2/displays/Kconfig
> > +++ b/drivers/video/omap2/displays/Kconfig
> > @@ -12,7 +12,7 @@ config PANEL_GENERIC_DPI
> > =20
> >  config PANEL_DVI
> >  	tristate "DVI output"
> > -	depends on OMAP2_DSS_DPI
> > +	depends on OMAP2_DSS_DPI && I2C
>=20
> It's just a matter of taste, but are you sure you want to "depend" on it =
and not
> "select" it? Other drivers tend to use select for I2C, for me it doesn't =
really
> matter.

Well, I'd like to "select", but I don't think that's correct. From
Documentation/kbuild/kconfig-language.txt:

        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.

But I do see quite many selects for I2C, so I'm not sure if all those
are wrong, or has it just been decided that I2C is a valid target for
select.

Using depend is in line with the other panel drivers in the same
directory. I've been thinking about the same thing from time to time,
and I'd rather select I2C, SPI and BACKLIGHT_CLASS_DEVICE than use
depend.

But, for example, using select to BACKLIGHT_CLASS_DEVICE is broken: if I
change a panel driver to select BACKLIGHT_CLASS_DEVICE, but then I
manually disable CONFIG_BACKLIGHT_LCD_SUPPORT (which the
BACKLIGHT_CLASS_DEVICE depends on) from the kernel config, this leads to
BACKLIGHT_CLASS_DEVICE being enabled, but CONFIG_BACKLIGHT_LCD_SUPPORT
being disabled, which is clearly broken.

So... As I see it, depending is a bit awkward, but it's correct.

 Tomi


--=-uP8Bth6b0E0tUihwuagM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTfw2AAoJEPo9qoy8lh71utsP+gOeXvMRTWqJrms4K3lJTvkS
5+6v1qDrqEFbf+W+f/iqnpZ95uQ9x3KaslkMvmK+LD6jd+6WzgzJj38wrAfNqEXU
zpq1T71Q+1DmmcnkjHUiF1nqzv1j7IuOJ2x6bXWIocc5y3O8DebVa7fjfuG0uH/t
qY13+TL00IHga1GtHuHnCoeUyEqmDH0COB0cTrAyREitpVdzNJxG3nfwR1osxNyJ
EEVE7E8ndqsYUB2oc7q3TFceZ0z8mXrOuqL6hROxsopPsmL4GIn+W1qQD0UXma51
WFJT9z7Wr9wrf4CCPGSAPI/J94xmkbQpY13LvOGMoE+x7t4l369NR8wLPgYSG97p
1ikiBdXX6N7INyVXh08QqB4pvPnSJEMmTJaTnPwXlbi/JQ1ci5UQrRM2S1LvGwnb
Cec+3csJ4MWipNFANqjiEYiZa1EMhzEufJ0Rl4DLF1r22WrEwhRoZnq1nRm1xKiI
N0UtrpMMKEMFpUJgM+n39c801LqYVRevLPoWkjbhTrgG0AuB9tMB9SmlH1+XXf4I
LbXnxt0alGCRkzccdRKpR1h7CegaU0G/1HmpyFORqDoKUqDcfXI/ZY0lycyQK4CE
nvfbWwjVZMkdQrG0ZEAJpL0hqHIGc16SkE2lIO71ft402F4v13njJUqJ+HjC/4GC
VUzI32HlVzQOXe+Ojjbz
=4Nb/
-----END PGP SIGNATURE-----

--=-uP8Bth6b0E0tUihwuagM--

