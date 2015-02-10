From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 10 Feb 2015 17:56:29 -0600
Message-ID: <20150210235629.GA4785@saruman.tx.rr.com>
References: <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com>
 <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
 <20150127171532.GC14878@saruman.tx.rr.com>
 <20150127171843.GD14878@saruman.tx.rr.com>
 <alpine.DEB.2.02.1501271751020.4845@utopia.booyaka.com>
 <alpine.DEB.2.02.1502102311570.3767@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbBJX5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2015 18:57:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1502102311570.3767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 10, 2015 at 11:12:40PM +0000, Paul Walmsley wrote:
> > > > > > > > hm... modulemode SWCTRL causes wait_target_ready to fail. A=
ny hints ?
> > > > > > >=20
> > > > > > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is=
 always
> > > > > > > read as 0x 12510f00 which would translate into:
> > > > > > >=20
> > > > > > > - module disabled
> > > > > > > - all opt clocks are on
> > > > > > > - module is transitioning
> > > > > > > - module in standby
> > > > > > > - clkA as TPIU and STM trace clock
> > > > > > > - all dividers set to 2
> > > > > >=20
> > > > > > just fyi, checking with HW folks, this might be a new bug, unle=
ss
> > > > > > debugss needs something special.
> > > > >=20
> > > > > If that happens on DEBUGSS disable, it's probably the same issue =
as on=20
> > > > > AM33xx:
> > > > >=20
> > > > > http://www.spinics.net/lists/arm-kernel/msg320801.html
> > > > > http://www.spinics.net/lists/arm-kernel/msg321930.html
> > > > > http://www.spinics.net/lists/arm-kernel/msg329151.html
> > > > >=20
> > > > > Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?
> > > >=20
> > > > I'll try it out in a bit...
> > >=20
> > > nope, same thing.
> > >=20
> > > [   27.633235] omap_hwmod: debugss: _wait_target_disable failed
> >=20
> > OK, looking at the code, this makes sense.  So here's what I'd suggest=
=20
> > asking the hardware team: is the right approach to:
> >=20
> > 1. keep the DEBUGSS CLKCTRL MODULEMODE bitfield at 0x2 all the time, ev=
en=20
> > when it's not in use or when entering chip low-power states, or
> >=20
> > 2. program the DEBUGSS CLKCTRL MODULEMODE bitfield to 0x0 when the DEBU=
GSS=20
> > is not in use or when entering chip low-power states, but ignore the=20
> > DEBUGSS CLKCTRL IDLEST register=20
> >=20
> > We'll need a new hwmod flag either way; the question is whether it shou=
ld=20
> > be something like HWMOD_CANNOT_DISABLE (case 1), or=20
> > HWMOD_DISABLE_IGNORE_IDLEST (case 2).
>=20
> Just checking on this.  Heard anything from the hardware team?  If not I'=
d=20
> say the HWMOD_CANNOT_DISABLE approach is probably the right one for now...

nothing from HW team yet. Last I heard is that they can reproduce the
issue, and are now digging through documentation (and maybe RTL, but I'm
speculating) to see if that should be supported or not.

=46rom my point of view, however, the thing idles, it just doesn't report
it.

--=20
balbi

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2pqtAAoJEIaOsuA1yqRE47UP/0XXLPiRAbXBmTXDU6p9rbdf
bxNydsXReJu7hbht+rska516qn7vrPY+wk8JImYoJ0MZA6B53+HXLvnd9Ht/VZKc
s5xd+v30/bsm3icZLm0/B7A+JGe8Q6zPGZCkRSa5nIu3AtDwG9coSMBmTiTFbJ7G
lQDbfbdx5zyHAPboF1LbuEKC/axE5uwFGP2dCBNdjKj1XrGGK4fhRP1B+rMo8ibP
/GOn4ARyK6xPrS/s40A55s/IijizW+Lbkfv2A+Xtax9+eUp98dbNgIOsX+70PByh
avZS/gmeNPeIRC7A8V+7Q4c5iP9LjRy1wWHBHgHtr9nAGDrRNBZj1vSO+jLW0vEO
GX6H13qgjx6rG+XDvk9vn5g/xrrtPFopawViHIg5a94Y4N/up3XAwPFAG7Zcqnad
TVA8mDwrEpIbBgQyAwKZLJZD+i3VJxNlLrKrsldVcYSOXQZ3xdLq7HE5hmRpKg54
roH9k8CqaN9eqUx14GNa8WwJ67jsYoTrV1fIk3ezW9vjE4ns+3dw7Gqo6x6qW/Cd
btuV9kJqxRnOc562JuruDhkZFo2r+C2sZOIiaNOSSaWnAc8gR6j18lqSqLvUp7rL
qFx/z5eZfN9OmGMZQTGYS1P2vITPzMW0w1adatj2skiSlVprboEqB5uuBGhx2HNn
y4vhHkUfEPlKBYFmd7LI
=2mEz
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
