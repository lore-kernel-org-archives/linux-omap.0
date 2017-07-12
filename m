From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Wed, 12 Jul 2017 17:18:40 +0200
Message-ID: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
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
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This adds audio support to Motorola Droid 4.

Tested:
 - Playing via both DACs using Speaker, Earpiece, Headphone
 - Recording using internal Mic
 - Volume Controls

Known not to work:
 - 3.5mm detection support (requires closed source firmware,
   needs further investigation)
 - Modem / Bluetooth Audio (actually untested, but probably
   needs some quirks)

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
  dt-bindings: sound: add motorola,cpcap-audio-codec
  ASoC: codec: cpcap: new codec
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio
  ARM: dts: omap4-droid4: add soundcard

Tony Lindgren (1):
  ALSA: pcm: Export soc_dpcm_runtime_update

 .../bindings/sound/motorola,cpcap-audio-codec.txt  |   19 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    7 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   84 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1607 ++++++++++++++++++++
 sound/soc/soc-pcm.c                                |    2 +
 7 files changed, 1726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.13.2
