From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 0/7] Implement generic ASoC HDMI codec
Date: Tue, 26 May 2015 21:59:04 +0300
Message-ID: <1432666751-24794-1-git-send-email-jsarha@ti.com>
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

Only the first three patches are meant for serious review.

The ASoC part should be ready for review in other respects but the
EDID SADs handling is waiting for Russell King's DRM ELD helper
patches. There is a copy-pasted not-to-be-merged patch with the same
functionality in the patch series.

The tda998x part is not complete and I do not think Jean-Francois'
binding are ready as such either. At least the usage of reg property in
a port node for something that is not an address or even guaranteed to
be unique is not a good idea. Some documentation of how to configure
AP0-AP4 pins (REG_ENA_AP?) would help in making a proper binding for
the tda998x audio configuration.

These patches, my tilcdc refactoring[1], and my latest BCLK fixes for
davinci-mcasp driver [2], can be found in a branch that produces
working HDMI audio on Beaglebone-Black here:

https://github.com/jsarha/linux.git linux-master-bbb-hdmi-20150512

[1] http://lists.freedesktop.org/archives/dri-devel/2015-May/082537.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090974.html

Jean-Francois Moine (1):
  drm/i2c: tda998x: Add support of a DT graph of ports DO NOT MERGE

Jyri Sarha (6):
  ASoC: core: If component doesn't have of_node use parent's node
    instead
  ASoC: hdmi: Remove obsolete dummy HDMI codec
  ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders
  ASoC: hdmi-codec: Add ELD based audio pcm rules DO NOT MERGE
  drm/i2c: tda998x: Register ASoC HDMI codec for audio functionality DO
    NOT MERGE
  ARM: dts: am335x-boneblack: Add HDMI audio support DO NOT MERGE

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  78 ++-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 328 +++++++++++-
 include/sound/hdmi-codec.h                         |  99 ++++
 include/sound/tda998x.h                            |   8 +
 sound/soc/codecs/Kconfig                           |   2 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/hdmi-codec.c                      | 560 +++++++++++++++++++++
 sound/soc/codecs/hdmi.c                            | 109 ----
 sound/soc/soc-core.c                               |  14 +-
 11 files changed, 1129 insertions(+), 125 deletions(-)
 create mode 100644 include/sound/hdmi-codec.h
 create mode 100644 include/sound/tda998x.h
 create mode 100644 sound/soc/codecs/hdmi-codec.c
 delete mode 100644 sound/soc/codecs/hdmi.c

-- 
1.9.1
