From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4] AM43xx-ePOS-EVM audio support with TLV320AIC31XX driver
Date: Mon, 10 Mar 2014 10:52:20 +0200
Message-ID: <cover.1394440470.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59431 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbaCJIwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 04:52:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Since the v3 version of the patches:
- Dropped "ASoC: tlv320aic32x4: Sort Makefile in alphabetic order" out 
- Changed DAMP widget "Mic Bias" to "MICBIAS"

Best regards,
Jyri

Jyri Sarha (1):
  ASoC: tlv320aic31xx: Add basic codec driver implementation

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   61 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    9 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/tlv320aic31xx.c                   | 1343 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  258 ++++
 6 files changed, 1677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h

-- 
1.7.9.5

