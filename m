From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/6] twl4030: Various fixes for charing-from-USB
Date: Mon, 30 Apr 2012 09:30:02 +1000
Message-ID: <20120430093002.472dfdde@notabene.brown>
References: <20120425072931.20124.56635.stgit@notabene.brown>
	<CANOLnOOQDxu-P=yTN6159XJANq-_FSCtZ4rBt69NSCPjLz1Rjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zSwXBRtVkfNvnqhYrj/p1k5"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANOLnOOQDxu-P=yTN6159XJANq-_FSCtZ4rBt69NSCPjLz1Rjw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <anton.vorontsov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/zSwXBRtVkfNvnqhYrj/p1k5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Apr 2012 14:31:13 +0300 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Wed, Apr 25, 2012 at 10:33 AM, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> wrote:
> > Following are a collection of patches that I've need using for a while
> > to make sure the charge-from-usb on my GTA04 works.
> > Hopefully I've included the right people in the recipient list :-)
>=20
> You missed the power supply maintainers - ./scripts/get_maintainer.pl
> is usually good at finding the right people, although their
> MAINTAINERS entry could be better I guess..
>=20
>=20

I guess you mean:

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:	Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>
M:	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
T:	git git://git.infradead.org/battery-2.6.git
S:	Maintained
F:	include/linux/power_supply.h
F:	drivers/power/power_supply*


get_maintainer.pl didn't find them.  The F: line seems to say they aren't
interested in individual drivers...

I'll include them if I resend.
Thanks,
NeilBrown

--Sig_/zSwXBRtVkfNvnqhYrj/p1k5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT53O+jnsnt1WYoG5AQK78RAAq6bgJypEJ3LeuH+EiEzQEWna4Gum4rsi
7qL59VkLqVEQWhgRG7kVBG0gP0xsreVPDy9J2ttDKA1CCKWKvy69m9Cn1EkPpZ9e
bC/cLmHzujjXKz02xZPMp7HlRi2bcdAxzAKcmiN9sYLPLXC8MYL+kg1/v1tKWY+Y
T7HN5MmcN32BQvelDTI0N+GDFmfRkbuvW9FpGkg+MmfRnbQTcaeGohfA1wTMcjwX
uKsgwIynypMHOt9YrxA6fGQeycIHdK5Qb6uxtBwFJEKDxaxmfdJWXSFUC6jhtZHZ
Cnx/J1h5MB3htl+MdA/IFVu5gbF7L8IxnpcCEfrRQqKVWfvveWCOQJGD2l8igzQs
Jz5N2OU/lqfZq2FjQzla0h6w2hkpn0xU2WteG3XE46r22pZBQNZee0c0TSmmzB7B
R/pG0tnwVe9stqVaSsozuoiLloz6+TwdOA7MKK2IVLhH46bBGpw3pJzyxM7Tja53
xmwoFwT8IgYzMro1tMqT6GG/tXOBQWD4P71d3/JvfLPdKiXQoBkCKxTs7aUCePra
FyJjb1C/vCR9NlyvCEJK6wTCtUzQ8WGElqwNFVs9gL03MSaUsw6fP3sd9VRbvp4Q
WimxDOiNahGevVW5Ni4Jw9fBKwFdjlzjHMLR/iKNKT9Kr+kPSw601E+sGZKPB50n
LCxqrycDCA4=
=4J7s
-----END PGP SIGNATURE-----

--Sig_/zSwXBRtVkfNvnqhYrj/p1k5--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
