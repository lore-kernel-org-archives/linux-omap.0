From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
Date: Sat, 19 Jan 2019 08:12:11 +0100
Message-ID: <20190119081211.73844b6a@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
        <20190118204204.44db353f@aktux>
        <20190118194802.GZ5544@atomide.com>
        <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QOboxb.j5kj7pmjtWLwyAwN"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, paul@pwsan.com, sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/QOboxb.j5kj7pmjtWLwyAwN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Jan 2019 12:09:48 +0530
"J, KEERTHY" <j-keerthy@ti.com> wrote:

> On 1/19/2019 1:18 AM, Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190118 19:42]: =20
> >> On Fri, 18 Jan 2019 20:38:47 +0100
> >> Andreas Kemnade <andreas@kemnade.info> wrote:
> >> =20
> >>> Hi,
> >>>
> >>> On Fri, 18 Jan 2019 10:36:30 -0800
> >>> Tony Lindgren <tony@atomide.com> wrote:
> >>>
> >>> [...] =20
> >>>> til the next workaround.
> >>>>     =20
> >>>>> That flags also causes the iclk being enabled/disabled
> >>>>> manually. =20
> >>>>
> >>>> Yes but SWSUP_IDLE for the interface clock to me currently
> >>>> just means:
> >>>>
> >>>> "manually enable and disable ocp interface clock"
> >>>>     =20
> >>> well, if we want to manually disable it and not automatically,
> >>> we have to disable autoidle or it will be automatically disabled.
> >>>
> >>> Disabling it manually when it is already auto-disabled (by autoidle) =
is
> >>> just practically a no-op towards the clock.
> >>> =20
> >>>> and with your changes it becomes:
> >>>>
> >>>> "manually enable and disable ocp interface clock and block
> >>>>   autoidle while in use".
> >>>>
> >>>> So aren't we now changing the way things behave in general
> >>>> for SWSUP_IDLE?
> >>>>     =20
> >>> Yes, we are, so proper testing is needed. But If I read those comments
> >>> it was always intended this way but not fully implemented because it
> >>> appeared to be more work like needing a usecounter (which my patchset
> >>> also adds) for that autoidle flag.
> >>> =20
> >> and there are quite few hwmods marked by this flag.
> >> And then there are those clocks marked by this flags (on am33xx) which
> >> do not have that autoidle feature at all, so the risk is not too high.=
 =20
> >=20
> > Keerthy, can you please test this series on top of the
> > related clock patches with your am335x PM test cases? =20
>=20
> Can you point me to the clock series that needs to be tested
> along with this?
>=20

https://patchwork.kernel.org/project/linux-clk/list/?series=3D66691

Regards,
Andreas


--Sig_/QOboxb.j5kj7pmjtWLwyAwN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCzcsACgkQfb1qx03i
kyRCyg/+MZv6UlN4QxGeLwJk5wnOiM/377SC6ANjD+Wzdmxoq7SctKitaPsqbKIy
/uHLgS52AzILAELttWdnldgJxeroELE1JyChE+hgb3zOcapGbKkzN5JYdc6cr6vP
RfG8GwTjDbO1BOdYKzKwDvwINmHpfr4j78/eiC0xjuI/F1tVk0KYWW7tjjmwbFQs
xSf9/6k/a0nMcTGmZtjBTdorN2qIKBNepeOSLgjj+/6j+WWA3WkiyLsqOyiDxCbU
TN+VUUDT0tPTFWzZlL3iNlv5bKGWVDBaoYyps4PYzvSlBzQHy9wVmW1KLT9VGIB1
7bRO3t15DB4eqUNI8JGxRnEto+MytVXB6qIWdhkE2lLBH7j7G3z7rV1kd/vmK+Sy
q3mgdOG13gtz2T4kKDD4Jf7Zy70pc3iyx9PgO2piptj5rJME2uYtmKRrWWJIDJ++
Y2BLPEPfVBQpUFnD56DUCdB/+Agx2db7Hmp9FPT5h/V9lWstADz+uFYgMijjBsyH
C8x2uLsXka6WkrFhq9uqB4aFYyW7tNZuXfuAQnLzK7QjXzKnr/IJStCKTz5hH9tR
tiUxiCMG81IcCtbgZOgScq1pUAsjsff+lr4xuQlr+wlBeBg1USCSNdrNylCbnHyH
ipN2p3zN/3rZWcaLPOnwkhhuPiSVnsTjOhfp6YQxj3WwQLvPPj4=
=iCUZ
-----END PGP SIGNATURE-----

--Sig_/QOboxb.j5kj7pmjtWLwyAwN--
