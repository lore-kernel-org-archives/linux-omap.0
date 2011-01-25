From: David Lambert <dlambert@ti.com>
Subject: [PATCH v3 0/4] Adding OMAP DMIC driver to kernel
Date: Tue, 25 Jan 2011 16:00:58 -0600
Message-ID: <1295992862-6154-1-git-send-email-dlambert@ti.com>
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

Note: The DMIC codec driver was removed from this series as it was
accepted for and merged for the 2.6.38 kernel.

Benoit Cousson (1):
  OMAP4: hwmod: add entries for DMIC driver

David Lambert (3):
  ASoC: DMIC: Adding the OMAP DMIC driver
  OMAP4: DMIC: initializes the DMIC driver
  OMAP4: DMIC: Add DMIC codec platform devices

 arch/arm/mach-omap2/board-4430sdp.c        |   11 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 +++++
 arch/arm/plat-omap/devices.c               |   35 ++
 arch/arm/plat-omap/include/plat/dmic.h     |   82 +++++
 sound/soc/omap/Kconfig                     |    3 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/omap-dmic.c                 |  534 ++++++++++++++++++++++++++++
 7 files changed, 758 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
 create mode 100644 sound/soc/omap/omap-dmic.c
