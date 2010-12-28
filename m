From: David Lambert <dlambert@ti.com>
Subject: [PATCH 0/5] Adding OMAP DMIC driver to kernel
Date: Mon, 27 Dec 2010 22:17:01 -0600
Message-ID: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Lambert <dlambert@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

This is a patch series to add the OMAP Digital Microphone
driver for OMAP4.

It includes the driver, a generic DMIC codec, platform devices,
as well as HWMOD entries for OMAP44xx chipsets.

David Lambert (5):
  ASoC: DMIC: Adding the OMAP DMIC driver
  ASoC: DMIC codec: Adding a generic DMIC codec
  ASoC: DMIC: Adding OMAP DMIC driver to build
  OMAP4: hwmod: add entries for DMIC driver
  MAP4: DMIC: Add DMIC codec platform devices

 arch/arm/mach-omap2/board-4430sdp.c        |   11 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 +++++
 arch/arm/plat-omap/devices.c               |   35 ++
 arch/arm/plat-omap/include/plat/dmic.h     |   83 ++++
 sound/soc/codecs/Kconfig                   |    3 +
 sound/soc/codecs/Makefile                  |    2 +
 sound/soc/codecs/dmic.c                    |   79 ++++
 sound/soc/omap/Kconfig                     |    5 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/omap-dmic.c                 |  596 ++++++++++++++++++++++++++++
 sound/soc/omap/omap-dmic.h                 |   38 ++
 11 files changed, 945 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
 create mode 100644 sound/soc/codecs/dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.h
