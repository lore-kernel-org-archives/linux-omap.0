From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 09:13:38 -0500
Message-ID: <20150930141338.GC31865@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1986790.syN3WBv9AR@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1986790.syN3WBv9AR@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 10:22:46AM +0200, Arnd Bergmann wrote:
> On Tuesday 29 September 2015 15:43:55 Felipe Balbi wrote:
> >=20
> > the following patches de-obfuscate arch/arm/mach-omap2/timer.c
> > and start moving code to drivers/clocksource. So far only counter32k
> > has been moved over.
> >=20
> > Note that we can't get rid of all the code (yet) because there are
> > still platforms relying to legacy boot and because of the strong
> > coupling with OMAP's hwmod layer.
> >=20
> > This is, for now, an RFC and has be written on top of [1]. Boot tested
> > with AM335x and AM437x.
> >=20
> > [1] http://marc.info/?l=3Dlinux-omap&m=3D144354336924308&w=3D2
>=20
> Looks very nice!
>=20
> > ps: if anybody has a good idea on how to get rid of
> > register_persistent_clock(), please let me know
>=20
> I don't think we want to get rid of that, because it is the more
> accurate interface. IIRC systems that have an RTC will use
> timekeeping_inject_sleeptime64() in rtc_resume(). I don't know however
> how the two methods are coordinated, i.e. how the kernel ensures that
> exactly one of the two is used, but never both.

however register_persistent_clock() is an ARM-only thing, the question
was more towards that. Do we want to continue using the ARM-only
register_persistent_clock() or is there a more generic version of it ?

--=20
balbi

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWC+4SAAoJEIaOsuA1yqREiRcQAItkPDxK7EryD3vLQQumF0PD
M/Z5paWdRlMeMC+gl1A/0OoYi13H87BM3LxcR0nVuyT9mX6Glo2thqJJo8fwBP63
E0udfhOyRxWY2VgY6bLtF+tHDDXmkqZ6OE/UWDe7xPlsp60gzG84V37ol5jia77C
1wrVIMV7MYNRjUGJAg0q5u66PSVxWCom6liPlTScB2P12bk2CH3JQp+oIZBwbFh+
JkM5CROsz2aq6nksA+8koMRj4M3Ui6WBOirvQN4ccVpztB3Xse3mEd/w4jPp4z+x
AN9wPNVo2zlG4ywW178OZ+On6CWJ9F297aE9lkTGB9jr21cWtEDWwSrv0KNsWKyk
9dUZsIAQB7Y0AD4VCUcdY9t+k8n70tgfv955oMDcH3G9/8126ioYEQSUTmGaQBBD
PzNlEzjYCgnKQ2g3ZSPrlPcqKl/u+oFgug03ovkzyasGCiPgLN9dwEXxxI7Qq0JI
94fVNRgNPXHlFqimoGX/XhG/51esuPV/rjvvzen3IMmj14k4rCE8UtoAmXwn7AJ3
qhh9WWr2XcEMH/kMqbxgyKAY87y4pxYIX4VWIaeyCSKtV3fHKdk7yI8RdtCiWIKR
LCKPtSdMxdDj0bW2HPykOZuydAJQBtc5ur46/2gm3bzl+3YVv0K/oLTZraVxQinZ
tn3B4fTvZ//6ih3Lrogz
=Yo6n
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
