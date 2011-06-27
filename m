From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] rtc-twl: Switch to using threaded irq
Date: Mon, 27 Jun 2011 18:45:06 +0200
Message-ID: <20110627164506.GA10827@earth.universe>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
 <BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
 <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
 <1305242664.2680.28.camel@work-vm>
 <4DD41BE5.4050600@kolumbus.fi>
 <20110531085139.GA7290@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:45950 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab1F0QpM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 12:45:12 -0400
Content-Disposition: inline
In-Reply-To: <20110531085139.GA7290@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, John Stultz <john.stultz@linaro.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, balajitk@ti.com, Ilkka Koskinen <ilkkakos@kolumbus.fi>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2011 at 10:51:39AM +0200, Sebastian Reichel wrote:
> > The driver is accessing to i2c bus in interrupt handler.
> > Therefore, it should use threaded irq.
> I think the patch should also remove the local_irq_enable() call in
> twl_rtc_interrupt, since it's no longer needed with threaded irq. At
> least on the Pandaboard the RTC is still working with the appended
> patch.

ping.

Currently the kernel prints a stacktrace for each rtc-twl interrupt,
because its interrupt handler enables interrupts.

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOCLOSAAoJENju1/PIO/qa75UP/RKWQyq7ySicYqR4oPAqYydz
MADkav5mc2DIsDiVvhCJO5f4EXXgSb22mmmBYRGg/cESOo8t9/gJTagta19ANBr3
LtYQz5hkXIig1ksTB+qV1DbOG0EaChu5GfFqI7W471sj4K9LYkTqLJTW3H0hHISQ
wg9Nx1iI0dtTKPD+vJpQv9ib6sEp1n5SpEkuj0tLIakeZG+sJV170FQGSWa8DJrv
tAHD5OpDXTM2Ahzb5eU6KLGLZnB5jkBtTaHrfSPPeGuf6i1iKTB1NpB3nWfDY7cO
EN6JdhlMWSHDHL8KgtN1cEuVWuDkptFtqPdR6/MEEDf3/emzB3Xg1170TbhyB1V6
w6ojLYuo/mK4o5GJt5ObqBA03DNyxL14PAvreOVlJRvKRD9Sr+xPOSeqWc56damN
pLwXfnopU37E/bMRw0dfhLA3qZ2iMrN5WPCbfExyV8kzhAK+6hoNOuSdA4TDtVtI
ZaVqTLLb2dOouUsdXh+HW810hghxAhnh0I4hKFy+B44eX2x53ui2KrhtJigvSwzr
/U8WnySsmMWYawm7VoJWYYUqSuiWcr8J6txXQIxZtTZKDdJcDbzImwLYue1rf7o7
qIJIZEdrM2epNaweto0ltuYHReSNNuFOrMyrt89YUSwiqhXXsYbt7sYY+tO5/+x3
CIo1f+0++w+jvUuNCH3f
=LlOM
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
