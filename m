From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCHv6 0/2] TWL6040 audio codec initial support
Date: Wed, 17 Mar 2010 17:40:32 -0500
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE662AC36A@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Following patch series add initial support for TWL6040 codec driver.
The patch set is based on the series sent from Misael Lopez in October 2009.

Changes from v5:
- Add CONFIG_PM for twl6040_suspend and twl6030_resume functions
- Add description for patch 1

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
 sound/soc/codecs/twl6040.c | 1227 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |  141 +++++
 6 files changed, 1379 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/codecs/twl6040.c
 create mode 100644 sound/soc/codecs/twl6040.h
