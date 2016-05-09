From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/3] HSI: omap-ssi: regressions against yesterday's
 linux-next
Date: Mon, 9 May 2016 23:21:19 +0200
Message-ID: <20160509212118.GD1129@earth>
References: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462288586-584690-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, May 03, 2016 at 05:16:19PM +0200, Arnd Bergmann wrote:
> One patch you added yesterday unfortunately caused (at least) three
> separate build problems with 32-bit ARM randconfig builds.
>=20
> These three patches should make it all work again.

Sorry for the delayed respones, I was on vacation last week and
asked Stephen to temp. disable the HSI tree. I just applied all
patches and asked him to reenable it.

-- Sebastian

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXMP9OAAoJENju1/PIO/qaslQP/1MQhACu43vYZ9mpa/Hff78h
gOHRaHCIrpIgvckjpay59QkSZK8WZbD4BeRposR0/ypPHQZkalTQVaRE/3EzLf1k
Kv8WeNZNC04uXTaBBDT4Ppn8Xr+KaTGn5/L08k4YKvkRSlpqpxrE6rAHzeAUka9x
Pq1ZQtpbofDgBqxVKAyFi8htNniIsXCbjCCDetf9RuVx7nbjXyJeeoae5JLVUiSb
MKgsJvNijj0YegvHKRpJ8zi1fPYqHKfhbc6JoBSkySGJX8IvmA8zodNb+aUv8Uo9
ZcJ1k9JBr3ATfytxvhArgf1QI49fIuVd73W9qfogTrm8KaCOzrXLzpINXEqVykC3
sg7NB6Kztz2hWVFbplFxbFeywn3fBYO9RvcvoruXxSCeuf9dNUBgDtkv+DmQEvdW
1Wl3wkgqok7ildglMVg66mfLaSrUnRGK2L6U6k6cP+7fHU/qVUKLUlDCQO3A+xAs
p0JjCSaTyezxO9OMA6SPpXns5dTNArRAhTTA+a/+aVsSpaf8Sggp74RERZK+GA4w
NHbYLe02mV9Fi5ioFooz+sjLiNkQFowZNxWAjtQL8k4mJ7R2mjhCp8wKR7YvMR8C
aGruq7iiPhyDwCTig8JG4anlb20Ibvwh7mM6NsbnukJGeuTzN2qKKE1u+JrhBfo9
+4uY2h5nq5OfpzwIzjvL
=uNQr
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
