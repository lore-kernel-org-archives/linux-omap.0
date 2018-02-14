From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv4 0/4] Motorola Droid 4 Audio Support
Date: Wed, 14 Feb 2018 23:07:37 +0100
Message-ID: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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
 - Modem / Bluetooth Audio (needs different DAI/I2S config)

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

Sebastian Reichel (4):
  dt-bindings: sound: add motorola,cpcap-audio-codec
  ASoC: codec: cpcap: new codec
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: omap4-droid4: add soundcard

 .../bindings/sound/motorola,cpcap-audio-codec.txt  |   17 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    5 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   84 ++
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1588 ++++++++++++++++++++
 6 files changed, 1701 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
