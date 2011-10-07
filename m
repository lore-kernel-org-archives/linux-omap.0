From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Fri, 7 Oct 2011 23:17:44 +0530
Message-ID: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43414 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab1JGRzL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

The folowing patch series provides IO Daisychain feature via omap hwmod mux
framework.

The patch series has been generated against 3.1 rc9 and tested on OMAP3 Platform
(ZOOM3 and OMAP3430 SDP) for Retentiona and OFF mode in suspend/cpuidle path.
Tested on OMAP4 using [1] as OMAP4 Core PM is not yet supported mainline.
[1]: git://gitorious.org/omap-pm/linux.git omap4_core_pm

Also tested against latest UART Runtime with Chain Handler patches [1].
[2]: git://gitorious.org/runtime_3-0/runtime_3-0.git v6_uart_runtime

Mohan V (1):
  ARM: OMAP3 PM: correct enable/disable of daisy io chain

Rajendra Nayak (1):
  ARM: OMAP4 PM: Add IO Daisychain support

Vishwanath BS (5):
  ARM: OMAP3 PM: Move IO Daisychain function to omap3 prm file
  ARM: OMAP3 PM: Enable IO Wake up
  ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
  ARM: OMAP3 PM: Remove IO Daisychain control from cpuidle
  ARM: OMAP3 PM: Enable IO Daisychain for supported chips

 arch/arm/mach-omap2/omap_hwmod.c   |    9 +++++-
 arch/arm/mach-omap2/pm.c           |   11 ++++++++
 arch/arm/mach-omap2/pm.h           |    1 +
 arch/arm/mach-omap2/pm34xx.c       |   49 ++---------------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   27 +++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   14 ++++++++++
 arch/arm/mach-omap2/prm44xx.c      |   33 ++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h      |    1 +
 8 files changed, 97 insertions(+), 48 deletions(-)

