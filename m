From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: fix section mismatch regression in
 probe
Date: Mon, 25 Jun 2012 12:47:17 +0300
Message-ID: <20120625094716.GD6468@arwen.pp.htv.fi>
References: <1340099868-24290-1-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:46462 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753595Ab2FYJtj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 05:49:39 -0400
Received: by lbon10 with SMTP id n10so10787478lbo.27
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 02:49:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340099868-24290-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, balbi@ti.com


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2012 at 03:27:48PM +0530, Venkatraman S wrote:
> Commit 7d6b6d83(make it behave as a module) annotated probe with
> __devinit, but a referenced function was not.
>=20
> This introduced a section mismatch warning:
> WARNING: vmlinux.o(.devinit.text+0x3eec): Section mismatch in reference
> from the function omap2_mcspi_probe() to the function
> .init.text:omap2_mcspi_master_setup()
>=20
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

my apologies

> ---
>  drivers/spi/spi-omap2-mcspi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 46ef5fe..1618e89 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1031,7 +1031,7 @@ static int omap2_mcspi_transfer_one_message(struct =
spi_master *master,
>  	return 0;
>  }
> =20
> -static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
> +static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
>  {
>  	struct spi_master	*master =3D mcspi->master;
>  	struct omap2_mcspi_regs	*ctx =3D &mcspi->ctx;
> --=20
> 1.7.0.4
>=20

--=20
balbi

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6DOkAAoJEIaOsuA1yqREmCwP/2jurFI5oL8qF9y4qlszG1fz
mehL6UaH9WKC4cvJpA8y72JuZEWMjRuvfYI/ns6aU0uTWHAMwZorP6QDx+wOGBLa
vI37lnmiWZJ/YQ2hjHqRgh5cjgFFFYkJtVvRVvWLGKGSmGJqNzdFp/RJVIFcQ1Fe
le+c9qAlGyqPjG7oX/Ej5leBi7lEM10TYBxlt0FLQtwrDtG9cgkS2UrLuczUUPXF
MgTK/W/Xz072IE+zM9/bLzLXKfWEhwXRF2A7bKWqnj2jp6hoNbBTL6GFcQdEZBwA
HQZtl37rfK0ZraQtrlMI2OOjxgoaGJEnIQlu2N0ODgu72DAnqWXxfqLuxiVf3lQx
midfwClxiZmrQHdWq7ZzRPbHGajsmSBgBy3SWcAE4SraQ1fYt9nswHtb+xJNOhxv
yxgP0XUs/2hF1IIkOfpWoTk0QUa4fnSZAb8JoMAyJ55x5vFPjA6wjM7yHwVML29a
l+5Ecl0oaJhewWoFma8UWNuzC7VJow3b66c4OY5NTBHuJPcHk9fNMpzzoN4zN0dK
KFjRy0XS2dtqzDZ5+SXJe4F8qTAefrnbM0APkRIgSJ8ATu+v9gPxBLRYWkSc6osI
Ue0dTgYbD+FhFC6sGC1xyi5kHHVd5hBwoWUo896M47QdaI9Y1pZH3LpTHkDFpE4l
qG/U75Bmpk7BzcIXPIuM
=Pguu
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
