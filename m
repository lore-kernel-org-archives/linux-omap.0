From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: AM33xx: hwmod/clock: add hwmod data and some
 clock/hwmod fixes for 3.7
Date: Wed, 12 Sep 2012 16:00:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121558540.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40486 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab2ILQAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 12:00:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.7

for you to fetch changes up to e76f55a1e301c230f4a7bbef5db60ad7d90d6e94:

  ARM: AM33XX: clock: Add dcan clock aliases for device-tree (2012-09-12 09:19:54 -0600)

- ----------------------------------------------------------------
AM33xx hwmod data and miscellaneous clock and hwmod fixes.
AM33xx should now boot on mainline after this is applied, according to
Vaibhav.

Basic build, boot, and PM test transcripts are here:

http://www.pwsan.com/omap/testlogs/am33xx_hwmod_clock_devel_3.7/20120912092510/

- ----------------------------------------------------------------

object size (delta in bytes from test_v3.6-rc5 (55d512e245bc7699a8800e23df1a24195dd08217)):
  text 	  data 	   bss 	 total 	kernel
 +8972 	+16432 	   +64 	+25468 	2430_testconfig
     0 	     0 	     0 	     0 	5912osk_testconfig
 +8784 	+16440 	     0 	+25224 	am33xx_testconfig
 +8960 	+16464 	     0 	+25424 	n800_b_testconfig
 +8980 	+16408 	     0 	+25388 	n800_multi_omap2xxx
 +8960 	+16488 	     0 	+25448 	n800_testconfig
     0 	     0 	     0 	     0 	omap1510_defconfig
     0 	     0 	     0 	     0 	omap1_defconfig
 +8832 	+16488 	     0 	+25320 	omap2_4_testconfig
 +8864 	+16472 	     0 	+25336 	omap2plus_defconfig
 +8800 	+16440 	     0 	+25240 	omap2plus_defconfig_cpupm
 +8860 	+16488 	     0 	+25348 	omap2plus_no_pm
 +4712 	+16488 	   +64 	+21264 	omap3_4_testconfig
 +8956 	+16408 	     0 	+25364 	omap3_testconfig
 +8872 	+16472 	     0 	+25344 	omap4_testconfig
 +9040 	+16464 	     0 	+25504 	rmk_omap3430_ldp_oldconfig
 +4820 	+14632 	     0 	+19452 	rmk_omap4430_sdp_oldconfig

Note that the object sizes for many .configs are larger than they
should be, since CONFIG_SOC_AM33XX is selected by default during 'make
oldnoconfig'.  The next time these configs are updated, it will be
deselected - probably during the next baseline test.

Vaibhav Hiremath (4):
      ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod framework
      ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
      ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check for common functions
      ARM: AM33XX: clock: Add dcan clock aliases for device-tree

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/clkt_dpll.c              |    4 +-
 arch/arm/mach-omap2/clock33xx_data.c         |    2 +
 arch/arm/mach-omap2/dpll3xxx.c               |    4 +-
 arch/arm/mach-omap2/io.c                     |    2 +
 arch/arm/mach-omap2/omap_hwmod.c             |  178 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c   | 3381 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 8 files changed, 3569 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQULEwAAoJEMePsQ0LvSpL5tkP/AvKupNQDh4kOUko8p4ljgTB
HxndMBqUMUFvF+M5oyhzdS8+dETLUbMZqHMFtrVA81YwC1nfQy3jbfi+PRch54k1
OhK8phTowsD2og8COkdZQ2sa4DJEnE2cSZtFvkswmuPw3AHjoD4zVXhQslXUJx12
ntzha96bNJbEvzzLUgREo4zCYkTGuLkIQVFJ7XdvySsKyma3ZnKep3VuZH2ymQUP
DCKQxuPjAzic6JGGclf2hOQri0Q6bEx+LfFM3YEpdZ7eiZWVakT5XZS7tEv+gWxr
HEuX8oeUGijTCNNEqCnGKQaRgkhrm6l/HKDyyXplFI8KZT4zr442IxVbgIK8vvRg
1Yvv1qos83Mm4KV/KDaTFftnd58ca/2bUxL37+1Sf8cGAL0R5TSyinCzMBJ9qYEo
xkVoGdfs6Qeea5VY+ImnYC+pEMow9w0pykgUT5grsN/J8HjjFk7oWoSLOEbmzWf+
A+AWZwbLAcC56XkF7nKzBFZ8PeTDZu6y2maNqB5uJXV/QTe6MQ4VCAs0a6MogYVs
DKBVnsT5LgCQBXUQPchXfNY61h2erXbTq33cmPLdXzQypbmFmmkbeO6NFvEO60O/
egHgeen+wckLJblPEJ4pq+hLY23Q04Ml8btFuiMz//2fBaPOGy62nyWoc6wxlaKm
31DSw8rqS9Z4uUsdgjiI
=2rIh
-----END PGP SIGNATURE-----
