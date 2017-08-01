From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] device property: Fix usecount for
 of_graph_get_port_parent()
Date: Tue, 1 Aug 2017 15:15:08 +0100
Message-ID: <20170801141508.l5dfu3bcimt5r5hc@sirena.org.uk>
References: <20170727094405.19778-1-tony@atomide.com>
 <CAL_JsqJ9Xmbws8gBRCxn2Nt=tj1HLnF-MGvnW+oOourvgbm9Nw@mail.gmail.com>
 <20170728060127.GH10026@atomide.com>
 <20170728082315.GL10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3xb5inf3godddqn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170728082315.GL10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org


--w3xb5inf3godddqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 01:23:15AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170727 23:02]:
> > * Rob Herring <robh+dt@kernel.org> [170727 15:19]:
> > > On Thu, Jul 27, 2017 at 4:44 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -708,6 +708,15 @@ struct device_node *of_graph_get_port_parent(s=
truct device_node *node)
> > > >  {
> Found few more things to fix with git grep -C20 of_graph_get_port_parent,
> below is v2.
>=20
> Can you all prese review again and do some testing. I also fixed up
> audio-graph-scu-card but can't test that one.
>=20
> Regards,
>=20
> Tony
>=20
> 8< ------
> From tony Mon Sep 17 00:00:00 2001

Like I've said before mangling patches into threads like this makes it
harder to apply them - right now my workflow for when I'm online is
based on pulling the patches out of patchwork rather than directly from
e-mail and patchwork definitely doesn't understand this well.

--w3xb5inf3godddqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAjOwACgkQJNaLcl1U
h9A3MAf/eDoODYfLe4hUb4s8m/4eR3FuaHMf+jLUYVDb1ea07JbfswLmWgVNOI7Y
OBXJqjg8/FPEwf1JuP4lnFBtLaC4vBdUIpUQugRLtnwhMWfaWGH2nUEUzSPFivMd
wBcKR/mETggufHjKox6Tar9QrEIzpnnuU6UEK2e0fjkcgPrDuFdRgYRfaEGJ/M+w
qY07+/X4hkN2iAEvhefNT4Zku5Uwl9jr9rWJ9T/8sXsUKmFw7Rm2OxSxmq6MZBJI
ZzM6JFfS3Z6l/z0x2cJxwaQTtQYtvI9xQriXnFOr02JfAFKtAhtWqtoBS3KIDHK1
+Hk03oE33znD6swsMI4ymP5w7cY6Mg==
=fXPN
-----END PGP SIGNATURE-----

--w3xb5inf3godddqn--
