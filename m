From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Fri, 30 Nov 2018 07:15:34 +0100
Message-ID: <20181130071534.0a6cd455@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
        <20181110203115.13335-3-andreas@kemnade.info>
        <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FQLc6guxB0FULy.fZogCAyY"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com, t-kristo@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

--Sig_/FQLc6guxB0FULy.fZogCAyY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, 29 Nov 2018 16:25:05 -0800
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Andreas Kemnade (2018-11-10 12:31:14)
> > Code might use autoidle api with clocks not being omap2 clocks,
> > so check if clock type is not basic
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > New in v2
> > ---
> >  drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > index 161f67850393..5bdae5552d38 100644
> > --- a/drivers/clk/ti/autoidle.c
> > +++ b/drivers/clk/ti/autoidle.c
> > @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >  int omap2_clk_deny_idle(struct clk *clk)
> >  {
> >         struct clk_hw_omap *c;
> > +       struct clk_hw *hw =3D __clk_get_hw(clk);
> > =20
> > -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC) =20
>=20
> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> Maybe add some flag in clk_hw_omap() instead?
>=20
hmm, Tero suggested that.
But to check flags in clk_hw_omap I first need to know that there is a
clk_hw_omap behind clk_hw. And for that I either need to check flags in
clk_hw or do more changes in the omap_hwmod code.

Regards,
Andreas

--Sig_/FQLc6guxB0FULy.fZogCAyY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwA1YgACgkQfb1qx03i
kyQ+yBAAidDLhlhMZ7eEWFOsruVGpL8JqvsCCCMue6pw/Se8mDoITcbDfV4phKcN
1Krz5PbnrhYeFOsAS9+qmI2xOyh0SyhuA/gEZz1ANREt2DS0zVnpLVW27U23lg0S
mKmqOHmCGrHnMHj4U2rgwDG+zbJ3sQlyuS4Gp7rK8vpfzwPjc9cfbBRRsjyEOGgX
2KdW+LezWLsl8FwOmuzmSJSw8s+2/yswK5Sh6n8VbJc3ZXf3pjfhrF2a+ODZsLU8
2ku+JKz+245xWYwjNspGAxpuHD5ZOaeYA8v6eDs9FdUxZ0ic2aq/kn+UKLLRSAGN
BljwO010K9VY74CctZDkMBCehMbuTbdrOQ1MQWYxnVUX4emDtUS4kK7cYN849Juf
3Ao71tKvqpUkWyJJ8E9m0e7UuMytCgs76cpvSwUVRkp6QluCXuTlyILKvpjp/gTD
9pvP6vPVI7tciHt8NUsBY1D7lRQv/D/qYQ0Xucypt7U5pkV7yVtAvHS/4fIleO8h
TrDEfGrTKKpK2JDUn8wiePtQ9Z15A4C8v8bSa4qL3mB0j32EuZa1V/P0r3sC+b4l
4vWq4/qcY+4q8oASQG3zvtcV1qrVJUPW0yKuA0K9eMWXU8XUVQALZBsrr9zg8DcI
fAfx4GxyROA/fMPruZgC57wW3JV16lQhagoTKCBIgSmlZsnnh7E=
=l8Gp
-----END PGP SIGNATURE-----

--Sig_/FQLc6guxB0FULy.fZogCAyY--
