From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Few dm816x fixes and improvments
Date: Tue, 17 Mar 2015 17:19:17 -0700
Message-ID: <1426637961-4197-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ar-005-i192.relay.mailchannels.net ([162.253.144.74]:39481 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752963AbbCRAYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 20:24:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

Here are few dm816x related fixes and improvments. Mostly to get
GPIO interrupts working, and add DMA for the USB.

Note that the USB still depends on the USB PHY driver posted in
"[PATCH v2] phy: Add a driver for dm816x USB PHY".

Regards,

Tony


Tony Lindgren (4):
  ARM: dts: Fix gpio interrupts for dm816x
  ARM: dts: Fix typo for dm816x usb0_pins
  ARM: dts: Add cppi41 support for dm816x MUSB
  ARM: dts: Remove PIN_INPUT for dm816x McSPI

 arch/arm/boot/dts/dm8168-evm.dts | 33 +++++++++++++----
 arch/arm/boot/dts/dm816x.dtsi    | 78 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 100 insertions(+), 11 deletions(-)

-- 
2.1.4

