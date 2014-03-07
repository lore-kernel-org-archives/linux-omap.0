From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 0/2] AM43xx-ePOS-EVM audio support with TLV320AIC31XX driver
Date: Fri, 7 Mar 2014 14:58:31 +0200
Message-ID: <cover.1394195429.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbaCGM6v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 07:58:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Since the v2 version of the patches [1] I have dropped davinci-evm
related patches since I plan to start using simple-card for machine
driver. I have also addressed Mark Brown's comments [2] as I described
in my mail here [3].

Best regards,
Jyri

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073809.html

[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073814.html

[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073992.html

Jyri Sarha (2):
  ASoC: tlv320aic32x4: Sort Makefile in alphabetic order
  ASoC: tlv320aic31xx: Add basic codec driver implementation

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |   61 +
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |    9 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    6 +-
 sound/soc/codecs/tlv320aic31xx.c                   | 1343 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic31xx.h                   |  258 ++++
 6 files changed, 1679 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 sound/soc/codecs/tlv320aic31xx.c
 create mode 100644 sound/soc/codecs/tlv320aic31xx.h

-- 
1.7.9.5

