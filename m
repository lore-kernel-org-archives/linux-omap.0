From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] Some omap_device/hwmod/pwrdomain patches
Date: Thu, 26 May 2011 19:45:04 +0300
Message-ID: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50746 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932212Ab1EZQpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 12:45:24 -0400
Received: by ewy6 with SMTP id 6so343033ewy.38
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 09:45:22 -0700 (PDT)
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

can_ever_lose_context code I didn't strictly need, but as there's such a
function I added that to the context save code in DSS while rewriting the code.

 Tomi

Tomi Valkeinen (3):
  OMAP: change get_context_loss_count ret value to int
  OMAP: add omap_device_reset()
  OMAP: Add (omap_device|omap_hwmod)_can_ever_lose_context functions

 arch/arm/mach-omap2/omap_hwmod.c              |   24 ++++++++++++-
 arch/arm/mach-omap2/powerdomain.c             |   14 +++++--
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   24 +++++++++----
 arch/arm/plat-omap/omap_device.c              |   48 ++++++++++++++++++++++++-
 8 files changed, 105 insertions(+), 18 deletions(-)

-- 
1.7.4.1

