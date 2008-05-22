From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] Add D2D clockdomain on OMAP3 ES2+
Date: Thu, 22 May 2008 11:33:47 -0600
Message-ID: <20080522173035.1292.74243.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40676 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758270AbYEVS2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 14:28:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>

Hello,

This patch series adds D2D (die-to-die) clockdomain handling into
OMAP3 ES2+ builds.  It seems the D2D clockdomain logic is still
present on the chip and must be manually programmed to allow the
CORE_D2D clockdomain to go inactive.

For this to work, the pm34xx.c code also had to be modified to use the
pwrdm_for_each_clkdm() iterator, lest the existing for-loop fall off
the end of pwrdm->pwrdm_clkdms[].  This also should fix an oops with
CONFIG_PM on any 3430ES1 boards out there.

Tested on 3430SDP ES2.0.


- Paul


diffstat:
 arch/arm/mach-omap2/clockdomains.h |    9 ++++++++-
 arch/arm/mach-omap2/pm34xx.c       |   23 ++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

size:
   text    data     bss     dec     hex filename
3280225  155416   98792 3534433  35ee61 vmlinux.3430sdp.orig
3280305  155416   98792 3534513  35eeb1 vmlinux.3430sdp.patched

