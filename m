From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 10/12] OMAP3+: VP: update_errorgain(): return error if VP
Date: Mon, 29 Aug 2011 10:58:10 -0700
Message-ID: <1314640692-3386-11-git-send-email-khilman@ti.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60563 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754430Ab1H2R6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:58:03 -0400
Received: by mail-yi0-f44.google.com with SMTP id 12so3358447yie.3
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:58:00 -0700 (PDT)
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Add check for valid VP in omap_vp_update_errorgain()

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 3807620..29698ac 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -103,6 +103,9 @@ int omap_vp_update_errorgain(struct voltagedomain *voltdm,
 {
 	struct omap_volt_data *volt_data;
 
+	if (!voltdm->vp)
+		return -EINVAL;
+
 	/* Get volt_data corresponding to target_volt */
 	volt_data = omap_voltage_get_voltdata(voltdm, target_volt);
 	if (IS_ERR(volt_data))
-- 
1.7.6

