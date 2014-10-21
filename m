From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/5] ARM: OMAP2+: gpmc: Error out if timings fail in gpmc_probe_generic_child()
Date: Tue, 21 Oct 2014 15:41:46 +0300
Message-ID: <1413895309-9152-3-git-send-email-rogerq@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbaJUMl7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Oct 2014 08:41:59 -0400
In-Reply-To: <1413895309-9152-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>

gpmc_cs_set_timings() returns non-zero if there was
an error while setting the GPMC timings. e.g. Timing was too
large to be accomodated with current GPMC clock frequency and available
timing range. Fail in this case, else we risk operating a NOR device
with non compliant timings.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 45f680f..f5d9dd2 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1562,7 +1562,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 
 	gpmc_read_timings_dt(child, &gpmc_t);
-	gpmc_cs_set_timings(cs, &gpmc_t);
+	ret = gpmc_cs_set_timings(cs, &gpmc_t);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set gpmc timings for: %s\n",
+			child->name);
+		goto err;
+	}
 
 no_timings:
 	if (of_platform_device_create(child, NULL, &pdev->dev))
-- 
1.8.3.2

