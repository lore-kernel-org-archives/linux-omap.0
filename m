From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 9 Jan 2013 22:34:56 +1100
Message-ID: <20130109223456.7832c2bd@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50ED3FA5.9030905@compulab.co.il>
	<20130109211931.0e00db5d@notabene.brown>
	<50ED4549.6080802@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/WL9HqMCKxGg0xIt+IyGjwaK"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41362 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757440Ab3AILfR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 06:35:17 -0500
In-Reply-To: <50ED4549.6080802@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

--Sig_/WL9HqMCKxGg0xIt+IyGjwaK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> Hi Neil
>=20
> On 01/09/2013 11:19 AM, NeilBrown wrote:
> > On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.co.=
il>
> > wrote:
> >=20
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >=20
> >> Hi Neil,
> >=20
> >> On 01/09/13 00:29, NeilBrown wrote:
> >>>
> >>> Hi,
> >>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
> >>>
> >>> My current stumbling block is USB.  The "Option" GSM module is attach=
ed via
> >>> USB (there is a separate transceiver chip attached to port 1 which is=
 placed
> >>> in OMAP_EHCI_PORT_MODE_PHY).
> >=20
> >> Which PHY is this (vendor/model)?
> >=20
> > Hi Igor,
> >   it is the SMSC USB3322
> >=20
> > http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
> >=20
> >=20
> > BTW I subsequently discovered that keeping USBHOST out off off_mode only
> > sometimes avoid the problem, not always.  So there are probably multiple
> > issues :-(
>=20
> Are you sure that you don't have glitch on power, reset pin during suspen=
d?
>=20

No, I don't really have the equipment to measure such things.
But is it likely?  Would enabling off_mode make it more likely?
Can you suggest some way I could test the hypothesis?

The power pin is connected to a 3v3 regulator which certainly should stay on
the whole time and other things which depend on it keep working.

The reset line is connected to GPIO174 which is configured:

# cat /sys/kernel/debug/omap_mux/mcspi1_cs0
name: mcspi1_cs0.gpio_174 (0x480021ce/0x19e =3D 0x011c), b ac2, t NA
mode: OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE4
signals: mcspi1_cs0 | sdmmc2_dat7 | NA | NA | gpio_174 | NA | NA | safe_mode

The "PIN_INPUT" seems a bit odd, so I changed it to OMAP_PIN_OUTPUT but that
didn't appear to make any difference.

Thanks,
NeilBrown

--Sig_/WL9HqMCKxGg0xIt+IyGjwaK
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUO1V4Tnsnt1WYoG5AQKHqw//R40kF1Yfzql0fzCv8ovMvduvWBdpp+qh
4fgzeKjy88+/s9+OjeOsH6NrDexHYF+NDl1QjzEwFx0tMjwY5/vU2/IdoQ4SWvcy
SO8oXWQMBKt5vyM/1g2S0rCyUfXHd/e4mo2ujmrAE9B7UrKMsDwE0evpFXG4FRVD
//4oxbDT0svpK2sN3OJdG/hap2Xvsw5BdEypdRepqStAn238DO6PrajeLcGt61kZ
SnxZJqB+BRkQaF0O0SrnLT5WsWfcnTuRgitoG6U/b6j3ATSb8yLH+218CfwNOAuQ
Z/1TZRDSHkGxTzQHiNMVZw47hAB8CIUdArnBItOeEV8YRrAgtxf0XYOk0b7gbRyp
8uQGH4FI2wZsNlSVV/yP/oXxb+soEnGRYf6ZNRD6OZYOD+iDZKdZRtXKAY0yMfGf
7jNriWyf79Kt+qGqyBQ2mHZDgKKIBwOZfsn6X2lgveT2hODH7b5dMOfZ6nEcKTMq
EGDjIHU2SVKhGlP/4a43z3zkeuM25QiFg+ubW8X5vs11F9XCklcqnnY/tLI+dHca
w58GrWYCwmeYNH44Kvu4n6CasdgNgtoNGZD1WsVZPECcOM4bjl5mHMP1qYKz48bW
vsuj6XyyS/c/K6MhXdHERPA2fE84DiZ8zY+yskr095uq987+8Dza3MjZ7BMfO5eS
Cns55z3LQbg=
=XfgN
-----END PGP SIGNATURE-----

--Sig_/WL9HqMCKxGg0xIt+IyGjwaK--
