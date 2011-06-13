From: Felipe Balbi <balbi@ti.com>
Subject: Re: N900 USB fix (Was: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime
 PM implementation to use device power domains)
Date: Mon, 13 Jun 2011 11:47:48 +0300
Message-ID: <20110613084746.GC3633@legolas.emea.dhcp.ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
 <1302134569-22825-3-git-send-email-khilman@ti.com>
 <4DF0D917.905@maxwell.research.nokia.com>
 <87boy73qrs.fsf@ti.com>
 <4DF1C075.9080401@maxwell.research.nokia.com>
 <20110613112820.9ccba4ee.jhnikula@gmail.com>
 <20110613084601.GB3633@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51464 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754570Ab1FMIry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 04:47:54 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so2541128fxm.25
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 01:47:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110613084601.GB3633@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Heikki Krogerus <heikki.krogerus@nokia.com>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 13, 2011 at 11:46:04AM +0300, Felipe Balbi wrote:
> On Mon, Jun 13, 2011 at 11:28:20AM +0300, Jarkko Nikula wrote:
> > On Fri, 10 Jun 2011 09:57:57 +0300
> > Sakari Ailus <sakari.ailus@maxwell.research.nokia.com> wrote:
> >=20
> > > > A fix has been posted (and pull req sent to Tony.)  Can you try my
> > > > for_3.0/pm-fixes branch which fixes this problem?  It's available i=
n my
> > > > git tree:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-=
pm.git
> > >=20
> > > Hi, Kevin!
> > >=20
> > > Many thanks to you! :-) The patches indeed fix the problem. I seem to
> > > have used for_3.0/pm-fixes-2 branch, though. I guess that doesn't rea=
lly
> > > matter. :-)
> > >=20
> > I was struggling also with non-working musb on N900. I traced primary
> > breakage to the same commit than Sakari. On top of that commit the
> > Kevin's fix made it working but it didn't work on top of 3.0-rc2 while
> > beagle was ok.
> >=20
> > I bisected another issue to commit 10299e2 ("ARM: RX-51: Enable isp1704
> > power on/off").
> >=20
> > 3.0-rc2 works if I enable the CONFIG_CHARGER_ISP1704=3Dy but do we
> > actually need to drive the ISP1704 into reset in
> > board-rx51-peripherals.c: rx51_charger_init as it breaks the musb when
> > the ISP1704 driver is missing and otherwise rx51_charger_set_power
> > should take care of ISP1704 reset control when the driver is there?
>=20
> You might want to ask from Heikki. He patched that part of the code.

used wrong mail address for Heikki, fixing.

--=20
balbi

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN9c6yAAoJEAv8Txj19kN10DcIAIALcGYJd2RIUim5n2gsea0P
SwWbPN03w05L5H0Ui+2YyoIsWCNUEBRAsBxll9RgnMr6A8fGLbSbBzpii9RNLkoA
wsIy/drNY/xBOvYno1WyQBpqd7ObMAtdWHHzVm+CNLF929WYGfjG+4odT2FMrvcK
dYLDILDGkpx4/7cpnspmZCbxvKSajBe00zPcWXZ09D1e8WilfhGm6595K6OuKyBs
PGrpMwRX9fcQOJDtc87VxZpne1QuTzy/oxK/G8M1TMdO3lNZvEvguuDsvltAQvic
M8w8Q0J3NERylobhJC9wYyE6WMo25Z1eej/xx6MhLHuXaWSUHdBJSZLkW/5Re9U=
=PcJ5
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
