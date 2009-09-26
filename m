From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCHv2 0/7] TWL6030 audio codec initial support
Date: Fri, 25 Sep 2009 21:02:16 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A391DE@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57176 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZIZCCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 22:02:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Following patch series adds initial support for TWL6030 codec
driver.

TWL6030 codec depends on TWL6030_CORE, which is not accepted yet.
The main intention then is to get comments, I'll repost the patches
of this series when TWL6030_CORE support gets accepted and rework
patches as needed.

Changes from v1:
- Renamed dai format for PDM as SND_SOC_DAIFMT_PDM
- CODEC driver registered as a platform driver
- AUDPWRON gpio line handled in the CODEC driver
- Handle scenario when no AUDPWRON gpio line is provided
- Corrected names of some widgets
- Avoid multiple calls to power functions in set_bias_level

Thanks,
-Misa

---

Misael Lopez Cruz (7):
      OMAP4: PMIC: Add support for twl6030 codec
      ASoC: Add PDM DAI format definition
      ASoC: TWL6030: Add twl6030 codec driver
      ASoC: TWL6030: Manual power-up/down sequences
      ASoC: TWL6030: Add support for low-power mode
      ASoC: TWL6030: Enable audio interrupt
      ASoC: TWL6030: Power-up seq completion through audio interrupt

 drivers/mfd/twl-core.c     |   15 +
 include/linux/i2c/twl.h    |   11 +
 include/sound/soc-dai.h    |    1 +
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl6030.c | 1179 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6030.h |  137 +++++
 7 files changed, 1349 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/twl6030.c
 create mode 100644 sound/soc/codecs/twl6030.h
