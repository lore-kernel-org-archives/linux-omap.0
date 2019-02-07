From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Droid 4 modem support in kernel & ofono
Date: Thu, 7 Feb 2019 23:17:46 +0100
Message-ID: <20190207221745.GA12219@amd>
References: <20190201203616.GA2087@amd>
 <20190201205032.GF5720@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4335952957439876803=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20190201205032.GF5720-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ofono.org/mailman/options/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono/>
List-Post: <mailto:ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ofono.org/mailman/listinfo/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Sender: "ofono" <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============4335952957439876803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so I got calls and smses somehow working in kernel&ofono ... which
> > is really all I need.
>=20
> Nice :)
>=20
> I think the SIM card reading and writing should be doable
> using dlci10 /dev/motmdm10 for AT+CRSM calls..

Might be. Sorry, this is outside of my area of interest, because LTE
would not be on usable frequencies, anyway.

> > I pushed the tree to git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:pavelmachek/ofono.git , branch
> > d4... But I had to do some "rather interesting" hacks. D4 modem
> > expects packets and current kernel drivers rely on write() boundaries
> > and flush(). .. which is a bit of problem for in ofonod, as it expects
> > to work with bytestream with no explicit packet boundaries.
> >=20
> > However D4 still uses normal AT commands, so... it would be good to be
> > able to use AT parsing framework in ofono.
> >=20
> > I believe easiest solution would be to automatically do the packet
> > splitting in kernel, it should be as easy as splitting on \r and
> > ^Z. (Currently packets are only generated when \r or ^Z is seen on
> > write boundary, but that does not work well for ofono).
>=20
> OK yeah it's worth trying. I hit that issue too with the
> flush needed for droid4-sms-tools scripts. And the traffic
> we're seeing is minimal and AFAIK there's no network port
> for ts27010. And SMS messages are PDU encoded anyways.
>=20
> Hmm should we do it for \r\n and \r? Otherwise the \n
> will be left out of the packet :)

I guess splitting on \n makes sense, yes.=20

Ofono normally uses just \r. Translating it to \r\n in kernel (ttys
already do that) would be super nice, but I think this is easy enough
to handle in ofono.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxcrokACgkQMOfwapXb+vK4bwCfV/LVgMgAXt7Rt3r5EGz7Cq9V
vV8AoJcZpIFS/6ox5j6ZCvHU9VHo6GkG
=9OQ6
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============4335952957439876803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4335952957439876803==--
