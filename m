From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] regulator: core: if voltage scaling fails, restore
 original voltage values
Date: Sat, 15 Dec 2012 16:57:38 +0200
Message-ID: <20121215145738.GB15606@arwen.pp.htv.fi>
References: <1355389980-5532-1-git-send-email-paolo.pisati@canonical.com>
 <1355389980-5532-2-git-send-email-paolo.pisati@canonical.com>
 <20121213094715.GA1916@arwen.pp.htv.fi>
 <20121214153943.GA3306@luxor.wired.org>
 <20121214154030.GD18233@arwen.pp.htv.fi>
 <20121215141519.GA22033@opensource.wolfsonmicro.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121215141519.GA22033@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Paolo Pisati <paolo.pisati@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 15, 2012 at 11:15:20PM +0900, Mark Brown wrote:
> On Fri, Dec 14, 2012 at 05:40:30PM +0200, Felipe Balbi wrote:
>=20
> > No no, I mean that before you SoB you should have a:
>=20
> > Cc: <stable@vger.kernel.org> # v3.x v3.y ...
>=20
> It's perfectly OK to omit this unless there's an awareness that the
> backport won't work on some kernels.

that's not what Greg says, but fair enough. Won't discuss it...

--=20
balbi

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzI/iAAoJEIaOsuA1yqREanMQAIFAwPSW3Tl8np+CMBSWVZHl
Ul5Cc74INgIezhgx5cFAeN+M8br3EAJoQRXwaGNJ5Vc6UiOxxGs69WgJuoHof1zz
xYGW8E5Y3JA9iTSiQqAoozUDPpAY/L3VcdWh6v28Lra0PAgZh2bGqFYVEIohk5jT
974PopIx7d2qiDYqT1KT/pmDm0+oh21y9rVDdy1DmfL6WcHc1HsH6SvkWMorseFK
Pi/yRosPhvuxk8md+5s5MUVCKdudvomaU3jXjb7gEq59xeulwNQ5Qu50QQ1KbbzI
ABDDEmPdp2a7RptZlOQLwpDIqwdd6YkML56PRbeCnpphBiSFKGzMKqFiZ5O1EbHe
/BB129oOUpNntyP/dD9hJqThO84VPFDeMybpnfhTvM11GP29lDbxhIi2xXv7YdK4
f+RwJMnPQs1x2LLUqC1QZe/PijLPPWECAxTlxCdgR/eW872QaB89sIr5EWgoTEfc
0uk8MQP121WVFwDk9FnLvzDpQkQeGso8hpdutH4j1gCfLekssJTUyAGhD1Df94Bq
doDjGjmVUeQBFwRyy4MoKG1dPg5MegZxqRisDDr2nu32dqsQAL/qHry9S7nAYLAd
RZPA3JGuVUHSAEqTQ9H/u7gYKSEyK130pXn5xaAifH31E6mFJmxyviyNGtk57Hiq
iBUQI4geGjPrFkhoZ+cv
=8XM5
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
