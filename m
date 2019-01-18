From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
Date: Fri, 18 Jan 2019 20:42:04 +0100
Message-ID: <20190118204204.44db353f@aktux>
References: <20190116220429.9136-1-andreas@kemnade.info>
        <20190116220429.9136-4-andreas@kemnade.info>
        <20190118154807.GV5544@atomide.com>
        <20190118181827.7163bee4@aktux>
        <20190118183630.GX5544@atomide.com>
        <20190118203832.3be7975e@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cmRBVXiaf7fgX4boBy//94_"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118203832.3be7975e@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, paul@pwsan.com, sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/cmRBVXiaf7fgX4boBy//94_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jan 2019 20:38:47 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
>=20
> On Fri, 18 Jan 2019 10:36:30 -0800
> Tony Lindgren <tony@atomide.com> wrote:
>=20
> [...]
> > til the next workaround.
> >  =20
> > > That flags also causes the iclk being enabled/disabled
> > > manually.   =20
> >=20
> > Yes but SWSUP_IDLE for the interface clock to me currently
> > just means:
> >=20
> > "manually enable and disable ocp interface clock"
> >  =20
> well, if we want to manually disable it and not automatically,
> we have to disable autoidle or it will be automatically disabled.
>=20
> Disabling it manually when it is already auto-disabled (by autoidle) is
> just practically a no-op towards the clock.
>=20
> > and with your changes it becomes:
> >=20
> > "manually enable and disable ocp interface clock and block
> >  autoidle while in use".
> >=20
> > So aren't we now changing the way things behave in general
> > for SWSUP_IDLE?
> >  =20
> Yes, we are, so proper testing is needed. But If I read those comments
> it was always intended this way but not fully implemented because it
> appeared to be more work like needing a usecounter (which my patchset
> also adds) for that autoidle flag.
>=20
and there are quite few hwmods marked by this flag.=20
And then there are those clocks marked by this flags (on am33xx) which
do not have that autoidle feature at all, so the risk is not too high.

Regards,
Andreas

--Sig_/cmRBVXiaf7fgX4boBy//94_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxCLAwACgkQfb1qx03i
kyRO7xAAwwh91blhaMQ/Mp4Os+lMhQQVtl7FMOfP3kaCWWC5kdmAe1Gk/6yYyst1
vL+zKBUSG4CW4EjVv5ihZOBP4pegYLVL851o6U2NWONNhJIi4+QIBEwZL6dRiYVi
RU7NM+AWAcpa1RMzusyUvUfusrw0vhsrHHsbzqJl0+R519fTnH9x7SeYmQBS2hZQ
aTdMLRD7BrZ+AgAN2AcLw3omXSfDB4S15hSwoV616JFTxuP50QZZM4rAVFgduUYL
zgIbSjAgM1OG71w171HH97VmxbS/rPuFDsDnSzhTMYv55/DfW9ObHZUnRnFAbFxc
2UodoKnN56uwPOUR8paJToZQ0AuVpNFyn3Td4jtd8KyD9QsIrfuYHUeLgcxbqZsT
0AbPcETW1cUnrofW5Y/d9vxjhb6L9jcmHh6mjJHlkM9Y/QQma3IUxntxuReE/su0
mffLNmAbtRD5xDylPuebvg19fnoVggcMow1BNn6/v0rB+UwpRa0m3bT+fBcBUIe5
wafau9J8Fbk0du2UbtJs291iajpps79asXpCjvrlfAnYKTUZpLJ/6D0XxKmy2k4T
lSOn2kYOv02n41AfRKQ9N9R8hQzOCDI3JaUEavyR2YGpJR4xtMpYlA80Ujxj5yUM
5tqBHdHPx5QI8YP+Fa+Rk46kVhbPsGSvr1KI9zZIj2RKfMx5naQ=
=MvR3
-----END PGP SIGNATURE-----

--Sig_/cmRBVXiaf7fgX4boBy//94_--
