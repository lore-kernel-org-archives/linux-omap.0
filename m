From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Sat, 18 Sep 2010 19:45:40 +0530
Message-ID: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48460 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0IROQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 10:16:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This patch series makes OMAP2PLUS specific GPIO implemented in hwmod
FW way. This is done by implementing GPIO module in platform device model.

This patch series is generated on "origin/pm-wip/pm-core" which
has Kevin's pm-next series, the runtime PM core patch series,
and a collection of hwmod fixes that Paul/Benoit have lined up
for 2.6.37.

Tested on OMAP2430, OMAP44430, OMAP3430 SDP and zoom3 boards.
Also verified that this patch series does not break the OMAP1 build.

This patch series is created on top of the following patches:
1. OMAP: HWMOD: Handle opt clocks using clk_add_alias
[https://patchwork.kernel.org/patch/124531/]
2. OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
[https://patchwork.kernel.org/patch/176172/]
3. OMAP: CPUIDLE: Enable IRQs during device activity check and idle management
by Kevin

This series is tested on OMAP4430 ES2 using the below series
http://www.spinics.net/lists/linux-omap/msg36023.html

Version History:
---------------
v6 Series:
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
Some link for v5 series:
https://patchwork.kernel.org/patch/117790/
https://patchwork.kernel.org/patch/117789/
https://patchwork.kernel.org/patch/117788/
https://patchwork.kernel.org/patch/117785/
https://patchwork.kernel.org/patch/117796/
Comments Fixed in v5:
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

Benoit Cousson (1):
  OMAP4: hwmod data: Add GPIO

Varadarajan, Charulatha (12):
  OMAP: GPIO: Modify init() in preparation for platform device
    implementation
  OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
  OMAP: GPIO: Introduce support for OMAP16xx chip GPIO init
  OMAP: GPIO: Introduce support for OMAP7xx chip GPIO init
  OMAP2420: hwmod data: Add GPIO
  OMAP2430: hwmod data: Add GPIO
  OMAP3: hwmod data: Add GPIO
  OMAP2PLUS: GPIO: use omap_device_build for device registration
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
 arch/arm/mach-omap2/Makefile               |    3 +-
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
 arch/arm/mach-omap2/gpio.c                 |   92 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  227 +++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  273 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  364 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  341 ++++++++
 arch/arm/plat-omap/gpio.c                  | 1283 ++++++++++++----------------
 arch/arm/plat-omap/include/plat/gpio.h     |   25 +
 48 files changed, 2473 insertions(+), 763 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c
 create mode 100644 arch/arm/mach-omap1/gpio16xx.c
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c
 create mode 100644 arch/arm/mach-omap2/gpio.c

