From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 0/5] ARM: omap3-lilly-a83x: update board support
Date: Fri, 23 May 2014 01:06:21 +0200
Message-ID: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58710 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbaEVXGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:06:52 -0400
Received: by mail-la0-f45.google.com with SMTP id gl10so3340641lab.32
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:06:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This set of patches updates board support for omap3-lilly-a83x.

Christoph Fritz (5):
  [RFC-HACK] pinctrl-single: init by postcore_initcall()
  [RFC-HACK] ARM: dts: OMAP3: reorder pinmux_gpio1_pins
  ARM: dts: omap3: set mcbsp2 status
  [RFC] ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable
  ARM: dts: OMAP3 a83x: fix duplicate usb pin config

 arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    7 +++---
 arch/arm/boot/dts/omap34xx.dtsi         |   28 ++++++++++++----------
 arch/arm/boot/dts/omap36xx.dtsi         |   40 ++++++++++++++++---------------
 arch/arm/mach-omap2/gpmc-nand.c         |   16 +++++--------
 drivers/pinctrl/pinctrl-single.c        |   15 ++++++++++++
 5 files changed, 61 insertions(+), 45 deletions(-)

-- 
1.7.10.4

