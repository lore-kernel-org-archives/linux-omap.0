From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sat, 29 Dec 2018 23:08:56 +0100
Message-ID: <20181229220856.GA28688@amd>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4153370453203406139=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ofono.org/mailman/options/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono/>
List-Post: <mailto:ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ofono.org/mailman/listinfo/ofono>,
 <mailto:ofono-request-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org
Sender: "ofono" <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
To: Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============4153370453203406139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

And thanks for a quick replies.

> >There's qmi and "normal" (but very buggy) AT interface on
> >them. Unfortunately that uses USB and uses too much power (which is a
> >problem on phone).
> >
> >Plus there's /dev/motmdm1, motmdm3 and motmdm9, multiplexed over
> >serial line.
>=20
> Kernel 27.010 multiplexer or something else entirely?

Kernel 27.010 multiplexer, AFAICT. Some of the endpoints are handled
in kernel (gps, audio mixer control).

> >Other major difference is that commands need to be sent to the right
> >device. It seems motmdm1 is for status and call control, and motmdm9
> >is for incoming sms.
> >
> >I guess that right way to do this is to introduce
> >drivers/motorolamodem (or can we just have drivers/motorola?).
>=20
> For some weird historic reason we called the atom drivers and thus the
> subdirectory housing the relevant sources with the 'modem' suffix.  So I
> guess we should stick to that just to be consistent.

Ok.

One more question: I guess I'll need to implement this... Is there
another example of driver doing AT commands but on multiple file
descriptors? I could really use something to look at as a template..=20

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwn8HgACgkQMOfwapXb+vIBegCfVB06xVfDJmhWfhY366Cav1wx
Ks0AoKc3eQ/f+FjyWOmZQXlg+f2E4gn2
=grxh
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============4153370453203406139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4153370453203406139==--
