From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [PATCH 6/6] DSPBRIDGE: Remove Warning pointer from integer w/o cast
Date: Tue, 3 Nov 2009 17:12:16 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426AACC50@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbZKCXML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:12:11 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3NCHTY028705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:12:17 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3NCGPN009176
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:12:16 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3NCGWv013129
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:12:16 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

warning: initialization makes pointer from integer without a cast

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 34e5a74..9324f1e 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -798,7 +798,8 @@ DSP_STATUS tiomap3430_bump_dsp_opp_level(void)
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	struct WMD_DEV_CONTEXT *dwContext;
-	struct DEV_OBJECT *hDevObject = DRV_GetFirstDevObject();
+	struct DEV_OBJECT *hDevObject =
+			(struct DEV_OBJECT *)DRV_GetFirstDevObject();
 	struct dspbridge_platform_data *pdata =
 			omap_dspbridge_dev->dev.platform_data;
 
-- 
1.6.2.4
