From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 0/2] ASoC: omap: Deprecate omap-pcm for
	sdma-pcm
Date: Wed, 9 May 2018 14:03:54 +0300
Message-ID: <20180509110356.26473-1-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v4:
- Really rebased on a clean tree
- Dropped the already applied patches

Changes since v3:
- Rebased to make sure it applies cleanly (I had one local Kconfig patch)

Changes since v2:
- Return -ENODEV from sdma_pcm_platform_register() in case !CONFIG_SND_SDMA_SOC

Changes since v1:
- Rebased on the n810 patches (Kconfig conflict)
- Delete the omap-pcm as the last step instead of keeping the .c/.h file.
  If there is a need it can be resurrected with a simple revert.
- I left out the Acked-by from Jarkko for the last patch since I have changed it

omap-pcm served us well over the years, but there is no reason to keep it around
as we can rely on generic dmaengine_pcm code without the need to maintain custom
code.

The series has been tested on:
omap2 n810, omap3 beagle-xm, omap4 PandaES, omap4 Blaze (SDP),
am57xx beagle-x15, dra7 evm.

McBSP, McASP, McPDM, DMIC and HDMI audio was tested and I have found no issue
with them.

I was not able to test on OMAP1 for various reasons, but mainly because the
Nokia 770 audio is not supported in mainline...

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: davinci-mcasp: Convert to use the sdma-pcm instead of omap-pcm
  ASoC: omap: Delete the obsolete omap-pcm

 include/sound/omap-pcm.h          |  30 ----
 sound/soc/davinci/Kconfig         |   2 +-
 sound/soc/davinci/davinci-mcasp.c |   8 +-
 sound/soc/omap/Kconfig            |   3 +-
 sound/soc/omap/Makefile           |   2 -
 sound/soc/omap/omap-pcm.c         | 262 ------------------------------
 6 files changed, 6 insertions(+), 301 deletions(-)
 delete mode 100644 include/sound/omap-pcm.h
 delete mode 100644 sound/soc/omap/omap-pcm.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
