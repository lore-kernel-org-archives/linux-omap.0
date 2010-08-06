From: Charulatha V <charu@ti.com>
Subject: [PATCH 00/13 v5] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Fri,  6 Aug 2010 18:04:12 +0530
Message-ID: <1281098065-24177-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52286 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934159Ab0HFMbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 08:31:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>

This patch series makes OMAP2PLUS specific GPIO implemented in HWMOD
FW way. This is done by implementing GPIO module in platform device model.

This patch series is generated on "origin/pm-wip/hwmods-omap4".

This patch series is created on top of the following two patches:
- OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
- musb: Kill board specific pinmux from driver file
	http://marc.info/?l=linux-usb&m=127858711304301&w=2
- Revert the following patch:
	OMAP: bus-level PM: enable use of runtime PM API for suspend/resume
	http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=commitdiff;h=8041359e18e49bf8a3d41f15894db9e476f3a8fc
	(or)
  Remove the locking in the omap_hwmod_for_each* function

This patch series is tested on OMAP4430 SDP board and OMAP3430 SDP board.
It would be of great help if someone could test the same on OMAP1
and OMAP2 boards.

Links to related discussions:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32833.html

Version History:
---------------
Comments Fixed in V5:
- Use dev_pm_ops instead of sys_dev_class
- Use runtime suspend/resume hooks for GPIO device
- extend the usage of mod_usage flag to all cpu classes.( Earlier it was
   used only for OMAP2PLUS)
- Make gpio_context as part of gpio_bank structure

v4 Series:
Some link for v4 series:
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
- Reason for using postcore_initcall is added to patch description for
    the patch "OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init"
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
    HWMOD FW adapted way for OMAP2PLUS

Charulatha V (13):
  OMAP: GPIO: Modify init() in preparation for platform device
    implementation
  OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
  OMAP: GPIO: Introduce support for OMAP16xx chip GPIO init
  OMAP: GPIO: Introduce support for OMAP7xx chip GPIO init
  OMAP: GPIO: add GPIO hwmods structures for OMAP3
  OMAP: GPIO: add GPIO hwmods structures for OMAP242X
  OMAP: GPIO: add GPIO hwmods structures for OMAP243X
  OMAP: GPIO: Add gpio dev_attr and correct clks in OMAP4 hwmod struct
  OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
  OMAP: GPIO: Implement GPIO as a platform device
  OMAP: GPIO: Make gpio_context as part of gpio_bank structure
  OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
  OMAP: GPIO: Remove omap_gpio_init()

 arch/arm/mach-omap1/Makefile               |    6 +
 arch/arm/mach-omap1/board-ams-delta.c      |    1 -
 arch/arm/mach-omap1/board-fsample.c        |    1 -
 arch/arm/mach-omap1/board-h2.c             |    1 -
 arch/arm/mach-omap1/board-h3.c             |    1 -
 arch/arm/mach-omap1/board-htcherald.c      |    1 -
 arch/arm/mach-omap1/board-innovator.c      |    1 -
 arch/arm/mach-omap1/board-nokia770.c       |    1 -
 arch/arm/mach-omap1/board-osk.c            |    1 -
 arch/arm/mach-omap1/board-palmte.c         |    1 -
 arch/arm/mach-omap1/board-palmz71.c        |    1 -
 arch/arm/mach-omap1/board-perseus2.c       |    1 -
 arch/arm/mach-omap1/board-sx1.c            |    1 -
 arch/arm/mach-omap1/board-voiceblue.c      |    1 -
 arch/arm/mach-omap1/clock_data.c           |    4 +-
 arch/arm/mach-omap1/gpio15xx.c             |  101 +++
 arch/arm/mach-omap1/gpio16xx.c             |  208 +++++
 arch/arm/mach-omap1/gpio7xx.c              |  274 ++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3430sdp.c        |    1 -
 arch/arm/mach-omap2/board-3630sdp.c        |    1 -
 arch/arm/mach-omap2/board-4430sdp.c        |    1 -
 arch/arm/mach-omap2/board-am3517evm.c      |    1 -
 arch/arm/mach-omap2/board-apollon.c        |    1 -
 arch/arm/mach-omap2/board-cm-t35.c         |    1 -
 arch/arm/mach-omap2/board-devkit8000.c     |    1 -
 arch/arm/mach-omap2/board-h4.c             |    1 -
 arch/arm/mach-omap2/board-igep0020.c       |    1 -
 arch/arm/mach-omap2/board-ldp.c            |    1 -
 arch/arm/mach-omap2/board-n8x0.c           |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 -
 arch/arm/mach-omap2/board-omap3evm.c       |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 -
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 -
 arch/arm/mach-omap2/board-omap4panda.c     |    1 -
 arch/arm/mach-omap2/board-overo.c          |    1 -
 arch/arm/mach-omap2/board-rx51.c           |    1 -
 arch/arm/mach-omap2/board-zoom2.c          |    1 -
 arch/arm/mach-omap2/board-zoom3.c          |    1 -
 arch/arm/mach-omap2/gpio.c                 |  120 +++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  234 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  290 +++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  382 +++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   40 +-
 arch/arm/mach-omap2/pm24xx.c               |    4 +-
 arch/arm/mach-omap2/pm34xx.c               |   23 +-
 arch/arm/plat-omap/gpio.c                  | 1259 ++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h     |   29 +-
 50 files changed, 2208 insertions(+), 803 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c
 create mode 100644 arch/arm/mach-omap1/gpio16xx.c
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c
 create mode 100644 arch/arm/mach-omap2/gpio.c

