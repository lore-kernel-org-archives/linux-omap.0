From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] arm/dts: Add OMAP2420 SDP support
Date: Thu, 7 Jun 2012 17:06:51 -0500
Message-ID: <1339106813-9962-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933030Ab2FGWGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 18:06:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>

This series fixes the OMAP2 interrupt controller binding and adds support for
the OMAP2420 SDP board. I have verified that the kernel boots with device-tree
on this board.

This series is based upon the linux-omap master branch (3.5-rc1).

Jon Hunter (2):
  arm/dts: OMAP2: Add support for OMAP2420 SDP
  arm/dts: OMAP2: Fix interrupt controller binding

 arch/arm/boot/dts/omap2.dtsi       |    2 ++
 arch/arm/boot/dts/omap2420-sdp.dts |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420-sdp.dts

-- 
1.7.9.5

