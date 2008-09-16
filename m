From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] OMAP2/3 clock: revise module idlest handling
Date: Tue, 16 Sep 2008 08:58:30 -0600
Message-ID: <20080916145747.1470.51591.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbYIPPPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:15:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>

Hello,

This series revises module idlest handling to use a new "idlest_bit"
field defined in struct clk for the CM_IDLEST mask.  After doing so,
the omap2_clk_wait_ready() function can be cleaned up.  More details
of the new arrangement are in the individual patch comments.

Applies on top of the "OMAP2/3 clock: encode prcm_mod for each struct clk"
series.

Boot-tested on 2430SDP and 3430SDP.  Comments welcome.


- Paul

---

   text    data     bss     dec     hex filename
3098504  137136  150888 3386528  33aca0 vmlinux.3430sdp.orig
3098472  137712  150888 3387072  33aec0 vmlinux.3430sdp


 arch/arm/mach-omap2/clock.c             |   96 ++-----
 arch/arm/mach-omap2/clock24xx.h         |  194 +++++++++-----
 arch/arm/mach-omap2/clock34xx.h         |  445 ++++++++++++++++++++++---------
 arch/arm/mach-omap2/cm-regbits-24xx.h   |   81 ++++--
 arch/arm/mach-omap2/cm-regbits-34xx.h   |  101 +++++--
 arch/arm/mach-omap2/pm-debug.c          |   15 +
 arch/arm/mach-omap2/prcm-common.h       |  198 +++++++++-----
 arch/arm/plat-omap/include/mach/clock.h |    8 -
 8 files changed, 741 insertions(+), 397 deletions(-)

