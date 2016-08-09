From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 0/3] drm/i2c: tda998x ASoC hdmi-codec
	support + BeagleBoneBlack audio support
Date: Tue, 9 Aug 2016 22:00:03 +0300
Message-ID: <cover.1470754071.git.jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, tony@atomide.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Changes since first version [1] of this series:
- "drm/i2c: tda998x: Improve tda998x_configure_audio() audio related pdata"
  - Change audio in tda998x pdata to audio_params to match the naming in
    private data struct
  - Skip IEC958_AES2 byte when writing status bytes to registers 
  - Turn AFMT-macros to enum
  - include linux/hdmi.h in drm/i2c/tda998x.h
- "drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding"
  - Fix macronaming naming in dt-bindings/display/tda998x.h
  - Turn AFMT-macros to enum
  - Add locking to protect access to audio registers from ASoC thread
- "dts/am335x-boneblack: SQUASH"
  - Use corrected macros from dt-bindings/display/tda998x.h

[1] https://lists.freedesktop.org/archives/dri-devel/2016-August/114491.html 

Jyri Sarha (3):
  drm/i2c: tda998x: Improve tda998x_configure_audio() audio related
    pdata
  drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding
  ARM: dts: am335x-boneblack: Add HDMI audio support

 .../devicetree/bindings/display/bridge/tda998x.txt |  18 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  71 ++++-
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 297 ++++++++++++++++++---
 include/drm/i2c/tda998x.h                          |  29 +-
 include/dt-bindings/display/tda998x.h              |   7 +
 6 files changed, 368 insertions(+), 55 deletions(-)
 create mode 100644 include/dt-bindings/display/tda998x.h

-- 
1.9.1
