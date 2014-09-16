From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 0/4] ARM: dts: cm-t54: enable video out, touchscreen and USB3.0
Date: Tue, 16 Sep 2014 19:35:18 +0300
Message-ID: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:41540 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703AbaIPQfg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 12:35:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add CM-T54 DT nodes:

* enable HDMI/DVI/LCD video output support
* add ADS7846 touchscreen support
* enchance DWC3 setup to enable power supply for USB3.0 OTG port

Dmitry Lifshitz (4):
  ARM: dts: cm-t54: add HDMI/DVI display data
  ARM: dts: cm-t54: add Startek LCD support
  ARM: dts: cm-t54: add ADS7846 touchscreen support
  ARM: dts: cm-t54: setup omap_dwc3

 arch/arm/boot/dts/omap5-cm-t54.dts |  268 ++++++++++++++++++++++++++++++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

-- 
1.7.5.4

