From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
Date: Thu, 9 Apr 2015 11:10:17 +0200
Message-ID: <20150409091017.GA4526@earth>
References: <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150409074238.GA22603@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> [...]
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> [...]

This should probably be

#include <linux/of.h>
#include <linux/gpio/consumer.h>

-- Sebastian

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVJkH0AAoJENju1/PIO/qafC4P/3We2KzaNAxENPh00J5HWwfU
5cowtsS0OaKQHleBXQfTa18voVeRJhDwFDhle4DLAPkOu1tNUn/xlomjYhrUqaOh
tlwX4u/Mn78KmSuU3k9cKaNi/DSYf24judZU4zT/jrAUd6jv48w/sqtTdvrXb6gz
iCb1/kINGGEPGTDCliQHlHkb2E7/fxSX/3X/yYDH9k778LPs/FbcAdYwarsuAuiJ
qLwIKSjSAoV8Yn8+he4aQMrPcf91gDrloGFydVVY0r1GeZ4ZBEYVpc7LSglLklav
aYuqe1sHHOO8pfaCynodZ6IVJ9oyVqxSDjJQG9kA+L7U9uUVsgynbqhDJH0jstdg
sKPfGJwtFQ5dPIeYt2yHQQEyN36IdOxRYHEHaBrkbtL6rWV8WYXagg5LIGzywWeM
EJv7enfn2UuxJ06PUzKiGgaa2DIYniE1B2m3PtUpvT2HirM6mKwFIBCgRPWza987
Fgb/IJShXnQEMIY17LJ8HaHHzFGLS1Bu/k0YuV2XFhWADuIoa2Of4v2Sdi9qUbMj
wEr+57bEUoRKgzXdtEmT45dLMIc9B8L5aZDP6a58hQ2RTkbsPI97KbhPCCzK9CdB
oCPGqouZqbAqEjJs2biBMDu3HX0m+p0hvBezbqp8bjtFRvC0Es8hOZkdoUtlce8r
NqOdtHshvWIsNmGl3iXJ
=0Mxe
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
