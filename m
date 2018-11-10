From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 1/2] clk: ti: add a usecount for autoidle
Date: Sat, 10 Nov 2018 08:52:43 +0100
Message-ID: <20181110085243.7da163b9@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
        <20181004203817.22101-2-andreas@kemnade.info>
        <23cbfc19-20d9-99f0-c086-e782cc36de34@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g7+_xUFQiCBMaTFikRMVVkp"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23cbfc19-20d9-99f0-c086-e782cc36de34@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/g7+_xUFQiCBMaTFikRMVVkp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Nov 2018 12:36:35 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 04/10/2018 23:38, Andreas Kemnade wrote:
> > We have the scenario that first autoidle is disabled for all clocks,
> > then it is disabled for selected ones and then enabled for all. So
> > we should have some counting here, also according to the
> > comment in  _setup_iclk_autoidle()
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++--------
> >   include/linux/clk/ti.h    |  1 +
> >   2 files changed, 25 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > index 7bb9afbe4058..bb6cff168e73 100644
> > --- a/drivers/clk/ti/autoidle.c
> > +++ b/drivers/clk/ti/autoidle.c
> > @@ -37,6 +37,14 @@ struct clk_ti_autoidle {
> >   static LIST_HEAD(autoidle_clks);
> >   static LIST_HEAD(clk_hw_omap_clocks);
> >  =20
> > +/*
> > + * we have some non-atomic read/write
> > + * operations behind it, so lets
> > + * take one mutex for handling autoidle
> > + * of all clocks
> > + */
> > +static DEFINE_MUTEX(autoidle_mutex); =20
>=20
> Why mutex? This prevents calling the autoidle APIs from atomic context.=20
> Did you check the mutex debug kernel configs with this?
>=20
Oops, I thought they were on, but they were not. OK,
I am preparing a v2 of this thing.


> This may cause problems with the runtime PM entries to the code at least.
>=20
>=20
> > +
> >   /**
> >    * omap2_clk_deny_idle - disable autoidle on an OMAP clock
> >    * @clk: struct clk * to disable autoidle for
> > @@ -48,8 +56,13 @@ int omap2_clk_deny_idle(struct clk *clk)
> >   	struct clk_hw_omap *c;
> >  =20
> >   	c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > -	if (c->ops && c->ops->deny_idle)
> > -		c->ops->deny_idle(c);
> > +	if (c->ops && c->ops->deny_idle) {
> > +		mutex_lock(&autoidle_mutex);
> > +		c->autoidle_count--;
> > +		if (c->autoidle_count =3D=3D -1) =20
>=20
> I think you should swap the arithmetics here, all the other usecounters=20
> use positive values, here you enter deep to the negative side when=20
> autoidle is denied by multiple users, which might be confusing.
>=20
agreed.

Regards,
Andreas

--Sig_/g7+_xUFQiCBMaTFikRMVVkp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvmjksACgkQfb1qx03i
kyTa/w/9Em6bQXMvZfpW/9iK4GXuM2on18lYod2wZn6xWUzESe0L3uDK+0oQMtd6
QWyxhNfqZ81q3sgZokwWOEspnyr6Naa1a0u8JLFbSMZwY1ajxp3aCsmcmVuAqhAO
HBWH5VCb8MbA3eXJwUsDU9zyx4Zlxyu7hVB7ku05+HMsxaGPdZFOLjI7RJPU7/ok
6LCo3qUaa+RrNdU+2mZXKEA16s4J7rtjjyqmXqVyRPI0d+o3jx/1ByVrJeGrkeoF
dD2SqibJQmdVgEWLav5qZoymY4MhY6Q3SGQttA+3U8IileC/m6BlOwd47X0ETVgD
wQ6HQ218JUElIW4SPWFdi7QdV2EPOuinnjpUiVON4f6e0GxYgR4626/tz7Edaiin
zy99XHSSiWozSmuhUEJwXcS9niI01fLDVonh4wh8aTtZ2tSIjBmi9FJrFBlJV0EN
v+F8kJWiclDSjwIhvD/1Z9TWzp1MsLJctJJlEa9GwfZ2uZPqFiFIt9Xl1KFR85AD
MmYN1Et49aPF1nFTzuW2O+yVZCkVjjGLn6UrYxrWkVTBat50pedRT5WzWfzjWWA0
aKACN9dXO3ZE+GBXT/HzaDUBo7uQ7sk/YznN94g0wi6FNAeh6Rg+Wt9QNidCNUCy
V2ZEFjjtAXTd9PoXZGO9Al7Kto4TsnkNtgE26wc0ik+3oPdsYEo=
=BL1u
-----END PGP SIGNATURE-----

--Sig_/g7+_xUFQiCBMaTFikRMVVkp--
