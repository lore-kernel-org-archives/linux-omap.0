From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.11-rc1
Date: Fri, 19 Jul 2013 03:45:38 -0700
Message-ID: <20130719104538.GE7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14849 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759405Ab3GSKpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 06:45:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-against-rc1

for you to fetch changes up to 7956c487e407bdbf7f8c8a570fd5d4d089973692:

  Merge branch 'omap-for-v3.11/dt-fixes' into omap-for-v3.11/fixes (2013-07-19 03:28:35 -0700)

----------------------------------------------------------------

Omap fixes mostly to deal with the dropping of platform
data for omap4, and to make v7_defconfig bootable on omap4
SDP with nfsroot.

----------------------------------------------------------------
Roger Quadros (1):
      ARM: OMAP2+: Provide alias to USB PHY clock

Tony Lindgren (3):
      ARM: multi_v7: Enabled omap4430 sdp nfsroot
      ARM: dts: Add missing vmmc2 regulator for twl
      Merge branch 'omap-for-v3.11/dt-fixes' into omap-for-v3.11/fixes

 arch/arm/boot/dts/twl4030.dtsi      |  6 ++++++
 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/mach-omap2/board-generic.c | 23 ++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)
