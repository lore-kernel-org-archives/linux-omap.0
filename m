From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: more fixes intended for 3.5-rc
Date: Wed, 4 Jul 2012 08:08:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040806270.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49936 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab2GDOIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 10:08:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-b-for-3.5rc

for you to fetch changes up to d7a0b5133f6b1d53d693b9b9873e64e3c8f0db0e:

  ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on OMAP4 (2012-07-04 06:55:29 -0600)

- ----------------------------------------------------------------
A few more OMAP fixes for 3.5-rc.  These fix some bugs with power
management and McBSP.

- ----------------------------------------------------------------

object size (delta in bytes from test_v3.5-rc5 (6887a4131da3adaab011613776d865f4bcfb5678)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	2430_testconfig/vmlinux
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
     0 	  -800 	     0 	  -800 	am33xx_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_b_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_multi_omap2xxx/vmlinux
     0 	     0 	     0 	     0 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2_4_testconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2plus_defconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2plus_no_pm/vmlinux
     0 	  -736 	     0 	  -736 	omap3_4_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap3_testconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap4_testconfig/vmlinux

Test logs are here:

http://www.pwsan.com/omap/testlogs/omap_fixes_b_3.5rc/20120704065841/

3530ES3 Beagle doesn't wake up from dynamic idle.  CORE powerdomain on
3530ES3 Beagle and 37xx EVM doesn't enter low-power states.  AM35xx
boards have the usual boot-time warnings.  All of these issues existed
on v3.5-rc5.

object size (delta in bytes from test_v3.5-rc5 (6887a4131da3adaab011613776d865f4bcfb5678)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	2430_testconfig/vmlinux
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
     0 	  -800 	     0 	  -800 	am33xx_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_b_testconfig/vmlinux
     0 	     0 	     0 	     0 	n800_multi_omap2xxx/vmlinux
     0 	     0 	     0 	     0 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2_4_testconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2plus_defconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap2plus_no_pm/vmlinux
     0 	  -736 	     0 	  -736 	omap3_4_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap3_testconfig/vmlinux
     0 	  -736 	     0 	  -736 	omap4_testconfig/vmlinux

Benoit Cousson (1):
      ARM: OMAP2+: hwmod data: Fix wrong McBSP clock alias on OMAP4

Paul Walmsley (1):
      ARM: OMAP4: hwmod data: temporarily comment out data for the usb_host_fs and aess IP blocks

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9E4TAAoJEMePsQ0LvSpLtrMP/1oQH3zcKGbWRZOZto0RuK4O
MbBFlnkJXXSlcNMhW5KNhQzROLrSltA7hv8Y4eVtpCDKYjdvpWGCdfuEn6H3mrYV
Dhq8Uk7oB46PX95s76coQOPnegocrAJmHc+stokaVB5KxwqxC6k/C/A9fAAuG3Uf
aR2+Rfv80AW66ZjgrCYbsMFrXUrzXPTIvEXNtmPrO+KXa10rthcVFUmW8OKHj9Kg
p97pTfEK9Xtmat6m6E57yE3qao3osp/FPtpAhxzc+xbs4BlArhrxPfru2KJwgquu
gzmwsE8xeVJYOz3+9Fpe7G7XZ1Lwt6+L8X0HrWXBC6R9dbeu54GwmLuflTNbR6Kd
BtZw47rYFQSqyCqtpr2bJX61tOe/jRCoo17ANkMUKroz1MdnV9Q/QTauuphrLwPr
DSFkWPkwGLtt8FI1pH9HvjWxVpcVAouJOdTHwysKx35J5gXLw2pC9Cmu1GTqEVav
aZIZdcaoLkgJ7Y2m0UouUEAXXWAN8pJ0yOlHEwXJquPkYTmd1pJFFJI3EbxRZbb6
rix2Nx/J+560orfDl1nuLGGMPU/2iMb0H9eLDhn+zdnQTuneklen8bNfTr2DEev3
A4urjs9iY8fRQmzB29A9qjIL+NnMTS8ofHkrhJLCftsbWL50shDHxAuq+geWhqgR
PGrKH29yL9HtGiY2hGYO
=KKTu
-----END PGP SIGNATURE-----
