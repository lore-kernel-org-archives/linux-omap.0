From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP AM33xx: add PRCM support (for 3.6)
Date: Mon, 18 Jun 2012 13:20:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206181319450.11642@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39177 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab2FRTUm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 15:20:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 08f3098928c991560408e8c71d4af8b1a3ff2d67:

  ARM: OMAP2+: am33xx: Add AM335XEVM machine support (2012-06-05 00:52:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.6

for you to fetch changes up to 9c80f3aa8b7828c89c5bae5c769955d1ac58630b:

  ARM: OMAP AM33xx: clockdomains: Add clockdomain data and respective operations (2012-06-18 12:08:06 -0600)

- ----------------------------------------------------------------
Adds AM33xx PRCM support

- ----------------------------------------------------------------

This branch is based on your devel-am33xx branch.

object size (delta in bytes from tmlind_devel_am33xx (08f3098928c991560408e8c71d4af8b1a3ff2d67)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
 +2364 	 +6976 	     0 	 +9340 	am33xx_testconfig/vmlinux
    +4 	  +568 	     0 	  +572 	n800_multi_omap2xxx/vmlinux
    +4 	  +576 	     0 	  +580 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
    +4 	 +2104 	     0 	 +2108 	omap2_4_testconfig/vmlinux
 +6216 	 +6944 	     0 	+13160 	omap2plus_defconfig/vmlinux
 +6276 	 +6720 	     0 	+12996 	omap2plus_no_pm/vmlinux
 +2120 	 +6560 	     0 	 +8680 	omap3_4_testconfig/vmlinux
 +2136 	 +5048 	     0 	 +7184 	omap3_testconfig/vmlinux
    +4 	 +1536 	     0 	 +1540 	omap4_testconfig/vmlinux


Vaibhav Hiremath (6):
      ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl offset
      ARM: OMAP AM33xx: voltagedomain: Add voltage domain data
      ARM: OMAP AM33xx: PRM: add PRM support
      ARM: OMAP AM33xx: CM: Introduce AM33xx CM APIs and register level details
      ARM: OMAP AM33xx: powerdomains: add AM335x support
      ARM: OMAP AM33xx: clockdomains: Add clockdomain data and respective operations

 arch/arm/mach-omap2/Makefile                  |    6 +
 arch/arm/mach-omap2/clockdomain.h             |    2 +
 arch/arm/mach-omap2/clockdomain33xx.c         |   74 +++
 arch/arm/mach-omap2/clockdomains33xx_data.c   |  196 +++++++
 arch/arm/mach-omap2/cm-regbits-33xx.h         |  687 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cm33xx.c                  |  313 +++++++++++
 arch/arm/mach-omap2/cm33xx.h                  |  420 +++++++++++++++
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/control.h                 |   39 +-
 arch/arm/mach-omap2/io.c                      |    3 +
 arch/arm/mach-omap2/powerdomain.h             |   23 +-
 arch/arm/mach-omap2/powerdomain33xx.c         |  229 +++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c   |  185 +++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h        |  357 +++++++++++++
 arch/arm/mach-omap2/prm33xx.c                 |  135 +++++
 arch/arm/mach-omap2/prm33xx.h                 |  129 +++++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 ++
 18 files changed, 2825 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/cm33xx.c
 create mode 100644 arch/arm/mach-omap2/cm33xx.h
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP338XAAoJEMePsQ0LvSpL09gQAIjd3cLj1IdNbu5JpstkFwfL
zgyhH3/1VnMJ8zYtM0M+j4JGBYVtSQ8v7Mp6cbMTyGTpxzy0h+kAb3wL+Tf2f++f
FpGGqO015n6aBAdWADcuf8ssYbgu5MmZTecfqMUuxMnNioXQkDbKREo9Srn9r/Et
987AXTaJFPMPu5JNbFDgaVi4axX+eMfHRk8vyMP5laBOOUWBVF7asq4SM2UyxAD8
s1dD8i/UX4tN7/sLDy6XHDVKLdOpR2aTitw+WQUBXwLaYObawNwVjnoZW7j+bby7
tUMaxbZTKZNE9utqYTdijYgnc3GsvjIp83jYVYfvjYcdYcc+LGoUSKpXa9ffvTj+
0dh78Zua/7lRcfhJhlaK3SLGD9UDEfGSq7tMC6tCE2YuHZp71c2Vuf9lzzzywfuT
LAzTrwkicMqPk3vDJxpgdmzxAyXCe5Qewh93Rgl9Y/Jei5sLmpMJYTGTBTV642cm
F8ykWaL9KQslqSFLoZwZ9wUlPbz4wiNhSXk2/PvCV5S4A721sQ7J67EZy7SjDW6F
gW0Mt6d0PdT7MwzqmHr+bYaeVMdgCLRbw9eC9Z6mIQ3Wyu+OTCn6b96tjrbymmy9
2PDvBXQhoCezRK6mZcrHfek7VoRd+otxvGfwakqPKj8FkAZpj6WfsnK4HSG2DF6e
ID0oP4CQFmqy4/gvUWqV
=zSRx
-----END PGP SIGNATURE-----
