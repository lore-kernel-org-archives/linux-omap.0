Return-Path: <SRS0=R7rC=DW=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E631C43457
	for <linux-omap@archiver.kernel.org>; Thu, 15 Oct 2020 23:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4E4207DE
	for <linux-omap@archiver.kernel.org>; Thu, 15 Oct 2020 23:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aNFLQgQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgJOXUC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 15 Oct 2020 19:20:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387898AbgJOXT5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2020 19:19:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09FNJr88066222;
        Thu, 15 Oct 2020 18:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602803993;
        bh=UOsV4hFzLJcmVg5PO1oqNX4CoiVj9cQF3QnIMYWLfo4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aNFLQgQcKfJ/wCC4hzepf/yi9PdJ82WdOHZhOSRpWeh16trIMdHVFtPJM8Yp2GCNT
         7JxpIqqUn3Zzb/1epAWrNlxG8d7nOjaGaz58MuWZWcIBCa+TtR/GzJwCZpxNpm+Ntf
         RlEdKgfRVOsRfWHDNqWpvMqJV0aOcS39PtLSqVVk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09FNJrkS008420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 18:19:53 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 15
 Oct 2020 18:19:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 15 Oct 2020 18:19:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09FNJpIV057704;
        Thu, 15 Oct 2020 18:19:52 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 4/9] net: ethernet: ti: cpsw_ale: add cpsw_ale_vlan_del_modify()
Date:   Fri, 16 Oct 2020 02:19:08 +0300
Message-ID: <20201015231913.30280-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015231913.30280-1-grygorii.strashko@ti.com>
References: <20201015231913.30280-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Add/export cpsw_ale_vlan_del_modify() and use it in cpsw_switchdev instead
of generic cpsw_ale_del_vlan() to avoid mixing 8021Q and switchdev VLAN
offload. This is preparation patch equired by follow up changes.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c       | 24 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ale.h       |  1 +
 drivers/net/ethernet/ti/cpsw_switchdev.c |  2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index a6a455c32628..b1cce39eda17 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -634,8 +634,8 @@ int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port_mask, int untag,
 	return 0;
 }
 
-static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
-				     u16 vid, int port_mask)
+static void cpsw_ale_vlan_del_modify_int(struct cpsw_ale *ale,  u32 *ale_entry,
+					 u16 vid, int port_mask)
 {
 	int reg_mcast, unreg_mcast;
 	int members, untag;
@@ -644,6 +644,7 @@ static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
 					ALE_ENT_VID_MEMBER_LIST);
 	members &= ~port_mask;
 	if (!members) {
+		cpsw_ale_set_vlan_untag(ale, ale_entry, vid, 0);
 		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
 		return;
 	}
@@ -673,6 +674,23 @@ static void cpsw_ale_del_vlan_modify(struct cpsw_ale *ale, u32 *ale_entry,
 			      ALE_ENT_VID_MEMBER_LIST, members);
 }
 
+int cpsw_ale_vlan_del_modify(struct cpsw_ale *ale, u16 vid, int port_mask)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
+	int idx;
+
+	idx = cpsw_ale_match_vlan(ale, vid);
+	if (idx < 0)
+		return -ENOENT;
+
+	cpsw_ale_read(ale, idx, ale_entry);
+
+	cpsw_ale_vlan_del_modify_int(ale, ale_entry, vid, port_mask);
+	cpsw_ale_write(ale, idx, ale_entry);
+
+	return 0;
+}
+
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -685,7 +703,7 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 	cpsw_ale_read(ale, idx, ale_entry);
 
 	if (port_mask) {
-		cpsw_ale_del_vlan_modify(ale, ale_entry, vid, port_mask);
+		cpsw_ale_vlan_del_modify_int(ale, ale_entry, vid, port_mask);
 	} else {
 		cpsw_ale_set_vlan_untag(ale, ale_entry, vid, 0);
 		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 5e4a69662c5f..13fe47687fde 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -134,6 +134,7 @@ static inline int cpsw_ale_get_vlan_p0_untag(struct cpsw_ale *ale, u16 vid)
 
 int cpsw_ale_vlan_add_modify(struct cpsw_ale *ale, u16 vid, int port_mask,
 			     int untag_mask, int reg_mcast, int unreg_mcast);
+int cpsw_ale_vlan_del_modify(struct cpsw_ale *ale, u16 vid, int port_mask);
 void cpsw_ale_set_unreg_mcast(struct cpsw_ale *ale, int unreg_mcast_mask,
 			      bool add);
 
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
index 985a929bb957..29747da5c514 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.c
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -227,7 +227,7 @@ static int cpsw_port_vlan_del(struct cpsw_priv *priv, u16 vid,
 	else
 		port_mask = BIT(priv->emac_port);
 
-	ret = cpsw_ale_del_vlan(cpsw->ale, vid, port_mask);
+	ret = cpsw_ale_vlan_del_modify(cpsw->ale, vid, port_mask);
 	if (ret != 0)
 		return ret;
 
-- 
2.17.1

