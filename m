From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Broken builds
Date: Mon, 11 Jun 2012 20:12:02 +0300
Message-ID: <1339434722.26639.36.camel@deskari>
References: <20120603180122.GA23368@n2100.arm.linux.org.uk>
	 <20120605082218.GL12766@atomide.com> <1338902400.1952.19.camel@lappyti>
	 <20120606075758.GS12766@atomide.com>
	 <20120611160925.GB9268@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-FLplV8HMWijuKFxbjgHc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48789 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751882Ab2FKRML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 13:12:11 -0400
Received: by lbbgj10 with SMTP id gj10so2981692lbb.9
        for <linux-omap@vger.kernel.org>; Mon, 11 Jun 2012 10:12:05 -0700 (PDT)
In-Reply-To: <20120611160925.GB9268@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--=-FLplV8HMWijuKFxbjgHc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-11 at 17:09 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 06, 2012 at 12:58:00AM -0700, Tony Lindgren wrote:

> > Tomi, please have your patches sitting in linux next for at least a
> > week before they get merged. That usually shakes down bugs like these
> > before the merge window.
>=20
> Note that tested simple bug fixes _should_ be upstreamed faster than
> that where possible - such as this one.
>=20
> I'm waiting for this to hit mainline before doing any further work on
> OMAP.  That basically means I've been totally ignoring OMAP because of
> this issue for the last week.

Okay. Perhaps I should have sent the patch directly to Linus, instead of
sending a pull request to fbdev maintainer. There's always a possibility
of delays with intermediate trees.

Then again, I don't see that it's such a big problem that I'd want to
skip the normal route for patches. Sure the bug is annoying, but one can
easily avoid the bug by just enabling CONFIG_DEBUG_FS and
CONFIG_OMAP2_DSS_DEBUG_SUPPORT.

I've now improved my testing process, and I hope things will go smoother
during the next merge window. Sorry about the mess.

 Tomi


--=-FLplV8HMWijuKFxbjgHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP1ibiAAoJEPo9qoy8lh71s+sQAKmFxWsBD2SE3vngEwvJf7Sf
PvePeoDYDtDj91OTgSHcXfiM5IOBB/TIYAV9iDsIgqXklbvKteKdcXZyzkt6aH5o
0zORsehEmarWmFYexqw3de+r/Uh6Qk0ad/oKvwsRxQ3hqxIWM1PsVSvog0VgMuOV
FNJdT4d2xZlmlteAPBjS/uMXnSDPR5f89K4LDH6CfT3qp27fVGuxE7tKHrswdaIv
h5s4K5N0q0d2pL4hm8hYMaPa1R2BQnYMxwhIOz815I+3oFVgBFJj330LhgTQrVgr
MMo1rahd+WJnqfsV2LEI/TA0dTc46SOSxZdvJaQD2F+atbJ8qFVv8O4VcOs4j40N
1sSRzRs36SAX9kVWbp9W9dOcwt7oTiMSu1iVooHQVmYDSqphTfGiwO3yJRbPIzPO
SsJgYK+OZuFMSlq0Vbja4od4GUKfvajWkqMK6hus/FOH49ReYbEw4bz1+FNkhcHd
2uo06OixUsceZ3GYFcBuUs3vu4SrU8LZuOVlSegeuXwTkMiy/KsV64WH97dKgpPs
8ssFUV8FnxMXWcZv4d8rL+/LAc58PMC/h/Z4Gihgc0yuqU6JiR0R4iaYyFlzF6oY
bkUHVj2I5BTN64UEnb+A0TBY9CG+7ucnipAsGUBnVgbNn2DKlL0HcF8iGqvba8Ad
6o4nOudYP4idKFQfZcPl
=ZenO
-----END PGP SIGNATURE-----

--=-FLplV8HMWijuKFxbjgHc--

