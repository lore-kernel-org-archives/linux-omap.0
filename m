From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] regulator: tps65910: check TPS65910_NUM_REGS at
 build time
Date: Tue, 13 Jun 2017 18:44:31 +0100
Message-ID: <20170613174431.lq3s5iyrohbegbpm@sirena.org.uk>
References: <0c5e903eed2005e39bdf7abdd1061dffc078109a.1497361550.git.mirq-linux@rere.qmqm.pl>
 <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jxl3v2id6st2v6rx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f2aee03834d8cdcc7195b9272982617d93f978dc.1497364762.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, j-keerthy@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--jxl3v2id6st2v6rx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 04:41:56PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Check TPS65910_NUM_REGS at build time instead of silently registering
> not all regulators at runtime.

Please don't send new versions of patches in reply to existing threads,
it makes it hard to figure out what the current versions of things are.

--jxl3v2id6st2v6rx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAJH4ACgkQJNaLcl1U
h9DPzQf+PewfRxzbYzzI7Ok4/3WvDzUY9PJCveeQQ8Y/v4+1eX1tKotq5r6MhPBC
Ah1xGcIqOxmUTXOS683W7bLF9tozSue40RJ8BtqYZLbLsYhln9XPCJElHQfTf+FC
06vAHeph3EcXgJnbVz4MVi/MwRtCX84LqMOSzvLfwLKq0uSOY9FHbDhjifdwbVcp
ZX5NkNLoz0+1tdfvyIIBK8bSq6YA46OdlOSdzetxqV/Hj1ffNHN1zAbH/8jSaQ8K
ntmOsUnXw7PseCbWF/VflRT7TfrKi+iDbF+17F1Cs4jcmDVuh/uNZBtZPWrujyl3
4oiVa8jIIYaQ6JibJLnw0SMRp5LWUA==
=ZkIH
-----END PGP SIGNATURE-----

--jxl3v2id6st2v6rx--
