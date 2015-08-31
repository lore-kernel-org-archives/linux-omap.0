From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: add runtime PM to set_cs()
Date: Mon, 31 Aug 2015 15:25:08 +0100
Message-ID: <20150831142508.GN12027@sirena.org.uk>
References: <1437590769-14632-1-git-send-email-sre@kernel.org>
 <20150724163946.GN11162@sirena.org.uk>
 <55E31701.7050807@bitmer.com>
 <20150830164444.GA22471@deathstar>
 <20150831085355.GF12027@sirena.org.uk>
 <20150831134645.GA11095@deathstar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dalTE8IaBbGRX0ud"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150831134645.GA11095@deathstar>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--dalTE8IaBbGRX0ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 08:46:46AM -0500, Michael Welling wrote:
> On Mon, Aug 31, 2015 at 09:53:55AM +0100, Mark Brown wrote:
> > On Sun, Aug 30, 2015 at 11:44:45AM -0500, Michael Welling wrote:

> > > The patch is currently sitting in linux-next.

> > > Not sure why it wasn't merged with 4.2.0-rc8.

> > You didn't indicate that it was a bug fix for Linus rather than a fix
> > for recent development :(

Ah, actually it did get applied as a fix - it's just that I didn't send
a pull request before v4.3 got released.  Looking at what's there I
wasn't comfortable with the volume of fixes that arrived and never got
round to picking out those that were most urgent.  Sorry, these things
do happen from time to time I'm afraid especially when I'm travelling,
if something is urgent it's good to verify around -rc6 or so.

> Sorry, I did not know that it was my responsibility.

> How do I indicate this for future reference?

> The patch that Sebastian sent said the following:

> "
> Michael also tested the patch, but have not explicitly written an
> Tested-By, so you may want to wait for feedback from him. The patch
> should be sent for 4.2-rc, which introduced the regression.
> "

That's not in the changelog which is all I have after the patch is
applied (and what I was looking at since I just pulled the commit up by
ID).  If something is in Linus' tree it's often helpful to say
"...introduced in v4.2-rc1" or similar in the changelog.  Though in this
case it wasn't the issue.

--dalTE8IaBbGRX0ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5GPDAAoJECTWi3JdVIfQ0CgH/jbSWk6NeyiCuU091WEPvWPw
Cjm3nWg8F52QPFtG1XYJ7xYhp2SVAByNX5IHsNZ0921fzzNQAZbA5eokTjUfA+uW
r8KznToxsM7VtWDOt/49RsXbWp299tmE0Zkiz3euD/5emKbWsaiKB2OB4rR+tw+f
kGpWDrQ26+QiD1tUgXKAf/2UKI/YO12qJJJErGuGeY9gHDXK1Uc4aUdA0Xc7uIcA
8jUvBgQLQeKiPyo49WGQtLi3mQOas3HyLIcYdAls811it06iehyFRtANgGU8lzib
UvIqLdZQbfJYeos6ZhEcq9ZnLR3wQS24FzSy+ExK3AvL5h/wTA1FuWHLZP5nZ7A=
=KyD4
-----END PGP SIGNATURE-----

--dalTE8IaBbGRX0ud--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
