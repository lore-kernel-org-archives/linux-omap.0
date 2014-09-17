From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH v2 0/6] ARM: dts: cm-t54: enable video out, touchscreen and USB3.0
Date: Wed, 17 Sep 2014 15:10:02 +0300
Message-ID: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52912 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbaIQMKT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 08:10:19 -0400
In-Reply-To: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add CM-T54 DT nodes:

* enable HDMI/DVI/LCD video output support
* add ADS7846 touchscreen support
* enchance DWC3 setup to enable power supply for USB3.0 OTG port

v2: * Fixed comment style issue for mux mode.
      Follow the convention mode0_name.modeX_name for pins
      which mux mode differs from MUX_MODE0

    * Moved aliases node to the top of dts file

Dmitry Lifshitz (6):
  ARM: dts: sbc-t54: fix mux mode comment style
  ARM: dts: cm-t54: fix mux mode comment style
  ARM: dts: cm-t54: add HDMI/DVI display data
  ARM: dts: cm-t54: add Startek LCD support
  ARM: dts: cm-t54: add ADS7846 touchscreen support
  ARM: dts: cm-t54: setup omap_dwc3

 arch/arm/boot/dts/omap5-cm-t54.dts  |  272 ++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 +-
 2 files changed, 272 insertions(+), 4 deletions(-)

-- 
1.7.5.4

