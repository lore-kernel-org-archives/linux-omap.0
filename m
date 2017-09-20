From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/3] ASoC: Handle return value of devm_kasprintf
Date: Wed, 20 Sep 2017 15:36:08 +0530
Message-ID: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

devm_kasprintf() can fail here and we must check its return value.

Arvind Yadav (3):
  [PATCH 1/3] ASoC: davinci-mcasp: Handle return value of devm_kasprintf
  [PATCH 2/3] ASoC: fsl-asoc-card: Handle return value of devm_kasprintf
  [PATCH 3/3] ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf

 sound/soc/davinci/davinci-mcasp.c | 12 ++++++++++++
 sound/soc/fsl/fsl-asoc-card.c     |  2 ++
 sound/soc/omap/omap-hdmi-audio.c  |  3 +++
 3 files changed, 17 insertions(+)

-- 
1.9.1
