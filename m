From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/5] ARM: OMAP2+: System timer updates
Date: Wed, 30 Jan 2013 11:04:26 -0600
Message-ID: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48852 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab3A3REk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 12:04:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series consists mainly of clean-ups for clockevents and
clocksource timers on OMAP2+ devices. The most significant change
in functionality comes from the 5th patch which is changing the
selection of the clocksource timer for OMAP3 and AM335x devices
when gptimers are used for clocksource. This change came about from
Vaibhav Bedia's series for AM335x [1]. See patch for more details on
the exact nature of the change.

Boot tested with and without  device-tree on OMAP2420 H4,
OMAP3430 SDP, OMAP3430 Beagle Board, OMAP4430 SDP and
AM335x EVM (AM335x only supports device-tree boot).

This series is based upon ARM-SoC next branch.

[1] https://patchwork.kernel.org/patch/1921421/

Jon Hunter (5):
  ARM: OMAP2+: Display correct system timer name
  ARM: OMAP2+: Remove hard-coded test on timer ID
  ARM: OMAP2+: Simplify system timer clock definitions
  ARM: OMAP2+: Simplify system timers definitions
  ARM: OMAP3: Update clocksource timer selection

 arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/common.h         |    3 +-
 arch/arm/mach-omap2/timer.c          |  134 ++++++++++++++++------------------
 4 files changed, 67 insertions(+), 74 deletions(-)

-- 
1.7.10.4

