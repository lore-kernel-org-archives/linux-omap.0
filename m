From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v9 0/7] Implement generic ASoC HDMI codec and
	use it in tda998x
Date: Thu, 31 Mar 2016 16:35:57 +0300
Message-ID: <cover.1459431292.git.jsarha@ti.com>
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

Couple of minor changes since v8 to ALSA/ASoC side patches. The series
is based on top of drm-next. However, it does not look like there is
enough attention to the DRM side so that the tda998x patches would get
in any time soon. So I am happy to rebase the first ALSA-side patches
on top of Mark Brown's for-next tree, for instance, if they would have
a change to go in on their own. The first two IEC958 helper patches
should apply as such.

There is currently two other patch series[2][3] that depend on the
first three (ALSA-) patches of this series. The third ("ASoC:
hdmi-codec: Add audio abort() callback for video side to use") is
currently not used and can be dropped if so decided. The rest depends
on those the first patches and adds hdmi-audio support for
Beaglebone-black.

Best regards,
Jyri

[1] "[PATCH v6 0/6] Implement generic ASoC HDMI codec and use it in tda998x"
    http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105524.html
[2] "[PATCH v6 00/10] ASoC: Add mediatek HDMI codec support" by Philipp Zabel 
    http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105509.html
[3] "[RFC v2 0/6] sti: add audio interface to the hdmi driver"
    http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103374.html
    and "[PATCH v4 0/6] add IEC958 channel status control helpers"
    http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105502.html
    by Arnaud Pouliquen

Changes since v8
* "ALSA: pcm: add IEC958 channel status helper for hw_params"
  - Split out the 32 bit support
  - add: "ALSA: pcm: Allow 32 bit sample format in IEC958 channel status helper"
* "ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders"
  - Set hw_params->msbits to 24 in hw_params() callback if sample width is
    greater than 24 bits

Changes since v7
* "drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding"
  - Remove the unused "int ret" variable from tda998x_configure_audio()

Changes since v6
* "ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders"
 - Add "Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>" and
   "Tested-by: Philipp Zabel <p.zabel@pengutronix.de>", no other changes
* "ALSA: pcm: add IEC958 channel status helper for hw_param"
 - Added kernel-doc for snd_pcm_create_iec958_consumer_hw_params()
* "drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding"
 - Use PTR_ERR_OR_ZERO() in tda998x_audio_codec_init()
 - Fix possible uninitialized use of 'size' in tda998x_get_audio_ports()
 - Store audio configuration in tda998x_audio_hw_params() instead of
   tda998x_configure_audio().

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

Jyri Sarha (7):
  ALSA: pcm: add IEC958 channel status helper for hw_params
  ALSA: pcm: Allow 32 bit sample format in IEC958 channel status helper
  ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders
  ASoC: hdmi-codec: Add audio abort() callback for video side to use
  drm/i2c: tda998x: Improve tda998x_configure_audio() audio related
    pdata
  drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding
  ARM: dts: am335x-boneblack: Add HDMI audio support

 .../devicetree/bindings/display/bridge/tda998x.txt |  18 +
 arch/arm/boot/dts/am335x-boneblack.dts             |  71 +++-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 275 ++++++++++++--
 include/drm/i2c/tda998x.h                          |  24 +-
 include/dt-bindings/display/tda998x.h              |   7 +
 include/sound/hdmi-codec.h                         | 104 ++++++
 include/sound/pcm_iec958.h                         |   2 +
 sound/core/pcm_iec958.c                            |  65 +++-
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/hdmi-codec.c                      | 414 +++++++++++++++++++++
 12 files changed, 917 insertions(+), 72 deletions(-)
 create mode 100644 include/dt-bindings/display/tda998x.h
 create mode 100644 include/sound/hdmi-codec.h
 create mode 100644 sound/soc/codecs/hdmi-codec.c

-- 
1.9.1
