From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH early RFC 0/2] Implement ASoC HDMI codec library
Date: Wed, 13 May 2015 12:23:45 +0300
Message-ID: <cover.1431508524.git.jsarha@ti.com>
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
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, moinejf@free.fr, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

This is on early RFC and should not be merged yet. The idea is just
to share my ideas early on as there has been a lot of development
going on around HDMI audio.

The I2S DAI of the ASoC side patch is usable already, the spdif
support has not been tested and the EDID SADs handling should use
Russel's DRM ELD helper when it is ready.

The tda998x patch is just to demonstrate the usage of the
HDMI-codec-lib. At least the audio related DT-bindings are missing
completely and the configuration is hard coded to work on
Beaglebone-Black.

Jean-Francois, would you consider trying the generic ASoC patch with
your HW, as I can not test the spdif functionality with mine?

The library could also be implemented as a separate platform driver,
but then adding a pointer for private data to struct
snd_soc_dai_driver, snd_soc_codec, or to snd_soc_component would be of
great help.

These patches, my tilcdc refactoring[1], and my latest BCLK fixes for
davinci-mcasp diver [2], can found in a branch that produces a working
HDMI audio on Beaglebone-Black here:

https://github.com/jsarha/linux.git linux-master-bbb-hdmi-20150512

[1] http://lists.freedesktop.org/archives/dri-devel/2015-May/082537.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090974.html

Jyri Sarha (2):
  ASoC: hdmi-codec-lib: Add hdmi-codec-lib for external HDMI-encoders
  drm/i2c: tda998x: HACK Implement primitive HDMI audio with ASoC
    hdmi-code-lib

 drivers/gpu/drm/i2c/Kconfig       |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c | 238 +++++++++++++++++
 include/sound/hdmi-codec-lib.h    | 105 ++++++++
 sound/soc/codecs/Kconfig          |   4 +
 sound/soc/codecs/Makefile         |   2 +
 sound/soc/codecs/hdmi-codec-lib.c | 536 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 886 insertions(+)
 create mode 100644 include/sound/hdmi-codec-lib.h
 create mode 100644 sound/soc/codecs/hdmi-codec-lib.c

-- 
1.9.1
