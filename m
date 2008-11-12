From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP3 clock: skip reserved FREQSEL settings
Date: Wed, 12 Nov 2008 11:50:31 -0700
Message-ID: <20081112183754.31228.73844.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56913 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYKLSxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 13:53:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>

Hello,

this series fixes a bug in the OMAP3 DPLL rate rounding code that will
attempt to program the DPLL to use an internal clock frequency that
does not exist in the FREQSEL table in 34xx TRM 4.7.6.2.  This mostly
seems to generate warnings, but can potentially hang the system.

As part of this process, improve the DPLL rate rounding algorithm to
start from a low divider (N) and count up; this should result in fewer
passes through the loop.

Tested on 3430SDP ES2 and a custom ES3 board.  Thanks to Peter de Schrijver
<peter.de-schrijver@nokia.com> for help with these patches.


- Paul

---

   text    data     bss     dec     hex filename
3574155  189440  108880 3872475  3b16db vmlinux.3430sdp.orig
3574251  189440  108880 3872571  3b173b vmlinux.3430sdp

 arch/arm/mach-omap2/clock.c             |  118 ++++++++++++++++++++++++-------
 arch/arm/mach-omap2/clock24xx.h         |    1 
 arch/arm/mach-omap2/clock34xx.h         |    5 +
 arch/arm/plat-omap/include/mach/clock.h |    1 
 4 files changed, 99 insertions(+), 26 deletions(-)

