From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 05/09] Prevents OFF transitions
Date: Tue, 8 Jul 2008 17:09:28 +0530
Message-ID: <030c01c8e0ef$47c04e50$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49324 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYGHLjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:37 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdTI8021819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:36 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxK005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:28 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a temp patch needed only till OFF mode is implemented.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>


---
 arch/arm/mach-omap2/resource34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-07-07 10:22:52.050624622 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-07-07 10:23:07.006143844 +0530
@@ -130,13 +130,13 @@ int set_pd_latency(struct shared_resourc
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

