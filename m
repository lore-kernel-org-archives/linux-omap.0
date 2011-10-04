From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 0/4] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Tue, 4 Oct 2011 23:22:00 +0530
Message-ID: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50695 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284Ab1JDR7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 13:59:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

The folowing patch series provides IO Daisychain feature via omap hwmod mux
framework.

The patch series has been generated against 3.1 rc4 and tested on OMAP3 Platform
(ZOOM3) for Retention and OFF mode in suspend/cpuidle path.

Also tested against latest UART Runtime with Chain Handler patches [1].

[1]: git://gitorious.org/runtime_3-0/runtime_3-0.git v6_uart_runtime

Rajendra Nayak (1):
  OMAP4 PM: Add IO Daisychain support

Vishwanath BS (3):
  OMAP3 PM: Fix IO Daisychain sequence
  OMAP3 PM: Enable IO Wake up
  OMAP3PLUS PM: Add IO Daisychain support via hwmod mux

 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
 arch/arm/mach-omap2/pm.c         |    9 +++++++++
 arch/arm/mach-omap2/pm.h         |    3 +++
 arch/arm/mach-omap2/pm34xx.c     |   33 +++++++--------------------------
 arch/arm/mach-omap2/pm44xx.c     |   36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 28 deletions(-)

