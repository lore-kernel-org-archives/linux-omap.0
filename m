From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/5] AM43xx-ePOS-EVM audio support with TLV320AIC31XX driver
Date: Wed, 26 Feb 2014 11:14:24 +0200
Message-ID: <cover.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbaBZJOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 04:14:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, broonie@kernel.org
Cc: peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This patch set adds audio support for AM43xx-ePOS-EVM. I'll mail
the dts and defconfig changes once these have been merged.

Jyri Sarha (5):
  ASoC: tlv320aic31xx: Add basic codec driver implementation
  ASoC: tlv320aic31xx: Add codec driver to Makefile and Kconfig
  ASoC: tlv320aic31xx: Add DT binding document
  ASoC: davinci-evm: Add AM43xx-EPOS-EVM audio support
  ASoC: davinci: Add SND_AM43XX_SOC_EPOS_EVM build option

 .../bindings/sound/davinci-evm-audio.txt           |    9 +-
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   57 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/tlv320aic31xx.c                   | 1360 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  265 ++++
 sound/soc/davinci/Kconfig                          |   12 +
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |   41 +
 9 files changed, 1748 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h

-- 
1.7.9.5

