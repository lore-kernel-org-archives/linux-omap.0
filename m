From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/3] ARM: AMx3xx: hwmod: RTC: Add lock and unlock functions
Date: Wed, 10 Jun 2015 14:56:26 +0530
Message-ID: <1433928386-24891-4-git-send-email-lokeshvutla@ti.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbbFJJ3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2015 05:29:30 -0400
In-Reply-To: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com, lokeshvutla@ti.com

RTC IP have kicker feature which prevents spurious writes to its registers.
In order to write into any of the RTC registers, KICK values has to be
written to KICK registers.

omap_hwmod_rtc_unlock/lock functions writes into these KICK registers
inorder to lock and unlock RTC registers.
This patch hooks omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index cabc569..2d92958 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -904,6 +904,8 @@ static struct omap_hwmod_class_sysconfig am33xx_rtc_sysc = {
 static struct omap_hwmod_class am33xx_rtc_hwmod_class = {
 	.name		= "rtc",
 	.sysc		= &am33xx_rtc_sysc,
+	.unlock		= &omap_hwmod_rtc_unlock,
+	.lock		= &omap_hwmod_rtc_lock,
 };
 
 struct omap_hwmod am33xx_rtc_hwmod = {
-- 
1.9.1

