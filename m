From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: add most of the remaining OMAP4
 hwmods
Date: Thu, 19 Apr 2012 14:29:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204191428550.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-471955330-1334867391=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37457 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab2DSU3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 16:29:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-471955330-1334867391=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 3af35fbcd088e0b675fa423a879c596384894180=
:

  ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-04-1=
9 04:25:08 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-=
devel-a-for-3.5

for you to fetch changes up to 96566043b19ae76d3828ce75cbf28dc6d0bcaaf1:

  ARM: OMAP4: hwmod data: add DEBUGSS skeleton (2012-04-19 13:33:59 -0600)

- ----------------------------------------------------------------
Add in most of the remaining hwmods (IP block descriptions) for the
OMAP44xx family of SoCs.  There still seem to be a few missing, such
as those for the MMU IP blocks, but this seems to cover the bulk of
the remainder.

- ----------------------------------------------------------------

This is based on top of the hwmod cleanup for 3.5 tag.

This series has been boot-tested on N800, 2430SDP, CM-T3517, 3530ES3
Beagle, 3730ES1.2 EVM, and 4430ES2 Panda.  System suspend entry and
exit (via UART wakeup) was tested on 3530ES3 Beagle and 4430ES2 Panda.
Dynamic idle entry and exit (via UART wakeup) was tested on 3530ES3
Beagle.  Logs of this testing are available at

    http://www.pwsan.com/omap/bootlogs/20120419/omap4_hwmod_devel_a_3.5__96=
566043b19ae76d3828ce75cbf28dc6d0bcaaf1/


- - Paul

- ---

object size (delta in bytes from hwmod_cleanup_a_3.5 (3af35fbcd088e0b675fa4=
23a879c596384894180)):
 text =09 data =09  bss =09total =09kernel
    0 =09    0 =09    0 =09    0 =095912osk_testconfig/vmlinux
    0 =09    0 =09    0 =09    0 =09n800_multi_omap2xxx/vmlinux
    0 =09    0 =09    0 =09    0 =09n800_testconfig/vmlinux
    0 =09    0 =09    0 =09    0 =09omap1_defconfig/vmlinux
+4096 =09+7008 =09    0 =09+11104 =09omap2_4_testconfig/vmlinux
    0 =09+6944 =09    0 =09+6944 =09omap2plus_defconfig/vmlinux
+4096 =09+7008 =09    0 =09+11104 =09omap2plus_no_pm/vmlinux
+4160 =09+7008 =09  +64 =09+11232 =09omap3_4_testconfig/vmlinux
    0 =09    0 =09    0 =09    0 =09omap3_testconfig/vmlinux
    0 =09+7136 =09    0 =09+7136 =09omap4_testconfig/vmlinux

Beno=EEt Cousson (6):
      ARM: OMAP4: hwmod data: add GPMC
      ARM: OMAP4: hwmod data: add the Slimbus IP blocks
      ARM: OMAP4: hwmod data: add McASP
      ARM: OMAP4: hwmod data: add remaining USB-related IP blocks
      ARM: OMAP4: hwmod data: add the OCP-WP IP block
      ARM: OMAP4: hwmod data: add DEBUGSS skeleton

Ming Lei (1):
      ARM: OMAP4: hwmod data: introduce fdif(face detect module) hwmod

Paul Walmsley (8):
      ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common
      ARM: OMAP4: hwmod data: add HDQ/1-wire
      ARM: OMAP4: hwmod data: add EMIF1 and 2
      ARM: OMAP4: hwmod data: add GPU
      ARM: OMAP4: hwmod data: add some interconnect-related IP blocks
      ARM: OMAP4: hwmod data: add OCM RAM IP block
      ARM: OMAP4: hwmod data: add System Control Module
      ARM: OMAP4: hwmod data: add PRCM and related IP blocks

 arch/arm/mach-omap2/Makefile                     |    8 +-
 arch/arm/mach-omap2/clockdomain44xx.c            |    6 +
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10 -
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       | 1504 ++++++++++++++++++=
++++++++++++++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 +
 7 files changed, 1463 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPkHV6AAoJEMePsQ0LvSpLJOAQAKi5wXrem3JhunXGUoywuKw/
/qy8Fy+s392JWzRla9c0+3Wn0MmcmSECdHFP49j1kiGrK2Nd3DpYQA4artkRKvlD
G9XhUYoxoV3cf6/b7QlMVxz2NHtm5BvhNPiwGOgMpyqPr121CaNihjcjyyzOl6nQ
006BUUWuxACwe5wBtqWa2CA4TLM+8+D/edtpTcrMBLgpfMqjQ2m4RwIgjV5A3D/h
KfSIrfaXe2xXEcIjqoGghsEesUThvw7GrKeP3Kde1cQKjR7inz1QrdjuKYG7RB5L
DrxWAZFyPY6aoo1QheiCaw8BpFWhX1sI43Wz6TUE5vOfLqwWoZk4lnMz2rS6KelJ
zRy/cmHzeMGY0j1o+VlYh80WHEl/sqOurIxsN0rJey1c/KRJURR8qmmPkRbyxsvD
hoLhFpP6Uh0CVJubayi/UPr+kUZZNYCLIpU8WBHa5Dqf8ID6NB7TbqgVTCIt86y7
r2kXOoF27KLXdZMundElcNGWuI906t/UbFt1x6KgIUO0mYCmjA8XymgoEWKCkzDv
oiWxHsECT/lRS2M9KGrQHzQsV9Uc/UmFH2bkPKLoA0zJpDrOViWYDroezp7i3kB9
cwaTyb2jilTRR+AIghGvhLFIh5PSAJZoIBcQEhWHykG+kL+NLXRRaVrtPBB6NSMQ
aFxSceVcuSynFrRe8IvN
=3DsO30
-----END PGP SIGNATURE-----
--155748971-471955330-1334867391=:29048--
