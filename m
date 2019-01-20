From: Sebastian Reichel <sre@kernel.org>
Subject: Re: cpcap-charger: generate events for userspace
Date: Sun, 20 Jan 2019 22:41:07 +0100
Message-ID: <20190120214107.n2ot5mvggub4aehn@earth.universe>
References: <20181227195221.GA11920@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5246124651533996246=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181227195221.GA11920@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mpartap@gmx.net, linux-pm@vger.kernel.org, tony@atomide.com, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, nekit1000@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============5246124651533996246==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byreiu6z4ngijxep"
Content-Disposition: inline


--byreiu6z4ngijxep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 27, 2018 at 08:52:21PM +0100, Pavel Machek wrote:
> The driver doesn't generate uevents on charger connect/disconnect.
> This leads to UPower not detecting when AC is on or off... and that is
> bad.
>    =20
> Reported by Arthur D. on github (
> https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
> Merlijn Wajer for suggesting a fix.
>    =20
> Cc: stable@kernel.org
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, queued to power-supply-next.

-- Sebastian

> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 9e8ff5c..7d8b4d5 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -576,6 +576,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>  			goto out_err;
>  	}
> =20
> +	power_supply_changed(ddata->usb);
>  	return;
> =20
>  out_err:
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--byreiu6z4ngijxep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6vMACgkQ2O7X88g7
+prkABAApFEELQA6AnpA5CNX/WpKDkKWb7dVv+2gvum+GwIZR/+c4idPzHOzHHLr
MTDkNE4AoTi/GA06Q7Ed2PE8NNgrLtDKC8edu8KMDM4TW4oo3d1RIS4JPvBDpewy
8KkeHBEPgBT0PDzFc379lAfXYr6V38GhMOR3b/Jqcu81F9jAeOk/gmOLIgdIXjIL
BS/CJMABO3yX5zoFdxiOYM1pkoKGf+bw+un7NW0RSkrSCaxUiDHvfl7+Et0N7ouI
zTSL54vGGvyXGmUE0PXujLrgUQ9jYPedxotL8GlA5uHsIa4mma36My6I4ldowppa
Y5Ys2+bglHbYnk0onp3GbpP4obdXaugsyPs18wpk6lVfxpYQ1hcY33v/E6hhKpLk
rM6urwQ4Fin81txDMMHIuhnXdf4V+BfVQH02B0+iDYjF/0FUs4n9jmHY6nuezXAq
RMMgMZ8sgTtllr4M7OxL2f9ZRrliqb3fAfSXgq7YFYqHQvgjAJUuSuP8OrCHvxUO
woFPWgjhxEjrreS9mzWFQp0EWlfSqGWA2WDbVzwvOMXrZAYnavr5Sjw+4jz9gS/v
yjLJyebiKu1k0558op7GbgwYJkdZO3CSPRvsRv1dnzuMf7cWYhUT5BH5UuUVmXaa
n/Bvcb2knDgaybIWF9gd8nodRBnBbrIwjRsBSj9I+DBOqDiSx+c=
=h22h
-----END PGP SIGNATURE-----

--byreiu6z4ngijxep--


--===============5246124651533996246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5246124651533996246==--
