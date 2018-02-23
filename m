From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 0/5] Motorola Droid 4 Audio Support
Date: Fri, 23 Feb 2018 21:02:49 +0100
Message-ID: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
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
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This adds audio support to Motorola Droid 4. I dropped the
regulator from the DT binding as requested by Mark.

Tested:
 - Playing via both DACs using Speaker, Earpiece, Headphone
 - Recording using internal Mic
 - Volume Controls

Known not to work:
 - 3.5mm detection support (requires closed source firmware,
   needs further investigation)
 - Modem / Bluetooth Audio (this needs something more sophisticated
   than the audio-graph-card driver. I will have a look once
   the basic support has been merged)

Changes since PATCHv4:
 * Replace verbose GPL text with SPDX header
 * Use "GPL v2" as MODULE_LICENSE
 * Drop "default MFD_CPCAP" for the codec driver
 * Use SOC_SINGLE instead of SOC_ENUM for Phase invert switches
 * Find DT node by node name instead of by compatible property
  - Drop Acked-by from Rob Herring
 * Add new patch for MFD driver to implement the mentioned
   DT change

Changes since PATCHv3:
 * Drop regulator from DT binding, request VAUDIO from
   global regulator namespace instead

Changes since PATCHv2:
 * Fix a whitespace issue
 * Fix const notes Takashi provided
 * Fix a DAPM route issue I accidently introduced in v2

Changes since PATCHv1:
 * Add patch from Tony exporting soc_dpcm_runtime_update
 * Integrate DT patch for vaudio initial mode
 * Split dt-binding from codec patch and add Ack from Rob
 * Fix CPCAP position in Kconfig/Makefile
 * Avoid "err +=" constructs
 * Simplify reset function
 * Drop cpcap_audio_read/write helpers
 * Do not use tertiary operator for mute register value
 * Update Input Mux logic
 * Switch from simple-audio-card to audio-graph-card

-- Sebastian

Sebastian Reichel (5):
  dt-bindings: mfd: motorola-cpcap: document audio-codec
  ASoC: codec: cpcap: new codec
  mfd: motorola-cpcap: Add audio-codec support
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: omap4-droid4: add soundcard

 .../devicetree/bindings/mfd/motorola-cpcap.txt     |   42 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   13 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   78 +
 drivers/mfd/motorola-cpcap.c                       |   51 +-
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1568 ++++++++++++++++++++
 7 files changed, 1757 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.16.1
