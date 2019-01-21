From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Date: Mon, 21 Jan 2019 18:53:44 +0100
Message-ID: <20190121185344.7cff9641@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
        <20190118194536.GY5544@atomide.com>
        <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
        <20190121170743.GB5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HnaydzaLFwE9HUO/Oh9Q2eo"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121170743.GB5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 21 Jan 2019 09:07:43 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> > On 18/01/2019 21:45, Tony Lindgren wrote: =20
> > > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]: =20
> > > > Hi,
> > > >=20
> > > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > > Tony Lindgren <tony@atomide.com> wrote:
> > > >=20
> > > > [...] =20
> > > > > til the next workaround.
> > > > >  =20
> > > > > > That flags also causes the iclk being enabled/disabled
> > > > > > manually. =20
> > > > >=20
> > > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > > just means:
> > > > >=20
> > > > > "manually enable and disable ocp interface clock"
> > > > >  =20
> > > > well, if we want to manually disable it and not automatically,
> > > > we have to disable autoidle or it will be automatically disabled.
> > > >=20
> > > > Disabling it manually when it is already auto-disabled (by autoidle=
) is
> > > > just practically a no-op towards the clock. =20
> > >=20
> > > OK I buy that :) It should be probably added to the patch
> > > description to make it clear what it changes.
> > >=20
> > > Tero, any comments on this change? =20
> >=20
> > Well, seeing the flag is pretty much only used for a handful of hwmods
> > nowadays, it should be fine. OMAP3 PM should be tested with this change
> > though, as there are couple of hwmods impacted on that platform. I wond=
er
> > what happens to cpuidle when display is active... =20
>=20
> OK so that's a good test case. AFAIK, we should have DSS idle
> and have the SoC hit at least core retention with DSI command mode
> displays. I don't know if this patch would block DSS autoidle then
> or not.. I'm guessing 80% chance that we still need DSS hit runtime
> suspend to enter SoC idle states meaning this patch would not
> affect it :)
>=20
So this is a call to Nokia N950 owners?
Unfortunately, I do not have one. I have seen on non-command-mode
displays that dss goes to idle when display is blanked.

Regards,
Andreas

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxGBygACgkQfb1qx03i
kyRBuxAAuFR8hFsL6uh6ARlVEQO+wUdp/ISgRQmvcwvKthz33KSQJdXmbzleXtSM
mV03OE6dFkMHdKkQalC31sYIfRcjYHBrguvKyz1XAojZhQgWWJJkJLx1Lauw9Yk8
wGc4D1LqdwmXoIQPAycpZMF9+lalo/7yc11u+yDQIyZc8aifyDLZHrkRuriZbqfS
eY6WvmjXpC3VJJTTCvipJL76b9dbmAxHDx4CysHbec1/CVB6Tu3diUALCBj0J2Fx
szsgvJF7veWy2gnZGFIj65QKE6DmGXq82wahcvdIxiapcRJwGDZYOAtLlJclquDV
H1c+xJhdcQauC9rE2ELdWBb7mmbTd3WlCr5x2IZ7zc0PfwqlFh4c9HolYUBXLtvU
7A7bkDpfL2St3vrv2Gxm/V+EDOrr0SDrVPlxiI/tVDtJfxq+ZQSG7RrXbxFA4W3e
/RdH9RXCpYoSLCHs7xguOcbwt7jMEMErUmtv7mP/xTdXthPl33pp/ILWCtDBekBo
S8zHSZJqdoAVlgrTh7iIiDb8lf2eJN99iNgoEvTwjm7Duit55C9+S3NI2Z2Rm1DX
bJjFzdlzFbh1qr4jtZTcuSUseR0axh82T19+G2S1buT0wcU9Sa3aRonxNm5QZGJh
4xZtwS68RXx5fz+H2AHUvTzDuPF5i+zPnbnjEEVhAkoPg444AD0=
=nkFt
-----END PGP SIGNATURE-----

--Sig_/HnaydzaLFwE9HUO/Oh9Q2eo--
