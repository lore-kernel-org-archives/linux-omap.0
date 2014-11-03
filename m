From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] OMAP Mailbox DTS patches for 3.19
Date: Mon, 3 Nov 2014 17:07:33 -0600
Message-ID: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaKCXIA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2014 18:08:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Tony,

The following OMAP mailbox DTS patches are based on 3.18-rc3 and are
intended for the 3.19 merge window.

The first patch is new and adds the interrupts property to all the mailbox
nodes on DRA7xx now that we have the DRA7xx interrupt crossbar driver
functional and merged in the kernel.

The second patch enables the OMAP Mailbox DT users (there are none at the
moment) to use the recently merged Mailbox framework API, and is a repost
of the DTS patch [1] from the OMAP Mailbox framework adaptation series [2]
after rebasing. The driver portion of the adaptation patch is posted
separately so that Jassi can pick it up. Together, these are the last
base mailbox dependent patches for Dave's PM work on AM335x.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=141038449717781&w=2
[2] http://marc.info/?l=linux-omap&m=141038447817775&w=2

Suman Anna (2):
  ARM: dts: DRA7: Add interrupts property to mailbox nodes
  ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox nodes

 arch/arm/boot/dts/am33xx.dtsi   |  1 +
 arch/arm/boot/dts/am4372.dtsi   |  1 +
 arch/arm/boot/dts/dra7.dtsi     | 64 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi |  1 +
 arch/arm/boot/dts/omap2430.dtsi |  1 +
 arch/arm/boot/dts/omap3.dtsi    |  1 +
 arch/arm/boot/dts/omap4.dtsi    |  1 +
 arch/arm/boot/dts/omap5.dtsi    |  1 +
 8 files changed, 71 insertions(+)

-- 
2.1.0

