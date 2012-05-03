From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 05/13] TEMP: ARM: OMAP5: Update the base address of the 32k-counter.
Date: Thu, 3 May 2012 12:56:14 +0530
Message-ID: <1336029982-31898-6-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39599 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab2ECH0f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:26:35 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

Not for merge.

Just update the base address of the counter for
OMAP5 soc.

This patch will no longer be needed after rebasing on top of below
series from Vaibhav Hiremath <hvaibhav@ti.com>.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67166.html

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/counter_32k.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..5a48ec9 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -90,6 +90,8 @@ int __init omap_init_clocksource_32k(void)
 			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
 		else if (cpu_is_omap44xx())
 			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
+		else if (cpu_is_omap54xx())
+			pbase = OMAP54XX_32KSYNCT_BASE + 0x30;
 		else
 			return -ENODEV;
 
-- 
1.7.1

