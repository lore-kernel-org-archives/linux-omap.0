From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Fri, 11 Nov 2016 13:01:14 +0100
Message-ID: <20161111120114.GA1076@amd>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <20161110175537.GF27724@atomide.com>
 <20161110202910.GE28832@amd>
 <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <80b645e7-c3fa-8001-d9b1-c3c8c40394fd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-11-10 22:34:07, Jacek Anaszewski wrote:
> Hi,
>=20
> On 11/10/2016 09:29 PM, Pavel Machek wrote:
> >On Thu 2016-11-10 10:55:37, Tony Lindgren wrote:
> >>* Pavel Machek <pavel@ucw.cz> [161110 09:29]:
> >>>Hi!
> >>>
> >>>>>>>Looks like commit 883d32ce3385 ("leds: core: Add support for poll(=
)ing
> >>>>>>>the sysfs brightness attr for changes.") breaks runtime PM for me.
> >>>>>>>
> >>>>>>>On my omap dm3730 based test system, idle power consumption is ove=
r 70
> >>>>>>>times higher now with this patch! It goes from about 6mW for the c=
ore
> >>>>>>>system to over 440mW during idle meaning there's some busy timer n=
ow
> >>>>>>>active.
> >>>>>>>
> >>>>>>>Reverting this patch fixes the issue. Any ideas?
> >>>
> >>>Are you using any LED that toggles with high frequency? Like perhaps
> >>>LED that is lit when CPU is active?
> >>
> >>Yeah one of them seems to have cpu0 as the default trigger.
> >
> >Aha. Its quite obvious we don't want to notify sysfs each time that
> >one is toggled, right?
> >
> >IMO brightness should display max brightness for the trigger, as Hans
> >suggested, anything else is madness for trigger such as cpu activity.
>=20
> Are you suggesting that we should revert changes introduced
> by below patch?
>=20
> commit 29d76dfa29fe22583aefddccda0bc56aa81035dc
> Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Date:   Tue Mar 18 09:47:48 2008 +0000
>=20
>     leds: Add support to leds with readable status
>=20
>     Some led hardware allows drivers to query the led state, and this pat=
ch
>     adds a hook to let the led class take advantage of that information w=
hen
>     available.
>=20
>     Without this functionality, when access to the led hardware is not
>     exclusive (i.e. firmware or hardware might change its state behind the
>     kernel's back), reality goes out of sync with the led class' idea of
> what
>     the led is doing, which is annoying at best.

Hmm. So userland can read the LED state, and it can get _some_ value
back, but it can not know if it is current state or not.

I don't think that's a good interface. I see it is from 2008... is
someone using it? Maybe it is too late for revert.

But I'd certainly not extend it with poll.

IMO reading/polling should only be available with some triggers. It
does not make sense with "CPU load" trigger. It makes sense with
"keyboard light changeable by hardware" trigger.

Best regards,
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlglswkACgkQMOfwapXb+vI7ZACeO3OyBWqqaUCGlbfzN0DbHDEJ
MmUAoL05Ct9aqRIDEADk7n624C/yuPOx
=8sPW
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
