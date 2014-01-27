From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Mon, 27 Jan 2014 16:51:06 +0100
Message-ID: <52E6806A.2090109@metafoo.de>
References: <y> <cover.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1390836773.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, Jean-Francois Moine <moinejf@free.fr>, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

I think you should try to get this in sync with the work Jean-Francois is
currently doing[1]. Having the HDMI transmitter register a CODEC device is
definitely the right approach, compared to the rather 'interesting'
constraints stuff you do in patch 4.

- Lars

[1] http://lkml.org/lkml/2014/1/27/85


On 01/27/2014 04:37 PM, Jyri Sarha wrote:
> Changes since RFC v2 version of the patches:
> - Dropped out already applied:
>   ASoC: hdmi-codec: Add devicetree binding with documentation
> - Addresses Mark's comments here:
>   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070605.html
>   - ASoC: davinci-evm: Add named clock reference to DT bindings
>     - Get rid of unnecessary castings
>     - Add mclk NULL checks
>     - Use devm_clk_get()
>     - Change clock name from "ti,codec-clock" to "mclk"
> - Address Mark's comments here:
>   http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/070606.html  - ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S bus
>     - Get rid of unnecessary castings
>     - Update commit message
>   - Add: ASoC: davinci-mcasp: Set BCLK divider if McASP is BCLK master
>     - Use snd_soc_params_to_bclk()
> 
> Changes since the first RFC version of the patches:
> - Drop out already applied: 
>   ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE playback format
> - Change sound node's compatible property
>   form: "ti,am33xx-beaglebone-black" to "ti,am33xx-beaglebone-black-audio"
> - Some minor style issue fixes from TI internal review
> 
> Jyri Sarha (8):
>   clk: add gpio controlled clock
>   ASoC: davinci-evm: Add named clock reference to DT bindings
>   ASoC: davinci-mcasp: Set BCLK divider if McASP is BCLK master
>   ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
>     bus
>   ASoC: davinci: HDMI audio build for AM33XX and TDA998x
>   drm/tilcdc: Add I2C HDMI audio config for tda998x
>   ARM: OMAP2+: omap2plus_defconfig: Enable tilcdc and TDA998X HDMI
>     support
>   ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
>     support
> 
>  .../devicetree/bindings/clock/gpio-clock.txt       |   21 ++
>  .../bindings/sound/davinci-evm-audio.txt           |   13 +-
>  arch/arm/configs/omap2plus_defconfig               |    5 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-gpio.c                             |  210 +++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
>  include/linux/clk-provider.h                       |   25 +++
>  sound/soc/davinci/Kconfig                          |   12 ++
>  sound/soc/davinci/Makefile                         |    1 +
>  sound/soc/davinci/davinci-evm.c                    |  211 +++++++++++++++++++-
>  sound/soc/davinci/davinci-mcasp.c                  |   20 ++
>  11 files changed, 534 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
>  create mode 100644 drivers/clk/clk-gpio.c
> 
