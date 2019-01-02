From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Wed, 2 Jan 2019 13:15:11 +0100
Message-ID: <20190102121511.GA7002@amd>
References: <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
 <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
 <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
 <20181230212253.GG6707@atomide.com> <20181231215444.GA7336@amd>
 <20181231222329.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0346353599517422826=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181231222329.GI6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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


--===============0346353599517422826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-31 14:23:29, Tony Lindgren wrote:
> * Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> [181231 21:54]:
> > Is it possible that epoll() does not work properly with /dev/motmdm*?
> > I am debugging weird problems with ofonod, and that would be an
> > explanation...
> >=20
> > epoll.poll() should be returning list of file descriptors and if they
> > are ready. And it seems to work for ttyUSB4 but not for motmdm.
> >=20
> > Hmm. And motmdm_cdev_poll() lacks EPOLLOUT() support, right? That
> > could explain things...
>=20
> Hmm yeah maybe.
>=20
> FYI, I just pushed a test script into github droid4-sms-tools repo
> for sending SMS and a related kernel fix for ctrl-z termination
> into k.o droid4-pending-mdm-v4.20 branch.
>=20
> But that seems to fix a different issue from what you're seeing.

Yes, I can easily work around the problem like this:

It needs huge fixme there, but if you could include it... "always
ready" is better than "never ready".

I'm currently adding code to ofono... I can decode incoming
SMS. Current is here. https://github.com/pavelmachek/ofono

Have you figured out how the incoming calls are supposed to work? I'm
getting this on incoming call:

ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+CIEV=3D1,4,0\n\r
ignoring line
ofonod[2534]: Voice: < ~+CLIP=3D"+420xxxxxxxxx",1,1,"",0,"",0\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+CIEV=3D1,0,0\n\r
ignoring line

ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r

I probably could use +CLIP as "there's incoming call", but I don't see
anything useful when I hang up and phone should stop ringing.=20

Best regards,
								Pavel


diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index 2cdc9e8..abf58e3 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -706,6 +706,7 @@ static __poll_t motmdm_cdev_poll(struct file *file, pol=
l_table *wait)
 		mask |=3D EPOLLIN | EPOLLRDNORM;
 	if (cdata->disconnected)
 		mask |=3D EPOLLHUP;
+	mask |=3D (EPOLLOUT | EPOLLWRNORM);
=20
 	return mask;
 }

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwsq08ACgkQMOfwapXb+vJTfgCgvhxtQDYSFP6ioyWnYHMPvqpN
EC0AnRxIG1ow1qlr2Dz+PgHwqbhh8SoO
=HOlZ
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============0346353599517422826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0346353599517422826==--
