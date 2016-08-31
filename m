From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Wed, 31 Aug 2016 18:24:40 +0100
Message-ID: <20160831172440.GA7866@sirena.org.uk>
References: <20160829182746.53vrgbxadqodzzug@atomide.com>
 <201608300739.JrTVlIyd%fengguang.wu@intel.com>
 <20160830183834.6u73eb5ujgm5emlk@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5935005333530031835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160830183834.6u73eb5ujgm5emlk@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, kbuild test robot <lkp@intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, kbuild-all@01.org, Pavel Machel <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============5935005333530031835==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2016 at 11:38:35AM -0700, Tony Lindgren wrote:

> Updated patch below, Mark let me know if you need an incremental
> patch to fix the warning.
>=20
> Regards,
>=20
> Tony
>=20
> 8< -----------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 29 Aug 2016 11:27:46 -0700
> Subject: [PATCHv2] ASoC: omap-mcbsp: Add PM QoS support for McBSP to prev=
ent

Please send the patch normally rather than burying it in the middle of
another e-mail :(

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXxxLXAAoJECTWi3JdVIfQEHwH/RcdnTEKuJq5g7V9GnElA2qr
NvvogYrkpTBPHHvj4EKsua4jxbMFoQtCwcRBCxfAMGYiHYqMxH2tzbYm9gorWAxg
h/qCRI5Rv7ZNifmPNzqcWGG++BaKhU5OtkOcPqjyF1XH5JJ1/ng/iOP3qmNKrRAW
5IbtPtOokVYH24DQ82k6s86VGC6Fk6+kKtP+ehzts0g2gtlwNmUeLD0RO1yiQqyc
JxG8fGIH+TAsBFRdSGVUbgdrNMKxMjDitNGCa3rdKiRKVgbCN6GXmUnabhJLpGcj
yJtdO6BOSeacqzPyAPCEKj/w5JF7Lzy3da6PDu3kHPPb9tG/cEVi0sPNJSL/dWQ=
=2xvS
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============5935005333530031835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5935005333530031835==--
