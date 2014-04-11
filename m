From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 00/11] Fixes for omap PM for making omap3 DT only
Date: Fri, 11 Apr 2014 22:47:33 +0200
Message-ID: <20140411204732.GA17997@earth.universe>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:57771 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbaDKUrx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2014 16:47:53 -0400
Content-Disposition: inline
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, Apr 10, 2014 at 04:47:08PM -0700, Tony Lindgren wrote:
> As we're planning to make omap3 device tree only soon, I was poking
> around and noticed that PM is not working properly. As we're planning
> to drop about 20k lines of code, I just had to try to fix this so we
> know what is going on and don't have to go back. I was pretty bummed
> out to find that we've had non-working PM code in mainline for
> really long time.
>=20
> Anyways, I got the voltage scaling and N900 debug leds working, so
> with those we can notice any future regressions immediately :)

cool :)

> These are against v3.14, then you might want to also apply the
> following two patches:
>=20
> [PATCH] of/platform: Fix no irq domain found errors when populating inter=
rupts
> https://lkml.org/lkml/2014/4/10/620
>=20
> [PATCH] serial: omap: Fix missing pm_runtime_resume handling by simplifyi=
ng code
> http://www.spinics.net/lists/linux-omap/msg104782.html
>=20
> Note that for the actual voltage scaling to happen, the twl4030
> PMIC scripts are also needed. I have some uncleaned patches to
> load those based on the compatible flag, will post those
> separately. This series alone fixes the idle state signaling to
> the PMIC, so we can monitor sys_clkreq and sys_off_idle pins
> properly.
>=20
> Please review, comment and test,

I'm on vacation from tomorrow until next week's weekend, but I will
have a look the week after next (if still needed).

I have not yet read much of TWL/OMAP PM documentation, but I wonder
if it makes sense to move the powerscripting stuff into the DTS file
somehow. On a first look the added N900 tables in
drivers/mfd/twl4030-power.c seem like a step back to me.

-- Sebastian

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTSFTkAAoJENju1/PIO/qa9egP/RpVKx7DWziwy6DdmslThBdh
KVXmET6iI66vPPQXCGlXcGhuIN7i5I51NwQRaRyHHYgXJ4xXAVImb11bmjgvhhRV
gDffoGI6Q0AsB31pdzSnSJxy3KAlMaB+CBSGBj0x/ryMWShbauPfU4bgiou/d+KD
oUaBfaZ5Riyw+F3n25j9r8ceOR0iWNfAISm40VoU/cZ2D+51DPDCxA62Se89eBST
5e3vQF7A6ykK6fLmUSAziZF1uBtzAO+AU7Fl13UDbkf/+Z//0VgQCB45OlyPJ8Ea
cN1YWtriZEon9ewrWtuabUSxPM9fy1+R3Tvyzzuors+f7McGJtgSBHwF3jwtGC8k
Kl8E4REV9kn4FIo6tzOVOpsUvngI7AdZK4AOC9gyOOPDgAFU3y3hMWoW5dm6VPyH
+3Bz0DHqzNHZGsiWLFt6rojz7C8F5JeQiF3/KkRM37jfjObQjy2nGhRt5/c7+LLG
YqtRPmHUu/lr9leuy+47bZjkhF9+gQBOqlmv1qWEiL0UkHizskcJ22cG3d5gEwzo
JqKwf9E18acmOj+LFFPqIDpgMaeRVkwoNTzR2omjFlH1mDPkTEvQFHeCZwRTDJck
8gHoK9a6paT1VpI2Um3k4dQwNW4kioGL2zB5I7sylZJoOv3e9SJkBGLQgFjaR3th
Td3LQk1fykB3Yzl68Ifq
=onEC
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
