From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod code/data: fixes for v3.13-rc
Date: Mon, 9 Dec 2013 19:07:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312091906150.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab3LITHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 14:07:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13-rc/hwmod-fixes-a

for you to fetch changes up to 0e7dc862cf687234ed1b01a6b2461b782ea0bca0:

  ARM: OMAP2+: hwmod: Fix usage of invalid iclk / oclk when clock node is not present (2013-12-09 11:51:30 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: hwmod code/data: fixes for v3.13-rc

Fix a few hwmod code problems involving recovery with bad data and bad
IP block OCP reset handling.  Also, fix the hwmod data to enable IP
block OCP reset for the OMAP USBHOST devices on OMAP3+.

Basic build, boot, and PM tests are available here:

http://www.pwsan.com/omap/testlogs/prcm_fixes_a_v3.13-rc/20131209030611/

- ----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP2+: hwmod: Fix usage of invalid iclk / oclk when clock node is not present

Roger Quadros (3):
      ARM: OMAP4+: hwmod data: Don't prevent RESET of USB Host module
      ARM: OMAP2+: hwmod: Fix SOFTRESET logic
      ARM: OMAP3: hwmod data: Don't prevent RESET of USB Host module

 arch/arm/mach-omap2/omap_hwmod.c           | 45 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 ++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 12 ++------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 13 ++-------
 4 files changed, 52 insertions(+), 31 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSphSWAAoJEMePsQ0LvSpLBGwP/19ygCpEptuQk3AKY411jgXl
rGEkdGlYcoHSd03ci2LjKds7iJgDnWdpCbrtfcRBmqSChlTk1AKqs8bnkQqYpY9P
j5g3aacwROsutc74xCDJFHY0mAIQ1wfIoj5oUmM3mgX4ftKpNyYZ0gRxfPX/29eO
YwOjzXEyHeRJ20UwL41Tp24Q1O6hziCDc1N0iMa+Yzbaf1Lwbq8la7FxOdmj+6la
ex06qt0VELv9B3gQATR8lvDoFIlJ+3AVDnR5z1ODRvZqE1XKMZ7koF/La6fBqfqd
pk7Nq7x3sN3TtDQb1dkvIrCOVwqYZnjkLXZ5UNam6tTnmDkB50ttoaJIoO0t+BA5
ALRkC9ni1StKKInTCJr1ncSmzaY1xCU1ePOrcxVDOvsxvmcUBtX50d9kRAssfkze
eanyJoCBAKIgSR82vpaS4qwGsiPRU4NPPIcKvtsWzd9Oot84QvDOGvVv5730l9iU
csJWay8rba9THbBNoghg2y5P4MBtsXFxCif1kXGyp9JZCek4wQZJAiHzXxqu/DIO
QcK2uHwVNWS/vlyvoUmu3BB0p08sy5xKHm/eqwAS3bUag42vK4YI1Q6bfulXmt5W
dslDMwVf/BbbbKO8Tee3vIWVc6NNVV5NHKTRvRtL85vt2+X63Ld1oZvOBq5A/hoF
x4Gdw6dkexIhE+5YsuHN
=hGE8
-----END PGP SIGNATURE-----
