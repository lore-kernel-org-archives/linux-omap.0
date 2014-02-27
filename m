From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Thu, 27 Feb 2014 10:18:07 +0200
Message-ID: <530EF4BF.1090507@ti.com>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk> <20140226185331.GA17632@earth.universe> <20140226212927.GB671@drone.musicnaut.iki.fi> <530EE6F2.7040903@ti.com> <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tkDseTK2Wftj2X6WbOxxoHt6rPukCIOKb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0IS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Feb 2014 03:18:27 -0500
In-Reply-To: <277ac9055a67992eb1c03e89788afebf@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@ring0.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--tkDseTK2Wftj2X6WbOxxoHt6rPukCIOKb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/02/14 10:19, Leigh Brown wrote:

> In the following commit it states that you ported the old blizzard
> driver to
> the new omapdss driver:
>=20
> commit fdcb68884b3b0def9cc410d07adbafe7c3a9e537
> Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date:   Tue May 10 17:31:20 2011 +0300
>=20
>     OMAPFB: remove old blizzard driver
>=20
>     N8x0's blizzard driver has been ported to new omapdss driver, so we=
 can
>     now remove the old blizzard driver.
>=20
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Did that driver work on the N810 at that point?  If I look at the kerne=
l
> tree
> at that point in time would all the components be there?  It would make=
 it
> easier if I had a starting point as I don't have any documentation so
> reading
> the old source code is the only way I can figure out how things work(ed=
).

Yes, that one worked, but... if I recall right, it didn't work in the
mainline version. Or more precisely, the mainline kernel didn't work on
N800 at all (at least for me).

When I did the porting (and if my memory works right) I had a big pile
of N800 patches on top of the mainline to get the board booting. And on
top of that, I made the new blizzard driver.

In fact, I possibly have the branch which I used in my backup
repository. I pushed it to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/n800-3=
9

However, looking at the log, it doesn't contain anything else than DSS
patches. So... Maybe that branch itself doesn't boot, it just contains
all the DSS related patches. I don't see any other related branches.

 Tomi



--tkDseTK2Wftj2X6WbOxxoHt6rPukCIOKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDvS/AAoJEPo9qoy8lh71UCAP/2dehTXYx0RCq94yRyDtZVf+
YMJCK0mMSko0Mtq3N3dPAngoFAccV2pI7TtU5AXVcUYnHxBB8neCJwvXG7Xks1QM
SnOvqEpMC3276fHxts89VKqvVw4MP3LdKu9Zo6pZkYlPeUOE+0Ed2+lHTTt0+0kr
iNy5qTUx5NRQuetuRmIOmoNvepsrRnq3CcHmyhhgNfUfP+/KDUIOilOkl3o1hpip
ENABFCluoWDydQaxDAml9iq40JSu78T2gvDR2bKt/KnwyeUszkr20UibSdYmrwhw
KIe3tfo7XZp105cQZ9bTh0vax/k3GCueLpcli6TGZf2Tbyc6X1RK08reBtghV29K
0Sn+7pwRMznbh5lqn0Enf8JbzsWwHWFF5w48t2azh+5SFg9BE6pklLo7KWzEboKx
kB95V35alAkjVwBDBbCyyHQ59nEvlhgRUHgd4ReiNkJTSjl5zguZnBkB3HTPVWp3
BL1jOilUXibD6Qhr0PKka0BvP1Cw4Ak5yCshxebQtSnvgGd1hdng2utZ4hiaPAWp
IgSSbN2Y0S61fAgjpebf/A0ebiXH1OHSKULF3BglrqOyXQTTBLDPVzGx1VSQCmCx
BAJCmcI056sUElQeHnr/8cWj6Mp9vUKKQBt1IG9w4VXsqvQotnZ39hTVGN93Drkz
AuFxjXYZRCWe+L1TvBp6
=lj+d
-----END PGP SIGNATURE-----

--tkDseTK2Wftj2X6WbOxxoHt6rPukCIOKb--
