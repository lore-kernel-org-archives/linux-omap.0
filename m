From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/10]  OMAP3 SRF: Prevents OFF transitions
Date: Mon, 11 Aug 2008 18:40:29 +0530 (IST)
Message-ID: <51348.192.168.10.89.1218460229.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49343 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbYHKNKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 09:10:35 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7BDAUa8020471
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:10:35 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7BDAQk5023891
	for <linux-omap@vger.kernel.org>; Mon, 11 Aug 2008 08:10:28 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A Temp patch needed only till OFF mode is implemented.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-08-11
17:39:00.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-08-11
17:39:00.000000000 +0530
@@ -131,13 +131,13 @@ int set_pd_latency(struct shared_resourc
 				omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[i]);
 			}
 			pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
-			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+			pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
 			for (i = 0; pwrdm->pwrdm_clkdms[i]; i++) {
 				omap2_clkdm_sleep(pwrdm->pwrdm_clkdms[i]);
 				omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[i]);
 			}
 		} else
-			pwrdm_set_next_pwrst(pwrdm, pd_lat_level);
+			pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
 		break;
 	case PWRDM_POWER_ON:
 		pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);


