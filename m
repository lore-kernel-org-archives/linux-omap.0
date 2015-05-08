From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of hwmod fixes for v4.1-rc
Date: Fri, 8 May 2015 20:43:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505082043110.19833@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47306 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbEHUnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 16:43:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.1-rc/omap-fixes-a

for you to fetch changes up to a5bf00cd735fbc293da8a9bada589c02861c8132:

  ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality (2015-05-08 13:05:19 -0600)

- ----------------------------------------------------------------
ARM: OMAP2+: first set of hwmod fixes for v4.1-rc

Fix a few AM43xx problems: add the VPFE hwmod data, which removes some
warnings; and fix the IP block hardreset implementation.

Basic build, boot, and PM test results are here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.1-rc/20150508130543/

Note that I do not have an AM43xx board in the testbed, and thus
cannot test on that platform.

- ----------------------------------------------------------------
Benoit Parrot (1):
      ARM: AM43xx: hwmod: add VPFE hwmod entries

Tero Kristo (2):
      ARM: OMAP4+: PRM: add support for passing status register/bit info to reset
      ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality

 arch/arm/mach-omap2/omap_hwmod.c           | 68 ++++++-----------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 70 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  3 +-
 arch/arm/mach-omap2/prminst44xx.c          | 20 +++------
 4 files changed, 93 insertions(+), 68 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTR/QAAoJEMePsQ0LvSpLP2wP/RU2rQWfIuK8Yec2IBH1+Dkn
mD5xcuG+vLFI6cEzGjh91QvknoWGpt05+gPH8xrfzCLH/czNU/RTwVgAm70u+373
NjiL5qIuB7UGERuAkqmXhy0fLTRvK/kQPp7lxE9bnrCNdRQHq7jDlvpRsrSrgVn1
lbB9o9wVIroL2vnUF6LAgGY04sWsn+JG6ra/9fntMzdxjBjET0YzJW1MwE67Ur+1
Ghp/lW39nHQ4zAdK9MhsZHH3h/4yFpSVgTqHgMwd2N1qCDKnl5ozrlUS16cQO7+d
fO1DBY3bo3UcyEScVbEiC6SCiIu7cXzUhhpUJRcyt+TlK/Tm2AFdxXW8dF1Xl5UE
ZK6ET+XgHxB7cJE0wDdkQQWxGSz+87MtMqC6L8UASMsBnCak2icqgFyuC20v08JC
j744vp6yshHTQ8gB0FLXM27uUR/nLX4fpmkieqvWNpD0zeEt5eS3Kp2m+gQs2hiM
VT1eTlzblmPi8MRzimlnophy+xMoGawX2u0AZ/RzthZ4aasYmokxffVXD/nKgilo
aF77qLdPRGYWBjMt0fW3kBK/EJt34gIM/WXFqLJmmTDcK51RXgNtpBBJFAzUVw2n
bAFQoowsA4aFRsNoCwSwp1C6P6e3oZWeT6uxXewDiClHpvoWPGY3TSx1VIg40tBe
hzc7o9RL2BuifhwWYm0x
=ElB0
-----END PGP SIGNATURE-----
