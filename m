From: Felipe Balbi <balbi@ti.com>
Subject: [GIT PULL] USB Patches
Date: Wed, 18 May 2011 13:44:09 +0300
Message-ID: <20110518104407.GA13908@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50093 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756924Ab1ERKoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 06:44:16 -0400
Received: by mail-bw0-f42.google.com with SMTP id 18so3120310bwz.1
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 03:44:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

These are all supposed to go into -rc cycle but I guess we're already
too late for that (?). If so, let me know and I can add Cc:
stable@kernel.org to all of those patches so they go to stable releases
too.

The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca876f:

  Linux 2.6.39-rc7 (2011-05-09 19:33:54 -0700)

are available in the git repository at:
  master.kernel.org:/pub/scm/linux/kernel/git/balbi/usb.git for-tony

Felipe Balbi (1):
      usb: musb: am35x: fix compile error when building am35x

Hema HK (3):
      usb: musb: OMAP4430: Power down the PHY during board init
      usb: otg: OMAP4430: Fixing the omap4430_phy_init function
      usb: otg: OMAP4430: Powerdown the internal PHY when USB is disabled

 arch/arm/mach-omap2/board-am3517evm.c   |    2 +-
 arch/arm/mach-omap2/omap_phy_internal.c |    9 ++++++---
 arch/arm/mach-omap2/usb-musb.c          |   10 +++++-----
 arch/arm/plat-omap/include/plat/usb.h   |    2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

--=20
balbi

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN06L3AAoJEAv8Txj19kN1KkMH/15OeFeLO2wJsD3U9P+2a8kv
ZrETH8Lvf10l4CPcQtWS0fmJiHLXv2xgm6k01IV3xY64xUK7idcSGm6CbWeXmVFs
ReN0cRYFHpimOuPxBVOJh1eHNWmt50AceQ04CZqsAY500eFsFXVZ78bIQE3c722+
RUSrnhIidw2vCv23Jd+TznrYn/wXqIctOEe2nILPSUHHwzGw6gOpLB+4qQv2uzfT
nxcc1psfkgt42MYPVfEkyVY+P0Ub+cs9ouXHYZMjCJaoLBgfnhBFJTGtLao5CY90
AYlvMOu5YzzeE1xZXXtMIr7S746I1GWfSC87evmXp9JnP7uP2hTF8Za0nrRiIO4=
=Npzs
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
