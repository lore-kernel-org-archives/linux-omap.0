From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 00/11] Fix AM335x-evm analog audio support
Date: Thu, 19 Sep 2013 14:29:33 +0300
Message-ID: <cover.1379590035.git.jsarha@ti.com>
References: <cover.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The RFC version of patches can been found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066178.html
The v2 version of patches can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066379.html

Changes since v2
  [PATCH v2 01/11] ASoC: davinci-evm: Move sysclk logic away from evm_hw_params
   - no change
  [PATCH v2 02/11] ASoC: davinci-evm: Add device tree binding
   - no change
  [PATCH v2 03/11] ASoC: davinci-mcasp: Add DMA register locations to DT
   - no change
  [PATCH v2 04/11] ASoC: davinci-mcasp: Extract DMA channels directly from DT
   - no change
  [PATCH v2 05/11] ASoC: davinci-mcasp: Remove interrupt property from DT bindin
   - restore binding but make it optional and add interrupt-names property
  [PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio
   - SND_DAVINCI_SOC help "Machine driver for ..." -> "Platform driver for ..."
   - SND_AM33XX_SOC_EVM depends on SND_DAVINCI_SOC && SOC_AM33XX 
   - SND_AM33XX_SOC_EVM does not selcet SND_DAVINCI_SOC
  [PATCH v2 07/11] ASoC: tlv320aic3x: Add regulators to DT bindings document
   - no change
  [PATCH v2 08/11] ASoC: tlv320aic3x: Add codec pins to DT bindings document
   - no change
  [PATCH v2 09/11] ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
   - restore interrupt property and add interrupt-names property
  [PATCH v2 10/11] ARM/dts: am33xx: mcasp: Add new dma register location to reg-property
   - no change
  [PATCH v2 11/11] ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
   - no change

Changes from RFC to v2
 - Dropped out "ASoC: davinci-mcasp: Add pinctrl support" since
   driver core is taking care of this now.
 - Cleanup am33xx audio build
 - Add regulators to tlv320aic3x DT binding document
 - Remove dm365-voice-codec-audio DT support as it has never
   been tested an probably does not work
 - Add output pins and Line In connector to davinci-evm-audio DT binding doc
 - Remove asp_chan_q and ram_chan_q properties from mcasp DT node
   in DT mode mcasp is hardcoded to event queue 0 (highest priority)
 - Add pins to tlv320aic3x DT bindings document. If I misunderstood
   Marks comment and this patch is not needed, then just leave it out
 Changes based on TI internal discussions
 - Move system clock rate logic away from from evm_hw_params soc-op
 - Remove unnecesary #if defined(CONFIG_OF) from davinci-evm.c
 - Make dma property DT binding document more exact
 - Add only "dma" reg location instead of separate "dma-tx" and "dma-rx"
 - Primarily look for "mpu" reg property, but fall back to index 0 if not found
 - Remove interrupt property from mcasp DT node as it is not used
 - Remove #address-cells and #size-cells mcasp properties as they are not needed

This set of patches fixes the basic audio support for am335x-evm. It
should also be relatively simple to add the necessary nodes to
relevant dts files to get BeagleBone + AudioCape and am335x-evmsk
working too.

The patch set depends on following patches:

[PATCH v11 4/8] ARM: dts: add AM33XX EDMA support 
     https://lkml.org/lkml/2013/6/18/49

[PATCH v11 5/8] ARM: dts: add AM33XX SPI DMA support
     https://lkml.org/lkml/2013/6/18/55

[PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA resources
     https://lkml.org/lkml/2013/7/22/441

I have tried my best not to break the existing support for older
davinci boards, but since I do not have those boards I can not be
sure.

Some commit comments refer to a dmaengine based davinci audio
implementation which is planned for but nothing has been done yet.

Best regards,
Jyri

Darren Etheridge (1):
  ARM/dts: am335x-evm: Add audio support for am335x-evm.dts

Hebbar, Gururaja (2):
  ASoC: davinci-evm: Add device tree binding
  ASoC: davinci: Add support for AM33xx SoC Audio

Jyri Sarha (7):
  ASoC: davinci-evm: Move sysclk logic away from evm_hw_params
  ASoC: davinci-mcasp: Add DMA register locations to DT
  ASoC: davinci-mcasp: Extract DMA channels directly from DT
  ASoC: davinci-mcasp: Interrupts property to optional and add
    interrupt-names
  ASoC: tlv320aic3x: Add regulators to DT bindings document
  ASoC: tlv320aic3x: Add codec pins to DT bindings document
  ARM/dts: am33xx: mcasp: Add new dma register location to reg-property

Pantelis Antoniou (1):
  ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries

 .../bindings/sound/davinci-evm-audio.txt           |   58 ++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |   17 +-
 .../devicetree/bindings/sound/tlv320aic3x.txt      |   26 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   56 ++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   29 +++
 include/linux/platform_data/davinci_asp.h          |    2 +
 sound/soc/davinci/Kconfig                          |   18 +-
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |  184 +++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.c                  |  106 +++++++----
 10 files changed, 435 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
