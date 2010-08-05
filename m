From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 00/12 v2] omap3: sr: janitor series
Date: Thu,  5 Aug 2010 17:24:00 -0500
Message-ID: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47365 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760821Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

August revision of pending janitor patches for SR rebased on latest
pm branch. Should be eventually squashed to the relevant SR patch
prior to upstreaming. Note: this series is a merged series posted
http://marc.info/?l=linux-omap&m=127741497415352&w=2 (June 24)
http://marc.info/?l=linux-omap&m=127750241431955&w=2 (June 25)
"omap3: sr: device: add unlikely checks" was dropped from this series
based on Artem's guidance - none of the other patches have recieved
any review comments so far.

Nishanth Menon (12):
  omap3: voltage: cleanup pr_xxxx
  omap3: voltage: make required variables static
  omap3: voltage: expose omap_change_voltscale_method
  omap3: sr: device: cleanup pr_xxx
  omap3: sr: device: check for dev_attr
  omap3: sr: device: fail sr_dev_init should return error
  omap3: sr: device: make omap_sr_latency static
  omap3: sr: cleanup pr_xxx
  omap3: sr: enable/disable sr only if required
  omap3: sr: export sr_dbg_dir
  omap3: sr: sr_exit should be static
  omap3: sr: class3: make class3_data static

 arch/arm/mach-omap2/smartreflex-class3.c      |    2 +-
 arch/arm/mach-omap2/smartreflex.c             |   26 ++++++++++++++++++------
 arch/arm/mach-omap2/sr_device.c               |   16 +++++++++++---
 arch/arm/mach-omap2/voltage.c                 |   13 ++++++-----
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/plat-omap/include/plat/smartreflex.h |    5 ++++
 6 files changed, 45 insertions(+), 18 deletions(-)

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Regards,
Nishanth Menon
