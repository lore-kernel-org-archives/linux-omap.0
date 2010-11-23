From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Tue, 23 Nov 2010 20:26:42 +0530
Message-ID: <1290524213-395-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259Ab0KWO5T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 09:57:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
module uses hwmod FW.

Tested on OMAP2430, OMAP44430, OMAP3430 SDP boards, OMAP4430 Blaze board
and zoom3 board. Verified that this patch series does not break the OMAP1
build.

Version History:
---------------
v7 Series:
- Use gpio iclks as main_clk in OMAP3 & OMAP4
- Implement GPIO as a platform device (use hwmod FW for OMAP2+)
 and the implementation is similar to current GPIO code. Does not
 modify the gpio suspend/ resume/ prepare for odle and resume after
 idle code and these modifications would be done in a separate patch
 series. This was suggested by Kevin in another internal email thread.

v6 Series:
Some links for v6 series:
https://patchwork.kernel.org/patch/189742/
https://patchwork.kernel.org/patch/189822/
https://patchwork.kernel.org/patch/189832/
Comments Fixed in v6:
-use PM runtime APIs for gpio in cpu idle/resume after
 idle path when interrupts are enabled.
-Do not use omap_device_* calls in the gpio driver
-Use clock alias names for debounce clocks while using clock
 framework APIs to do clk_get.
-do a kfree of pdata after doing omap_device_build()
-use PM runtime APIs during probe before and after accessing
 gpio registers
-Remove sysconfig register access from GPIO driver
-Use ARRAY_SIZE instead on size_of in OMAP1 gpio_init

v5 Series:
Some links for v5 series:
https://patchwork.kernel.org/patch/117790/
https://patchwork.kernel.org/patch/117789/
https://patchwork.kernel.org/patch/117788/
https://patchwork.kernel.org/patch/117785/
https://patchwork.kernel.org/patch/117796/
Comments Fixed in v5:
- Use dev_pm_ops instead of sys_dev_class
- Use runtime suspend/resume hooks for GPIO device
- extend the usage of mod_usage flag to all cpu classes.(Earlier it was
   used only for OMAP2+)
- Make gpio_context as part of gpio_bank structure

v4 Series:
Some links for v4 series:
https://patchwork.kernel.org/patch/107411/
Comments Fixed in v4:
- Remove gpio_bank_count from dev_attr field and derive it from
   hwmod class iteration count
- Add TODOs for future omap gpio code cleanup related activity
- Rename gpio's platform_data 'method' to 'bank_type'
- Rename gpio's platform_data 'gpio_bank_bits' to 'gpio_bank_width'
- Add 'rev' field to gpio class in hwmod datbase and get 'bank_type'
   based on 'rev' field
- Filename removed from file description when a new file is created

v3 Series:
Some of the v3 links:
https://patchwork.kernel.org/patch/106224/
Comments Fixed in v3:
- .module_offs populated in hwmod structures
- If not defined CONFIG_PM_RUNTIME is not handled in GPIO driver
- No changes to mach-omap2/clockxxxx-data.c to handle clocks by dev ptr
    as it is taken care using clock get by name in hwmod & omap_device layer
- Using "ick" instead of "arm_gpio_ck" for OMAP15xx clock
- SoC base addresses moved to plat-omap/omapXXXX.h that should be
    used only by the omap_hwmod_xxxx_data.c file
- OMAP2/3 hwmod structures naming convention changed as it is
    followed in OMAP4
- omap24xx_gpio_init() uses cpu_is_omap24xx() instead of separate
    checks for 2420 & 2430 in OMAP2 specific init call (mach-omap layer)
- Reason for using postcore_initcall is added to patch description
- Comments added for usage of dbck_flag and other elements
    in dev_attr structure
- Uses dev_dbg() and dev_err() instead of pr_dbg() and pr_err()
- Corrects the gpio clock details in OMAP4 hwmod database

v2 series:
Some important links to patch v2 series and comments:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30262.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28787.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30263.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30295.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30259.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28933.html
Comments Fixed in V2:
- GPIO dev attr was added for SoC specific chip info (eg., gpio bank count)
- Removed omap_gpio_init() usage from board files 
- platform_get_resource() used instead of pdata->base for
    OMAP2+ base addresses
