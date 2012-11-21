From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Wed, 21 Nov 2012 13:41:38 +0200
Message-ID: <20121121114138.GB10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <87fw49cnvh.fsf@deeprootsystems.com>
 <50AA05C3.7010003@ti.com>
 <876251b2kq.fsf@deeprootsystems.com>
 <20121120231312.GP18567@atomide.com>
 <50ACA758.9070600@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382Ab2KULsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 06:48:11 -0500
Content-Disposition: inline
In-Reply-To: <50ACA758.9070600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 12:05:12PM +0200, Roger Quadros wrote:
> Hi Tony,
>=20
> On 11/21/2012 01:13 AM, Tony Lindgren wrote:
> > Hi Roger,
> >=20
> > * Kevin Hilman <khilman@deeprootsystems.com> [121119 15:24]:
> >> Roger Quadros <rogerq@ti.com> writes:
> >>
> >>> Kevin,
> >>>
> >>> On 11/16/2012 10:08 PM, Kevin Hilman wrote:
> >>>> Roger Quadros <rogerq@ti.com> writes:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> This patchset addresses the following
> >>>>>
> >>>>> - Avoid addressing clocks one by one by name and use a for loop + b=
unch
> >>>>>   of cleanups.
> >>>>> - Get number of channels/ports dynamically either from revision reg=
ister
> >>>>>   or from platform data. Avoids getting clocks that are not present.
> >>>>> - Add OMAP5 and HSIC mode (Not tested)
> >>>>> - Save power on Panda when EHCI driver is not loaded.
> >>>>>
> >>>>
> >>>> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
> >>>> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if=
 it
> >>>> fixed up the problem where CORE does not hit retention in idle when =
USB
> >>>> host is enabled, even with no devices attached.
> >>>>
> >>>> Unfortunately, it didn't help. :(
> >>>
> >>> oh that's bad. But this series wasn't meant to fix that ;).
> >>
> >> Oh, sorry.  Yeah, I didn't mean this as a nak.  Just an opportunity to
> >> complain to the maintainers that a long-standing issue needs to be
> >> addressed.
> >=20
> > It seems that drivers/mfd/omap-usb-host.c is one of the last users
> > of cpu_is_omap macros blocking enabling ARM multiplatform support for
> > omap2+.
> >=20
> > Please fix that ASAP as early as possible in this patch series to
> > remove the dependencies between core omap code development and driver
> > development.
> >=20
> > Basically you need to remove #include <plat/cpu.h> and pass the
> > revision information in platform data (and device tree compatible
> > flag when that is supported).
> >=20
>=20
> Okay I'll send a patch to fix that ASAP.
>=20
> Felipe, any comments on the patches in this series?

I'm waiting for Keshava's comments since he's the one who has been
dealing with omap usb host the most. I can look into this series too
shortly.

--=20
balbi

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrL3yAAoJEIaOsuA1yqREagwQALNjRsgl0FMjNYgaNCYvtMBF
klASfuQXxUhGVkosJn/H33y5ZBB1NqzilMIj/rkusvsVbd3x9T6JoTQrN0frZ/SA
NLF+x/9Z6EH9LOFLiPE147EDNz9/7w1ntIEF4Kp3o2jFIT7e/maxBoE31fNewzgm
DlURZicJyRtQvQTYvq/k2n2CQPq4DatLmQJEYu/Zm6odh7Y8XHlYtXw4w4X0qTQU
9BTwlbJkd9aNoGkjnMdClmCmQfYLBtMsB42xjiDTgIJdIBNJCWJLPcoECktKTEab
vxkY3BdBcfPNuKCIlZJX6ajS3W0EClP7qgBlM50goAkVXzQkTIezkolhOw8rafqP
PonTH6lb1DVWHH5Rt3rzRLO38bGSqukjW+kU1jGzH7MXW5yjTaBfjNJB5PVuD7wC
BHm7G+/6QrER3vyTVG3TlpVIk0QBLcGVJysegvl1euMw2ri/PG1apZXbQuzMJOoU
bWpilfZNsqOkOcAUAastXcEUNeaHiAxW7xnSqwyIiml5qZHKWnjvWOxCLLAz9YEI
d3/kqDZlV82oZhSetpQOhHLc3Hzpp/qsk8k9X1r7Z5RSTikEQe3bzlyYOZUCn8QS
OmUfx/FMI3ZAwgtytm5UV25o/O6VbFV4/F06Zimnl6IxbjLzjNvynh1LFtaqiyjw
lvAfCjjcmkjt+iqJUxIn
=vPGD
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
