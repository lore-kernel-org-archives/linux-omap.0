From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Tue, 4 Apr 2017 13:19:57 +0100
Message-ID: <20170404121957.v64jcx2k4w3mwtje@sirena.org.uk>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
 <20170328003648.GS10760@atomide.com>
 <20170328151849.uvj2ljkbts4cwksq@sirena.org.uk>
 <20170328154740.GW10760@atomide.com>
 <20170328164911.xwwl3kdy6j2y7hfq@sirena.org.uk>
 <20170328171022.GZ10760@atomide.com>
 <20170404030300.GK10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kxsjvmmaxil4dq2d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404030300.GK10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--kxsjvmmaxil4dq2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2017 at 08:03:00PM -0700, Tony Lindgren wrote:

> So I'll drop the genirq/regmap_irq related hacks and resend just
> the minimal MFD fixes. Similar misconfiguration may be the root
> cause for other drivers too..

It is sadly far too common for people to implement interrupt controllers
that only do edge triggers, I've no idea why even on what are supposed
to be relatively high end SoCs.  It seems to be a hardware designer
thing, AFAICT they think for something to be useful it needs to be a bit
more complicated.

--kxsjvmmaxil4dq2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljjj2wACgkQJNaLcl1U
h9BQRQf/e5POjRhnXx7eP53NvPZ9mfMEnFz497uRFulghlJwL7mWmckEzSsM2HBJ
KQ/YmgR2tH02FsttYMr4w62RwOZRge3mo4maqAvyxriFX4HTblyvwidq2MJig9tP
u0LmeDhI2QQSaFxhnTLUN0dHRcZx+gcd8cYDObw/lIngC0F8QCft5mp5/CVdkvfd
YKRHVfR+5BbBjhVRrYyRZsgAm42xunYCoqrPQEV2vjCze5vebU3ct/WkEJ6qJdgi
9W6/LzWfaKgaCH7RSPpmAgLd5AeoNcbeI7SUMRIjzbZWoOmF91kqrotJ8R5vMihM
JXmf7Uhp83It6j80DpS8p1lO1PHodQ==
=dPui
-----END PGP SIGNATURE-----

--kxsjvmmaxil4dq2d--
