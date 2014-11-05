From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Few fixes for omaps to reduce bootup noise
Date: Wed,  5 Nov 2014 10:35:45 -0800
Message-ID: <1415212550-24692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19334 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751122AbaKEShl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:37:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Here are few fixes to reduce bootup errors and warnings when
booting omaps in device tree mode. All these are non-critical,
so these are intended for the v3.19 merge window unless somebody
comes up with a real need for these earlier.

Regards,

Tony


Tony Lindgren (5):
  ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree
  ARM: dts: Fix NAND last partition size on LDP
  ARM: dts: Add twl keypad map for LDP
  ARM: dts: Add twl keypad map for LDP
  ARM: OMAP4+: Remove unused omap_l3_noc platform init

 arch/arm/boot/dts/omap3-evm-common.dtsi | 21 +++++++++++++++++++
 arch/arm/boot/dts/omap3-ldp.dts         | 23 ++++++++++++++++++++-
 arch/arm/boot/dts/omap3.dtsi            |  2 +-
 arch/arm/mach-omap2/devices.c           | 36 +--------------------------------
 drivers/bus/omap_l3_smx.c               | 26 +++++++++++++++++++-----
 5 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.1.1

