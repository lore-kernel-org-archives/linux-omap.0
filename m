From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] arm: omap: fix the alphabetical order
Date: Thu, 30 Jun 2011 15:06:51 +0300
Message-ID: <1309435611-2068-1-git-send-email-balbi@ti.com>
References: <1309434503-1737-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47800 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752483Ab1F3MG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 08:06:56 -0400
Received: by mail-bw0-f50.google.com with SMTP id 11so2455393bwb.23
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 05:06:55 -0700 (PDT)
In-Reply-To: <1309434503-1737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

That might have been correct on some ancient
dead language, but I like better when things
are recent.

Fix the alphabetical order.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Fixed missing comma after Richard's name and removed
comma after Vikram's name.

Thanks Charulatha Varadarajan for spotting those two.

 arch/arm/plat-omap/include/plat/omap_device.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..5a2369ba 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -4,10 +4,9 @@
  * Copyright (C) 2009 Nokia Corporation
  * Paul Walmsley
  *
- * Developed in collaboration with (alphabetical order): Benoit
- * Cousson, Kevin Hilman, Tony Lindgren, Rajendra Nayak, Vikram
- * Pandita, Sakari Poussa, Anand Sawant, Santosh Shilimkar, Richard
- * Woodruff
+ * Developed in collaboration with (alphabetical order): Anand Sawant, Benoit
+ * Cousson, Kevin Hilman, Rajendra Nayak, Richard Woodruff, Sakari Poussa,
+ * Santosh Shilimkar, Tony Lindgren, Vikram Pandita
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.6

