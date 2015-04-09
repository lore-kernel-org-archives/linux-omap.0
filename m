From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
Date: Thu, 9 Apr 2015 14:19:14 +0200
Message-ID: <20150409121913.GB18713@earth>
References: <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
 <20150409091017.GA4526@earth>
 <20150409112943.GA31173@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150409112943.GA31173@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2015 at 01:29:43PM +0200, Pavel Machek wrote:
> On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
> > On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> > > [...]
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/gpio.h>
> > > [...]
> >=20
> > This should probably be
> >=20
> > #include <linux/of.h>
> > #include <linux/gpio/consumer.h>
>=20
> And I thought people would only bikesched paint on the
> Documentation. Sakari, feel free to change that, but

> a) I don't see why Sebastian's version is better

You neither use <linux/of_gpio.h> nor <linux/gpio.h>.

Well "include/linux/gpio.h" describes the old gpio API. The new
gpiod gpiod API is described in "include/linux/gpio/consumer.h" and
you use it, so the include should be included ;)

You don't use anything from "include/linux/of_gpio.h", but it
includes "include/linux/of.h", which you are using. So you should
include <linux/of.h> instead ;)

> b) am pretty sure there is about infinite number of
> possibilities there.

Yes, but most are wrong. You should include all headers,
that are used by you - nothing more and nothing less.

-- Sebastian

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVJm4/AAoJENju1/PIO/qakUwP/j+pIZlLYhC5zZ8T3fSP0iwy
9Kapsg9VLs8iyvc89urlzI/tfWf6i2WhDNboC9gYuQ6ivU87YeH482Er0bSPlsiM
uVXGN3PV0O1fdvbekoKWU0tjYQMywoNqJzNMeTDhXj3P08/SUspC2H23W2PK5AH6
mB7GKHZloEkqQkIC7KvStuohrwiyH81YatQVNAUPxlcrb7FsNNAbiEd2x1PbvVfj
8q0cGBjND448DkFH32QZmE5kVE8A0fmqAPSmruJqXUx1R7aucCkAHWKvXS9MGwz7
4aHibMaPEaLaMqD0aS/npgUGS8nwuI80yinzi75sXDylcFYVuURTqigaEj7+N6Hy
o3f6/zxZD8spTtPWGuu7i5CnpxmbeaGUQcuSABFR/okbloSl+gob7hzhcGB1qtHs
+284ckVrC7AyquMk+phK6qdYjC1zWQO9PmjJo44q6lvEsSRNHwe1OipaYI2gWMbI
d/cfXlVB+BkBV3SAIilmtyvGsBcDr0yRdcu6B55cmO0tHqYPPVB5GvGw0S6NnYp2
+c0mvGcpk1nNYGNUwp0tv6pDIpqdvKfE05K2jWslNzmsXjRjzsEFsObdprbfiWG1
aDp9Iiyj3ddnsAkRucTCm9W6mtp/EqVtRo2LK87HFKy68+7nx5yMhYSN7q8GtfM3
UHAXuYDzkSvGua31P8Aa
=4AM/
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
