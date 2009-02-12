From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 3/3] Boosting OPP1 voltage level
Date: Thu, 12 Feb 2009 14:48:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1013@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39653 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbZBLJSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:18:52 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9IjL8005028
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:18:51 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9IiJP002013
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:48:44 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From a0b8d146249e05465ff30cfd72592418c7a5da8d Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Thu, 12 Feb 2009 03:03:18 +0530
Subject: [PATCH 3/3] Boosting OPP1 voltage level

some issues are observed like DSP sending SYS_ERROR
MMU Fault if operated in OPP1, Looks like drop in voltage
making DSP to crash, this patch boosts voltage level slightly
for stable DSP.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

---
 arch/arm/mach-omap2/omap3-opp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index 5540e5b..3b7fff6 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -24,7 +24,7 @@
 static struct omap_opp omap3_mpu_rate_table[] = {
 	{0, 0, 0},
 	/*OPP1*/
-	{S125M, VDD1_OPP1, 0x18},
+	{S125M, VDD1_OPP1, 0x1C},
 	/*OPP2*/
 	{S250M, VDD1_OPP2, 0x20},
 	/*OPP3*/
@@ -48,7 +48,7 @@ static struct omap_opp omap3_l3_rate_table[] = {
 static struct omap_opp omap3_dsp_rate_table[] = {
 	{0, 0, 0},
 	/*OPP1*/
-	{S90M, VDD1_OPP1, 0x18},
+	{S90M, VDD1_OPP1, 0x1C},
 	/*OPP2*/
 	{S180M, VDD1_OPP2, 0x20},
 	/*OPP3*/
-- 
1.5.3.2
