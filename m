From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 03/19] omap3+: voltage: remove initial voltage
Date: Sat, 19 Feb 2011 17:31:42 +0530
Message-ID: <1298116918-30744-4-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44531 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648Ab1BSMCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:02:32 -0500
Received: by mail-gy0-f179.google.com with SMTP id 8so1880236gyg.10
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:02:31 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

omap2_set_init_voltage should setup the curr_volt based on which OPP
the system is functioning at. Blindly setting a 1.2v setting in the
initial structure may not even match the default voltages stored in
the voltage table which are supported for the domain.

For example, OMAP3430 core domain does not use 1.2v and ends up
generating a warning on the first transition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 12be525..280ee12 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -863,7 +863,6 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OCP_MOD;
 	vdd->prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
 	vdd->read_reg = omap3_voltage_read_reg;
@@ -1054,7 +1053,6 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OMAP4430_PRM_OCP_SOCKET_INST;
 	vdd->read_reg = omap4_voltage_read_reg;
 	vdd->write_reg = omap4_voltage_write_reg;
-- 
1.7.1

