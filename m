From: Jon Hunter <jon-hunter@ti.com>
Subject: [RESEND PATCH V3 0/2] arm/dts: Add OMAP2420 H4 support
Date: Tue, 12 Jun 2012 19:40:44 -0500
Message-ID: <1339548046-27988-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42766 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab2FMAkx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 20:40:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>

This series fixes the OMAP2 interrupt controller binding and adds support for
the OMAP2420 H4 board. I have verified that the kernel boots with device-tree
on this board.

This series is based upon the linux-omap master branch (3.5-rc1).

V3: Rename OMAP2420 SDP to OMAP2420 H4
V2: Correct typo in copyright date

Jon Hunter (2):
  arm/dts: OMAP2: Add support for OMAP2420H4 Board
  arm/dts: OMAP2: Fix interrupt controller binding

 arch/arm/boot/dts/omap2.dtsi      |    2 ++
 arch/arm/boot/dts/omap2420-h4.dts |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420-h4.dts

-- 
1.7.9.5

