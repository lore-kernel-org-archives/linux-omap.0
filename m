Return-Path: <SRS0=2M7l=CF=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0926AC433E3
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84A322B4B
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SzqCyDHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgH0Owq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:52:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0NVm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2020 09:21:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07RDLL32051660;
        Thu, 27 Aug 2020 08:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598534481;
        bh=jcZmBfUXVLDbmP9+jachlmxqxGc7XxXtsRG81uIPyOc=;
        h=From:To:Subject:Date;
        b=SzqCyDHmBO2/C3U30I0112wCgCfaHCnbscxSsxiJFpWyQJ29kACluLvsyPdoZme/E
         T8VSmxq0RJanT7Ca8gDvE1QUO8BzfvGjzgMwlPgsTc2ls+jcKotzckur082i8pyF8z
         rPAIZ/jPIFyae6u3Hc+y5Hm3es6TFf6RwNqZFT0E=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07RDLLHU025533;
        Thu, 27 Aug 2020 08:21:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 27
 Aug 2020 08:21:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 27 Aug 2020 08:21:20 -0500
Received: from uda0868495.fios-router.home (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07RDLJJo113730;
        Thu, 27 Aug 2020 08:21:19 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v4] net: ethernet: ti: cpsw_new: fix error handling in cpsw_ndo_vlan_rx_kill_vid()
Date:   Thu, 27 Aug 2020 09:21:18 -0400
Message-ID: <20200827132118.31768-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

This patch fixes a bunch of issues in cpsw_ndo_vlan_rx_kill_vid()

 - pm_runtime_get_sync() returns non zero value. This results in
   non zero value return to caller which will be interpreted as error.
   So overwrite ret with zero.
 - If VID matches with port VLAN VID, then set error code.
 - Currently when VLAN interface is deleted, all of the VLAN mc addresses
   are removed from ALE table, however the return values from ale function
   calls are not checked. These functions can return error code -ENOENT.
   But that shouldn't happen in a normal case. So add error print to
   catch the situations so that these can be investigated and addressed.
   return zero in these cases as these are not real error case, but only
   serve to catch ALE table update related issues and help address the
   same in the driver.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v4 - updated error message with name of the function failed.
 v3 - updated commit description to describe error check related to
      port vlan VID
 v2 - updated comments from Grygorii, also return error code if VID
 drivers/net/ethernet/ti/cpsw_new.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 8d0a2bc7128d..8ed78577cded 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1032,19 +1032,34 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 		return ret;
 	}
 
+	/* reset the return code as pm_runtime_get_sync() can return
+	 * non zero values as well.
+	 */
+	ret = 0;
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		if (cpsw->slaves[i].ndev &&
-		    vid == cpsw->slaves[i].port_vlan)
+		    vid == cpsw->slaves[i].port_vlan) {
+			ret = -EINVAL;
 			goto err;
+		}
 	}
 
 	dev_dbg(priv->dev, "removing vlanid %d from vlan filter\n", vid);
-	cpsw_ale_del_vlan(cpsw->ale, vid, 0);
-	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-			   HOST_PORT_NUM, ALE_VLAN, vid);
-	cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
-			   0, ALE_VLAN, vid);
+	ret = cpsw_ale_del_vlan(cpsw->ale, vid, 0);
+	if (ret)
+		dev_err(priv->dev, "cpsw_ale_del_vlan() failed: ret %d\n", ret);
+	ret = cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
+				 HOST_PORT_NUM, ALE_VLAN, vid);
+	if (ret)
+		dev_err(priv->dev, "cpsw_ale_del_ucast() failed: ret %d\n",
+			ret);
+	ret = cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
+				 0, ALE_VLAN, vid);
+	if (ret)
+		dev_err(priv->dev, "cpsw_ale_del_mcast failed. ret %d\n",
+			ret);
 	cpsw_ale_flush_multicast(cpsw->ale, ALE_PORT_HOST, vid);
+	ret = 0;
 err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
-- 
2.17.1

