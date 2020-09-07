Return-Path: <SRS0=EwIw=CQ=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B10C2D0E1
	for <linux-omap@archiver.kernel.org>; Mon,  7 Sep 2020 08:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F423521556
	for <linux-omap@archiver.kernel.org>; Mon,  7 Sep 2020 08:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OK4DSsR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgIGI0K (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:26:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41054 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgIGI0I (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2020 04:26:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0878Q44B020255;
        Mon, 7 Sep 2020 03:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599467164;
        bh=pkx2SrCRUB6MBIJBbgIJ0ZtAu8m9uIBL0QuzR64GiNI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OK4DSsR86L7w75icpyFIqLJE1ITazBi9TsgJL7eYrQlIzxTviMspQ7sO0XBQj1skC
         6AAP0MkaxqK0WOWCFVJREyfx79LqbrmyDRvBsw3vYkzM1m9dLhZlvCDsuZ1r93+66P
         VoCYpc0Q3Y+simGgTAu8l33FIBsfLUsa5Y3PjQ2Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0878Q4uS075601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 03:26:04 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 03:26:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 03:26:04 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878Q1YH087957;
        Mon, 7 Sep 2020 03:26:03 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <sboyd@kernel.org>
CC:     <linux-omap@vger.kernel.org>
Subject: [PATCH 1/3] clk: ti: autoidle: add checks against NULL pointer reference
Date:   Mon, 7 Sep 2020 11:25:58 +0300
Message-ID: <20200907082600.454-2-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907082600.454-1-t-kristo@ti.com>
References: <20200907082600.454-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The clk pointer passed to omap2_clk_(deny|allow)_idle can be NULL, so
add checks for this.

Reported-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/autoidle.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 1cae226759dd..f6f8a409f148 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -82,7 +82,12 @@ static int _omap2_clk_allow_idle(struct clk_hw_omap *clk)
  */
 int omap2_clk_deny_idle(struct clk *clk)
 {
-	struct clk_hw *hw = __clk_get_hw(clk);
+	struct clk_hw *hw;
+
+	if (!clk)
+		return -EINVAL;
+
+	hw = __clk_get_hw(clk);
 
 	if (omap2_clk_is_hw_omap(hw)) {
 		struct clk_hw_omap *c = to_clk_hw_omap(hw);
@@ -101,7 +106,12 @@ int omap2_clk_deny_idle(struct clk *clk)
  */
 int omap2_clk_allow_idle(struct clk *clk)
 {
-	struct clk_hw *hw = __clk_get_hw(clk);
+	struct clk_hw *hw;
+
+	if (!clk)
+		return -EINVAL;
+
+	hw = __clk_get_hw(clk);
 
 	if (omap2_clk_is_hw_omap(hw)) {
 		struct clk_hw_omap *c = to_clk_hw_omap(hw);
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
