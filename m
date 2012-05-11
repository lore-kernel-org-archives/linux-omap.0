From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap fixups for v3.5 merge window
Date: Fri, 11 May 2012 12:22:31 -0700
Message-ID: <20120511192230.GV21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37604 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760812Ab2EKTWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 15:22:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here are the fixes needed for the regressions caused by
omap-cleanup-sparse-for-v3.5. I suggest pulling this into
arm-soc/omap/cleanup-sparse where the issues got introduced.

Regards,

Tony


The following changes since commit 09f45b83109cb8e23a06d5efb1096a08a9545974:

  Merge tag 'omap-cleanup-a2-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into cleanup-sparse (2012-04-18 10:09:26 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-for-cleanup

for you to fetch changes up to 19b08b33fa4c60d66d4e341d4d1d9a6e86ffc9e6:

  ARM: OMAP: OTG integration: fix compiler warning (2012-05-11 09:56:43 -0700)

----------------------------------------------------------------
Turns out the earlier omap-cleanup-sparse-for-v3.5
up introduced one compile issue and a new warning.

----------------------------------------------------------------
Paul Walmsley (2):
      ARM: OMAP1: USB: fix ocpi_enable compile problem on non-1610 builds
      ARM: OMAP: OTG integration: fix compiler warning

 arch/arm/mach-omap1/common.h |    4 ++++
 arch/arm/plat-omap/usb.c     |    4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)
