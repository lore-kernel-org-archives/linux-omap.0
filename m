From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 0/6] Implement generic ASoC HDMI codec and
	use it in tda998x
Date: Tue, 8 Mar 2016 22:14:24 +0200
Message-ID: <cover.1457465383.git.jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, tony@atomide.com, broonie@kernel.org, arnaud.pouliquen@st.com, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tiwai@suse.de, tomi.valkeinen@ti.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

There is currently two other patch series[1][2] that depend on the
three first (ALSA-) patches of this series. It would be nice to get at
least those three applied sooner rather than later, so please tell me
if I can do anything to get those in.

BTW, I applied the relevant patches from the two series to on top of
this one. Obviously the two series conflicted with each other a bit and
also the IEC958 helper patch from [2] conflicted with the IEC958 patch
from my series (which is weird since Arnaud's series depends on my
series...). After resolving the conflicts everything compiled fine,
but for some reason neither the 'ELD' or IEC958 Playback Default'
appeared on my BBB. I'll try to find time to debug this further at
some point.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105509.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105502.html

Changes since v5
 - Rebased on top of the latest drm-next branch
 - Allow 32 bit samplewidth in snd_pcm_create_iec958_consumer() and
   snd_pcm_create_iec958_consumer_hw_params()
 - Propose new simpler DT binding for tda998x audio
 - Squash tda998x audio DT binding together with hdmi-codec integration

Changes since RFC v4,
 - Rebased on top of the latest drm-next branch
 - Split the hdmi-codec abort functionality into a separate patch for
   better visibility of what it is all about
   - This does not affect the tda998x patches as the abort
     functionality is not used
 - Drop S18_3* formats from I2S_FORMATS and add a comment about formats
   not supported by HDMI

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

Jyri Sarha (6):
  ALSA: pcm: add IEC958 channel status helper for hw_params
  ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders
  ASoC: hdmi-codec: Add audio abort() callback for video side to use
  drm/i2c: tda998x: Improve tda998x_configure_audio() audio related
    pdata
  drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding
  ARM: dts: am335x-boneblack: Add HDMI audio support

 .../devicetree/bindings/display/bridge/tda998x.txt |  18 +
 arch/arm/boot/dts/am335x-boneblack.dts             |  71 +++-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 271 ++++++++++++--
 include/drm/i2c/tda998x.h                          |  24 +-
 include/dt-bindings/display/tda998x.h              |   7 +
 include/sound/hdmi-codec.h                         | 104 ++++++
 include/sound/pcm_iec958.h                         |   2 +
 sound/core/pcm_iec958.c                            |  53 ++-
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/hdmi-codec.c                      | 411 +++++++++++++++++++++
 12 files changed, 898 insertions(+), 72 deletions(-)
 create mode 100644 include/dt-bindings/display/tda998x.h
 create mode 100644 include/sound/hdmi-codec.h
 create mode 100644 sound/soc/codecs/hdmi-codec.c

-- 
1.9.1
