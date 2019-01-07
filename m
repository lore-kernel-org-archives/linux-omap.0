From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Mon, 7 Jan 2019 18:41:26 +0100
Message-ID: <20190107174126.GA933@amd>
References: <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
 <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
 <20181230212253.GG6707@atomide.com> <20181231215444.GA7336@amd>
 <20181231222329.GI6707@atomide.com> <20190102121511.GA7002@amd>
 <20190107152908.GD5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2209202378862870204=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20190107152908.GD5544-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============2209202378862870204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > But that seems to fix a different issue from what you're seeing.
> >=20
> > Yes, I can easily work around the problem like this:
> >=20
> > It needs huge fixme there, but if you could include it... "always
> > ready" is better than "never ready".
>=20
> OK I'll take a look when I get a chance. I think all we need
> to do there is check that cdata->write_offset < cdata->write_buf_sz.

Makes sense. And you probably need to wake up userspace when buffer
was full and free space appears.

> > Have you figured out how the incoming calls are supposed to work? I'm
> > getting this on incoming call:
=2E..
> > ofonod[2534]: Voice: < ~+CIEV=3D1,4,0\n\r
> > ignoring line
> > ofonod[2534]: Voice: < ~+CLIP=3D"+420xxxxxxxxx",1,1,"",0,"",0\n\r
> > ignoring line

> > I probably could use +CLIP as "there's incoming call", but I don't see
> > anything useful when I hang up and phone should stop ringing.=20
>=20
> Parsing the number(s) from +CIEV should tell that, see what
> I added to motmdm_read_state().

+CIEV is documented as "indicator event". I can make ofono parse that,
but it will be ... slightly hacky.

Is there "RING" or something like that going on any of the interfaces?

BTW does 5.0-rc1 boot for you?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzj0YACgkQMOfwapXb+vIzgACfbINbcx4wnE/fR1iTyEU6DZCX
ZsoAoMTG+6K9V7S/w6Yx19VtNzakaxJv
=WxRC
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

--===============2209202378862870204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2209202378862870204==--
