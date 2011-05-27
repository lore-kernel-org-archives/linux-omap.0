From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/2] Some omap_device/hwmod/pwrdomain patches
Date: Fri, 27 May 2011 10:38:26 +0300
Message-ID: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47462 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754345Ab1E0Hij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 03:38:39 -0400
Received: by mail-ey0-f169.google.com with SMTP id 9so785237eyd.14
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 00:38:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

I came up with these patches while implementing pm runtime adaptation for DSS
driver. I'm not quite sure on who's turf they belong, or do they even belong
together, but here they are anyway.

get_context_loss_count patch was discussed on l-o with Kevin.

The omap_device_reset patch I made as some parts of DSS currently presume that
the HW module is reset when it is enabled, and the reset is better handled in
hwmod code.

Changes in v2
* Dropped can-ever-lose-context patch
* Use INT_MAX instead of ~(1 << 31) when masking the ctx loss count

 Tomi

Tomi Valkeinen (2):
  OMAP: change get_context_loss_count ret value to int
  OMAP: add omap_device_reset()

 arch/arm/mach-omap2/omap_hwmod.c              |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |   14 ++++++++++----
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    3 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   24 +++++++++++++++++-------
 arch/arm/plat-omap/omap_device.c              |   25 ++++++++++++++++++++++++-
 8 files changed, 58 insertions(+), 18 deletions(-)

-- 
1.7.4.1

