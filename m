From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH v2] clk/ti/adpll: allocate room for terminating null
Date: Sat, 19 Oct 2019 15:54:41 +0200
Message-ID: <20191019155441.2b1b349f@heffalump.sk2.org>
References: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
        <20190927180559.18162-1-steve@sk2.org>
        <20191017154854.5285220869@mail.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/84fHvmaca2L9PPmq15CP2ZV"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017154854.5285220869@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/84fHvmaca2L9PPmq15CP2ZV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2019 08:48:53 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Stephen Kitt (2019-09-27 11:05:59)
> > The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> > terminating null. This patch switches to ka_sprintf to avoid
> > overflowing.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> >  drivers/clk/ti/adpll.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> > index fdfb90058504..021cf9e2b4db 100644
> > --- a/drivers/clk/ti/adpll.c
> > +++ b/drivers/clk/ti/adpll.c
> > @@ -195,14 +195,8 @@ static const char *ti_adpll_clk_get_name(struct
> > ti_adpll_data *d, return NULL;
> >         } else {
> >                 const char *base_name =3D "adpll"; =20
>=20
> This is used once.
>=20
> > -               char *buf;
> > -
> > -               buf =3D devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) =
+ 1 +
> > -                                   strlen(postfix), GFP_KERNEL);
> > -               if (!buf)
> > -                       return NULL;
> > -               sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
> > -               name =3D buf;
> > +               name =3D devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.%s.%=
s", =20
>=20
> So why not make this "%08lx.adpll.%s"?

Thanks for the review! I hesitated to do this because I thought the purely
formatting string "%08lx.%s.%s" made the resulting code easier to understand
than a combined "%08lx.adpll.%s". I=E2=80=99ll follow up with a v3 which me=
rges the
"adpll" string into the format string.

Regards,

Stephen

--Sig_/84fHvmaca2L9PPmq15CP2ZV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl2rFaEACgkQgNMC9Yht
g5ym2Q//TWIp7cVUWt4XkcfWI1ktVARFG1AgDkdOnpJNGVc72ic18oi7MCF301eI
Df0TWiciOshRpUTbTNtqbHkA9NKAIacHSqdJfdxBfUrZYHCPWBv/6qxWAom3Zd89
1Ri99eugCJfYTOYNEyZLelHgUvQIijKjAezWozlIe4p8gfSqzP+Ee+oY7s4dh+BY
ttmyWvl3YZ4X8K8Fzb1P7aeAg9Qz8CSuDuJVmzztx0cvBG/36PHf/b1jcqukeRoo
kNN/iyjKAD+ctdEh84soEexF5x5S9Ecu+ilxODTiyUlyz9gdmg4xL31lI+Q+R6kf
uY+5Mz1/cWx3+2lzC7u1go0Wm9kjDZhtkHG4b2tZ/xcRhx9jk7OGf+u4SVKf5/Cb
ho0XEEpZXryhXwELygOjajGIqsxuEhfCpr1oT6vr8uiiPQaxoD7gf1AlUgow2Ql0
lgSvJAmuRxRu+C0Cm5Si+6wHTk3J8dVFa7lutk5puGTplveq6EoB7eHOo8RvUVz4
IXf8exJti705Uy3YhybvcX+NAMmJkNWbiLHJSwS2ZtZh0U/auodKKxBVhJaVOeIJ
jBBGSpzVMehXPWmY8J+RTHfpH0Fkrv93BcPX0izX463eIHdZezDbLl6+erVjLxtd
H6stqVeqrHusfTKLb8XP295y+n0LekTk9sadeJeNhGKPh4YVOuQ=
=zhZj
-----END PGP SIGNATURE-----

--Sig_/84fHvmaca2L9PPmq15CP2ZV--
