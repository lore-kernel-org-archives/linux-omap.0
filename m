From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output on SoC pad
Date: Tue, 7 May 2013 15:09:32 +0530
Message-ID: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56051 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755526Ab3EGJpC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 May 2013 05:45:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

'clkout2' comes out on the device pad and is being used by various
external on-board peripherals like, Audio codecs, Wilink and stuff.
So enable the clkout2 by default during init sequence itself
along with right pinmux configuration clkout2 output.

Also, add the missing entry of "clkout2_ck" to the AM33xx clock table.

As far as enabling of clkout2 during init is concerned,
we can argue that it can be handled using DT property and enable
the clock only when specified; but not until OMAP clock-tree
migration to DT.

Vaibhav Hiremath (2):
  ARM: OMAP AM33XX: clock data: Enable clkout2 as part of init
  ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output

 arch/arm/boot/dts/am335x-bone.dts     |    8 +++++++-
 arch/arm/boot/dts/am335x-evm.dts      |    8 +++++++-
 arch/arm/boot/dts/am335x-evmsk.dts    |    8 +++++++-
 arch/arm/mach-omap2/cclock33xx_data.c |    2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

