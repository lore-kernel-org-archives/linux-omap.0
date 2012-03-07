From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Wed, 7 Mar 2012 16:45:50 +0530
Message-ID: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab2CGLQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 06:16:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
as we already have them as part of bank->context now. Also, remove un-used
variable from gpio_irq_handler.

The fixes include correction of _set_gpio_irqenable() implementation,
missing wakeup_en register update in set_gpio_wakeup(), type mismatch
of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
register update in set_gpio_dataout_() and few corrections in context
save logic.

It is baselined on top of Kevin's following series:
gpio/omap: cleanup and runtime PM conversion for v3.4
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes

Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZE

v3:
- Added 4 more additional patches to the previous series
  which are all bug fixes.

v2:
- Added a new patch to update wakeup_en register in _set_gpio_wakeup()
 in addition to updating bank->context.wake_en.

- Added a new patch to remove redundant decoding of gpio offset in
 gpio_get(), _get_gpio_datain() and _get_gpio_dataout().

- Added a new patch to remove suspend/resume callbacks because the
 operations performed with the callbacks are redundant.

Tarun Kanti DebBarma (13):
  gpio/omap: remove saved_fallingdetect, saved_risingdetect fields
  gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
  gpio/omap: remove suspend_wakeup field from struct gpio_bank
  gpio/omap: remove saved_wakeup field from struct gpio_bank
  gpio/omap: get rid of retrigger variable in gpio_irq_handler
  gpio/omap: fix trigger type to unsigned
  gpio/omap: fix _set_gpio_irqenable implementation
  gpio/omap: remove redundant decoding of gpio offset
  gpio/omap: remove suspend/resume callbacks
  gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg
  gpio/omap: fix dataout register overwrite in _set_gpio_dataout_*
  gpio/omap: fix incorrect context restore logic in omap_gpio_runtime_resume
  gpio/omap: fix incorrect update to context.irqenable1

 drivers/gpio/gpio-omap.c |  125 +++++++++++++--------------------------------
 1 files changed, 36 insertions(+), 89 deletions(-)

