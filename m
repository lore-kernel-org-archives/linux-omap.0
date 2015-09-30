From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 17:03:40 +0200
Message-ID: <20150930150340.GA19079@ulmo.nvidia.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20150930141338.GC31865@saruman.tx.rr.com>
 <3705422.OMk7ysE7Jn@wuerfel>
 <6944324.e1oo8C9xbx@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6944324.e1oo8C9xbx@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 04:49:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 30 September 2015 16:42:21 Arnd Bergmann wrote:
> >=20
> > TEGRA folks: the tegra_read_persistent_clock() implementation apparently
> > predates the Tegra RTC driver and I wonder if they actually do the
> > right thing in combination. Could it be that the wall time forwards
> > twice as fast as it should during resume when the RTC driver is loaded?
> > Could it be that we can simply remove  tegra_read_persistent_clock()
> > and the register_persistent_clock() infrastructure?
> >=20
>=20
> I found the 'sleeptime_injected' variable now, which takes care of
> forwarding the clock by the correct amount.
>=20
> I also found the CLOCK_SOURCE_SUSPEND_NONSTOP flag next to it, which
> should let us use the counter32k driver to provide the correct
> time during suspend without the omap_read_persistent_clock() function.
> We should be able to just delete that code.
>=20
> If we decide to also delete the tegra_read_persistent_clock()
> function, we can remove the registration too.

This was discussed a very long time ago, but I can't remember most of
the context. I found this in my inbox:

	https://lkml.org/lkml/2014/11/7/605

But I don't remember if there was an outcome or if anything came of
that. I'm currently busy with some other work, but thought I'd drop
this reference here in case somebody wants to dig into it before I
get around to it.

Thierry

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWC/nIAAoJEN0jrNd/PrOhex8P/iQH6oxefHHQWx5Gu0/sHcD9
8YuEvOAvNwccUTF5KtrcYfOOwU/V2QQKzOFiPdbdvz5zZPJlYaIWK1EgO1uv5AYD
hqlb3vVWVCY7ow2GG6CvD1rvFEp8LsssV2hvAJM1sT7pnqOJlESZIIzl6tUalGhX
iU/YGE2s0TmnzHajx/5U/rTcyKoCkxO7lWla/i94YmNG1NnNVyVgdJ+ZNT9Wks4r
PfK1jSLxTa/2yo9D5XHWMhiL+QFeHpC4K85NkJkY/WcBlikn+1l9kM0sn603Cdzu
2rkwZwzbrz91gD/BI+OWllc1Bvc/nxz9quRD/ASrPaTzTq7QjszGE/dGmycf4ELZ
/RvmP0i8F9HuQ4Vu12rI/Hz/LQEGLJZ7TtkT10B/dorPr+z/3roxo7v/gPmKfKYs
z8ZSLx6PCpXeTysKE5B3SATdm7reG4FsLgRCdrrLUP+Zhg4Qu8DkCNNbBwqMrG8Q
UOBInpbRkdvFGSGDcgdtOk9yftH4WCafziHJ0FLo6dpDrnDrVEjhabtqImnQD8Bk
pOGTAOaXakUBCRn576p4wQJQNzVSRVZnMnxVcXZ091NFurX17FUUVBWzfyGCmKN8
ga5klfuTmxUDbZ70ykasL9N0+Nn3s7Jfb7jkZMDK7plMFlSEPnJB6CaIW7ILxeJc
C+Zk043ri/IsI0z1dW4k
=d0oQ
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
