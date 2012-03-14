From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP4: hwmod data: add almost all remaining IP
 blocks
Date: Wed, 14 Mar 2012 02:45:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203140241070.7269@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1528478852-1331714560=:7269"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37943 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381Ab2CNIpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Mar 2012 04:45:04 -0400
Content-ID: <alpine.DEB.2.00.1203140243160.7269@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1528478852-1331714560=:7269
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1203140243161.7269@utopia.booyaka.com>

Hi Tony

The following changes since commit afce19b152eedea0402561087dd939b23b53f3cb=
:

  ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-03-0=
8 21:04:50 -0700)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 hwmod_enable_remaining_hwmods_devel_3.4

for you to fetch changes up to de028b2eb97649d82ebb1ca1f6fabc932ca98354:

  ARM: OMAP4: hwmod data: add DEBUGSS skeleton (2012-03-08 21:29:05 -0700)

This series has a dependency on the 'hwmod_remove_link_arrays_cleanup_3.4'=
=20
branch.


- Paul

----------------------------------------------------------------
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
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       | 1473 ++++++++++++++++++=
+++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 +
 7 files changed, 1443 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c
--155748971-1528478852-1331714560=:7269--
