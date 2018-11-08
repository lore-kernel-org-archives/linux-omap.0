From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/8] ASoC: omap-mcbsp: Cleanup and split
	core/sidetone support
Date: Thu, 8 Nov 2018 09:29:52 +0200
Message-ID: <20181108073000.21114-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v2:
- Split the dma_data addr and maxburst cleanup patches
- Added Jarkko's Acked-by tot he series.

Changes since v1:
- Two patch added to address the code move triggered few warnings from build.
  One of them is around mcbsp->pdata checks (not valid complaint), the other is
  that we set -EINVAL to unsigned variables (they were not used in that case)

While preparing for merging the davinci and omap directories (I will send the
series for that shortly) I have taken some time to do cleanup on the McBSP
driver.

The mcbsp.c/h files were the result when we moved code from arch/arm/plat-omap
to sound/soc/omap/ a long time ago and it contained code for McBSP core and the
OMAP3 sidetone functionality.

With this series I tried to split the core and sidetone code to separate files.

There were two reasons for this:
1. to have the OMAP specific DAI driver files prefixed with omap-* under the new
   sound/soc/ti/ directory
2. easier to find functions as all sidetone code is in separate file.

Regards,
Peter
---
Peter Ujfalusi (8):
  ASoC: omap-mcbsp: Clean up dma_data addr initialization code
  ASoC: omap-mcbsp: Skip dma_data.maxburst initialization
  ASoC: omap-mcbsp: Clean up the interrupt handlers
  ASoC: omap-mcbsp: Simplify the mcbsp_start/_stop function parameters
  ASoC: omap-mcbsp: Move out the FIFO check from set_threshold and
    get_delay
  ASoC: omap-mcbsp: Re-arrange files for core McBSP and Sidetone
    function split
  ASoC: omap-mcbsp: Remove redundant check for mcbsp->pdata
  ASoC: omap-mcbsp: No need to initialize max_xx_thres when it is not
    used

 sound/soc/omap/Makefile                       |    2 +-
 sound/soc/omap/mcbsp.c                        | 1104 -----------------
 sound/soc/omap/{mcbsp.h => omap-mcbsp-priv.h} |  126 +-
 sound/soc/omap/omap-mcbsp-st.c                |  516 ++++++++
 sound/soc/omap/omap-mcbsp.c                   |  852 ++++++++++---
 sound/soc/omap/omap-mcbsp.h                   |    8 +-
 6 files changed, 1278 insertions(+), 1330 deletions(-)
 delete mode 100644 sound/soc/omap/mcbsp.c
 rename sound/soc/omap/{mcbsp.h => omap-mcbsp-priv.h} (70%)
 create mode 100644 sound/soc/omap/omap-mcbsp-st.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
