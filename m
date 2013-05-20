From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output on SoC pad
Date: Mon, 20 May 2013 18:58:08 +0530
Message-ID: <1369056490-12632-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52616 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab3ETN2o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 09:28:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

'clkout2' comes out on the device pad and is being used by various
external on-board peripherals like, Audio codecs, Wilink and stuff.
So enable the clkout2 by default during init sequence itself
along with right pinmux configuration clkout2 output.

Also, add the missing entry of "clkout2_ck" to the AM33xx clock table.

As far as enabling of clkout2 during init is concerned,
we can argue that it can be handled using DT property and enable
the clock only when specified; but not until OMAP clock-tree
migration to DT.

Changes from V1:
	- Fixed spelling mistake in dts file
	- Added Acked-by from 'Paul Walmsley'

Vaibhav Hiremath (2):
  ARM: OMAP AM33XX: clock data: Enable clkout2 as part of init
  ARM: dts: AM33XX: Set pinmux for clkout2 pad used for clock output

 arch/arm/boot/dts/am335x-bone.dts     |    8 +++++++-
 arch/arm/boot/dts/am335x-evm.dts      |    8 +++++++-
 arch/arm/boot/dts/am335x-evmsk.dts    |    8 +++++++-
 arch/arm/mach-omap2/cclock33xx_data.c |    2 ++
 4 files changed, 23 insertions(+), 3 deletions(-)

