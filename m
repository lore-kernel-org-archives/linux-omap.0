From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap board changes for v3.3 merge window
Date: Wed, 14 Dec 2011 11:39:44 -0800
Message-ID: <20111214193944.GJ32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46212 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab1LNTjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 14:39:49 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap board changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap board

This contains minimal changes to support new omap
variants and features using existing board-*.c files.

These depend on the soc branch that I posted a pull
request for just before this one.

Regards,

Tony


The following changes since commit 4390f5b2cb1f568c1d4b3e5bbf57158f6809627a:
  Hemant Pedanekar (1):
        ARM: OMAP: TI814X: Add cpu type macros and detection support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap board

Aaro Koskinen (1):
      ARM: OMAP3: rx51: enable tsc2005 touchscreen

Hemant Pedanekar (1):
      ARM: OMAP: TI814X: Create board support and enable build for TI8148 EVM

Igor Dmitriev (1):
      ARM: OMAP3: sdram-nokia: add 200 MHz memory timings info

Igor Grinberg (5):
      ARM: OMAP3: cm-t35: Add regulator for ads7846 touchscreen
      ARM: OMAP3: cm-t35: Use correct DSS regulator supply
      ARM: OMAP3: cm-t35: enable audio
      ARM: OMAP3: cm-t35: Add reset for USB hub
      ARM: OMAP3: cm-t35: fix mux mode for DSS pins

Peter Ujfalusi (2):
      ARM: OMAP4: devices: Register OMAP4 DMIC platform device
      ARM: OMAP4: board-4430sdp: Register platform device for digimic codec

 arch/arm/mach-omap2/Kconfig                  |    5 ++
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-4430sdp.c          |    6 ++
 arch/arm/mach-omap2/board-cm-t35.c           |   82 ++++++++++++++++++--------
 arch/arm/mach-omap2/board-rx51-peripherals.c |   46 ++++++++++++++-
 arch/arm/mach-omap2/board-ti8168evm.c        |   22 +++++--
 arch/arm/mach-omap2/devices.c                |   22 +++++++
 arch/arm/mach-omap2/sdram-nokia.c            |   25 ++++++++-
 arch/arm/plat-omap/include/plat/uncompress.h |    3 +
 9 files changed, 179 insertions(+), 33 deletions(-)
