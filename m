From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Wed, 5 Aug 2015 13:44:12 +0100
Message-ID: <20150805124412.GN20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rkfdwoJB1s8W8pdr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--rkfdwoJB1s8W8pdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2015 at 02:40:01PM +0200, Michal Suchanek wrote:
> On 5 August 2015 at 13:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > As far as I can tell you want to set a per spi_message flag saying that
> > the message is a flash read command?  If that's what this is trying to
> > do then why do you need to set the flag at all?  If the message is in a
> > clearly defined format and it's more efficient to use this mmap mode
> > then surely the driver can just recognise that the format is approprate
> > and switch into mmap mode without being explicitly told - I'm not clear
> > what the flag adds here.

> ehm, the read command is just one byte.

> I don't think sending 03 or other random byte as the first byte of a
> SPI transfer can be used as reliable detection that we are talking to
> a SPI flash memory.

Why care - if something is physically in the same format as a flash read
command how would a device be able to tell that it wasn't actually a
flash read command?  The signals sent on the bus are going to be
identical anyway.

--rkfdwoJB1s8W8pdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwgUbAAoJECTWi3JdVIfQ2RkH/jYBCdjmJQXi3KiNfAXn72iu
2UAZttHkB9Imo8itr3CaepTmsxifFHEXrONVCMqL6cQLduJebkc/ocQMQH5nASxH
oCR9efPj4QlxKharz0w64sGn6zUd8PqAk+1nwmIzUoUfK5bUq0Jl2HizHo6kgMzK
WvNzRzkIBo7bp+RTO+LWWI+y71z8PsJJBNsQWuJHUzPVPgk+pj4Cj0glC2FGcdet
HHEAl74ZUZLdgoZQ+SGsnfHvg7t3BdmPtdbsOjbjDXIrMKi40txym/v4D9chtDrf
f4b/n5bCGWWXROWRNXWgZchQ/B1CAH/rmfSh81rVB0S64cf942AZCKRZ8xo5W6U=
=klpL
-----END PGP SIGNATURE-----

--rkfdwoJB1s8W8pdr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
