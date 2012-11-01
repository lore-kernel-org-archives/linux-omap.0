From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/3] ARM: dts: OMAP4/5 device-tree timer updates
Date: Thu, 1 Nov 2012 10:49:24 -0500
Message-ID: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010Ab2KAPtz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 11:49:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

A few device tree timer updates for OMAP4/5 devices.

This series adds ...
1. MPU private addresses for OMAP4 timers
2. Timer nodes for OMAP5
3. 32kHz counter node for OMAP5

This is based upon of Benoit Cousson's OMAP device-tree branch for v3.8.

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.8/dts

Jon Hunter (3):
  ARM: dts: Update OMAP4 timer addresses
  ARM: dts: Add OMAP5 timer nodes
  ARM: dts: Add OMAP5 counter node

 arch/arm/boot/dts/omap4.dtsi |   20 +++++----
 arch/arm/boot/dts/omap5.dtsi |   95 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 8 deletions(-)

-- 
1.7.9.5

