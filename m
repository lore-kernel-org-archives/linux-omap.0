From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/8] ASoC: OMAP-twl4030: Add support for more3
	boards
Date: Mon, 31 Dec 2012 11:51:41 +0100
Message-ID: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: NeilBrown <neilb@suse.de>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hello,

This series will update the omap-twl4030 machine driver and the twl4030 codec
driver to enable support for more boards.
With this change we can remove two more machine drivers: zoom2 and sdp3430 since
they will be supported by the common omap-twl4030 machine driver.
The arch/arm/mach-omap2/ patches will go as a separate series to avoid cross
tree issues.

Regards,
Peter
---
Peter Ujfalusi (8):
  ASoC: twl4030: Correct the support for Voice port
  ASoC: zoom2: No need to configure the Voice port anymore
  ASoC: sdp3430: No need to configure the Voice port anymore
  ASoC: twl4030: Convert MICBIAS to SUPPLY widget
  ASoC: twl4030: Configure extmute pinmux when the dedicated pin is in
    use
  ASoC: sdp3430: No need to configure pin mux for extmute
  ASoC: omap-twl4030: Add support for routing, voice port and jack
    detect
  ASoC: OMAP: Remove obsolete machine drivers for Zoom2 and SDP3430

 .../devicetree/bindings/sound/omap-twl4030.txt     |  46 ++++
 sound/soc/codecs/twl4030.c                         |  71 ++++--
 sound/soc/omap/Kconfig                             |  19 +-
 sound/soc/omap/Makefile                            |   4 -
 sound/soc/omap/omap-twl4030.c                      | 204 ++++++++++++++-
 sound/soc/omap/omap3pandora.c                      |   8 +-
 sound/soc/omap/sdp3430.c                           | 278 ---------------------
 sound/soc/omap/zoom2.c                             | 207 ---------------
 8 files changed, 304 insertions(+), 533 deletions(-)
 delete mode 100644 sound/soc/omap/sdp3430.c
 delete mode 100644 sound/soc/omap/zoom2.c

-- 
1.8.0.2
