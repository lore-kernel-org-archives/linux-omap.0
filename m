Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D25C63697
	for <linux-omap@archiver.kernel.org>; Wed, 18 Nov 2020 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A1D22244
	for <linux-omap@archiver.kernel.org>; Wed, 18 Nov 2020 14:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YSLN8FHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgKROTL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:19:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34470 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKROTL (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2020 09:19:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIEJ7dq066074;
        Wed, 18 Nov 2020 08:19:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605709147;
        bh=KI2Z4UHnxhnILseGS7lyqummupvcLaGAH+tnwbFydjE=;
        h=From:To:CC:Subject:Date;
        b=YSLN8FHRSD9I47kMCVjUBOq0tt/8T6pgf3oAqJ5bZR2dz6v3eTVxEsYdOcS3J6F5/
         SsxXY4BMmGoB0Agw5ACfDHQ9NuB79rp28Qu7pQaiZ4KeKX7cOcMiUsTYHKinmQ4yJZ
         tTkrUZ1J4AudiSDdwo7MGPRNzSjV5jhpQmi57aXQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIEJ7A9006416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 08:19:07 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 08:19:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 08:19:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIEJ6n1037747;
        Wed, 18 Nov 2020 08:19:07 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] bus: ti-sysc: suppress err msg for timers used as clockevent/source
Date:   Wed, 18 Nov 2020 16:19:00 +0200
Message-ID: <20201118141900.25063-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

GP Timers used as clockevent/source are not available for ti-sysc bus and
handled by Kernel timekeeping core. Now ti-sysc produces error message
every time such timer is detected:

 "ti-sysc: probe of 48040000.target-module failed with error -16"

Such messages are not necessary, so suppress them by returning -ENXIO
instead of -EBUSY.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 792a2878cb16..02186bac1b0b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2883,7 +2883,7 @@ static int sysc_check_active_timer(struct sysc *ddata)
 
 	if ((ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT) &&
 	    (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE))
-		return -EBUSY;
+		return -ENXIO;
 
 	return 0;
 }
-- 
2.17.1

