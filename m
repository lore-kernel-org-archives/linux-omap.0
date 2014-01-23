From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] driver: pwm: ti-ecap: Remove duplicate put_sync call.
Date: Thu, 23 Jan 2014 15:19:47 +0100
Message-ID: <20140123141946.GC6503@ulmo.nvidia.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
 <1387366615-23182-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387366615-23182-3-git-send-email-sourav.poddar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 05:06:54PM +0530, Sourav Poddar wrote:
> Remove duplicate 'pm_runtime_put_sync' in the remove path.
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/pwm/pwm-tiecap.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied, thanks.

Thierry

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4SUCAAoJEN0jrNd/PrOhTJQQAL2dFfcWe4pOT1GZuPqmsKKS
YY1K7Cc/wvBtUR4m591sAyPcjTV1mAzKGWV9QIetHaqv/H0BIsTGaaYC9CFZC01Y
+Hyl1PnuT+BtgDMU8GDR3GuJ/HzHw1zBXaSFvdGXeiaCRpu3QNlO++otG+A3STqD
c7H31PPl1WQhP1c+7E5AoowSa9sfVfvi7Mg44lpfZ7aVnoJ1AIjxg0YMStmT8802
Nfyr7f1XmK+grv956IcTVbCFgwjOcL7qikK96LcHS16Tr7nYKOQN3BH7BtZy4W/j
20ZepsZFhyOoXu5kJCyfamk+bL7riQewBulUcaJfgbxMErGm1GSfYtey2zxQun5T
/jj9QT7FBP5vWz+TnWFtqnYLspoy2keQqdO0p8btA1THYLFWLnFe2CpgVCJVKDjw
bhzrDzGSGUUfp+quBbFGDw9ZOSCRzsI8nAHFGxC0VisBeV2Do6qITGC+LJk1HQo7
Q1xOh8bCYx0idM+2ccFYFmov2fRVhl/GQxMuC3CfKKsBe8tM5Y9hqVKXvStVmsWB
ZpdDJrB0cvys1fHxAPX6gioZZPImD1VUAyc9PCmnu1LALDJN1f6TI3FKq5BAmoMM
omLKIi5FnNJwy2pN6/E1fMd4ZwniG/NcWs+a/0VCL3e9SKgRsL4gXccAEMlhCa+i
Xs+vVTVgl6TTZft2yd1o
=2mdo
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
