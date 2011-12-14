From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap musb platform init updates for v3.3 merge window
Date: Wed, 14 Dec 2011 11:42:19 -0800
Message-ID: <20111214194218.GK32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50275 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1LNTmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 14:42:22 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull musb updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap musb

This branch enables musb for some new omaps and boards.

It depends on the board branch I posted a pull request
for just before this email.

Regards,

Tony


The following changes since commit a890b6760d975cdbdfcdf5753dab4c91059af9b1:
  Hemant Pedanekar (1):
        ARM: OMAP: TI814X: Create board support and enable build for TI8148 EVM

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap musb

Ajay Kumar Gupta (1):
      ARM: OMAP: musb: Add ti81xx phy power function

Ravi Babu (2):
      ARM: OMAP: musb: Adding support for ti81xx
      ARM: OMAP: musb: Add support for ti816evm

 arch/arm/mach-omap2/board-ti8168evm.c   |    9 ++++++++
 arch/arm/mach-omap2/omap_phy_internal.c |   35 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c          |    3 ++
 arch/arm/plat-omap/include/plat/usb.h   |   32 ++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 0 deletions(-)
