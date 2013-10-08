From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 00/10] Fix AM335x-evm analog audio support
Date: Tue, 8 Oct 2013 22:36:31 +0300
Message-ID: <cover.1381259962.git.jsarha@ti.com>
References: <cover.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787Ab3JHTgx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 15:36:53 -0400
In-Reply-To: <cover.1379409268.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, Jyri Sarha <jsarha@ti.com>

The v3 version of patches can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066728.html
The v2 version of patches can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066379.html
The RFC version of patches can been found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066178.html

Changes since v3
  - Rebased on top of v3.12-rc4
  - Drop already applied patches:
    - [PATCH v2 01/11] ASoC: davinci-evm: Move sysclk logic away from evm_hw_params
    - [PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio
    - [PATCH v2 07/11] ASoC: tlv320aic3x: Add regulators to DT bindings document
    - [PATCH v2 08/11] ASoC: tlv320aic3x: Add codec pins to DT bindings document
  - Add: ASoC: davinci: Fix AM33xx SoC Audio support
    - Contains the fixes from Peter:
      http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066448.html
    - Contents of this patch were squashed to "[PATCH v3 06/11] ASoC:
      davinci: Add support for AM33xx SoC Audio", but since the patch v2 was
      already applied the changes are here as a separate patch.
  - Add: ASoC: davinci-mcasp: Remove redundant num-serializer DT parameter
  - Change: ASoC: davinci-mcasp: Add DMA register locations to DT
    to: ASoC: davinci-mcasp: Add location for data port registers to DT
    - Use more accurate name for data port register location
    - Improve commit message
  - Change: ASoC: davinci-mcasp: Interrupts property to optional and add interrupt-names
    to: ASoC: davinci-mcasp: Improve DT bindings document
    - Remove #address-cells and #size-cells
    - Bracket named interrupts tuples
    - Add missing "for" to serial-dir description
    - Improve tdm-slots description
    - Improve op-mode description
    - Add pinctrl-names and pinctrl-0 descriptions
  - Change: ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
    - Use board specific name 'AM335x-EVM' for the soundcard.
    - Use the board specific tlv320aic3106 codec. Use this name instead of generic
      tlv320aic3x.
    - Remove num-serializer property from mcasp node
    - Remove blank lines
  - Change: ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
    - Bracket all named property tuples
  - Add: ARM/dts: am335x-evmsk: Audio support
  - The other patches in the set not mentioned here are identical to their
    earlier version

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

The patch set depends on following patches:

[PATCH v11 4/8] ARM: dts: add AM33XX EDMA support 
     https://lkml.org/lkml/2013/6/18/49

[PATCH v11 5/8] ARM: dts: add AM33XX SPI DMA support
     https://lkml.org/lkml/2013/6/18/55

[PATCH v2 01/11] ASoC: davinci-evm: Move sysclk logic away from evm_hw_params 
     http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066381.html

[PATCH v2 06/11] ASoC: davinci: Add support for AM33xx SoC Audio 
     http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066385.html

This set of patches fixes the basic audio support for am335x-evm and
am335x-evmsk. It should be relatively simple to add the necessary
nodes to relevant dts files to get BeagleBone + AudioCape working too.

I have tried my best not to break the existing support for older
davinci boards, but since I do not have those boards I can not be
sure.

Some commit comments refer to a dmaengine based davinci audio
implementation which is planned for but nothing has been done yet.

Best regards,
Jyri

Darren Etheridge (1):
  ARM/dts: am335x-evm: Add audio support for am335x-evm.dts

Hebbar, Gururaja (1):
  ASoC: davinci-evm: Add device tree binding

Jyri Sarha (5):
  ASoC: davinci: Fix AM33xx SoC Audio support
  ASoC: davinci-mcasp: Add location for data port registers to DT
  ASoC: davinci-mcasp: Extract DMA channels directly from DT
  ASoC: davinci-mcasp: Improve DT bindings document
  ARM/dts: am33xx: mcasp: Add location for data port registers to
    reg-property

Pantelis Antoniou (1):
  ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries

Peter Ujfalusi (2):
  ASoC: davinci-mcasp: Remove redundant num-serializer DT parameter
  ARM/dts: am335x-evmsk: Audio support

 .../bindings/sound/davinci-evm-audio.txt           |   58 +++++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |   38 ++++--
 arch/arm/boot/dts/am335x-evm.dts                   |   54 +++++++++
 arch/arm/boot/dts/am335x-evmsk.dts                 |   51 ++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   29 +++++
 include/linux/platform_data/davinci_asp.h          |    2 +
 sound/soc/davinci/Kconfig                          |    4 +-
 sound/soc/davinci/davinci-evm.c                    |  120 +++++++++++++++++-
 sound/soc/davinci/davinci-mcasp.c                  |  128 ++++++++++++--------
 9 files changed, 417 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5

