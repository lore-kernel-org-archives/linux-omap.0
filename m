From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Mon, 31 Dec 2018 22:54:44 +0100
Message-ID: <20181231215444.GA7336@amd>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
 <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
 <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
 <20181230212253.GG6707@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5972246457978031823=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <20181230212253.GG6707-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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


--===============5972246457978031823==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Oh, I think I forgot to answer your question regarding PM,
> there's nothing that the user space needs to except to avoid
> polling the /dev/motmdm* devices unnecessarily. And to type
> AT+SCRN=3D0 on /dev/motmdm1 when no notifications for signal
> strength and network status are needed.

Is it possible that epoll() does not work properly with /dev/motmdm*?
I am debugging weird problems with ofonod, and that would be an
explanation...

epoll.poll() should be returning list of file descriptors and if they
are ready. And it seems to work for ttyUSB4 but not for motmdm.

Hmm. And motmdm_cdev_poll() lacks EPOLLOUT() support, right? That
could explain things...

Best regards,
								Pavel

Type "help", "copyright", "credits" or "license" for more information.
>>> f =3D open("/dev/ttyUSB4", "r+")
>>> f.write("AT\r\n")
>>>
>>> import select
>>> epoll =3D select.epoll()
>>> epoll.register(1, select.EPOLLOUT)
>>> epoll.register(f.fileno(), select.EPOLLOUT | select.EPOLLIN)
>>> epoll.poll(1)
[(1, 4), (3, 5)]
>>> select.EPOLLOUT
4
>>> select.EPOLLIN
1
>>> f =3D open("/dev/motmdm1", "r+")
>>> #f =3D open("/dev/ttyUSB4", "r+")
=2E.. f.write("AT\r\n")
>>>
>>> import select
>>> epoll =3D select.epoll()
>>> epoll.register(1, select.EPOLLOUT)
>>> epoll.register(f.fileno(), select.EPOLLOUT | select.EPOLLIN)
>>> epoll.poll(1)
[(1, 4)]
>>>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwqkCQACgkQMOfwapXb+vJAKgCcClRX8qnhxDatjbJc/TvADmfV
cQ0AoJMpoGSSMgkYIDHaf09sFTzhC5AT
=XRkW
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============5972246457978031823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5972246457978031823==--
