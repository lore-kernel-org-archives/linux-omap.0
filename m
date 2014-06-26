From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 00/12] Rework OMAP4+ HDMI audio support
Date: Thu, 26 Jun 2014 22:20:51 +0300
Message-ID: <cover.1403807781.git.jsarha@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <y>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, jyri.sarha@iki.fi
List-Id: linux-omap@vger.kernel.org

The patches are based on linux 3.16-rc2 and OMAPDSS HDMI infoframe
patches[1] from Tomi Valkeinen. The base, the patches, and couple of
additional not-to-be-merged omap2plus_defconfig patches can be found
here:

git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio

The patch set fixes OMAP4+ HDMI audio. The structure of the
implementation looks a bit different than before. Instead of creating
a driver specific API for a separate ASoC component driver to connect
to, this implementation integrates an the ASoC cpu-dai component
driver into the HDMI driver. Also the other ASoC component drivers
needed for operational audio are automatically registered by the HDMI
driver. There is no need to add anything to the device tree as long as
the nodes needed for HDMI video are there.

Big part of the HDMI audio code is still unchanged and there is a need
for a cleanup there. Also there is still probably something wrong with
speaker mapping of multi-channel streams. I will get back to cleaning
up these issues later.

Best regards,
Jyri

[1] http://marc.info/?l=linux-fbdev&m=140360425130951&w=2

Jyri Sarha (12):
  ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi_wp: Add function for getting hdmi_wp physical base
    address
  OMAPDSS: hdmi_audio: Integrated ASoC DAI component driver
    implementation
  OMAPDSS: Kconfig: Select audio dependencies if OMAP4_DSS_HDMI_AUDIO=y
  OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
  OMAPDSS: Kconfig: Select audio dependencies if OMAP5_DSS_HDMI_AUDIO=y
  OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: hdmi4: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: hdmi5: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: Remove all references to obsolete HDMI audio callbacks

 arch/arm/mach-omap2/devices.c                      |   28 --
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 ------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |   24 +-
 drivers/video/fbdev/omap2/dss/Makefile             |    2 +
 drivers/video/fbdev/omap2/dss/hdmi.h               |   43 ++-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  158 +++------
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  170 +++------
 drivers/video/fbdev/omap2/dss/hdmi_audio.c         |  317 +++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |    6 +
 include/video/omapdss.h                            |   31 --
 sound/soc/omap/Kconfig                             |   13 -
 sound/soc/omap/Makefile                            |    4 -
 sound/soc/omap/omap-hdmi-card.c                    |   87 -----
 sound/soc/omap/omap-hdmi.c                         |  364 --------------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 16 files changed, 489 insertions(+), 951 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h

-- 
1.7.9.5
