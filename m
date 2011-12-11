From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 00/10] ARM: OMAP1: ams-delta: replace custom I/O with GPIO
Date: Sun, 11 Dec 2011 21:11:58 +0100
Message-ID: <1323634328-856-1-git-send-email-jkrzyszt__18651.1072483428$1323634521$gmane$org@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, David Woodhouse <dwmw2@infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The Amstrad Delta board has two extra output ports used for driving
input lines of different on-board devices. Those ports are now
controlled with custom functions, provided by the board arch code and
used by several device drivers.

The idea behind the series is to replace those custom I/O functions
with gpiolib API. This way, existing drivers can be made less platform
dependent, and some of them perhaps even superseded with generic GPIO
based drivers after the board platform device descriptions are
converted. Moreover, should a new driver for the on-board Smart Card
controller ever be created, it could be designed as a generic GPIO
based driver, not a custom one.

Janusz Krzysztofik (10):
  GPIO: gpio-generic: Move initialization up to postcore
  ARM: OMAP1: ams-delta: convert latches to basic_mmio_gpio
  ARM: OMAP1: ams-delta: supersede custom led device by leds-gpio
  LED: drop leds-ams-delta driver
  MTD: NAND: ams-delta: use GPIO instead of custom I/O
  ARM: OMAP1: ams-delta: Use GPIO API in modem setup
  ASoC: OMAP: ams-delta: Drive modem/codec pins over GPIO API
  omapfb: lcd_ams_delta: Drive control lines over GPIO
  input: serio: ams-delta: toggle keyboard power over GPIO
  ARM: OMAP1: ams-delta: drop custom I/O functions

 arch/arm/mach-omap1/Kconfig                       |    2 +
 arch/arm/mach-omap1/board-ams-delta.c             |  220 +++++++++++++++++----
 arch/arm/plat-omap/include/plat/board-ams-delta.h |   50 ++---
 drivers/gpio/gpio-generic.c                       |    2 +-
 drivers/input/serio/ams_delta_serio.c             |   45 +++--
 drivers/leds/Kconfig                              |    7 -
 drivers/leds/Makefile                             |    1 -
 drivers/leds/leds-ams-delta.c                     |  137 -------------
 drivers/mtd/nand/ams-delta.c                      |   74 +++++--
 drivers/video/omap/lcd_ams_delta.c                |   27 ++-
 sound/soc/omap/ams-delta.c                        |   21 ++-
 11 files changed, 309 insertions(+), 277 deletions(-)
 delete mode 100644 drivers/leds/leds-ams-delta.c

-- 
1.7.3.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
