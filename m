From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 00/18] OMAP: GPIO: cleanup GPIO driver
Date: Fri, 22 Apr 2011 16:38:14 +0530
Message-ID: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab1DVLE7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Modifies the OMAP GPIO driver to avoid usage of cpu_is* checks
for different OMAP architectures. This is done by moving some
architecture specific code to mach-omap* and call them from
plat-omap* using function pointers. Also remove the register offset
macros from OMAP GPIO driver and handle the same in mach-omap*.

Avoid usage of gpio_bank_count and gpio_bank pointer array by
means of maintaining a list. Removes the bank->method flag from
the GPIO driver.

All OMAP1 SoCs has one MPUIO type GPIO bank. OMAP2+ does not have
any MPUIO type GPIO bank. Since MPUIO type GPIO bank is the same for
all OMAP1 CPUs, they are handled in plat-omap/ itself as
there is no common gpio.c file for all cpu types in mach-omap1.
They are identified by using bank->stride flag as it is '0'
for other than MPUIO type banks.

Patch series is based on mainline rc4 following commit:
91e8549bde9e5cc88c5a2e8c8114389279e240b5
Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block

Compile tested for:
 - omap1_defconfig
 - omap2plus_defconfig

Boot test (success on the following boards):
 - OMAP1710-H3
 - OMAP2420-H4
 - OMAP3430-SDP
 - OMAP3430-Zoom2
 - OMAP3630-Zoom3
 - OMAP4430-SDP
 - OMAP4430-Blaze

GPIO module functionality testing (success on the following boards):
 - OMAP2420-H4
 - OMAP3430-SDP
 - OMAP3430-Zoom2
 - OMAP3630-Zoom3
 - OMAP4430-SDP
 - OMAP4430-Blaze

PM Testing (success as given below):
OMAP3430-SDP: retention, off_mode, system_wide suspend, gpio wakeup
OMAP3630-Zoom3: retention, system_wide suspend
using the following:
	     echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
	     echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
	     echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
	     echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
	     echo '5' > /debug/pm_debug/wakeup_timer_seconds
	     echo 1 > /debug/pm_debug/sleep_while_idle
	     echo 1 > /debug/pm_debug/enable_off_mode

Charulatha V (18):
  OMAP1: GPIO: Fix mpuio_init() call
  OMAP: GPIO: remove get_gpio_bank()
  OMAP: GPIO: Move gpio_get_index() to mach-omap
  OMAP: GPIO: Move gpio_valid() to SoC specific files
  OMAP: GPIO: cleanup datain,dataout,set dir funcs
  OMAP: GPIO: cleanup set trigger func
  OMAP: GPIO: cleanup set/get IRQ, clr irqstatus funcs
  OMAP: GPIO: req/free: Remove reg offset macros usage
  OMAP: GPIO: cleanup gpio_irq_handler
  OMAP: GPIO: cleanup set wakeup/suspend/resume funcs
  OMAP: GPIO: Remove dependency on gpio_bank_count
  OMAP: GPIO: cleanup set_debounce, idle/resume_after_idle
  OMAP: GPIO: cleanup save/restore context
  OMAP: GPIO: Remove CONFIG_ARCH_OMAP16XX/OMAP2+ defines
  OMAP: GPIO: cleanup gpio_show_rev
  OMAP: GPIO: move omap_gpio_mod_init to mach-omap
  OMAP: GPIO: use dev_err* instead of printk
  OMAP: GPIO: Remove usage of bank method

 arch/arm/mach-omap1/gpio15xx.c         |  110 ++-
 arch/arm/mach-omap1/gpio16xx.c         |  174 +++-
 arch/arm/mach-omap1/gpio7xx.c          |  132 ++-
 arch/arm/mach-omap2/gpio.c             |  476 +++++++++-
 arch/arm/plat-omap/gpio.c              | 1770 ++++++++------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  108 ++-
 6 files changed, 1380 insertions(+), 1390 deletions(-)

