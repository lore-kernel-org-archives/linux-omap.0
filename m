From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH 0/4] ASoC: tpa6130a2: Add support for multiple instances
Date: Sat, 18 Jun 2016 00:26:27 -0300
Message-ID: <cover.1466218805.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Helen Koike <helen.koike@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

The current tpa6130a2 driver supports only a single instance.
This patch series add support for multiple instances by removing the global
variable that holds the instance.
This is performed by using the component API, regmap, the
snd_soc_{info,put,get}_volsw API and DAPM.

This patch series also touches code from the Nokia RX51 which I didn't tested (as
I am testing the tpa6130a2 in another board that is not upstream).
I would appreciate is if someone who possesses the Nokia RX51 (n900) could please
test the code.

This patch series is based on git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
Available at https://git.collabora.com/cgit/user/koike/linux.git/log/?h=sound/review/tpa6130a2

Helen Koike (4):
  ASoC: tpa6130a2: Register component
  ASoC: tap6130a2: Use regmap
  ASoC: tpa6130a2: Use snd soc volsw functions
  ASoC: tpa6130a2: Add DAPM support

 sound/soc/codecs/tpa6130a2.c | 382 ++++++++++++-------------------------------
 sound/soc/codecs/tpa6130a2.h |  14 +-
 sound/soc/omap/rx51.c        |  45 ++---
 3 files changed, 130 insertions(+), 311 deletions(-)

-- 
1.9.1
