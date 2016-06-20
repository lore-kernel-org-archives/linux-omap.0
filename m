From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v2 0/5] ASoC: tpa6130a2: Add support for
	multiple instances
Date: Mon, 20 Jun 2016 14:12:28 -0300
Message-ID: <cover.1466441036.git.helen.koike@collabora.co.uk>
References: <20160618104038.GB31665@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160618104038.GB31665@earth>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: k.kozlowski@samsung.com, lars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, cphealy@gmail.com, Helen Koike <helen.koike@collabora.co.uk>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
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

Helen Koike (5):
  ASoC: tpa6130a2: Register component
  ASoC: tap6130a2: Use regmap
  ASoC: tpa6130a2: Use snd soc volsw functions
  ASoC: tpa6130a2: Add DAPM support
  ASoC: tpa6130a2: Remove goto err_gpio

 sound/soc/codecs/tpa6130a2.c | 393 ++++++++++++-------------------------------
 sound/soc/codecs/tpa6130a2.h |  14 +-
 sound/soc/omap/rx51.c        |  46 ++---
 3 files changed, 136 insertions(+), 317 deletions(-)


Changes since v1:
  ASoC: tpa6130a2: Register component
	- Remove prefix from snd_kcontrol_new in tpa6130a2.c
	- Add tested-by and reviewd-by from Sebastian
  ASoC: tap6130a2: Use regmap
	- Add tested-by from Sebastian
  ASoC: tpa6130a2: Use snd soc volsw functions
	- Add tested-by from Sebastian
  ASoC: tpa6130a2: Add DAPM support
	- Replace
		+	{"TPA6130A2 HPLEFT", NULL, "LLOUT"},
		+	{"TPA6130A2 HPRIGHT", NULL, "RLOUT"}
	
		by
	
		+       {"TPA6130A2 LEFTIN", NULL, "LLOUT"},
		+       {"TPA6130A2 RIGHTIN", NULL, "RLOUT"},
	- Add tested-by and reviewed-by from Sebastian
	- Add struct device dev* in struct tpa6130a2_data and pass data instead
	of dev to tpa6130a2_power function
	- remove #include "../codecs/tpa6130a2.h" in rx51.c
  ASoC: tpa6130a2: Remove goto err_gpio
	- this is a new patch in the series
-- 
1.9.1
