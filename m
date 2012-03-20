From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 RESEND 0/7] gpio/omap: Some more driver fixes
Date: Tue, 20 Mar 2012 16:23:12 +0530
Message-ID: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52146 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759671Ab2CTKxg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:53:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

This series excludes the cleanup patches as suggested by Kevin from
the previously posted series.

The fixes include correction of _set_gpio_irqenable() implementation,
missing wakeup_en register update in set_gpio_wakeup(), type mismatch
of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
register update in set_gpio_dataout_() and few corrections in context
save logic.

It is baselined on top of:
git://git.secretlab.ca/git/linux-2.6.git gpio/next
Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_fixes

Power Test:
Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
Also confirmed that dataout register content preserved over
off-mode.

Functional Test:
OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZE

v4:
a) Implemented all comments on v3 which are mostly related to
avoiding unnecessary register read while updating the context.

b) Folded:
gpio/omap: fix dataout register overwrite in _set_gpio_dataout
into:
gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg

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

Tarun Kanti DebBarma (7):
  gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
  gpio/omap: fix trigger type to unsigned
  gpio/omap: fix _set_gpio_irqenable implementation
  gpio/omap: fix missing dataout context save in _set_gpio_dataout_reg
  gpio/omap: fix incorrect context restore logic in omap_gpio_runtime_*
  gpio/omap: fix incorrect update to context.irqenable1
  gpio/omap: fix redundant decoding of gpio offset

 drivers/gpio/gpio-omap.c |   47 ++++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 22 deletions(-)

