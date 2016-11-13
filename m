From: Pavel Machek <pavel@ucw.cz>
Subject: Three different LED brightnesses (was Re: PM regression with LED
 changes in next-20161109)
Date: Sun, 13 Nov 2016 10:10:54 +0100
Message-ID: <20161113091054.GA17790@amd>
References: <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
 <20161111120114.GA1076@amd>
 <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <20161111221224.GB10983@amd>
 <3ca04742-6376-5a88-8d10-5b88fcd8f5e5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ca04742-6376-5a88-8d10-5b88fcd8f5e5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2016-11-12 09:03:42, Hans de Goede wrote:
> Hi,
>=20
> On 11-11-16 23:12, Pavel Machek wrote:
> >Hi!
> >
> >Reason #1:
> >
> >>>>Hmm. So userland can read the LED state, and it can get _some_ value
> >>>>back, but it can not know if it is current state or not.
>=20
> That is not correct, the current behavior for eading the brightness
> atrribute is to always return the current state.

No. (Because some hardware can't get back current state of
hardware-controlled leds, and because of blinking).

> >>Why a dedicated file? Are we going to mirror brightness here
> >>wrt r/w (show/store) behavior ? If not userspace now needs
> >>2 open fds which is not really nice. If we are and we are
> >>not going to use poll for something else on brightness itself
> >>then why not just poll directly on brightness ?
> >
> >Reason #1 is above.
>=20
> See my reply above.
>=20
> >Reason #2 is "if userspace sees brightness file, it can not know if
> >the notifications on change actually work or not".
>=20
> If it needs to know that it can simply check the kernel version.

No. Because in case of hardware blinking we can't provide poll()
functionality.

Plus, saying "simply check the kernel version" simply means you should
not be submitting patches to kernel... at all. (Hint... it also does
not work.)

> >Reason #3 is that you broke Tony's system. Polling does not make sense
> >when trigger such as "CPU in use" is active.
>=20
> Have you seen v4 of my patch? It fixes this while keeping the
> polling on the brightness attribute itself, it basically goes
> back (more or less) to v1 of my patch which did not have this
> problem. I never wanted notification of trigger / blinking
> changes because I already feared Tony's problem would happen.

Have you seen v67123 of my latest facebook post? It explains why you
are completely wrong.

> >Reason #4 is that there are really two brightnesses:
> >
> >1) maximum brightness trigger is going to use
> >
> >2) current brightness
> >
> >Currently writing to "brightness" file changes 1), but reading returns
> >2) when available.
>=20
> Right and Jacek has already said that we cannot change the
> reading behavior on the brightness file because of ABI concerns.

Until there's user that actually reads that, ABI can be fixed. Given
that it basically returns random value,

> >So, feel free to propose better interface. One that solves #1..#4
> >above.
>=20
> Proposal 1:
>=20
> v4 of my patch, see the list. It solves all but #4, which
> is out of scope for my patch, feel free to submit a patch to
> solve #4 (with a new sysfs attr).

NAK on that. (And it does not solve #1 and #2 at least.)

> Proposal 2:
>=20
> Add a new "user_brightness" file, which shows the last brightness
> as set by the user, this would show the read behavior we really
> want of brightness: show the real brightness when not blinking /
> triggers are active, show the brightness used when on when
> blinking / triggers are active.

No, that's just adding more mess on the system.

Here's better proposal:

brightness (write): what we do today. (Mess, but too late to change it)
	   (read): -Esomething or what we do today (if someone
	   	   	       	       	  	   acutally uses it)
           (poll): -Esomething

current_brightness (write): -Esomething, or maybe change brightness
		   for triggers that can work with that
              (read, poll): if the current trigger can get current
	             state of led, do it, otherwise -Esomething...
		     or maybe file should be simply hidden from sysfs.

trigger_max_brightness (read,write): change the maximum brightness for
		       a trigger.
	       (poll): -Esomething

If you have hardware changing the brightness behind kernel's back,
that should be modelled as a trigger. Userspace should know
there's hardware changing it autonomously ... there should be
"hardware-keylight-brightness" trigger, probably impossible to change
(depends on hardware behaviour).

On thinkpad, for example, for many LEDs kernel can select either
"hardware drives the LED", but then current_brightness is unavailable,
or "kernel drives the LED", but then hardware does not touch the led
at all.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgoLh4ACgkQMOfwapXb+vIjhwCgkiyHh+pytuFqVaT/oKvYoUp0
lxMAn38EaDs1v4w60lW7ZHYxuJXA2mAZ
=qHzJ
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
