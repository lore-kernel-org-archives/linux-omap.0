From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 0/4] ARM: dts: omap5: Cleanup and updates for DT files
Date: Wed, 5 Jun 2013 12:16:06 +0530
Message-ID: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab3FEGqt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 02:46:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: r.sricharan@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

uevm is the official board supported for OMAP5 soc in the mainline.
This series renames the board dts file for OMAP5 accordingly and cleans
up the same. Also a few additional device DT entry updates are done.

This is on top of the below branch
    git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
    for_3.11/dts

Boot tested on omap5-uevm after pulling in the data from below place
    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git
    HWMOD DATA: for_3.11/omap5_data_files
    CLOCK DATA: out_of_tree/omap5_clk_data

Dan Murphy (1):
  ARM: dts: omap5-uevm: Add LED support for uEVM blue LED

Roger Quadros (1):
  ARM: dts: omap5-uevm: Add USB Host support

Sourav Poddar (1):
  ARM: dts: omap5-uevm: Add uart pinctrl data

Sricharan R (1):
  ARM: dts: omap5: Rename omap5-evm to omap5-uevm

 arch/arm/boot/dts/Makefile       |    2 +-
 arch/arm/boot/dts/omap5-evm.dts  |  261 -------------------------------
 arch/arm/boot/dts/omap5-uevm.dts |  319 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi     |   30 ++++
 4 files changed, 350 insertions(+), 262 deletions(-)
 delete mode 100644 arch/arm/boot/dts/omap5-evm.dts
 create mode 100644 arch/arm/boot/dts/omap5-uevm.dts

-- 
1.7.9.5

