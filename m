From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] omap_ssi_core: fix kilo to be "k" not "K"
Date: Sun, 1 Oct 2017 17:12:58 +0200
Message-ID: <20171001151258.du7jdx3kqkswrp6r@earth>
References: <20170923190838.GA16966@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcntcbpkjwnkobni"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170923190838.GA16966@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Andrew Morton <akpm@osdl.org>
List-Id: linux-omap@vger.kernel.org


--mcntcbpkjwnkobni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 23, 2017 at 09:08:38PM +0200, Pavel Machek wrote:
>=20
> Kilo should be "k" not "K", fix it it comments and messages.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, queued.

-- Sebastian

> index 88e48b3..41a09f5 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -334,7 +334,7 @@ static int ssi_clk_event(struct notifier_block *nb, u=
nsigned long event,
>  	case POST_RATE_CHANGE:
>  		dev_dbg(&ssi->device, "post rate change (%lu -> %lu)\n",
>  			clk_data->old_rate, clk_data->new_rate);
> -		omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /*=
 KHz */
> +		omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /*=
 kHz */
> =20
>  		for (i =3D 0; i < ssi->num_ports; i++) {
>  			omap_port =3D omap_ssi->port[i];
> @@ -467,9 +467,9 @@ static int ssi_hw_init(struct hsi_controller *ssi)
>  	}
>  	/* Resetting GDD */
>  	writel_relaxed(SSI_SWRESET, omap_ssi->gdd + SSI_GDD_GRST_REG);
> -	/* Get FCK rate in KHz */
> +	/* Get FCK rate in kHz */
>  	omap_ssi->fck_rate =3D DIV_ROUND_CLOSEST(ssi_get_clk_rate(ssi), 1000);
> -	dev_dbg(&ssi->device, "SSI fck rate %lu KHz\n", omap_ssi->fck_rate);
> +	dev_dbg(&ssi->device, "SSI fck rate %lu kHz\n", omap_ssi->fck_rate);
> =20
>  	writel_relaxed(SSI_CLK_AUTOGATING_ON, omap_ssi->sys + SSI_GDD_GCR_REG);
>  	omap_ssi->gdd_gcr =3D SSI_CLK_AUTOGATING_ON;
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--mcntcbpkjwnkobni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnRBfoACgkQ2O7X88g7
+povpg//V9jGNZpf6ioy9Prj/hVCsIvev9cTz71gk9CsY6ooX0L1HIHJ3abXGi3d
x87l9Iw+IKZyWSuwQgDvTvUxnRgis5BxjRKPYyoCTW+pNiPUfz2wCRNzyMJbLtg0
TTvPXKJcu2WIiujEKxDL8JZ3yFAD5m0fHTfTpvDP9VXC5nq8lYFut9vAwLwmWYlU
KIvaHyRiVQ/vDBy3IFcg3AvZfLIvPIWCv7LIDiJMi0i95SQj9WJ0Z5TYLfU8ybFN
WhrlaNMbuziLfqucXnd42lHHmk8eVNKWUapTXRDrITt2IusJNB17+1TWTiEXXJTQ
Xm7q2+WLqoOZImKZIJ1QWx44G97qeLlWGuTtIsoaFsBxX2EDVym+nq6l8IColRf2
WIxOH5zh1CbENiDfQSrm6lErdEyrMjVkIZRDHoAnAjxnH6U/ehqXzB6eW+0Y1e4K
7TibpZenq0fYC8tw9XC9m82sCbKAfYt2qKbBOFmW4iq6aKzLeHgRGsHMK9vcZJWj
0EYL9+5MmBbCnhs1V2xMvsiCcJ76PfYOeo8NL3QNjQifgSGZdQCBlh6nSCs6FGiZ
LoJ/aLXYLequG1S2nIh0Q6hoxRgUGVmpHlvmHZrT+cOnSLHdnfzD0TWQyqTN0Qkd
Sby0kpHadbIBgBHr3RSNSBdFcb/yh0B/GgbLCOnyWXpfrZItff8=
=dZhG
-----END PGP SIGNATURE-----

--mcntcbpkjwnkobni--
