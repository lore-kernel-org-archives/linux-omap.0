From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 0/7] Implement generic ASoC HDMI codec
	and use it in tda998x
Date: Fri, 14 Aug 2015 12:30:38 +0300
Message-ID: <cover.1439542916.git.jsarha@ti.com>
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

This is my third RFC patch series on the subject. This time also the
tda998x driver patches are a serious attempt to come up with an
initial implementation for HDMI audio ASoC support.

Russell's "drm/edid: add function to help find SADs" is here just to
produce a working patch-set on top of mainline. It should be getting in
trough drm-next at some point.

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

Jyri Sarha (5):
  ASoC: hdmi: Remove obsolete dummy HDMI codec
  ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders
  drm/i2c: tda998x: Remove include/sound/tda998x.h and fix graph parsing
  drm/i2c: tda998x: Register ASoC HDMI codec for audio functionality
  ARM: dts: am335x-boneblack: Add HDMI audio support

Russell King - ARM Linux (1):
  drm/edid: add function to help find SADs, DO NOT MERGE

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  51 +++
 arch/arm/boot/dts/am335x-boneblack.dts             |  90 +++-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 336 +++++++++++++--
 include/drm/drm_edid.h                             |  19 +
 include/sound/hdmi-codec.h                         |  99 +++++
 sound/soc/codecs/Kconfig                           |   3 +-
 sound/soc/codecs/Makefile                          |   4 +-
 sound/soc/codecs/hdmi-codec.c                      | 467 +++++++++++++++++++++
 sound/soc/codecs/hdmi.c                            | 109 -----
 10 files changed, 1026 insertions(+), 153 deletions(-)
 create mode 100644 include/sound/hdmi-codec.h
 create mode 100644 sound/soc/codecs/hdmi-codec.c
 delete mode 100644 sound/soc/codecs/hdmi.c

-- 
1.9.1
