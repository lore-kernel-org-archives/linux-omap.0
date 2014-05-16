From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some hwmod data patches for v3.16
Date: Fri, 16 May 2014 04:45:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405160444200.29738@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaEPEpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 00:45:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.16/hwmod-a

for you to fetch changes up to 433480707967187a74ced38bd38edba749998013:

  ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data (2014-05-14 12:26:10 -0600)

- ----------------------------------------------------------------
First (and possibly last) set of hwmod data changes for v3.16.  This
set should clean up some obsolete OMAP4 hwmod data, and add OMAP5 DSS
support.

Basic build, boot, and PM logs are available here:

http://www.pwsan.com/omap/testlogs/hwmod-a-v3.16/20140515210013/

- ----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP2+: hwmod: OMAP5 DSS hwmod data

Peter Ujfalusi (1):
      ARM: omap4: hwmod_data: Clean up audio related structures (remove/merge them)

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  99 +---------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 90 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdZeVAAoJEMePsQ0LvSpLlPsP/32nvu4wLWKSRfHAZFSTO3cf
MAPWwxsej9FfkOJN92Y/z6RVt8UNaIGmNTZgJr4tQMhvNuIxTM39jkl2NSB0ggJU
NlQdJkgV6M5cGhKkAC3u7+Fz7/lxsr8ml2MpBzifHGVf9zZHGrNRhwMs3r34fVz0
pGu3XGQI/LBkASW5TLfEqWrYfYCBR1dsEVLlFuUfLc+DIvpFU7z07DM577BHLlzg
17KByqWHFW3dn15JSWYgOEFicYGnD5absjSXayAw5B9gjCKrNycPEk1Tm3FePX8r
lH8cqHGJ7aiffhj2h/HkX8jUHKXNCyWkyEOzey59V8Rde1G5Rhm3dIxrlBldBS9e
Wxa16MiqMktcVf4iUbuesTPEldtqkCc39zuiRwqQ6YRotFxmCPZlI+gNKkfmcqSD
zRn+q+XoeNsh5Y9UekqfK4Cm1+NacLxmS8nxtjxaVPvkzLLX0lYubG8WRedg/501
7wCd/ubsRGeH+tSt49IItmoEYZgBysareZDxAL8oSX/7zjklaNJcR4k1uGZ8xDVU
r9MNzxBl0a/wvCz6zGY8gdpy1hbCt9uM9iXH36nopG6oXOFayTQKZlv0g/xOlyzs
gNy7ELwtVq7AVCnAPaeBy3kLbV5nOFWaTSR/jdaCfNx6oaGOVvFEzsDEU820Sd2G
WXtp0giThLDS7xBdsQc/
=seX1
-----END PGP SIGNATURE-----
