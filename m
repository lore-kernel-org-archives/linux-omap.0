From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 0/5] OMAP3530evm misc fixes for linux-omap
Date: Mon, 11 Jun 2012 22:00:11 +0800
Message-ID: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44331 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2FKOAk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:00:40 -0400
In-Reply-To: <zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, zumeng.chen@gmail.com

These patches fix misc problems when reflash ti-omap3530evm for
master branch on Linux-omap. Currently they have been tested on
3530evm but were not ack'ed.

Most of them are the leftovers from the great original developers
with my the latest updates for adapting to the current kernel, so
I add you directly into SOB(If not proper, please let me know).

The series is based upon the latest linux-omap master branch from
Tony (3.5-rc1).

Zumeng Chen (5):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      MFD: OMAP3EVM: USB: cosmetic fix to failed parent clk set
      Input: ads7846: set proper debounce time in driver level

 arch/arm/mach-omap2/board-omap3evm.c |   75 ++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/ads7846.c  |    2 +
 drivers/mfd/omap-usb-host.c          |    4 +-
 3 files changed, 80 insertions(+), 1 deletions(-)

