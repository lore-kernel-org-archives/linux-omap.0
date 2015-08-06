From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 12:23:53 +0100
Message-ID: <20150806112353.GT20873@sirena.org.uk>
References: <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="62KrrilqlZ2duPAE"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--62KrrilqlZ2duPAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:

> However, I am familiar m25p80.c and as I understand it the controller
> is basically supposed to implement m25p80.c in hardware when this flag
> is set.

But what in concrete terms is that supposed to mean?  It's currently
just an essentially undocumented flag on a message rather than something
operating at the level of a flash chip.  That's pretty much where
Russell's comments come from.

> If I was using m25p80.c to talk to anything but an actual flash chip
> it would get me quite worried.

Sure, but at the end of the day it's just emitting standard SPI messages
which don't know anything about flash.  If those messages are a sensible
interface here then why bother with the flag, we can just pattern match
on the format of the message.  If that doesn't work then probably this
isn't a great interface and a separate, application specific interface
makes more sense.

--62KrrilqlZ2duPAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw0PJAAoJECTWi3JdVIfQlDwH/RoJjV1vtBZvIz6y2rNeg6SY
/EngkfZbUpsCABFhzmUP0eF4uLs6R4JzzRaEbG02wW3XcEjn+l1eFywV4ab9iVuu
QXlEYaxK6jChxAZWps+AGHXXZ8sBOKTc3rEjX1fv5ahCgjikPZ6/q2EsahqliE+L
87r0GR+Vslu5eedlvXytMPQiepzHxLAmoWiIeyA/fRJhpSyeh1VYB/LrUWsf/2tf
B1HTFQeiYkbL2F/83qFZzEC+ODwYF08/7a/aaDQraEZ9dkTimjeLO6r9NxuF90iE
F6ivbguXfkxBSil0BaJRL2PpVf3ZWAfFxOiMbIvr1HudheTnvm+7PLDrawgiux4=
=RTgY
-----END PGP SIGNATURE-----

--62KrrilqlZ2duPAE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
