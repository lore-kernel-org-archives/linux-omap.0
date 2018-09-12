From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Wed, 12 Sep 2018 23:49:38 +0200
Message-ID: <20180912214938.GA30654@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 09/11/2018 03:05 PM, Pavel Machek wrote:
> > On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
> >> Remove support for the LM3697 LED device
> >> from the ti-lmu.  The LM3697 will be supported
> >> via a stand alone LED driver.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >=20
> > I'd really like to see better explanation here.
> >=20
>=20
> I will update the commit message but....
>=20
> How do I politely explain that the original implementation was wrong for =
certain devices?

Implementation? Device tree is hardware description.

> How do I politely explain that this binding has information that
>  does not exist?

I don't understand this sentence.

> Isn't code and documentation supposed to be pushed in stages
> together?

Device tree is _not_ documentation. And yes, it is normally pushed
together. But that did not happen here, and bindings are already in.

Bindings are an ABI between bootloader and kernel. They should not be
changed lightly.=20

Here I believe they should be fixed; not deleted.

> Unfortunately Milo left TI before he had a chance to finish upstreaming.

Well -- I wanted to finish upstreaming. I still have those patches,
and they still look reasonably well. Better than=20

> Some issues with the current binding:
> 1) The documentation referenced in the ti-lmu.txt does not exist but the =
binding was accepted.
> [1] ../leds/backlight/ti-lmu-backlight.txt
> [2] ../leds/leds-lm3633.txt
> [3] ../regulator/lm363x-regulator.txt
>=20
> 2) ramp-up-msec and ramp-down-msec are not explained or defined in this c=
urrent binding.
> Looks to be defined in the staged code though.
>=20
> 3) The ramp-up-msec and ramp-down-msec are not the right node parameters
> the code shows ti,ramp-down-ms and ti,ramp-up-ms.  Looking at the clean u=
p of the binding
> in the staged commits the binding still does not match the code.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/com=
mit/?h=3Ddroid4-pending-v4.19&id=3Dd774c7e447ac911e73a1b3c775e6d89f0422218c
>

Bindings are authoritative. Of course, they can be fixed if really
neccessary, but normally code should be adapted to the bindings, not
the other way around.

If slow ramping up/down is something that would be expected in other
chips, too, ti, prefix is not good idea.

> 4) The ramp rates ranges are incorrect for the LM3697 it should be from 0=
 -> 117400 ms
>=20
> 5) The children compatibles are not defined in this binding but appear to=
 be removed in the staged code.
>=20
> 6) address-cells and size-cells are missing from the binding

Yep, ok, so these should be fixed. Still the bindings should be fixed,
not removed and started over.

> I am attempting to clean this up for all the dedicated LED drivers.
> There is a lot of bloat with this driver to support a single LED driver t=
hat is a single function device.
>

What about the multi function devices? They should have same binding.

> This ti-lmu driver may be a great thing for the Droid 4 but from a custom=
ers
> stand point that just wants to use just 1 of the dedicated LED drivers th=
is driver is
> overly complex and possibly hard to add code for differentiation.

The ti-lmu driver sounds like a way to go. We really want single
driver, even if more complex, than 6 separate ones.

> > We have existing binding, for lm3697 and similar devices. With this
> > series, different binding is introduced, without documented reason.
> >=20
>=20
> I can update the commit message to indicate that this device is not a MFD
> device and only is a SFD that needs to be supported by a dedicated
> driver.

Device bindings are operating systems independend. This is not an argument.

> > Now, maybe you are right and the hardware should be handled by
> > drivers/leds, not drivers/mfd. But we should have solution for all the
> > similar chips, and that still does not mean we have to modify the
> > binding. (But maybe we want to move it to different
> > directory). Bindings are supposed to describe hardware, not mirror
> > structure of our drivers.
>=20
> But this is not clean to have this device in the MFD bindings directory
> when the support is in the LEDs directory.

Perhaps location of the binding is wrong. Still not reason to drop it
and introduce new one.

> >> index c885cf89b8ce..920f910be4e9 100644
> >> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> >> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
> >>    LM3632       Backlight and regulator
> >>    LM3633       Backlight, LED and fault monitor
> >>    LM3695       Backlight
> >> -  LM3697       Backlight and fault monitor
> >> =20
> >>  Required properties:
> >>    - compatible: Should be one of:

You see? Even if your "new" binding has no flaws, "flawed" binding
still remains in tree, and we still have problems for lm3632, 3633,
3695. That's why it needs to be fixed, not replaced.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluZifIACgkQMOfwapXb+vLjqgCgkY672WQ5AXqFcoyUHSAY4VxN
8nAAni+wU410wF8iIReHojXX9IZcmPoP
=JyMt
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
