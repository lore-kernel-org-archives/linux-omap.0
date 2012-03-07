From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Urgent pre-emptive fixes for next merge window
Date: Wed, 7 Mar 2012 14:59:46 -0800
Message-ID: <20120307225946.GK12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965260Ab2CGW7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 17:59:49 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Arnd & Olof,

The following contains fixes for the next merge window.
Included are the issues noted by Russell.

I've tested it against the current next tree with
omap1_defconfig, omap2plus_defconfig, and Russell's
omap3430-ldp and omap4430-sdp seed configs, and the
related allnoconfigs.

One more patch seems to be needed for some .config
files that I've just posted as "[PATCH] ARM: OMAP2+:
Fix build issues with missing include of linux/bug.h".
I'd like to figure out what exactly causes that, so
as soon as that's done, I'll send a pull request for
that.

Please note that arm-soc/for-next and ASoC changes
in next can have minor merge with these fixes.  

I saw the following with today's next tree:

1. These fixes can conflict with some ASoC changes
   using cpu_is_omap4430 that should be replaced with
   cpu_is_omap443x (or cpu_is_omap44xx) to avoid
   breaking build. This series removes cpu_is_omap4430
   as it is broken as noted in the changelog. As an
   earlier patch already fixed an issue in dma.c,
   this series is based on commit d82ba995.

2. For arch/arm/mach-omap2/io.c this series can cause
   a minor conflict with clean-up with the includes.
   This can break build if include "common.h" is
   not kept.

For reference, here's what I resolved with when doing
a test merge against current next tree:

--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@@ -528,20 -485,6 +528,20 @@@ void __init omap4_panda_display_init(vo
  	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
  }
  
 +static void omap4_panda_init_rev(void)
 +{
- 	if (cpu_is_omap4430()) {
++	if (cpu_is_omap443x()) {
 +		/* PandaBoard 4430 */
 +		/* ASoC audio configuration */
 +		panda_abe_audio_data.card_name = "PandaBoard";
 +		panda_abe_audio_data.has_hsmic = 1;
 +	} else {
 +		/* PandaBoard ES */
 +		/* ASoC audio configuration */
 +		panda_abe_audio_data.card_name = "PandaBoardES";
 +	}
 +}
 +
  static void __init omap4_panda_init(void)
  {
  	int package = OMAP_PACKAGE_CBS;
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@@ -29,18 -30,19 +29,18 @@@
  #include <plat/sram.h>
  #include <plat/sdrc.h>
  #include <plat/serial.h>
 +#include <plat/omap-pm.h>
 +#include <plat/omap_hwmod.h>
 +#include <plat/multi.h>
  
 -#include "clock2xxx.h"
 -#include "clock3xxx.h"
 -#include "clock44xx.h"
 -
 +#include "iomap.h"
+ #include "common.h"
 -#include <plat/omap-pm.h>
  #include "voltage.h"
  #include "powerdomain.h"
 -
  #include "clockdomain.h"
- #include "common.h"
 -#include <plat/omap_hwmod.h>
 -#include <plat/multi.h>
 +#include "clock2xxx.h"
 +#include "clock3xxx.h"
 +#include "clock44xx.h"
  
  /*
   * The machine specific code may provide the extra mapping besides the

And the pull request is below.

Regards,

Tony


The following changes since commit d82ba9954b6b2c4ac91ec6f6f42be8c5215d0619:
  Peter Ujfalusi (1):
        OMAP4: dma: Correct CPU version check for dma_common_ch_end

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part2

Afzal Mohammed (1):
      ARM: OMAP2+: id: Add am33xx SoC type detection

Bernhard Walle (1):
      ARM: OMAP2+: GPMC: Export gpmc_enable_hwecc and gpmc_calculate_ecc

Danny Kukawka (2):
      ARM: OMAP: clock.c: included linux/debugfs.h twice
      ARM: OMAP2+: included some headers twice

Felipe Contreras (1):
      ARM: OMAP: mailbox: trivial whitespace fix

Grazvydas Ignotas (1):
      ARM: omap: pandora: fix usbhs platform data

Ilya Yanok (1):
      ARM: OMAP2+: ads7846_init: put gpio_pendown into pdata if it's provided

Jon Hunter (1):
      ARM: OMAP: Remove definition cpu_is_omap4430()

Kevin Hilman (2):
      ARM: OMAP2+: PM: fix section mismatch with omap2_init_processor_devices()
      ARM: OMAP2+: PM: fix wakeupgen warning when hotplug disabled

Masanari Iida (1):
      ARM: OMAP1: Fix typo in lcd_dma.c

Ohad Ben-Cohen (1):
      ARM: OMAP: don't build hwspinlock in vain

Tarun Kanti DebBarma (1):
      ARM: OMAP: dmtimer: fix missing content/correction in low-power mode support

Tony Lindgren (3):
      ARM: OMAP1: Fix section mismatch for omap1_init_early()
      ARM: OMAP2+: Fix omap24xx_io_desc warning if SoC subtypes are not selected
      ARM: OMAP2: Fix section warning for n8x0 when CONFIG_MMC_OMAP is not set

Vaibhav Bedia (1):
      ARM: OMAP: sram: Add am33xx SRAM support (minimal)

Yuan Jiangli (1):
      ARM: OMAP3+: PM: VP: fix integer truncation error

 arch/arm/mach-omap1/io.c                   |    2 +-
 arch/arm/mach-omap1/lcd_dma.c              |    2 +-
 arch/arm/mach-omap2/Makefile               |    4 ++-
 arch/arm/mach-omap2/board-ldp.c            |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    8 ++--
 arch/arm/mach-omap2/board-omap3pandora.c   |   10 +++---
 arch/arm/mach-omap2/common-board-devices.c |    8 +++--
 arch/arm/mach-omap2/control.h              |    5 +++
 arch/arm/mach-omap2/gpmc.c                 |    2 +
 arch/arm/mach-omap2/id.c                   |    2 +
 arch/arm/mach-omap2/io.c                   |    3 +-
 arch/arm/mach-omap2/omap-wakeupgen.c       |   53 +++++++++++++++-------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 arch/arm/mach-omap2/pm.c                   |    2 +-
 arch/arm/mach-omap2/vp.c                   |    4 +-
 arch/arm/plat-omap/clock.c                 |    1 -
 arch/arm/plat-omap/dmtimer.c               |   19 ++++++++--
 arch/arm/plat-omap/include/plat/cpu.h      |    2 -
 arch/arm/plat-omap/include/plat/sram.h     |    1 +
 arch/arm/plat-omap/mailbox.c               |    2 +-
 arch/arm/plat-omap/sram.c                  |   14 ++++++-
 21 files changed, 90 insertions(+), 56 deletions(-)
