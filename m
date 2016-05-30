From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v1 00/14] clk/mfd/ASoC/ARM: OMAP4/5:
	McPDM/twl6040 pdmclk support
Date: Mon, 30 May 2016 11:55:08 +0300
Message-ID: <20160530085522.30398-1-peter.ujfalusi@ti.com>
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
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Added Rob's Acked-by to patch 5 and 14
- Check the return value of clk_prepare_enable() calls in the last patch

this is something I wanted to do for a long time...

First of all: sorry for the cross domain series. I did tested alone all the
domain patches and they are not causing any regression. When they come together
we will have ability to control the pdmclk needed by McPDM.

CLK patches:
The driver was w/o DT support and needed some cleanup so we can use the driver.
I have also renamed it to twl6040-pdmclk from twl6040-clk to be precise.

MFD patches:
The regmap_sync() was not working since the twl6040 does not support bulk access
and now we are going to create the needed child for the pdmclk.

ARM patches:
Updatding the board DTS files and add the needed lines for the pdmclk.

ASoC patches:
The machine driver needs to select the twl6040-clk driver as it will be used
by the omap-mcpdm.
I needed to do some cleanup and add also suspend/resume support before adding
the code for pdmclk handling since I don't want to keep the twl6040 powered on
when the board is suspended. At the moment it is not possible to do true
dynamic twl6040 power up/down due to pop noises, but I will be looking at that
later.
The driver in the future will fail if it is not able to get the pdmclk to avoid
kernel crash (McPDM registers are not accessible when pdmclk is not available).

I have tested the patches by domain and also in all (I hope) permutation they
could be. I have not experienced any regression.

Regards,
Peter
---
Peter Ujfalusi (14):
  clk: twl6040: Correct clk_ops
  clk: twl6040: Register the clock as of_clk_provider
  clk: twl6040: Rename the driver and use consistent names in the code
  mfd: twl6040: The chip does not support bulk access
  mfd: twl6040: Register child device for twl6040-pdmclk
  ARM: dts: omap5-board-common: Add pdmclk binding for audio
  ARM: dts: omap4-panda-common: Add pdmclk binding for audio
  ARM: dts: omap4-sdp: Add pdmclk binding for audio
  ARM: dts: omap4-var-som-om44: Add pdmclk binding for audio
  ARM: dts: omap4-duovero: Add pdmclk binding for audio
  ASoC: omap: Kconfig: SND_OMAP_SOC_OMAP_ABE_TWL6040 to select
    CLK_TWL6040
  ASoC: omap-mcpdm: Move the WD enable write inside
    omap_mcpdm_open_streams()
  ASoC: omap-mcpdm: Support for suspend resume
  ASoC: omap-mcpdm: Add support for pdmclk clock handling

 Documentation/devicetree/bindings/mfd/twl6040.txt  |  1 +
 .../devicetree/bindings/sound/omap-mcpdm.txt       | 10 +++
 arch/arm/boot/dts/omap4-duovero.dtsi               |  5 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  5 ++
 arch/arm/boot/dts/omap4-sdp.dts                    |  5 ++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |  5 ++
 arch/arm/boot/dts/omap5-board-common.dtsi          |  5 ++
 drivers/clk/clk-twl6040.c                          | 80 ++++++++++++---------
 drivers/mfd/twl6040.c                              |  6 ++
 include/linux/mfd/twl6040.h                        |  2 +-
 sound/soc/omap/Kconfig                             |  1 +
 sound/soc/omap/omap-mcpdm.c                        | 84 ++++++++++++++++++++--
 12 files changed, 170 insertions(+), 39 deletions(-)

-- 
2.8.3
