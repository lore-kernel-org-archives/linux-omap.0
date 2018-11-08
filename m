From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod
 requires that
Date: Thu, 8 Nov 2018 12:08:47 +0100
Message-ID: <20181108120847.1ef7ec02@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
        <20181004203817.22101-3-andreas@kemnade.info>
        <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DNrPM6vl+hRXWj1jQJVW_UG"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 8 Nov 2018 12:26:08 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 04/10/2018 23:38, Andreas Kemnade wrote:
> > Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> > that makes hwmods working properly which cannot handle
> > autoidle properly in lower power states.
> > Affected is e. g. the omap_hdq.
> > Since an ick might have mulitple users, autoidle is disabled
> > when an individual user requires that rather than in
> > _setup_iclk_autoidle. dss_ick is an example for that.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
> > index bb641e6c93d0..0078b0e1d242 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod.c
> > @@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
> >   		clk_enable(oh->_clk);
> >  =20
> >   	list_for_each_entry(os, &oh->slave_ports, node) {
> > -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> > +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
> > +			omap2_clk_deny_idle(os->_clk); =20
>=20
> I think calling this unconditionally across all platforms / clock types=20
> might cause problems. Checking kernel, am33xx seems to have one clock=20
> with this flag that is not of omap2 type. Do we have any testing data=20
> that this doesn't break things?
>=20
Somehow I have missed that am33xx clock. I have not tested it on that
platform. Concerning am3xxx I have only a beaglebone block but it not
am33xx I guess. So I have to recheck I guess.
But I think the intention of this flag was to control autoidle
vs. sw-controlled idle according to...
[...]
> >   		if (os->flags & OCPIF_SWSUP_IDLE) {
> > -			/* XXX omap_iclk_deny_idle(c); */
> > +			/*
this comment. So we need a if (clock_is_omap2()) or something like that
or remove that flag from any other clocks?

Regards,
Andreas

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvkGT8ACgkQfb1qx03i
kyRPvA/+O3wf6sLIltlhj735JbtwBPTRgBqSE3bhiI0zhdEqGBCGC1yDF1NDRKxQ
ALw1g1MRyLbswezPvJhxbuvF3c3kSpPbGRjVNRW15ypI9gOeu6k05m1Ikj1I6J0p
tsYiL0oEIWi37pynfT3oQerS7sUxBKCp7Nf2OU0HMrsVNFLMVVUlJBm2WUv07RuM
lOJefgdVH5VElEsrjb+Ug/0l1lD8DxC8Cs01oD8Yr7zT06npPtOgOTCvWDPsEMZS
DFddlAcPju4gblQ5Ihf3jDxc7sqlKyqnt2wZy9yAS/tCGDmcvU+6AbTEgwC4p6IN
SM3KpMmRiaL0SQWZYW9NLPFFWlXl8QIaPaITlG/ZN5aG8dqIEmMUE5hjqHTu6e6s
rUfbcI6RmJ/11HlQC6ONBArIvQ2NSk4G9Myj/lcBoHtJtqE5sRXr3sAs/60FbWMa
hcB7wiXl7XrUTYYjAj7AbEJQO/CuArtc6OrL1wbo5guNmcBXOOc8KnNARhJdsaLq
gtBkQWovGZQ8E/6tjTU1q7U+UEFgS8OcTneR/791q9nDocKZgm73CX8jZSo6mOHU
Kwzat2k2VgqqwV1m9+7upJk5o8Ov3hDk2y2RtfJkdUw4K2aqiEBi0bBUAKb4IZPf
6stpkeWo0GJaBhkHy6T4Jujy/GZoxG8+uFd+6VXkOBneAy7Qyck=
=AU3Q
-----END PGP SIGNATURE-----

--Sig_/DNrPM6vl+hRXWj1jQJVW_UG--
