From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 23:33:30 +0100
Message-ID: <20181230223330.GA31362@amd>
References: <20181229094953.GA15358@amd>
 <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
 <20181229220856.GA28688@amd>
 <2e54ecb4-e104-5d1d-5e5c-274ee13b7d73@gmail.com>
 <20181230181419.GE6707@atomide.com>
 <ea54fd64-d45f-7324-c5a9-6044ff34bb23@gmail.com>
 <20181230202454.GF6707@atomide.com>
 <2c639e8b-2594-6dc6-7dc5-7fad8a81e356@gmail.com>
 <20181230212253.GG6707@atomide.com>
 <5950f965-effa-25ca-3533-de1b95923aa5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5995625038859229673=="
Return-path: <ofono-bounces-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <5950f965-effa-25ca-3533-de1b95923aa5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: mpartap-hi6Y0CQ0nG0@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, merlijn-tF0PIh4TN3odnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nekit1000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ofono-bdc2hr5oBkPYtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============5995625038859229673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>How are you handling data connections?  PPP? Or is there some other pro=
tocol
> >>to transfer packets back and forth?
> >
> >All the data connections in this case are done using QMI over USB.
> >
> >And that probably explains why I have not seen any data related
> >stuff on ts 27.010.
>=20
> Ew.  So is everything related to packet services is running over QMI?
>=20
> When Pavel explained that he wanted to use the weird squiggly AT commands=
, I
> assumed you wanted to run the packet services over AT as well.

No idea about packet data for now. I currently run them over
qmi... which means increased power consumption, I guess that's ok if
data are active.


> >>>>- GNSS/GPS is intended to be handled via oFono LocationReporting API.=
  I
> >>>>would recommend integrating this as intended...
> >>>
> >>>We have a standard kernel GNSS API now :) And we have /dev/gnss0
> >>>already working for droid 4.
> >>
> >>That's great.  But I think my recommendation still stands.  You want GPS
> >>state to be synchronized with the overall modem state, etc...
> >
> >Hmm sounds like ofono would benefit from using /dev/gnss0 in the
> >long run though. I guess the situation is similar to having
> >multiple computer mouse drivers earlier with their own interfaces
> >vs standard /dev/input :)
>=20
> Yep, agreed.  I already tried to nudge Pavel to propose something.

?

I believe that kernel doing the multiplexing and "normal" /dev/gnss0
being available to userspace is actually very nice solution.

> >Oh, I think I forgot to answer your question regarding PM,
> >there's nothing that the user space needs to except to avoid
> >polling the /dev/motmdm* devices unnecessarily. And to type
> >AT+SCRN=3D0 on /dev/motmdm1 when no notifications for signal
> >strength and network status are needed.
> >
>=20
> Right, but since /dev/motmdm1 would in theory belong exclusively to oFono,
> you probably still need some way of sending the screen 'off' command.  So=
 in
> effect you're integrating power management with the telephony stack.

I don't understand. Display power management should be separate from
ofono?

Tony: are there expected to be differences between motmdm1 and other
ttys? It does not gatchat seems to work ok with ttyUSB4, but does not
quite behave with motmdm1. Are the settings like ctsrts and baudrates
used for something?

Plus, it seems has its own subsystem, so
this is needed:

+       udev_enumerate_add_match_subsystem(enumerate, "motmdm");

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwpR7oACgkQMOfwapXb+vJ6zgCeJULQa8J4Ymg8V4vq7U3y/0aH
7yIAn3uIV1BO+dq3HdNLE8mBIrOuXvtm
=eRHu
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============5995625038859229673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5995625038859229673==--
