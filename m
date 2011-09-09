From: sricharan <r.sricharan@ti.com>
Subject: [PATCH v2 1/8] OMAP: hwmod: Fix the addr spaces, irq, dma count APIs.
Date: Fri, 9 Sep 2011 21:32:14 +0530
Message-ID: <1315584134-3869-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537Ab1IIP7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 11:59:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: b-cousson@ti.com, santosh.shilimkar@ti.com, paul@pswan.com

The address spaces, irqs and dma reqs count API returns the
number of corresponding entries in a hwmod including a additional
null value or a -1 terminator in the structure introduced
recently. More information here:

	212738a4 (omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs arrays)
	78183f3f (omap_hwmod: use a null structure record to terminate omap_hwmod_addr_space arrays)
	bc614958 (omap_hwmod: use a terminator record with omap_hwmod_dma_info arrays)

The devices which have multiple hwmods and use device_build_ss are
broken with this, as their resources are populated with a
extra null value, subsequently the probe fails. So fix the API not to
include the array terminator in the count.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
[v1]
     Initial version.
[v2]
     1) Added the correction for irq and dma counts along with
	addr spaces.
     2) Changed the commit log.

 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..c69fbc2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -745,9 +745,9 @@ static int _count_mpu_irqs(struct omap_hwmod *oh)
 	if (!oh || !oh->mpu_irqs)
 		return 0;
 
-	do {
-		ohii = &oh->mpu_irqs[i++];
-	} while (ohii->irq != -1);
+	ohii = &oh->mpu_irqs[i];
+	while (ohii->irq != -1)
+		ohii = &oh->mpu_irqs[++i];
 
 	return i;
 }
@@ -768,9 +768,9 @@ static int _count_sdma_reqs(struct omap_hwmod *oh)
 	if (!oh || !oh->sdma_reqs)
 		return 0;
 
-	do {
-		ohdi = &oh->sdma_reqs[i++];
-	} while (ohdi->dma_req != -1);
+	ohdi = &oh->sdma_reqs[i];
+	while (ohdi->dma_req != -1)
+		ohdi = &oh->sdma_reqs[++i];
 
 	return i;
 }
@@ -791,9 +791,9 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 	if (!os || !os->addr)
 		return 0;
 
-	do {
-		mem = &os->addr[i++];
-	} while (mem->pa_start != mem->pa_end);
+	mem = &os->addr[i];
+	while (mem->pa_start != mem->pa_end)
+		mem = &os->addr[++i];
 
 	return i;
 }
-- 
1.7.0.4

