From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Couple of omap fixes
Date: Thu, 30 Sep 2010 15:46:59 -0700
Message-ID: <20100930224659.GP3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0I3WrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 18:47:05 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Linus,

Please pull two omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:

  Linux 2.6.36-rc6 (2010-09-28 18:01:22 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Scott Ellis (1):
      omap: McBSP: tx_irq_completion used in rx_irq_handler

Tony Lindgren (1):
      omap: Fix compile dependency to LEDS_CLASS

 arch/arm/plat-omap/Kconfig |    2 +-
 arch/arm/plat-omap/mcbsp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
