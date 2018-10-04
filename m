From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RFC 1/2] clk: ti: add a usecount for autoidle
Date: Thu, 4 Oct 2018 21:34:48 +0200
Message-ID: <20181004213448.55c08208@aktux>
References: <20181004055147.23048-1-andreas@kemnade.info>
        <20181004055147.23048-2-andreas@kemnade.info>
        <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DI2+y_6kLlI.i7YQdkdRjJF"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 4 Oct 2018 17:40:06 +0300
Tero Kristo <t-kristo@ti.com> wrote:

> On 04/10/18 08:51, Andreas Kemnade wrote:
> > We have the scenario that first autoidle is disabled for all clocks,
> > then it is disabled for selected ones and then enabled for all. So
> > we should have some counting here, also according to the
> > comment in  _setup_iclk_autoidle()
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/clk/ti/autoidle.c | 20 ++++++++++++--------
> >   include/linux/clk/ti.h    |  1 +
> >   2 files changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> > index 7bb9afbe4058..be2ce42e4f33 100644
> > --- a/drivers/clk/ti/autoidle.c
> > +++ b/drivers/clk/ti/autoidle.c
> > @@ -48,8 +48,11 @@ int omap2_clk_deny_idle(struct clk *clk)
> >   	struct clk_hw_omap *c;
> >  =20
> >   	c =3D to_clk_hw_omap(__clk_get_hw(clk));
> > -	if (c->ops && c->ops->deny_idle)
> > -		c->ops->deny_idle(c);
> > +	if (c->ops && c->ops->deny_idle) {
> > +		c->autoidle_count--;
> > +		if (c->autoidle_count =3D=3D -1)
> > +			c->ops->deny_idle(c); =20
>=20
> This code is racy as you have no locking in place. Please fix.
>=20

hmm, yes, it is. Due to low risk (things are only called from init
before the drivers are initialized, if I understand that correctly). I
kept that for final polishing and not for a rfc patch.
The deny_idle/allow_idle are also racy themselves. Multiple clocks with
bits in the same register changed at the same time would also create a
mess.

> Also, this should be verified that it doesn't cause any PM regressions,=20
> I hope you have done that?
>=20
Tested things: I checked various autoidle registers for changes.
I checked registers by reading out /dev/mem
Seen changes: hdq iclk no autoidle (that is the goal of all this)
dss iclk no autoidle. This one is really interesting: There are
multiple users of dss_ick, so that is a special case. I will check
whether I can handle that (I have already an idea) or just delete that
flag there for sorting out that later, we could somehow live with not
disabled autoidle flag there but needed some strange fixes in the past.
Now dss_ick does unecessarily enabled, so yes, a little regression.

CORE/PER idlest seems to behave as well as before that change.

Regards,
Andreas

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlu2a1gACgkQfb1qx03i
kyTUJw//bk67LvreD5J0A92GGWjzLptxyyqnzPs6JmSzGymmvcNzCfwUFHri76CT
xDBs5DyRUWcTg51aRFmjcYS1yBx3UJSscDX52V2CPYF6zvhfWL3w92VDlqawdQjt
ADIRnpiFA/JsaRakszMia/2Yvqybf/eXchmE/PVZgn8IQnFJW0SgcvBXrUmFVznX
55nkSeBThO8Rt/1JWmeaUp73m4MPZ0IDp0/5a2nFRMoIp1Arkd632MbWKesT7sD+
d84LSP5MEslEpB0mHdXNgkuJfxS0WcgrkXeVuvTJq3JkJSy+LQLYlyDwAJkfC8TV
/FO8lYFFnH7GcgdNhPmv3r/iUrdSUIujIat5oyUpuz00AVMA0+tstrQxQ2mIRIpM
P/2+h8AL+4el+bNQRYCPMCckCVj/zvzSD2XVnAc9N5q+GD4UYQQ3+9CZanpETr16
XFMAK5nzGpxPI0f13utAsunRMk+7RNX3ECybnO/402T/CQYepITQWhjig5n5nDx8
ZHvBHKLmWBxVPvg0ml598m5PHRO/FCbCBPK1hfSd1fhy9HN9Ya/LW6EjAyjY9s9c
v8jOw3eik4iokdz5zSxhhdArqU0mO4FwA8p5/lTLC/Fuurr9gnpxIm1Xr5nMIWik
0O0/1OqtM2LwgQ1IvfAenwODCaKcwSG1VupZzG8rj0+mt2DbNuE=
=xAN8
-----END PGP SIGNATURE-----

--Sig_/DI2+y_6kLlI.i7YQdkdRjJF--
