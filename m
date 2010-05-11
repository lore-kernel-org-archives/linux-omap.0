From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/5] OMAP4 clockdomain: Fix omap2_clkdm_clk_enable/disable api for 44xx
Date: Tue, 11 May 2010 12:57:09 +0530
Message-ID: <1273562830-9758-5-git-send-email-rnayak@ti.com>
References: <1273562830-9758-1-git-send-email-rnayak@ti.com>
 <1273562830-9758-2-git-send-email-rnayak@ti.com>
 <1273562830-9758-3-git-send-email-rnayak@ti.com>
 <1273562830-9758-4-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab0EKH1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 03:27:18 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B7RDhP000555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 02:27:15 -0500
In-Reply-To: <1273562830-9758-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Currently omap2_clkdm_clk_enable/disable api's program all clockdomains
in forced sleep/wakeup, even if they support HWSUP/AUTO control mode.
This patch fixes this by adding the missing check for omap44xx cpu.
For omap44xx omap2_clkdm_clk_enable/disbale are actually not expected
to do anything if the clockdomain is already in HWAUTO.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6e568ec..13dcd6f 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -994,6 +994,9 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
+	if (cpu_is_omap44xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO)
+		return 0;
+
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
 	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
 		/* Disable HW transitions when we are changing deps */
@@ -1056,6 +1059,9 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 
 	v = omap2_clkdm_clktrctrl_read(clkdm);
 
+	if (cpu_is_omap44xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO)
+		return 0;
+
 	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
 	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
 		/* Disable HW transitions when we are changing deps */
-- 
1.7.0.rc1.33.g07cf0f

