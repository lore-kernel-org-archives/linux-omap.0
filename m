From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Thu, 27 Dec 2018 21:12:22 +0100
Message-ID: <20181227211222.5996c356@aktux>
References: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
        <20181130071534.0a6cd455@kemnade.info>
        <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
        <20181130153729.GG53235@atomide.com>
        <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
        <20181203153910.GA6707@atomide.com>
        <20181203172246.0e767a16@kemnade.info>
        <20181204164556.GB6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TIvixuQ9bzfDR./7PwxIb2L"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204164556.GB6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

--Sig_/TIvixuQ9bzfDR./7PwxIb2L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 4 Dec 2018 08:45:57 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
> > On Mon, 3 Dec 2018 07:39:10 -0800
> > Tony Lindgren <tony@atomide.com> wrote: =20
> > > The consumer device stays active just fine with PM runtime
> > > calls. So yes, the problem is keeping a clock controller forced
> > > active for the period of consumer device reset. Other than
> > > that typically autoidle can be just kept enabled.
> > >  =20
> > Are we still talking about the same problem? Maybe I am losing track
> > here. Just to make sure.=20
> > The patch series was about disabling autoidle for devices which cannot
> > work with it during normal operation. Not during reset or something
> > like that.=20
> > Or is the keep-clock-active-during-reset just a requirement for bigger
> > restructuring ideas? =20
>=20
> Yeah there are two issues: The fix needed for the issue you brought up,
> and also how to let a reset driver to block autoidle for reset.
>=20
Hmm, is this set now waiting for the famous "somebody" fixing all
the stuff?
What are currently visible symptoms for the driver not blocking
autoidle for reset? Maybe I can at least test something there. I have
also omap5 here.

Regards,
Andreas

--Sig_/TIvixuQ9bzfDR./7PwxIb2L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwlMiYACgkQfb1qx03i
kySS0xAArFtcBqNv3FgSHyXCkCfojx8xM1WGyVr+paQgNoOZtmThhgTTi1CEgQ4a
ElAK5Lp7sl1JeYmqIP/XYHBkFDRfavWRIGU1ZggahsP5gmalPZV1k7HtkCGaubua
5pVvpmNYy4txp7oatJ4FpQJKAiyXqz9u6on4t2uUdOxqDIJWpnP/3EHORjiXzel4
Ss4P712YS42TsKsCvdwNNXAMNtci1GyDZ0OWYITBgW+bqzIV+qWgaNAX6g2q+1rd
0lmqTllP2N9KRLQ8dteBYlDQiB2A7GSblynObVnaRWGN/1/gFgbQ87SoSbyaFvXT
4gmypEeB9Sh/vkg9Jjjxq7gkpV6v3STXIy8Dx7jY0I1/Wtd4KRhJYApOs2xQqZo0
iOZqSflhm3/np3ldpxkZYb0IEqFHPZzYzfjlmNxYojpJ8qInrMF1sVcvpRFPNh/p
mIx7bHF37KOmex/+H1GBHWTuAvEitrNHAYT3JdpKxVHfOJX/b7H0OhZXjnQ6Mvvm
VAqWEBkjueo0wEH4cfMz3yxftEpjAYgBnOb7KLfinc38gS4PQWMEun6YyWTg8Z4E
SSJvK3BYPXNZT1HLjlhB4W4JtzNtKbIqwJAOBahiK0KgHHNRg3FV+KE9ZdwMxX6O
T+z8EQLrsdFkS5vM6LNJn7JbgSix33pO9X20xE50sLvCmqEEfrw=
=5Sng
-----END PGP SIGNATURE-----

--Sig_/TIvixuQ9bzfDR./7PwxIb2L--
