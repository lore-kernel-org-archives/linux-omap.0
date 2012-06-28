From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP AM35xx: some fixes for 3.6 (fwd)
Date: Thu, 28 Jun 2012 02:20:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206280220240.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44745 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab2F1IUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 04:20:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Got the l-o list address wrong, sigh...


- Paul

---------- Forwarded message ----------
Date: Thu, 28 Jun 2012 02:19:47 -0600 (MDT)
From: Paul Walmsley <paul@pwsan.com>
To: tony@atomide.com
Cc: linux-omap@vger.kernel.com, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: OMAP AM35xx: some fixes for 3.6

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git 

for you to fetch changes up to a77e1c4d09c88f98ac2e653382d2c1861dbb736f:

  Merge branches 'am35xx_hwmod_data_fixes_a_3.6', 'am35xx_emac_mdio_devel_3.6' and 'am35xx_prcm_data_devel_3.6' into am35xx_devel_3.6 (2012-06-28 00:13:19 -0600)

- ----------------------------------------------------------------

Some OMAP AM35xx fixes.

The powerdomain and clockdomain data for the AM35xx are finally fixed.
The AM35xx EMAC/MDIO Ethernet controller integration code has been
converted to use the OMAP device and hwmod framework.  Also the UART4
and HSOTGUSB warnings have been fixed.

- ----------------------------------------------------------------

Test logs are at:

   http://www.pwsan.com/omap/testlogs/am35xx_devel_3.6/20120628014213/

On 3530ES3 Beagle, wakeup from dynamic retention idle is broken; can
be worked around by reverting commit
91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: UART: Add mechanism
to probe uart pins and configure rx wakeup").  On 3530ES3 Beagle and
37xx EVM, CORE powerdomain won't enter retention.  On 37xx EVM, CORE
powerdomain won't enter off.  On 4430ES2 Panda, the serial port prints
garbage at the end of long transmissions when dynamic idle is enabled.
All of these problems are present with stock v3.5-rc4; none of them
were added by this series.


object size (delta in bytes from test_v3.5-rc4 (6b16351acbd415e66ba16bf7d473ece1574cf0bc)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
  +124 	 +2464 	     0 	 +2588 	am33xx_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_b_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_multi_omap2xxx/vmlinux
     0 	     0 	     0 	     0 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap2_4_testconfig/vmlinux
  +104 	 +2520 	     0 	 +2624 	omap2plus_defconfig/vmlinux
  +104 	 +2200 	     0 	 +2304 	omap2plus_no_pm/vmlinux
  +104 	 +2456 	     0 	 +2560 	omap3_4_testconfig/vmlinux
  +104 	 +2488 	     0 	 +2592 	omap3_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap4_testconfig/vmlinux


Mark A. Greer (3):
      ARM: OMAP AM35x: EMAC/MDIO integration: Add Davinci EMAC/MDIO hwmod support
      ARM: OMAP AM35x: clockdomain data: Fix clockdomain dependencies
      arm: omap3: am35x: Set proper powerdomain states

Paul Walmsley (4):
      ARM: OMAP AM35xx: clock and hwmod data: fix AM35xx HSOTGUSB hwmod
      ARM: OMAP AM35xx: clock and hwmod data: fix UART4 data
      ARM: OMAP: AM35xx: fix UART4 softreset
      Merge branches 'am35xx_hwmod_data_fixes_a_3.6', 'am35xx_emac_mdio_devel_3.6' and 'am35xx_prcm_data_devel_3.6' into am35xx_devel_3.6

 arch/arm/mach-omap2/am35xx-emac.c           |   90 +++++++--------
 arch/arm/mach-omap2/clock3xxx_data.c        |   28 +++--
 arch/arm/mach-omap2/clockdomains3xxx_data.c |  157 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/cm-regbits-34xx.h       |    4 +-
 arch/arm/mach-omap2/include/mach/am35xx.h   |    2 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |  143 ++++++++++++++++++++++--
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  139 ++++++++++++++++++++++--
 arch/arm/mach-omap2/prcm-common.h           |    4 +-
 8 files changed, 471 insertions(+), 96 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7BM8AAoJEMePsQ0LvSpLwtoQAKjqee7aQanU7/8mbKqekQ9q
HQpwUoRU0tu8dfUQmXwA+OuHQSGTL7wly/McmBSvDQLusT6o3cDqUDi0b3PP64zJ
GIdBXb+0NbQyx29CkuHRBcOGAPS5m2StAwwuj2gugGt1rquMk9JHlcEZAWgjB3Yk
jLduAMf16ECF+CjZifq6lAq+Ha+TXBQg8hJMf5bgfbGFQ3ax4SEi8QvLtB9OZ4NU
nxjomr/zqwk8mlofeB1YFMPKyIFrodFWEJhoTy7HNmKlToselnSnUFapL6JuwDkC
JbU0XvYEaesZJcbGLCB0OQDgNnKKwkCLzjFaDoZViFNJ2U4JljupkHN71HZ4y+W6
SzPZDETutIxa3190NuN6LTYq8Oe+jwg+pbogKqgeODz89CKK8DbLQ6AIarkS3SX0
w+1/TcVfwQtFRg/tZANC+nT4LP98po0SU+yZA6lMiFpEjw1BgKhosJPog0Dozd5V
n/lmgGhb8KTT8KWv+iDva2PBuRN82NKISZHjc7oCPilzRBAcQm54jsEsA2KwwFaA
PQC2gB+zOWRLAyqS2xneAIlnH0cOgmGFXS0RmsSQ2AvaYrK+PQHbPgQ7Sw+vUJx1
finzAVGI5qOGZPt+L+OrSblPRdUAlLkfcTSJxYtvWlmzl3FGikGIbn1D+J3UlTbX
h4exg8Cju+199gySOwcL
=6PAM
-----END PGP SIGNATURE-----
