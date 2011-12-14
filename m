From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two omap fixes for v3.2-rc5
Date: Wed, 14 Dec 2011 13:53:05 -0800
Message-ID: <20111214215305.GN32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19647 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab1LNVxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 16:53:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull two regression fixes for the -rc series from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Regards,

Tony


The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
  Linus Torvalds (1):
        Linux 3.2-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Felipe Contreras (1):
      ARM: OMAP: rx51: fix USB

Jarkko Nikula (1):
      ARM: OMAP: mcbsp: Fix possible memory corruption

 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/mcbsp.c                  |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
