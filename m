From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Mon, 3 Dec 2018 17:22:46 +0100
Message-ID: <20181203172246.0e767a16@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
        <20181110203115.13335-3-andreas@kemnade.info>
        <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
        <20181130071534.0a6cd455@kemnade.info>
        <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
        <20181130153729.GG53235@atomide.com>
        <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
        <20181203153910.GA6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MhEEXM=lh9cLcZUfXC+oZzA"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203153910.GA6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

--Sig_/MhEEXM=lh9cLcZUfXC+oZzA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Dec 2018 07:39:10 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Stephen Boyd <sboyd@kernel.org> [181130 23:52]:
> > Quoting Tony Lindgren (2018-11-30 07:37:29) =20
> > > Hi,
> > >=20
> > > * Tero Kristo <t-kristo@ti.com> [181130 09:21]: =20
> > > > On 30/11/2018 09:57, Stephen Boyd wrote: =20
> > > > > No that is not preferred. Can the omap2_clk_deny_idle() function =
be
> > > > > integrated closer into the clk framework in some way that allows =
it to
> > > > > be part of the clk_ops structure? And then have that take a clk_hw
> > > > > structure instead of a struct clk? I haven't looked at this in any
> > > > > detail whatsoever so I may be way off right now. =20
> > > >=20
> > > > It could be added under the main clk_ops struct, however this would
> > > > introduce two new func pointers to it which are not used by anythin=
g else
> > > > but OMAP. Are you aware of any other platforms requiring similar fe=
ature? =20
> > >=20
> > > From consumer usage point of view, I'm still wondering about
> > > the relationship of clk_deny_idle() and clkdm_deny_idle().
> > >=20
> > > It seems that we need to allow reset control drivers call
> > > clk_deny_idle() for the duration of reset. And it seems the
> > > clk_deny_idle() should propagate to also up to the related
> > > clock domain driver to do clkdm_deny_idle().
> > >=20
> > > So maybe clk_deny_idle() is could just be something like:
> > >=20
> > > dev =3D clk_get_device(clk);
> > > ...
> > > error =3D pm_runtime_get(dev);
> > > ...
> > > pm_runtime_put(dev);
> > > ...
> > >=20
> > > And that way it would just propagate to the parent clock
> > > domain driver and the clock framework does not need to know
> > > about clockdomains. A clockdomain could be just a genpd
> > > domain.
> > >=20
> > > Or do you guys have better ideas?
> > >  =20
> >=20
> > Wouldn't the device link in clk framework patches do this for you if we
> > had the RUNTIME_PM flag passed in. If this is about keeping the clock
> > controller active when a consumer device is using it then I think it may
> > work. =20
>=20
> The consumer device stays active just fine with PM runtime
> calls. So yes, the problem is keeping a clock controller forced
> active for the period of consumer device reset. Other than
> that typically autoidle can be just kept enabled.
>=20
Are we still talking about the same problem? Maybe I am losing track
here. Just to make sure.=20
The patch series was about disabling autoidle for devices which cannot
work with it during normal operation. Not during reset or something
like that.=20
Or is the keep-clock-active-during-reset just a requirement for bigger
restructuring ideas?

Regards,
Andreas

--Sig_/MhEEXM=lh9cLcZUfXC+oZzA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwFWFcACgkQfb1qx03i
kySk6g/+POdYvoVVKYBjrqm8GKTLWubPUYY+oelza7BS0AKMJzYPTvpbv57Qn7Tt
Nq2uUJXp12CCJ5jVw6j1M3m3A0vuySx0ILwawNiNdTpkj4x7ugwOp1N6OCepojrn
FDyw+9xHfofNKWnk/bs67PxTIS0upsQLBUg1pBB9bi8zMBn4kkAtHkVgnnqVEF8Y
/v7BWbpr63hLNv3aVys9cQ5iP0bC0wfJ5/lPAH9g33ROdqVlzrBKUHkkVmahyW+e
wNbNLTgLPSnZFiPqF2NTT+lITgWdC8ca95biJAid83W/3aNIkRdhI0zW/bgZwz/x
z2SHVnMwuGwxC/JcR1S6k6Y1plReLMMJRShcverR+CtnYNsLnyUahBd2Kq+IdeIP
x/CMwUHDOnEf9euNJXTTC0rYJeBKrWK6kMrOV1kGHuPpLkXLS+eryuHxDOT3PDcZ
BUwDpm5DNdtPM0s6vnrHRM8AlGEOo/zUZyuhy3Haq9fXDzmBqr5jdWLodb8xQxdQ
ioZHavWlLlOyiIHm1bfrRXBjr4c0ZFnWtS4a46CoGZad1py6UqKNcpZFe4dT4qXe
rbteKFT+DKqPlOleMLkXwmFhZXwbbkSOGQFUt0QBUIvj9tulM2tP1NpC+lYvAFci
+DukCT1on+3G6v6YakpnToswR6xza9kW+mdAwhXkZPtyGS6m/o0=
=FLW9
-----END PGP SIGNATURE-----

--Sig_/MhEEXM=lh9cLcZUfXC+oZzA--
