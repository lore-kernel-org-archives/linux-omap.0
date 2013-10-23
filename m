From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 0/4] Fix AM335x-evm analog audio support
Date: Wed, 23 Oct 2013 15:30:12 +0300
Message-ID: <cover.1382529191.git.jsarha@ti.com>
References: <cover.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54208 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab3JWMad (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Oct 2013 08:30:33 -0400
In-Reply-To: <cover.1379409268.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, joelf@ti.com, tony@atomide.com, Jyri Sarha <jsarha@ti.com>

The v5 version of patches can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067443.html

Changes since v5
   - Rebase on top of 3685646e from:
     - git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound topic/davinci
   - Drop patches already applied to Benoit Cousson's for_3.13/dts branch:
     - [PATCH v5 08/12] ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree
     - [PATCH v5 09/12] ARM/dts: am33xx: mcasp: Add location for data port
     - [PATCH v5 10/12] ARM/dts: am335x-evm: Add audio support for
     - [PATCH v5 11/12] ARM/dts: am335x-evmsk: Audio support
   - Drop patches already applied to Mark Brown's topic/davinci branch:
     - [PATCH v5 03/12] ASoC: davinci-mcasp: Add location for data port
     - [PATCH v5 04/12] ASoC: davinci-mcasp: Extract DMA channels directly
     - [PATCH v5 05/12] ASoC: davinci-mcasp: Change compatible property
     - [PATCH v5 06/12] ASoC: davinci-mcasp: Improve DT bindings document
     - [PATCH v5 07/12] ASoC: davinci-mcasp: Remove redundant num-serializer DT 
   - Restore patch [PATCH v3 03/11] and squash [PATCH v5 01/12] into it
     - Adds: ASoC: davinci-mcasp: Add DMA register locations to DT
     - Drops: [PATCH v5 01/12] ASoC: davinci: Fix AM33xx SoC Audio support 
   - Change: [PATCH v5 02/12] ASoC: davinci-evm: Add device tree binding
     - Remove TLV320AIC3X pins from davinci-evm-audio binding document
     - Use devm_snd_soc_register_card in davinci-evm.c
     - Restore if defined(CONFIG_OF) #endif inside evm_init() and evm_exit()
       in davinci-evm.c to prevent compile failure if building without CONFIG_OF
   - Add: ASoC: davinci-mcasp: Remove last reference to num-serializer in DT doc

The patches were tested by merging the topic/davinci branch and patches on 
top of for-next branch. The patches do not compile on topic/davinci because
of devm_snd_soc_register_card() usage.

Best regards,
Jyri

Hebbar, Gururaja (2):
  ASoC: davinci: Add support for AM33xx SoC Audio
  ASoC: davinci-evm: Add device tree binding

Jyri Sarha (2):
  ASoC: davinci-mcasp: Remove last reference to num-serializer in DT
    doc
  arm: omap2plus_defconfig: enable AM33xx SOC EVM audio

 .../bindings/sound/davinci-evm-audio.txt           |   42 +++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |    1 -
 arch/arm/configs/omap2plus_defconfig               |    2 +
 sound/soc/davinci/Kconfig                          |   18 ++-
 sound/soc/davinci/Makefile                         |    1 +
 sound/soc/davinci/davinci-evm.c                    |  124 +++++++++++++++++++-
 6 files changed, 182 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5

