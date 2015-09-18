From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v4 0/8] Implement generic ASoC HDMI codec
	and use it in tda998x
Date: Fri, 18 Sep 2015 14:06:37 +0300
Message-ID: <cover.1442572860.git.jsarha@ti.com>
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
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, moinejf@free.fr, tony@atomide.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Changes since RFC v3,
ASoC side:
- Add "ALSA: pcm: add IEC958 channel status helper for hw_params"
- Add "tda998x: Improve tda998x_configure_audio() audio related pdata"
- use snd_pcm_create_iec958_consumer_hw_params() to construct the stream header
- Remove set_clk() callback from hdmi-codec. It is not needed for now.
- Refer to stream header in AIF as specified in HDMI standard
- Set current_stream to NULL only after video side audio_shutdown() has
  been called. Avoid potential race if video side attempts to abort audio
  at the same time.
- No need to have video side device pointer in the hdmi codec's pdata as
  it is found from dev->parent.
- Fix hdmi-codec enum: DAI_ID_I2C > DAI_ID_I2S
- Improve audio_startup API comment
- Make improved checkpatch happy 
  - BUG_ON > WARN_ON
  - put */ ending the block comment to a separate line

DRM side:
- Fix tda998x get_eld() locking
- Change tda998x audio parameters in pdata to more generic, that can
  be readily used in tda998x_audio_config()
- Rename and restructure audio port related private data members to
  be more descriptive
- Require audio configuration trough ASoC hdmi-codec if HDMI audio is
  configured trough DT binding. 

DTS:
- Increase McASP fifo usage form 1 to 32

The binding for tda998x is taken from Jean Francois' patch series[1] on
the same subject. The implementation of the of-node parsing has some
minor changes from my self.

Here is what I think at least could or should still be done, but non of
that stuff does not sounds critical right now.
 
Missing from tda998x driver side
- hdmi_codec_ops audio_startup() implementation for audio abort support
- multi channel audio support (I would need specs and preferably some
  HW to test for this).

Missing from ASoC side generic implementation:
- channel_allocation handling is completely left for the video side driver,
  see if ASoC side could help in any way
- snd_soc_jack functionality to handle hdmi cable plug/unplug events

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/095596.html

Best regards,
Jyri

Jean-Francois Moine (1):
  drm/i2c: tda998x: Add support of a DT graph of ports

Jyri Sarha (7):
  ASoC: hdmi: Remove obsolete dummy HDMI codec
  ALSA: pcm: add IEC958 channel status helper for hw_params
  ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders
  drm/i2c: tda998x: Remove include/sound/tda998x.h and fix graph parsing
  drm/i2c: tda998x: Improve tda998x_configure_audio() audio related
    pdata
  drm/i2c: tda998x: Register ASoC HDMI codec for audio functionality
  ARM: dts: am335x-boneblack: Add HDMI audio support

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 +++
 arch/arm/boot/dts/am335x-boneblack.dts             |  90 ++++-
 drivers/gpu/drm/armada/armada_drv.c                |  25 +-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 319 +++++++++++++---
 include/drm/i2c/tda998x.h                          |  24 +-
 include/sound/hdmi-codec.h                         | 104 ++++++
 include/sound/pcm_iec958.h                         |   2 +
 sound/core/pcm_iec958.c                            |  52 ++-
 sound/soc/codecs/Kconfig                           |   4 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/hdmi-codec.c                      | 404 +++++++++++++++++++++
 sound/soc/codecs/hdmi.c                            | 109 ------
 13 files changed, 985 insertions(+), 204 deletions(-)
 create mode 100644 include/sound/hdmi-codec.h
 create mode 100644 sound/soc/codecs/hdmi-codec.c
 delete mode 100644 sound/soc/codecs/hdmi.c

-- 
1.9.1
