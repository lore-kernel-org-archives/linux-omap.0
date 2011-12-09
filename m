From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 2/5] omap3: voltage: fix channel configuration
Date: Fri, 9 Dec 2011 17:29:46 +0200
Message-ID: <1323444589-19940-3-git-send-email-t-kristo@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58793 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab1LIPaA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:30:00 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pB9FTxt7004664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:59 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTxZf000578
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:59 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTxE5018729
	for <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:59 -0600 (CST)
Received: from localhost.localdomain (h88-4.vpn.ti.com [172.24.88.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id pB9FTtvD006466	for
 <linux-omap@vger.kernel.org>; Fri, 9 Dec 2011 09:29:58 -0600
In-Reply-To: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
overlap with VDD2 and attempting to modify VDD1 voltage will actually change
VDD2 voltage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc3xxx_data.c |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index cfe348e..0136ad5 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -46,6 +46,7 @@ static struct omap_vc_common omap3_vc_common = {
 };
 
 struct omap_vc_channel omap3_vc_mpu = {
+	.flags = OMAP_VC_CHANNEL_DEFAULT,
 	.common = &omap3_vc_common,
 	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
-- 
1.7.4.1

