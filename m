From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/3] Motorola Droid 4 Audio Support
Date: Fri,  7 Jul 2017 18:42:26 +0200
Message-ID: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
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

I got working sound on Droid 4 with mainline \o/. The codec is
currently missing support for detecting if something has been
plugged into the 3.5mm connector, since that seems to require
some closed source firmware and needs further investigation. I
think this can be added later.

Tested:
 - Playing via [HiFi] using Speaker, Earpiece, Headphone
 - Playing via [Voice] using Speaker, Earpiece, Headphone
 - Recording via [Voice] using Mic
 - Volume Controls
 - Checking that DAPM graph look correct

-- Sebastian

Sebastian Reichel (3):
  ASoC: codec: cpcap: new codec
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: omap4-droid4: add soundcard

 .../bindings/sound/motorola,cpcap-audio-codec.txt  |   19 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    6 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   76 ++
 sound/soc/codecs/Kconfig                           |    3 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1422 ++++++++++++++++++++
 6 files changed, 1528 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.13.2
