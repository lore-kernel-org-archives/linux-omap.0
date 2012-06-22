From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM/hwmod: reimplement the OMAP PRCM I/O
 chain code for 3.6
Date: Fri, 22 Jun 2012 09:37:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206220935000.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60687 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762606Ab2FVPhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 11:37:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, vishwanath.bs@ti.com, t-kristo@ti.com, rnayak@ti.com, mohanv@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.6

for you to fetch changes up to fafcdd53220f44d7ae2f06a9ce20c8d550df2d9b:

  ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle (2012-06-22 08:40:36 -0600)

- ----------------------------------------------------------------
Reimplement the OMAP PRCM I/O chain code.  Needed for I/O wakeups to
work correctly.

- ----------------------------------------------------------------

Testing logs are at:

http://www.pwsan.com/omap/bootlogs/20120621/io_chain_devel_3.6__fafcdd53220f44d7ae2f06a9ce20c8d550df2d9b/

All the usual v3.5-rc3 issues are present; this series doesn't affect them.
N800 crashes on boot due to an MMC driver bug.  3517 boards won't NFS-mount
root and several WARN()s occur during boot.  37xx EVM and 35xx Beagle CORE
powerdomain doesn't enter retention or off-mode.  Also, on 35xx Beagle,
wakeup via the serial port does not work for off-mode system suspend.

object size (delta in bytes from v3.5-rc3 (485802a6c524e62b5924849dd727ddbb1497cc71)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
  +276 	   +16 	     0 	  +292 	am33xx_testconfig/vmlinux
  +204 	   +40 	     0 	  +244 	n800_b_testconfig/vmlinux
  +172 	   +32 	     0 	  +204 	n800_multi_omap2xxx/vmlinux
  +204 	   +40 	     0 	  +244 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
  +400 	   +16 	     0 	  +416 	omap2_4_testconfig/vmlinux
 +4372 	   +48 	     0 	 +4420 	omap2plus_defconfig/vmlinux
  +212 	    +8 	     0 	  +220 	omap2plus_no_pm/vmlinux
  +216 	   -24 	     0 	  +192 	omap3_4_testconfig/vmlinux
    +4 	   +16 	     0 	   +20 	omap3_testconfig/vmlinux
  +228 	   +72 	     0 	  +300 	omap4_testconfig/vmlinux


Kevin Hilman (1):
      ARM: OMAP2+: PRM: fix compile for OMAP4-only build

Mohan V (1):
      ARM: OMAP3: PM: correct enable/disable of daisy io chain

Rajendra Nayak (1):
      ARM: OMAP4: PRM: Add IO Daisychain support

Tero Kristo (1):
      ARM: OMAP3+: PRM: Enable IO wake up

Vishwanath BS (3):
      ARM: OMAP3: PM: Move IO Daisychain function to omap3 prm file
      ARM: OMAP3PLUS: hwmod: reconfigure IO Daisychain during hwmod mux
      ARM: OMAP3: PM: Remove IO Daisychain control from cpuidle

 arch/arm/mach-omap2/omap_hwmod.c   |   38 ++++++++++++++++++++--
 arch/arm/mach-omap2/pm34xx.c       |   44 -------------------------
 arch/arm/mach-omap2/prcm-common.h  |    8 +++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   51 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    6 ++--
 arch/arm/mach-omap2/prm44xx.c      |   63 +++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.h      |    2 ++
 7 files changed, 162 insertions(+), 50 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5JCOAAoJEMePsQ0LvSpLEaUP/0vitnlw++YkhczasWdnaeVh
mAUwrJsfbacx+zNBMyGLzaoSsWNAaVuQMHQsU83GyQ7HEQeSZJZimcW0D2gwww4g
6Gm++sKjaJ5ch2lA6SxLG5S3tZl0z3El9SqCFF4JNIJcItjZ600yMOiwZXidV5y+
9Ni/Ad1YJwC1it+aHiEevTYqJ8gxE6DceyF/3abP2wzXBcWN/XQJOmto4DxCpVO6
z4xOaY7b4+gmVnYcidAkZWRvRR5YCLB9CNDqBD8WrHjJ3Dw+nIwhigCSJfmG0M5L
pn/rH9kMenDs1xmQD8vvels5BQ6Z1gZCcfMmU8nLCwvBobGlHSHwbl63Yby3xz8O
Z8wWLgEeHKsDnCBgIkEweG6kPDQnpv3Xj/vpBILEbAK3CJuwKdXh/ngXYwCEMOTh
+9/zGKDaNNPzOOHMf14b6zIBjJmWv2kSB98IsUYDASSNd3FlAgGX2QcNUo3IXVxO
4oROrwH/2gflcEzvm+ppJb0jpH7Yx7QhAkkwlYwBOCMxKFrs9pb8oi18Rev0SB32
REXLWfJE7KlWyc0xIkujP+aD0vxv+Msb4bU7xKAvaO20ZHgSqfwSKb9O1bz8NiOL
Og+/SSVAVhZ4oa0dZ0huMedNpmKKfRsd0xUNCTbw/IyCgO+Bfy+wM8rePDbYjZyd
aHPpWYUVx62iu7TXGd7/
=nCye
-----END PGP SIGNATURE-----
