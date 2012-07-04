From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP AM33xx: clock data for 3.6
Date: Wed, 4 Jul 2012 03:25:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040323500.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39529 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab2GDJZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:25:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hvaibhav@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 6fd8246b1c1167c983b089f9eaafa13ef9ca7adf:

  Merge tag 'omap-devel-a-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-am33xx (2012-06-22 01:50:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-e-for-3.5

for you to fetch changes up to e30384abd63dfa11508a38243e1d78f1d70486b1:

  ARM: OMAP3+: clock33xx: Add AM33XX clock tree data (2012-06-29 16:16:40 -0600)

- ----------------------------------------------------------------
OMAP AM33xx clock data

- ----------------------------------------------------------------

Test logs are at:

http://www.pwsan.com/omap/testlogs/am33xx_clock_hwmod_devel_3.6/20120704015524/

All the usual v3.5-rc1 problems are visible.  Note that this branch was
not tested on an AM33xx itself, but Vaibhav Hiremath has apparently been
doing this and the patches aren't significantly changed from his.


object size (delta in bytes from test_6fd8246b1c1167c983b089f9eaafa13ef9ca7adf (6fd8246b1c1167c983b089f9eaafa13ef9ca7adf)):
  text 	  data 	   bss 	 total 	kernel
     0 	  +192 	     0 	  +192 	2430_testconfig/vmlinux
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
 +4272 	 +8000 	     0 	+12272 	am33xx_testconfig/vmlinux
     0 	  +192 	     0 	  +192 	n800_b_testconfig/vmlinux
     0 	  +160 	     0 	  +160 	n800_multi_omap2xxx/vmlinux
     0 	  +192 	     0 	  +192 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap2_4_testconfig/vmlinux
  +240 	 +8064 	     0 	 +8304 	omap2plus_defconfig/vmlinux
  +176 	 +7744 	     0 	 +7920 	omap2plus_no_pm/vmlinux
 +4272 	 +8000 	     0 	+12272 	omap3_4_testconfig/vmlinux
 +4264 	 +8192 	     0 	+12456 	omap3_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap4_testconfig/vmlinux


Paul Walmsley (1):
      ARM: OMAP3+: clock: Move common clksel_rate & clock data to common file

Vaibhav Hiremath (1):
      ARM: OMAP3+: clock33xx: Add AM33XX clock tree data

 arch/arm/mach-omap2/Makefile                  |    2 +
 arch/arm/mach-omap2/clock.h                   |   14 +
 arch/arm/mach-omap2/clock33xx_data.c          | 1105 +++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c          |   20 +-
 arch/arm/mach-omap2/clock44xx_data.c          |   72 --
 arch/arm/mach-omap2/clock_common_data.c       |   77 ++
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 8 files changed, 1205 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock33xx_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9AuSAAoJEMePsQ0LvSpL97MQAKxhDSNn0eaZRU8fBUcktg+G
ABgT6rYafascU1EwdR4xa0qi6PFbFKfN34azBVcoafbXIhz1ia3XszI3tPWRjDvV
gZRj18IAbFOmJnO634gA4vecNEU1RBIGeHCRUVz3ILPpDYI3mg0zNE/w7pysbuZa
/Su8uF09ei95vipWQswd8Mcrgm8QAN+xPHdkjjT4etl2/hsa8HXW5ofp0Yqa14VB
eSpTYrRGcyD7I8wOMp8NRFOWggcvC2sRv9yZBQUcWRMo8HPsF8x38h+CWlScUhYN
OB+Wd3/oFSyOuCmEaZ0AbEgg5LQ9zEpWutZ6Rgq/kAREalqs6rTgFYQrYcabNreA
M8yGaZCk9bnsqxwDTJfL9dlt3M3H0Rv5TbFU6C/1bpXqAyioQN/OvRQPqCCkDP8G
XerzFug0d+MwP6fWujOOPSLh2Fl4Gw54EgLQTkCalEMjLuQgZEzBo8a1IzU2kr82
bDkWjsGzwSaYlWidx4eYWaL6Esiztjj32x/JZwjPudtNIoKcTbQgjvzumoH+StFC
wR7/xnvSVQXuDIt7UGRvYdua6qyG5VjVHkzjolShGuVcz64fKUM06njsK1Ifu0up
ZLl66hEhbZx+RAW1Myu5jgUBq82VvRa8CowZy/SnVj8+15MLEYEulY4PobdKwjnp
+q6sZask4hCxc7eiqogI
=Po23
-----END PGP SIGNATURE-----
