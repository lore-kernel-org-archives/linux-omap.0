From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: DTS: omap5-uevm: Enable audio (for 3.17)
Date: Thu, 10 Jul 2014 14:24:00 +0300
Message-ID: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51167 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaGJLYd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 07:24:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This set is to enable audio (finally) on the omap5-uevm. We have been waiting
for the palmas 32K clock driver to make it to upstream, which it did and it is
already in linux-next.

With the three patch we can have audio working on omap5-uevm with linux-next.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
  ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
  ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040)

 arch/arm/boot/dts/omap5-uevm.dts | 68 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 6 deletions(-)

-- 
2.0.0

