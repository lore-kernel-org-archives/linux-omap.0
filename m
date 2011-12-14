From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 REPOST 0/7] ARM: OMAP3PLUS PM: Add IO DaisyChain support via hwmod mux
Date: Wed, 14 Dec 2011 21:31:10 +0530
Message-ID: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab1LNQLD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 11:11:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

The following patch series provides IO Daisychain feature via omap hwmod mux framework.
The patch series has been generated against Tero's V11 irq chaining series [1].

Testing Performed:
OMAP3:
Tested for Retention and OFF mode in suspend/cpuidle path on OMAP3430 SDP and ZOOM3.
Also tested against latest UART Runtime + Chain Handler patches[2] for Ret/OFF in
cpuidle/suspend path.

OMAP4:
Boot tested on OMAP4430 SDP. Also tested for Suspend/resume with CSWR using custom OMAP4
kernel as Core PM is not yet supported in mainline.

Thanks to Govind for testing the series with UART Runtime patches on various OMAP3 platforms.

Patch series is available here[3].

[1]: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git chain-prcm-v11

[2]: git://gitorious.org/runtime_3-0/runtime_3-0.git
for_3_3/tmp_rc4_uart_pm_intg

[3]: git://gitorious.org/omap-pm/linux.git for_3.3/io_daisy_chain_rebased

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
 arch/arm/mach-omap2/pm34xx.c       |   47 ++---------------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   27 ++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    7 +++++
 arch/arm/mach-omap2/prm44xx.c      |   30 +++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h      |    1 +
 8 files changed, 87 insertions(+), 46 deletions(-)

