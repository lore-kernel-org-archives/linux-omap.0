From: Suman Anna <s-anna@ti.com>
Subject: [REPOST PATCHv3] OMAP Mailbox DTS patch for 3.18
Date: Wed, 10 Sep 2014 14:27:22 -0500
Message-ID: <1410377243-8147-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55264 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaIJT1s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 15:27:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Tony,

This is a repost of just the DTS patch (third patch) from the OMAP
Mailbox framework adoption and DT support series [1], for it to be
picked up in your dts branch for 3.18. There are no changes, just
rebased onto 3.17-rc3. This is the DTS counterpart for the mailbox
DT support series for 3.18 [2].

The following shows the boot logs on various OMAP platforms with
just this patch:
  OMAP2 (SDP2430)           : http://pastebin.ubuntu.com/8311699
  OMAP3 (BeagleXM)          : http://pastebin.ubuntu.com/8311804
  OMAP4 (PandaBoard)        : http://pastebin.ubuntu.com/8311837
  OMAP5 (OMAP5 uEVM)        : http://pastebin.ubuntu.com/8311834
  DRA7  (DRA7 EVM)          : http://pastebin.ubuntu.com/8311859
  AM33xx (BeagleBone Black) : http://pastebin.ubuntu.com/8311774
  AM43xx (AM437x GP EVM)    : http://pastebin.ubuntu.com/8311754

[1] http://marc.info/?l=linux-omap&m=140668054422693&w=2
[2] http://marc.info/?l=linux-omap&m=141037688814464&w=2

Suman Anna (1):
  ARM: dts: OMAP2+: Add sub mailboxes device node information

 arch/arm/boot/dts/am33xx.dtsi   | 4 ++++
 arch/arm/boot/dts/am4372.dtsi   | 4 ++++
 arch/arm/boot/dts/omap2420.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi | 4 ++++
 arch/arm/boot/dts/omap3.dtsi    | 4 ++++
 arch/arm/boot/dts/omap4.dtsi    | 8 ++++++++
 arch/arm/boot/dts/omap5.dtsi    | 8 ++++++++
 7 files changed, 40 insertions(+)

-- 
2.0.4

