From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: tpa6130a2: model handling cleanup
Date: Tue, 30 Aug 2011 14:39:51 +0300
Message-ID: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Small cleanup for the tpa6130a2 driver for model handling:
Remove the model_id from platform_data, and use the device name/device_data
to distinguish between the supported models of TPA.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: tpa6130a2: Model support cleanup
  OMAP: RX51: No need to configure the tpa_model
  ASoC: tpa6130a2: Remove model_id from platform data

 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 -
 include/sound/tpa6130a2-plat.h               |    6 ------
 sound/soc/codecs/tpa6130a2.c                 |   12 +++++++++---
 3 files changed, 9 insertions(+), 10 deletions(-)

-- 
1.7.6.1
