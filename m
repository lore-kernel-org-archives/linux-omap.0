From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Fri, 11 Nov 2016 23:12:24 +0100
Message-ID: <20161111221224.GB10983@amd>
References: <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Reason #1:

> >>Hmm. So userland can read the LED state, and it can get _some_ value
> >>back, but it can not know if it is current state or not.

> Why a dedicated file? Are we going to mirror brightness here
> wrt r/w (show/store) behavior ? If not userspace now needs
> 2 open fds which is not really nice. If we are and we are
> not going to use poll for something else on brightness itself
> then why not just poll directly on brightness ?

Reason #1 is above.

Reason #2 is "if userspace sees brightness file, it can not know if
the notifications on change actually work or not".

Reason #3 is that you broke Tony's system. Polling does not make sense
when trigger such as "CPU in use" is active.

Reason #4 is that there are really two brightnesses:

1) maximum brightness trigger is going to use

2) current brightness

Currently writing to "brightness" file changes 1), but reading returns
2) when available.

So, feel free to propose better interface. One that solves #1..#4
above.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgmQkgACgkQMOfwapXb+vJtsQCfSMj/ZVQX6BFBzROSZ4Wahew3
XS8AoKVrkeJNNZwHo+3gFfpGgpU4pn7C
=HRis
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
