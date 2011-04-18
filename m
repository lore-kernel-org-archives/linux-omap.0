From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
Date: Mon, 18 Apr 2011 20:36:50 +0530
Message-ID: <1303139217-10285-1-git-send-email-charu@ti.com>
References: <no>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab1DRPDo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 11:03:44 -0400
In-Reply-To: <no>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Use PM runtime framework in OMAP GPIO driver.

Patch series is based on mainline rc3 following commit
commit a1b49cb7e2a7961ec3aa8b64860bf480d4ec9077
Merge branch 'i2c-for-linus' of
	git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging

Changes in v2:
* Use a per-bank flag 'looses_context' (using pwrdm_can_ever_lose_context())
       instead of using the powerdomain name
* Make use of omap_device_get_context_loss_count() to decide on if restore
       context needs to be done.
* Do not remove #ifdef CONFIG_ARCH_OMAP2PLUS
* Do not use pm_runtime_suspended() before calling pm_runtime_get_sync/put_sync
* use IS_ERR_VALUE() instead of '< 0' in "if" conditions
(Thanks to Kevin and Paul for the above suggestions)

Previous version of this patch series is available at:
http://ns.spinics.net/lists/linux-omap/msg48167.html
http://ns.spinics.net/lists/linux-omap/msg47989.html
http://ns.spinics.net/lists/linux-omap/msg47827.html
http://ns.spinics.net/lists/linux-omap/msg47830.html

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

GPIO module functionality testing (success on the following boards):
 - OMAP2420-H4
 - OMAP3430-SDP
 - OMAP3430-Zoom2
 - OMAP3630-Zoom3
 - OMAP4430-SDP

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
	     echo mem > /sys/power/state


Charulatha V (7):
  OMAP: GPIO: Make gpio_context part of gpio_bank structure
  OMAP: GPIO: Use flag to identify wkup dmn GPIO
  OMAP4: GPIO: Save/restore context
  OMAP: GPIO: handle save/restore ctx in GPIO driver
  OMAP2+: GPIO: make workaround_enabled bank specific
  OMAP: GPIO: Cleanup prepare_for_idle/resume
  OMAP: GPIO: use PM runtime framework

 arch/arm/mach-omap2/gpio.c             |    6 +
 arch/arm/mach-omap2/pm34xx.c           |   22 +-
 arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/gpio.h |    3 +-
 4 files changed, 439 insertions(+), 358 deletions(-)

