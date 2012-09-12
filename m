From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some Makefile cleanup for 3.7
Date: Wed, 12 Sep 2012 09:12:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209120911110.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39314 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab2ILJMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 05:12:18 -0400
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.7

for you to fetch changes up to df47adb825c221ff45126fd54e531f01ea490334:

  ARM: OMAP2+: clean up PRCM sections of the Makefile (2012-09-11 19:09:15 -0600)

- - Paul

- ----------------------------------------------------------------
Clean up and standardize several parts of
arch/arm/mach-omap2/Makefile.  Beyond readability and diffstat
improvements, the series should reduce the risk of conflicts during
future cleanups by ensuring related lines are in the same section of the
Makefile.

Test results are available here:

http://www.pwsan.com/omap/testlogs/makefile_cleanup_3.7/20120911191710/

- ----------------------------------------------------------------
object size (delta in bytes from test_v3.6-rc5 (55d512e245bc7699a8800e23df1a24195dd08217)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	2430_testconfig
     0 	     0 	     0 	     0 	5912osk_testconfig
     0 	     0 	     0 	     0 	am33xx_testconfig
    +8 	     0 	     0 	    +8 	n800_b_testconfig
    +8 	     0 	     0 	    +8 	n800_multi_omap2xxx
    +8 	     0 	     0 	    +8 	n800_testconfig
     0 	     0 	     0 	     0 	omap1510_defconfig
     0 	     0 	     0 	     0 	omap1_defconfig
   +32 	     0 	     0 	   +32 	omap2_4_testconfig
 +4104 	     0 	     0 	 +4104 	omap2plus_defconfig
    +8 	     0 	     0 	    +8 	omap2plus_defconfig_cpupm
   +16 	     0 	     0 	   +16 	omap2plus_no_pm
    -8 	     0 	     0 	    -8 	omap3_4_testconfig
    +8 	     0 	     0 	    +8 	omap3_testconfig
     0 	     0 	     0 	     0 	omap4_testconfig
     0 	     0 	     0 	     0 	rmk_omap3430_ldp_oldconfig
     0 	     0 	     0 	     0 	rmk_omap4430_sdp_oldconfig

Paul Walmsley (6):
      ARM: OMAP2+: clean up whitespace in Makefile
      ARM: OMAP2+: clean up omap_hwmod.o build directives in Makefile
      ARM: OMAP2+: move MPU INTCPS, secure monitor, SDRC build directives in Makefile
      ARM: OMAP2+: clean up OMAP4 PRM & sleep build directives in Makefile
      ARM: OMAP2+: clean up OMAP clock Makefile sections
      ARM: OMAP2+: clean up PRCM sections of the Makefile

 arch/arm/mach-omap2/Makefile |  108 +++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 64 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUFBZAAoJEMePsQ0LvSpLdcwP/1Z6XcuaHQToJtemuoNDuWxz
KkfjcakpgmgQuB3ynO3skk2BNHLkxQhMFAMwGnhWwSuLZ3sYpTwnR4CiPTgP20PR
1PrN9u4ytFVaKMENoVhp/Wg1GtDim/DMdYVzEwFZC+eEig4hUsYZSAi0RVlcyz+T
LEaDcPu2+LPXaXCjMFIO1NiU3csFS4NByAuLTBuoWkIvZO7n5/Dk8DTDojcF+KMt
ilUp86spPbJTsY7jpegHE9QWA5qfPL5ca1V/QEYMnyxKkRrs95G0eelRq8ndBC+7
/FnC9uYyQnm/9jhki4u17udBoMq3WtGDk3nQSk391JwItsaDAGOXJ4icGl/xHAI/
EW+usBDKNvLSg5iNw6yM6uTAq18wehnVqzUlIYLPBzPjChq1nuYN2jHrUyhlOGlX
fSGDqiGlov1VvQT0dcPRevXiOBuIXtdsjQPZSuKv/RrZeMUin4g153Ccn1riZFJ9
hJ6BGa91LlghzOBY9vUk2cFKWgE4LKNql2UonGFtyzKogZK0vIRAJSxOV2ERh4iv
jWqycUbHAsIJ0qoIzi/CyR0qpf4PSC8Bw1kH7QAPq5NMEK29OIdvJKLjkEH5s0OS
EgW7z+bfvSJYymVjvPRZgfEfQF25z7NZl3vcgOfzAZLgiKGnpXrvkXN7xUuulPLl
70O2+vs7c0CF6ynXnprk
=A5QQ
-----END PGP SIGNATURE-----
