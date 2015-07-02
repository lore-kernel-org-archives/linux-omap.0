From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/20] ARM: DTS: am335x/am43xx: Audio support and fixes for audio
Date: Thu, 2 Jul 2015 17:06:15 +0300
Message-ID: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Add patch for omap2plus_defconfig to enable needed audio drivers
- Included other board patches since they all need the change in
  omap2plus_defconfig

Enable the simple card in omap2plus_defconfig as more boards are using that for
audio support.

am437x-sk-evm, am335x-evmsk and am335x-evm:
There is no reason to use the davinci-evm machine driver's compatible for audio
support since the setup is simple and the common simple-audio-card can handle it
just fine.

am43xx-epos-evm, am437x-gp-evm:
Add audio support via simple-card

Regards,
Peter
---
Peter Ujfalusi (20):
  ARM: omap2plus_defconfig: Enable audio related config options
  ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
  ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
    support
  ARM: DTS: am43xx-epos-evm: Add gpio-hog for configuring the
    display/audio mux
  ARM: DTS: am43xx-epos-evm: Add regulator for VBAT and DCDC4 of
    tps65218
  ARM: DTS: am43xx-epos-evm: McASP1 node for audio support
  ARM: DTS: am43xx-epos-evm: Add node for tlv320aic3111 audio codec
  ARM: DTS: am43xx-epos-evm: Enable analog audio via simple-card
  ARM: DTS: am437x-gp-evm: Add gpio-hog for configuring the
    display/audio mux
  ARM: DTS: am437x-gp-evm: Rename fixed regulator vmmcsd_fixed to
    evm_v3_3d
  ARM: DTS: am437x-gp-evm: Add node for tlv320aic3106 audio codec
  ARM: DTS: am437x-gp-evm: McASP1 node for audio support
  ARM: DTS: am437x-gp-evm: Enable analog audio via simple-card
  ARM: DTS: am335x-evmsk: Fix mcasp1 node's indentation
  ARM: DTS: am335x-evmsk: Add sleep pin settings for mcasp1
  ARM: DTS: am335x-evmsk: Switch using simple-audio-card for audio
    support
  ARM: DTS: am335x-evm: Fix mcasp1 node's indentation
  ARM: DTS: am335x-evm: Rename pinctrl section for McASP1
  ARM: DTS: am335x-evm: Add sleep pin settings for mcasp1
  ARM: DTS: am335x-evm: Switch using simple-audio-card for audio support

 arch/arm/boot/dts/am335x-evm.dts     |  69 +++++++++++++------
 arch/arm/boot/dts/am335x-evmsk.dts   |  62 ++++++++++++-----
 arch/arm/boot/dts/am437x-gp-evm.dts  | 108 +++++++++++++++++++++++++----
 arch/arm/boot/dts/am437x-sk-evm.dts  |  45 +++++++++---
 arch/arm/boot/dts/am43x-epos-evm.dts | 130 +++++++++++++++++++++++++++++++----
 arch/arm/configs/omap2plus_defconfig |   3 +
 6 files changed, 340 insertions(+), 77 deletions(-)

-- 
2.4.5
