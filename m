From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 00/10] OMAP: GPIO: cleanup GPIO driver
Date: Mon, 16 May 2011 17:11:34 +0530
Message-ID: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48319 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1EPLlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 07:41:47 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4GBfiCO031806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 06:41:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Do some more cleanup of OMAP GPIO driver and avoid usage of gpio_bank_count
and gpio_bank pointer array by means of maintaining a list.

Patch series is on following commit of linux-omap-pm (branch: wip/gpio-cleanup):
73ec20e00b9c02d5588dc83babb567527ed4394d
OMAP: GPIO: cleanup show revision, remove cpu_is checks, display only once

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

Charulatha V (6):
  OMAP: GPIO: Avoid cpu_is checks during module ena/disable
  ZOOM: QUART: Request reset GPIO
  OMAP2PLUS: GPIO: Fix non-wakeup GPIO and rev_ids
  OMAP: GPIO: Remove dependency on gpio_bank_count
  OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
  OMAP: GPIO: Use USHRT_MAX for rev offset instead of -1

Tarun Kanti DebBarma (4):
  OMAP: GPIO: cleanup suspend and resume functions
  OMAP: GPIO: cleanup prepare-for and resume-after idle functions
  OMAP: GPIO: cleanup omap_gpio_free and triggering functions
  OMAP: GPIO: remove harcoded offsets in context save and restore

 arch/arm/mach-omap1/gpio15xx.c              |    5 +-
 arch/arm/mach-omap1/gpio16xx.c              |    9 +-
 arch/arm/mach-omap1/gpio7xx.c               |    4 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 +
 arch/arm/mach-omap2/gpio.c                  |   50 +++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c  |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    2 +-
 arch/arm/plat-omap/gpio.c                   |  467 ++++++++++-----------------
 arch/arm/plat-omap/include/plat/gpio.h      |   14 +-
 10 files changed, 257 insertions(+), 307 deletions(-)