- postcore_initcall used for gpio init instead of making
    GPIO as an early platform device. SoC specific gpio_init
    needs to be done before machine_init functions access gpio
    APIs. Hence making SoC specific gpio_init as postcore_initcall.
- getting gpio dbck is moved to omap_set_gpio_debounce()
    instead of doing it in probe

v1 series:
Some important links to patch v1 series and comments:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26934.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27860.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28183.html
Highlights in v1:
- Introduces SoC specific functions at mach-omap layer
- Implements GPIO as a platform device
- Make gpio an early device and make it implemented in

Benoit Cousson (1):
  OMAP4: hwmod data: Add GPIO

Varadarajan, Charulatha (10):
  OMAP: GPIO: prepare for platform driver
  OMAP15xx: GPIO: Introduce support for GPIO init
  OMAP16xx: GPIO: Introduce support for GPIO init
  OMAP7xx: GPIO: Introduce support for GPIO init
  OMAP2420: hwmod data: Add GPIO
  OMAP2430: hwmod data: Add GPIO
  OMAP3: hwmod data: Add GPIO
  OMAP2+: GPIO: device registration
  OMAP: GPIO: Implement GPIO as a platform device
  OMAP: GPIO: Remove omap_gpio_init()

 arch/arm/mach-omap1/Makefile               |    6 +
 arch/arm/mach-omap1/board-ams-delta.c      |    1 -
 arch/arm/mach-omap1/board-fsample.c        |    1 -
 arch/arm/mach-omap1/board-h2.c             |    1 -
 arch/arm/mach-omap1/board-h3.c             |    1 -
 arch/arm/mach-omap1/board-htcherald.c      |    2 -
 arch/arm/mach-omap1/board-innovator.c      |    1 -
 arch/arm/mach-omap1/board-nokia770.c       |    1 -
 arch/arm/mach-omap1/board-osk.c            |    1 -
 arch/arm/mach-omap1/board-palmte.c         |    1 -
 arch/arm/mach-omap1/board-palmz71.c        |    1 -
 arch/arm/mach-omap1/board-perseus2.c       |    1 -
 arch/arm/mach-omap1/board-sx1.c            |    1 -
 arch/arm/mach-omap1/board-voiceblue.c      |    1 -
 arch/arm/mach-omap1/clock_data.c           |    4 +-
 arch/arm/mach-omap1/gpio15xx.c             |   98 +++++
 arch/arm/mach-omap1/gpio16xx.c             |  199 +++++++++
 arch/arm/mach-omap1/gpio7xx.c              |  261 ++++++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3630sdp.c        |    1 -
 arch/arm/mach-omap2/board-4430sdp.c        |    1 -
 arch/arm/mach-omap2/board-am3517crane.c    |    2 -
 arch/arm/mach-omap2/board-am3517evm.c      |    1 -
 arch/arm/mach-omap2/board-apollon.c        |    1 -
 arch/arm/mach-omap2/board-cm-t35.c         |    1 -
 arch/arm/mach-omap2/board-cm-t3517.c       |    1 -
 arch/arm/mach-omap2/board-devkit8000.c     |    1 -
 arch/arm/mach-omap2/board-h4.c             |    1 -
 arch/arm/mach-omap2/board-igep0020.c       |    1 -
 arch/arm/mach-omap2/board-igep0030.c       |    1 -
 arch/arm/mach-omap2/board-ldp.c            |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 -
 arch/arm/mach-omap2/board-omap3evm.c       |    1 -
 arch/arm/mach-omap2/board-omap3logic.c     |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 -
 arch/arm/mach-omap2/board-omap4panda.c     |    1 -
 arch/arm/mach-omap2/board-overo.c          |    1 -
 arch/arm/mach-omap2/board-rx51.c           |    1 -
 arch/arm/mach-omap2/board-zoom.c           |    1 -
 arch/arm/mach-omap2/gpio.c                 |  103 +++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  229 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  279 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  360 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  341 +++++++++++++++
 arch/arm/plat-omap/gpio.c                  |  622 +++++++++-------------------
 arch/arm/plat-omap/include/plat/gpio.h     |   24 +-
 51 files changed, 2103 insertions(+), 465 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c
 create mode 100644 arch/arm/mach-omap1/gpio16xx.c
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c
 create mode 100644 arch/arm/mach-omap2/gpio.c

