From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: a few more clock/hwmod fixes for v3.15-rc
Date: Wed, 14 May 2014 18:52:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405141850410.21921@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46480 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaENSwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 14:52:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.15-rc/omap-fixes-b

for you to fetch changes up to 0f9e19ad88eee820f517b85531b555a0fa73e7e4:

  ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM (2014-05-14 11:25:58 -0600)

- ----------------------------------------------------------------
Two small OMAP fixes for v3.15-rc.  One fixes "slow motion" or
"choppy" audio playback on OMAP5.  The other applies an OMAP3630 fix
for clock rate setting for camera to other OMAP3 chips.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/prcm-fixes-b-v3.15-rc/20140514112639/

- ----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms

Peter Ujfalusi (1):
      ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM

 arch/arm/mach-omap2/cclock3xxx_data.c      | 3 ++-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTc7rpAAoJEMePsQ0LvSpLG6wP/RK72RBnYUULa1IgNoF9FIN6
UzNDio1EgVbXI0kbKZ9XyFvJ9l6rGHP0PZU4qPbeq+XTefCyGyxJkZR9+XV6CkI2
VhVyyvE+bPuxpgwQ4WwXTsbLgq3ZieEGN3CKvTzwq90qSa3rGkxYconMySFgItgK
242KtbTBwXGDlYtqV8/jsFXwPkVU2DSRunv/5Lb6bMlc2iHjx774wwsvnoIWMC5U
I8pH8tzUTl1qJPIYdbrqCAsbIyCZL2HcaiRQk3/DgRBOdz0n/RQOxVpM52FD44zT
ZF1BTKxdSciRfb4qd2csGQHMBejTO6hWpnKnd63tssSMQfAk5Vznwgc33IymP5P8
J5Y8Yan3hzDb9Jprl6bDqCaQUZ7S3SnpTT/RsM4AneeFRvd5xSnPwIYMuv9x6B1t
Y1Y3zUNdyey5QEkagiz0ORYYGD9+H37mGaqKrml9xLRBm5G6GAXFW1NnpBOrng5x
VvIHcTvjzZJurTxK+kM/bGZp2GFVlwYgQ3FCHpLYYvK5Ekr/iQe17iM9NjS8uKIB
RhrzdZs8fON1IVVQJU3epy4D+qdnhHZubkKgVKMwt9hTF1I0MfLhsII+R5HDdClV
FUgq3FT2mavJ+fmCXLpsOa1TWbQ/JDkHaiU8XoE/XQR77xuueHAMCTb/PkfDD+bK
e8eSwKv50t/WrbpPYqIr
=8LDA
-----END PGP SIGNATURE-----
