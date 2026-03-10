Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBB37F007;
	Tue, 10 Mar 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141556; cv=fail; b=fN1q8HVfVNVfS5Qp+/WuFNtzBwhlkhJzhJ1/R5nwq4g+hOwYi032cRIO1OeuHA/jG3ctY7k1jx9EF8y6+Ls+KM3znJ8t3HhOTyI4H1U/gl0En52oXltDY2qoUSmMy7KFSDA/r8Y2ArkTcbWjdlslHpCvNd3E9cVryTsRopGER3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141556; c=relaxed/simple;
	bh=S7DWq4HC61el0MOZ/JMVQJV2eB5UIpt7GUjH1f4G7J8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrSaE7sErttCoum4LNgn42p8EY0UVwouYzbgLjp3izdEjHZwcrgHCKHoBni0eBOBh2ivJ6GD1B+NxhLApbKRgz436axVbvLxTjVVSlibVZHfwHve6iPgCzWn6NQ+q+kNfjCVJzk1XVK1WwfzgTLPq1N13Zke6xS0UoUFHu3ClT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xv758P6t; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xv758P6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOWnu4oJmpBT7U0imYUq2mHd9wP01Vi3j1qNN8asJw6z3It+xWyVjk7BeVQ1ConXrpWRARhdmXJPs3QGe17R2+56BFshnHkTmDIVtuDiVvHfx/IfYp90cbA09pJPdLXCGp+7GDyeQi+DbnjcX/0zM2jInJcDFqOsqw8S+1qbcjSAOIP1/Bh+Wb8utslRezj4E9aYN4pbDhohMORM16Zowu2bxYF0iCGmOZUCNyuhUvBsbL3YNaL4qXjzk35CZJVtlTAXTTKvJv+E5ct3m/PmMtYQHUw3ECRaqATxs0AN8P2+ztArW/8NVGyj6mkR+zid4gnwCSV13gf9fWSO6FRy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L0wRm/RqSJLhtSwnPJpdXphWSD570KZtfJJg/R3G4Q=;
 b=ihMaj6ubXgR11W85qnhnP40glIEGoYbqjmQYvpl9EMnAyNIYeFWeVu+CNWDp9dMinMADwZibOwTJrsUprLWrPlQgVZhbaVuAJTxconHAWyLs6NqTOYJlrQYA3fVab6oUQhjORh3JK8Zsm8RO5fzgCl7A+syKTxB3Zf4f1dpMfB29kb8RfTreW7/lUGBbXRonzirtn+82Q3lgIeu3J/vfPtkuxoQ75VV719ZLeLfaAGP2z3XJp3G8y+8oT75rUGAwRY65Ln05KlJ0Z6AnjSaQc0IKT189USQ+9PJQv17ToVTivriwuARvp8jFRenqBN+AlzVYquObtZtvbZGoFr2g6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L0wRm/RqSJLhtSwnPJpdXphWSD570KZtfJJg/R3G4Q=;
 b=Xv758P6ti0lHbbyasGMKACnse/tCxs77KFM02wdHWMIARk7Bb0e2u0LR/+B4CdRcT5XzBxYqppyMwbf3HvSSYFiO+ynb54vafQe5Weo8ZO/jbFld9itIKO4cnSXuFfynpoljrFYMlyDeExyDg0cRo3nKPr42bkW/GIFRGmmPhTo=
