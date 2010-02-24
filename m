From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv4 0/7] TWL6030 audio codec initial support
Date: Tue, 23 Feb 2010 18:10:13 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE65DD1B12@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab0BXAKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 19:10:22 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Following patch series add initial support for TWL6030 codec driver.
The patch set is based on the series sent from Misael Lopez in October 2009.

Changes from v3:
- Remove snd_soc_init_card function
- Adapt to latest twl core changes based on Balaji's comment

Regards,
Margarita

---
Misael Lopez Cruz (7):
  OMAP4: PMIC: Add support for twl6030 codec
  ASoC: TWL6030: Add twl6030 codec driver
  ASoC: TWL6030: Manual power-up/down sequences
  ASoC: TWL6030: Add support for low-power PLL
  ASoC: TWL6030: Add restrictions for low-power playback mode
  ASoC: TWL6030: Enable audio interrupt
  ASoC: TWL6030: Detect power-up sequence completion

 drivers/mfd/twl-core.c     |   18 +-
 include/linux/i2c/twl.h    |    4 +
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl6030.c | 1241 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6030.h |  141 +++++
 6 files changed, 1407 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/twl6030.c
 create mode 100644 sound/soc/codecs/twl6030.h
