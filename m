From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/7] ASoC: Mark expected switch fall-throughs
Date: Fri, 3 Aug 2018 11:26:59 -0500
Message-ID: <cover.1533312229.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (7):
  ASoC: davinci-i2s: mark expected switch fall-through
  ASoC: fsl_esai: Mark expected switch fall-through
  ASoC: Intel: skl-pcm: Mark expected switch fall-through
  ASoC: omap-dmic: Mark expected switch fall-throughs
  ASoC: omap-mcpdm: MArk expected switch fall-throughs
  ASoC: samsung: i2s: Mark expected switch fall-through
  ASoC: core: mark expected switch fall-through

 sound/soc/davinci/davinci-i2s.c   | 1 +
 sound/soc/fsl/fsl_esai.c          | 1 +
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 sound/soc/omap/omap-dmic.c        | 2 ++
 sound/soc/omap/omap-mcpdm.c       | 4 ++++
 sound/soc/samsung/i2s.c           | 1 +
 sound/soc/soc-core.c              | 1 +
 7 files changed, 11 insertions(+)

-- 
2.7.4
