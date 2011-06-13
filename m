From: Felipe Balbi <balbi@ti.com>
Subject: Re: N900 USB fix (Was: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime
 PM implementation to use device power domains)
Date: Mon, 13 Jun 2011 11:46:04 +0300
Message-ID: <20110613084601.GB3633@legolas.emea.dhcp.ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
 <1302134569-22825-3-git-send-email-khilman@ti.com>
 <4DF0D917.905@maxwell.research.nokia.com>
 <87boy73qrs.fsf@ti.com>
 <4DF1C075.9080401@maxwell.research.nokia.com>
 <20110613112820.9ccba4ee.jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37561 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754191Ab1FMIqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 04:46:12 -0400
Received: by fxm8 with SMTP id 8so2825699fxm.26
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 01:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110613112820.9ccba4ee.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <balbi@ti.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Heikki Krogerus <ext-heikki.krogerus@nokia.com>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 13, 2011 at 11:28:20AM +0300, Jarkko Nikula wrote:
> On Fri, 10 Jun 2011 09:57:57 +0300
> Sakari Ailus <sakari.ailus@maxwell.research.nokia.com> wrote:
>=20
> > > A fix has been posted (and pull req sent to Tony.)  Can you try my
> > > for_3.0/pm-fixes branch which fixes this problem?  It's available in =
my
> > > git tree:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit
> >=20
> > Hi, Kevin!
> >=20
> > Many thanks to you! :-) The patches indeed fix the problem. I seem to
> > have used for_3.0/pm-fixes-2 branch, though. I guess that doesn't really
> > matter. :-)
> >=20
> I was struggling also with non-working musb on N900. I traced primary
> breakage to the same commit than Sakari. On top of that commit the
> Kevin's fix made it working but it didn't work on top of 3.0-rc2 while
> beagle was ok.
>=20
> I bisected another issue to commit 10299e2 ("ARM: RX-51: Enable isp1704
> power on/off").
>=20
> 3.0-rc2 works if I enable the CONFIG_CHARGER_ISP1704=3Dy but do we
> actually need to drive the ISP1704 into reset in
> board-rx51-peripherals.c: rx51_charger_init as it breaks the musb when
> the ISP1704 driver is missing and otherwise rx51_charger_set_power
> should take care of ISP1704 reset control when the driver is there?

You might want to ask from Heikki. He patched that part of the code.

--=20
balbi

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN9c5JAAoJEAv8Txj19kN19HwH/RN/wnXDTGo+pic6gXCCBx+b
YZWSG8zB0ifvTFwtTY8ioQR2WKuFbZMmVjFOUNIEUtVYI5WO+EVvPwyEeAQnZMzY
75Yt7XJWkW4f1aoJHPel2r4N7WUAMvfLdtK0BKBWeJ0V3tyJm2uF23N84E2p3ONp
EKvZ8GXHwfa523kqiQITASiOHIUzLV8vzFMqI7isAfg7gqgqXkM8OZ4cpsa/kOyo
Et4T6BxchRe4ubiIsKQ3lCuSEVtbt0RaUcr0viGwdNO4qJxfKHf8BTxUnKgc9vva
bYqwGnhx+l9ajJgLvsNVk6sgUWxBYE3yNMckIQVr6BBhaH9PjynYHQ0W+TE1TUI=
=Ix41
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
