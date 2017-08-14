From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 00/11] ASoC: make snd_soc_platform_driver const
Date: Mon, 14 Aug 2017 17:08:39 +0530
Message-ID: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, plai@codeaurora.org, bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make snd_soc_platform_driver const.

Bhumika Goyal (11):
  ASoC: codecs: make snd_soc_platform_driver const
  ASoC: Intel: make snd_soc_platform_driver const
  ASoC: fsl: make snd_soc_platform_driver const
  ASoC: nuc900: make snd_soc_platform_driver const
  ASoC: omap: make snd_soc_platform_driver const
  ASoC: pxa: make snd_soc_platform_driver const
  ASoC: qcom: make snd_soc_platform_driver const
  ASoC: samsung: make snd_soc_platform_driver const
  ASoC: sh: make snd_soc_platform_driver const
  ASoC: txx9: make snd_soc_platform_driver const
  ASoC: soc-utils: make snd_soc_platform_driver const

 sound/soc/codecs/cs47l24.c                   | 2 +-
 sound/soc/codecs/rt5514-spi.c                | 2 +-
 sound/soc/codecs/wm5102.c                    | 2 +-
 sound/soc/codecs/wm5110.c                    | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c                  | 2 +-
 sound/soc/fsl/mpc5200_dma.c                  | 2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c  | 2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c    | 2 +-
 sound/soc/intel/skylake/skl-pcm.c            | 2 +-
 sound/soc/nuc900/nuc900-pcm.c                | 2 +-
 sound/soc/omap/omap-pcm.c                    | 2 +-
 sound/soc/pxa/mmp-pcm.c                      | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c                   | 2 +-
 sound/soc/qcom/lpass-platform.c              | 2 +-
 sound/soc/samsung/idma.c                     | 2 +-
 sound/soc/sh/dma-sh7760.c                    | 2 +-
 sound/soc/sh/fsi.c                           | 2 +-
 sound/soc/sh/rcar/core.c                     | 2 +-
 sound/soc/soc-utils.c                        | 2 +-
 sound/soc/txx9/txx9aclc.c                    | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

-- 
1.9.1