Received: from SN7PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:f2::20)
 by IA0PR10MB7578.namprd10.prod.outlook.com (2603:10b6:208:491::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Tue, 10 Mar
 2026 11:19:11 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::20) by SN7PR04CA0015.outlook.office365.com
 (2603:10b6:806:f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 11:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 11:19:10 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 06:19:10 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 06:19:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 06:19:09 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ABIm7c2963300;
	Tue, 10 Mar 2026 06:19:03 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <aaro.koskinen@iki.fi>, <andreas@kemnade.info>,
	<khilman@baylibre.com>, <rogerq@kernel.org>, <tony@atomide.com>,
	<lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <s-ramamoorthy@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <d-gole@ti.com>,
	<k-willis@ti.com>, <a-kaur@ti.com>
Subject: [PATCH 2/2] mfd: tps65219: Make poweroff handler conditional on system-power-controller
Date: Tue, 10 Mar 2026 16:48:46 +0530
Message-ID: <20260310111846.1084623-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310111846.1084623-1-a-kaur@ti.com>
References: <20260310111846.1084623-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA0PR10MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: d782f817-62b3-49e3-cea8-08de7e96da85
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|921020;
X-Microsoft-Antispam-Message-Info:
	mUBDDe1jNc1QouZ45+/OHLr+9g8tuEsKQxZJZpb1oxaYf5CDtfLC1wQdL/cRDpRe2+/rCbxhCZuJwnsxEv1lXmIwGHvUP+4djOaq4uKa8DKOyl1lVMZt8qzLdvxW7I7XInWZ9Zrx/LQ68DOn22Felq+PUO2/oZQpoBO4EzBX0QiJ/jIzAaiageGPIXfqxOs5Daqx+8hVyzAWsipxWhZ8LsNGPtBLjsamePl58AkNYCAK2Scaa/VGE6t46aWP/P/urSjhymE65P9UHFP0S41sHYbxqd4hcmHQE2YDzPLGTREIPvzZZMZ2gr4N4DjlZG20NtzzCZPPZULsF2O2OSi3gVdR0JOH71nE5OnENMcDWP5FZpu4JlyWu5e4Q5iUWzy4jf35t++IQcvx+b57H0NpC5ZeiMybSx0V0yeiqB7QTYfGJYifqbFwZqvvhqs1gR8lj61H1qfxPjLRJK7APhF/F/rBSDLz8KklQ2WovnhDrHkxbX5oPRMesxs9kA5UiCJkmmciwNcthXudadAbEt/sLDuktqMXPl94zF1irQEOaebzOKeSVbkCetL7ZASaf/4GkXPv0xKVHNaycCCPW/9VZcLhkjZ1q9A6+rCYe/g6BL2J8+/JhI0wWA5TpwQQOVDzTr1rrk8s2bslWEZtiVLjZ66ubn+o42eOs2QjO/FCS+/n9qWuRCV6SlHpO7H3LUFCj/pxBt3QyZsyeAxZSR/VZTBeIiI+lbH9z/T0pWBOt3wfdU07Qj9joBLiBdMaCQu9ItpgjzM+o98l826j+MJBb3iDGGngApUQbfBMn5EmYeO48ctFTM+lYN/NLuBa6Rw7
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W1+e6ib1fBQ0IGL3rq9Er9kBWwgEhCXF/BsOZ0Isz5RIJtIeN1p7SsdB7DLjbwrmndl4B38cKmZPUjO9+yGZ9ptEOBb4LsMIMKqGuMBnInGfXlXk8ko2v/dpRPGBw9xvydeCIN0GvUWRXNMqKu6x4xtpiDjEzbZUOijqAnDMfqfILPlVxkQzTrqApKdEIDbmu8gKArF5dBfE4SW2zawBS3HvePfI7lzNO6AnqDf3qSzKFevUzFqy21ys6Oj+pSjA/VU3w26MOnb8O0xIeY8WN2zHP5w+lQjwceQMIh6gc0lN3FIPgMIwHFFCvUuLreUF2YqARhOyO7wPGB1pC5A14pSRwRmrRhC/P9gtrbDi/UsKEGi87hgzlw26gSNmRL7WMRqJ6RxB7bYFWR6adPQfPlqMmSuzwUbtjLTbpxS9Csztzem7HEkFLBW0MsUFXHaA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:19:10.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d782f817-62b3-49e3-cea8-08de7e96da85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7578

Currently, the TPS65219 driver unconditionally registers a poweroff
handler. This causes issues on systems where a different component
(such as TF-A firmware) should handle system poweroff instead.

Make the poweroff handler registration conditional based on the
"system-power-controller" device tree property. This follows the
standard kernel pattern where only the designated power controller
registers for system poweroff operations.

On systems where the property is absent, the PMIC will not register
a poweroff handler, allowing other poweroff mechanisms to function.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/mfd/tps65219.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 7275dcdb7c44..beb816707d8f 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -541,13 +541,19 @@ static int tps65219_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_register_power_off_handler(tps->dev,
-					      tps65219_power_off_handler,
-					      tps);
-	if (ret) {
-		dev_err(tps->dev, "failed to register power-off handler: %d\n", ret);
-		return ret;
+	/*
+	 * Only register PMIC power-off handler if system-power-controller
+	 * property is present.
+	 */
+	if (of_device_is_system_power_controller(tps->dev->of_node)) {
+		ret = devm_register_power_off_handler(tps->dev,
+						      tps65219_power_off_handler,
+						      tps);
+		if (ret)
+			return dev_err_probe(tps->dev, ret,
+					"failed to register power-off handler\n");
 	}
+
 	return 0;
 }
 
-- 
2.34.1

