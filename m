From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Device tree related changes to boot dm816x
Date: Tue, 13 Jan 2015 15:37:48 -0800
Message-ID: <1421192272-20754-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17228 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbAMXlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 18:41:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Here are the device tree related changes to boot dm816x 
boards as tested on a dm8168-evm.

Note that these depend on the other related patches I've
posted today. To make it easier to figure out what all is
needed, i've also posted a temporary test branch with all
the necessary patches applied to a tmp-testing-dm81xx branch
at:

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=tmp-testing-dm81xx

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Add board-generic.c entry for ti81xx
  ARM: dts: Add basic dm816x device tree configuration
  ARM: dts: Add basic clocks for dm816x
  ARM: dts: Add minimal support for dm8168-evm

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/dm8168-evm.dts     | 105 ++++++++++
 arch/arm/boot/dts/dm816x-clocks.dtsi | 250 +++++++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi        | 375 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c  |  34 ++++
 5 files changed, 765 insertions(+)
 create mode 100644 arch/arm/boot/dts/dm8168-evm.dts
 create mode 100644 arch/arm/boot/dts/dm816x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dm816x.dtsi

-- 
2.1.4

