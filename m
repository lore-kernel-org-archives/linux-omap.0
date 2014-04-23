From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Fix LAN9220 caused memory corruption noticed on cm-t3730
Date: Wed, 23 Apr 2014 12:03:20 -0700
Message-ID: <1398279803-5655-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20580 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932099AbaDWTD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 15:03:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

I noticed some occasional memory corruption issues on transferring
data over LAN9220 after upgrading my gateway machine.

Please test if you have a board with LAN9220 on GPMC, this
should not affect boards with LAN9221.

As these fix memory corruption using LAN9220 at least on cm-t3730,
I'm planning to send these ASAP after some testing.

Regards,

Tony

Tony Lindgren (3):
  ARM: dts: Fix bad OTG muxing for cm-t boards
  ARM: dts: Fix GPMC Ethernet timings for omap cm-t sbc-t boards for
    device tree
  ARM: dts: Fix GPMC timings for LAN9220

 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 19 ++++-----
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi     | 66 +++++++------------------------
 arch/arm/boot/dts/omap3-sb-t35.dtsi       | 37 +++++------------
 arch/arm/boot/dts/omap3-sbc-t3517.dts     | 13 ++++++
 4 files changed, 46 insertions(+), 89 deletions(-)

-- 
1.8.1.1

