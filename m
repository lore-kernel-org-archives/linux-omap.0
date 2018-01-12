From: Mark Brown <broonie@kernel.org>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 19:12:51 +0000
Message-ID: <20180112191251.GE21458@sirena.org.uk>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112190046.GD4821@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2018 at 11:00:46AM -0800, Tony Lindgren wrote:

> It's commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read
> on twl4030"). And that is for the PMIC on my test system, so
> adding Kuninori and Mark to the thread :)

> Kuninori, it seems that commit 3bb0f7c31b1a causes higher
> power consumption on an idle system on omap3 using twl4030.
> Reverting 3bb0f7c31b1a makes things behave again. My guess
> is that twl4030_read does not do the same as snd_soc_read
> in the driver?

As far as I can tell it should end up boiling down to the same thing but
I didn't follow through in detail, they should both bottom out in
twl_i2c_read_u8() if they hit hardware - all snd_soc_read() did was call
twl4030_read(), the patch just removes the indirection through assigning
the pointer.

Could you try deleting the attempt to read from the cache in
twl4030_read() and always go to hardware?

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZCLIACgkQJNaLcl1U
h9BCbAf/faTpWXhY5A8FDrn8KKPw88Vll+1F/y5su4rqWLZV0xbCflYiIsXKDjJU
hfnsx9L5P02EHG4F12VNvZkIXoOd6M8ljxIuSzsxqehfT7N7uispgqksMurea2oe
jRB/ucCy0MM7RGISHS4XFC1phL61Pn3BOJwJZ1gR21cZ491q88Ukc5p0LfdXvblz
HHUm3K51QQX6X2TzfCBWVbHxADhS3oLehQl+7yzv5s35Kk0L9B/NeqIsxuoWWRHw
xtUtWywS5lDRExMcGTGURaE6Xlp6wlz6WYX2mChhaTOAd0NGz9Pgx9V+TiAV3nCm
p/ehDA0N+ker0pVrZZsSOtSWJO9UTw==
=nckl
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
