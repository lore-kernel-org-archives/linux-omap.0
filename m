From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/5] ASoC: TDM stuff for simple-card, mcasp,
	and tlv320aic3x
Date: Wed, 9 Sep 2015 21:27:41 +0300
Message-ID: <cover.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, Li.Xiubo@freescale.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

The first patch is an independent fix.

The symmetric_samplebits constraint could probably be removed too
(with some changes to mcasp code too), but as tlv320aic3x family
codecs won't support it, I could not test it.

Jyri Sarha (5):
  ASoC: davinci-mcasp: Set .symmetric_rates = 1 in snd_soc_dai_driver
  ASoC: simple-card: Add tdm slot mask support to simple-card
  ASoC: davinci-mcasp: Add set_tdm_slots() support
  ASoC: davinci-mcasp: Get rid of bclk_lrclk_ratio in private data
  ASoC: tlv320aic3x: Improve tdm support

 .../devicetree/bindings/sound/tdm-slot.txt         |  11 +-
 include/sound/simple_card.h                        |   2 +
 include/sound/soc.h                                |   2 +
 sound/soc/codecs/tlv320aic3x.c                     |  30 +-
 sound/soc/davinci/davinci-mcasp.c                  | 306 ++++++++++++++-------
 sound/soc/generic/simple-card.c                    |   8 +-
 sound/soc/soc-core.c                               |  25 ++
 7 files changed, 274 insertions(+), 110 deletions(-)

-- 
1.9.1
