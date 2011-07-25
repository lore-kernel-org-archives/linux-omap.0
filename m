From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 10/11] TEMP: OMAP3: pm: disable / enable PRCM chain interrupts during wakeup from suspend
Date: Mon, 25 Jul 2011 19:36:10 +0300
Message-ID: <1311611771-15093-11-git-send-email-t-kristo@ti.com>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35177 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab1GYQgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 12:36:38 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6PGacJd014436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:38 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6PGacok003647
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:38 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6PGaaqw009347
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:37 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This prevents system hang while attempting to access suspended console. Should
most likely be fixed with proper console locking.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b9b5128..b071857 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -506,6 +506,8 @@ static int omap3_pm_begin(suspend_state_t state)
 	disable_hlt();
 	suspend_state = state;
 	omap_uart_enable_irqs(0);
+	disable_irq(prcm_io_irq);
+	disable_irq(prcm_wkup_irq);
 	return 0;
 }
 
@@ -514,6 +516,8 @@ static void omap3_pm_end(void)
 	suspend_state = PM_SUSPEND_ON;
 	omap_uart_enable_irqs(1);
 	enable_hlt();
+	enable_irq(prcm_io_irq);
+	enable_irq(prcm_wkup_irq);
 	return;
 }
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

