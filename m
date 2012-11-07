From: Tony Lindgren <ton@atomide.com>
Subject: [GIT PULL 1/1] omap fixes for v3.7-rc4
Date: Wed, 7 Nov 2012 09:17:11 -0800
Message-ID: <40326.3159831569$1352308652@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61628 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752940Ab2KGRRR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 12:17:17 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc4/fixes-signed

for you to fetch changes up to 5dfcb3b58c6c8934dec8898827736a1e26732cdd:

  Merge tag 'omap-fixes-b2-for-3.7-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.7-rc4/fixes (2012-11-06 09:55:20 -0800)

----------------------------------------------------------------

Minor OMAP PM and hwmod fixes for v3.7-rc series via
Kevin Hilman and Paul Walmsley.

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP2+: PM: add missing newline to VC warning message
      ARM: OMAP4: PM: fix regulator name for VDD_MPU

Miguel Vadillo (1):
      ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to support only SWSUP

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: add flag to prevent hwmod code from touching IP block during init
      ARM: OMAP4: hwmod data: do not enable or reset the McPDM during kernel init

Tero Kristo (1):
      ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod

Tony Lindgren (2):
      Merge tag 'for_3.7-rc5-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.7-rc4/fixes
      Merge tag 'omap-fixes-b2-for-3.7-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.7-rc4/fixes

 arch/arm/mach-omap2/clockdomains44xx_data.c  |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c             | 63 +++++++++++++++++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  8 ++++
 arch/arm/mach-omap2/twl-common.c             |  2 +-
 arch/arm/mach-omap2/vc.c                     |  2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |  6 +++
 6 files changed, 66 insertions(+), 17 deletions(-)
