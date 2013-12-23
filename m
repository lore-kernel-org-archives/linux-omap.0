From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for 3.13?)
Date: Mon, 23 Dec 2013 11:28:33 +0200
Message-ID: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60162 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab3LWJ3F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 04:29:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rogerq@ti.com, balbi@ti.com

Hi,

The audio frequency has been incorrectly set in the DTS file which results
incorrect playback frequency on EVM-SK.

The SD card can not be used without the second patch on 3.13-rc5.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: DTS: am335x-evmsk: Correct audio clock frequency
  ARM: dts: am335x-evmsk: Fix mmc1 support

 arch/arm/boot/dts/am335x-evmsk.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
1.8.5.2

