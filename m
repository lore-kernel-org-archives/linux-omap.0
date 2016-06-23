From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v3 0/2] ASoC: tpa6130a2: Add support for
	multiple instances
Date: Thu, 23 Jun 2016 16:23:12 -0300
Message-ID: <cover.1466709086.git.helen.koike@collabora.co.uk>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1466441036.git.helen.koike@collabora.co.uk>
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

The first 3 pathes of this series were already applied, these two are missing

This patch series is based on git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
Available at https://git.collabora.com/cgit/user/koike/linux.git/log/?h=sound/review/tpa6130a2

Helen Koike (2):
  ASoC: tpa6130a2: Add DAPM support
  ASoC: tpa6130a2: Remove goto err_gpio

 sound/soc/codecs/tpa6130a2.c | 196 ++++++++++++++++++-------------------------
 sound/soc/codecs/tpa6130a2.h |  11 +--
 sound/soc/omap/rx51.c        |  23 ++---
 3 files changed, 93 insertions(+), 137 deletions(-)


Changes since v2:
  ASoC: tpa6130a2: Add DAPM support
	- Add braces around else statement in tpa6130a2_power_event
  ASoC: tpa6130a2: Remove goto err_gpio
	- Add tested-by and reviewed-by from Sebastian
-- 
1.9.1
