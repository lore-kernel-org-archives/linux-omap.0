From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv5 0/2] TWL6040 audio codec initial support
Date: Fri, 12 Mar 2010 19:52:11 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE66173AF5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52727 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab0CMBwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 20:52:22 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Following patch series add initial support for TWL6040 codec driver.
The patch set is based on the series sent from Misael Lopez in October 2009.

Changes from v4:
- Rename twl6030_codec as twl6040_codec
- Rebase the 6 codec patches into a single patch
- Rename twl6040_read as twl6040_read_reg_volatile
- Use msleep instead of large mdelays
- Add more trigger sources
- Restructure set_bias_level function to avoid transitions like PREPARE->ON

Regards,
Margarita
---

Misael Lopez Cruz (1):
  ASoC: TWL6040: Add twl6040 codec driver

Margarita Olaya Cabrera (1):
  OMAP4: PMIC: Rename twl6030_codec as twl6040_codec

 drivers/mfd/twl-core.c     |    4 +-
 include/linux/i2c/twl.h    |    6 +-
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/twl6040.c | 1223 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |  141 +++++
 6 files changed, 1375 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/codecs/twl6040.c
 create mode 100644 sound/soc/codecs/twl6040.h