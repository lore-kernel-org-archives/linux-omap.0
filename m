Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB69566C48;
	Tue,  8 Sep 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882189; cv=fail; b=LrXX29Jy+UpPdZeEV2WKyIdMVKQ+dkzs9xL13GuFhmJC2EKuW+vEJVhzFywl1wdfWNQ8Fj0OWyYSb4eOlplCAKbfm+FwPZNV/Rz/ksKBdi5CNhYKu9VVPbTtCjErAjjNq36MpRTi4IKMuxh2nodbPukuTKOBlqYNT0xJ3+DWarE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882189; c=relaxed/simple;
	bh=D3vWuoujBubp5bT9ZHDQeih/pkyy+vORMKoxxQ99wHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtQ2YX8kmNQ8qyL8UDYmwanowZFw3IXBG/Ensjx1dh5+T4anxu9s2wo+qVRDlCWNzRkOrtWwNbdWQX17gbYaL+MmQJ9Twyze0ZRauDDlS0j7+FL7uoe5yXb3RRRzNCL4K926MSohxFIvJWzC9qij484RRVLdXflHHuwsOXfzb2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=N2u9rj/P; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uqu/46kk; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="N2u9rj/P";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uqu/46kk"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Eloog1845540;
	Tue, 8 Sep 2026 10:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wBYMysOBsG3Mpnztt/jp8rqcUrVbJ5vmIz1uOCkQQ
	8k=; b=N2u9rj/PifGFGUYmXVFTljJu6adAil8yrmS6IEan89DOLTq6ZM6hyvK6U
	LOUOFmTtFaN3AGDw8R2hxkFzBUN/2jSl6wMUOnFom7BjSswGb1c2O3DwYY1xMd88
	6ohIJo83ZjxTOIcS553ZKKyhn/vRf5m9v4F6VDDJyFG4FbZpVcljCKBSjWCuJzlm
	bxJO8FUew3H0dxYnvgn/RK5TytyapqwDhWcLIMHKPIU4lTAPGyEfa7SabHmZE3vj
	6pQwguLsDZVCesGut2ZnzPzI5ThpHwc4NDCfTDUyhD3BPd77nJQB/CJpYnDRPHOV
	3l8DUCTiMb6SV4DAoZwRAKaMeVYzQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940mxxt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:42:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtnWYmYz922LT7edljOJ5yah5GGyH5QxYdyWOBv4nN93YdxHAPfYMNiSf7eGOYD7EoRbOrkKCAsXCQnzxKO+PSVOLd1SGdjOGrZTMUc35E1J+NKN3X/ie7mvx9vV0NO0VgJSCp9MOz0SwJatU7Y2YJtAvQ46wQDPQlmYL9KcYb2qxO5wOCMdTCyHguJgyYjkmg3nbwH3UeYQpEaWjp6uBIMf4NYoTOGJZ1e6ATnqyjbrAubmyt2v/GiNKhRuMK3bfxaQ2d6g+I9sOm0D5Hdt1RAsAHWS/92GMrkw8BjkngugdAQfQ8D+h5o/lv5Kg0O/41IPjaXh08irF8nXg0ekKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBYMysOBsG3Mpnztt/jp8rqcUrVbJ5vmIz1uOCkQQ8k=;
 b=WVO/fIs//FZeDUnh8tlsqhFDQUN7hcnFfU7ywjRAqpZYu4cSgshxetrlXNMdgkSYmJTHE0mEXGiOk4FuhxjNfcpWDF+WRGP7c7QE+1j5QjfQ4kHPjMXfnM98TaKbksKkF7oxjkh3SKvBy2LVR8KQ3TSpad2jVXQKqMYcZkPboMn1c3ipa/S4/rUUWs09ab5IRdbUcUvSb6QIjvprYvhveDcYm+tHSzkYGXgHxgcDz48PdudwzFLKnGnzYMmoODkL8QtYcfM2o/ENlyN48EFDI/SCh8VZD4Xu1XShLwnlWk7PO/xiZuq7c1QzXduRyixbKqCNdg9Vq0Wur/LMFya6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBYMysOBsG3Mpnztt/jp8rqcUrVbJ5vmIz1uOCkQQ8k=;
 b=uqu/46kkfuMs7SQ7ejdc5sdeNFoM8BKgYYsSmHQC95yJnfUdQ+meaXxj6Yd+cD66840cY+I+ziNmVZEqxzW5W4qRAzdvCBY0eUGuryZ5YfLeraWLdcPA/q2mDMauWRb8jmAn+eYQypXwWWfdIxbwpGaE5OKQl86aGRBogZRco0M=
Received: from CH2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:610:4d::16)
 by PH3PPF730141699.namprd10.prod.outlook.com (2603:10b6:518:1::7ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:42:36 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::6c) by CH2PR19CA0006.outlook.office365.com
 (2603:10b6:610:4d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 15:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:36 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:25 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:25 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWd3725209;
	Tue, 8 Sep 2026 10:42:25 -0500
From: Andrew Davis <afd@ti.com>
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        "Andreas
 Kemnade" <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 3/8] i2c: omap: Use devm_pm_runtime_enable() helper
Date: Tue, 8 Sep 2026 10:42:18 -0500
Message-ID: <20260908154223.116074-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260908154223.116074-1-afd@ti.com>
References: <20260908154223.116074-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|PH3PPF730141699:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f9262c-3238-46b8-a3fe-08df0dbfce8a
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Wmpky1vZOF6VL8mUuZnCgbvmeVXBWKg4JEfQl4UftdDFgjvs7QqXsqUC4He27+y0cHUqvb5yE4y+XCo/ZZ5HVSzt3ikgw/7UZ59baXeTTNGMYc1EYARyr5usYb1/IoF4tF3i5p2Dyoi9lldPlTZo1CFRzUhGTe0sVD0zhid4E01NZ+W1K1I8mpKNrAQzMWcu73HVXnOCNN2pK3zZKf0OaZGuwTio+j7uRUv88OKLNli0iPq0ZI3yMkOy4ofPPvJt5I0hv5fXf81VX09uPvHba9xdQJSv7N8UEHRW5wLIAmh2+oIH9CadSsR/qxCUt2Xo5DNlH8Zq0Ry28PEIOU6OU7USowV6TyXwH612JQGFifVhIFfpxikCW2Zqs6gh0FQuq3UNwG/Qsj5HuP1xLG08wjz3PKRr9QcARcWcM5ZppUpf/1VHQOFOOgz7h/1S3e1vWDyGf2l17sW7a6JwGy2wcgkz7QCmAtVucPxYh3ZV5u6N8Cu+2gCbbAxmK7q8Q8pg9FGyNaJPZvE5+y2LIDecTExW2Qq4UkmZorHp5nYGDv/9CukcdbHN7N93gPi38dFFVyNt0rJBrPaiyhL9tvNFvbkloOViyMEYJuU6jKb0luMnjXpCBkNmD9uVIoEBqphriow8uSOu/MqwPhdVeVfn6hZ8BOxQH2IPzJ9WumfKf4GHCZuFrRbJlM6pMFBcAiCvZ8S6zO/XLJzYgpMpFpxmKA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	weLJvrmpIfv4qTvT4gZJZfx28g3zsiAvc9p2FiI/4zP1RCsyMoCo5ciaNPQsx7viEaTsBGHCJPjgzIIwMmwxbi7yRxYOo7k06V62B28i5lS9XebMEbjoBH9Dchy+r3k5PO4JcFM2dF2aPnlRxU48qf5CgYeschii+KyPofDLP2d1J9UNuN1BE6TBfN8waYvrL0EFJeUnjR8+fw8YIZBHT1UcWuV/PfCGUtPJYwLzQPapxmx8LTONshmXAiiajZFtLGG3RHuj6BiTOMVkAbB6oYKAi2N02gNgNAQ5+PSArqzZD85MekcqEkJCWUzMdXB5dDekpKH9HrYrtomv/2MzkCWvVwCzNQi55/vobmb0U4dSwKQ5sjJ1JvEnA3WjilbHS19OtbR/Wq4DU1IgX8+hPDZQkdLbcncTYi0wAH/ngGuIxBhQ1lgQwlaVcaKtpy33
X-Exchange-RoutingPolicyChecked:
	q6rFHJGTL49E5r6/MoGOVJHCIOlY727aXRaaUlW1rnOnmp//OOTHlTbyEi+PkBGQBuoTEu/Ch8SpA8dRE4ZH5OlIJaCsjRwIym9vxYq+llZqRKlwxLYWwVOb5HWer7IQzMYbA5tapSVBCYjBqku3xELSbCKoieQLzPbNfgyePmXFUQJc26PQNl2cqmQ6qQFNs+L2OHWmAgRc+KKbAf0EVdUF+J17WFowr1crbwuR/P2eegvFKfPfVx0jAQfCJO0LUtPimgLbQ8uWEEqXMK32gH1GX3hucrbN/cDUlTaJ0Zw+oXlR/xkHHR0kCkTofmRXVjyZo9uIY+4IY2Kmjm/Siw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:36.4054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f9262c-3238-46b8-a3fe-08df0dbfce8a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF730141699
X-Proofpoint-ORIG-GUID: t7OdWvQ-libYUJ_1xnGMceNksPIAJQ4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX0S8FX+mSHpsa
 81t6cyDwALi5vkEJudSsqjaA0K6Ficzh8XZ9z95Wpn37SLngylNaQEJCw5qGwZWfhmubTqHixMS
 7HTrvP2TpIWOKzdvbajSmtj6YpdkqJH8zHu36azfoboWbuPfcwGwLdTULHkJ4yEA15eOPm3sOVE
 tpSvLzCiJweyalq03MBGL/Y+WTOnYRkBaiheKPastAANGyijgbg4WhmmrAXV7QJcAw4CT2rzBEh
 858vowUTxozZw1Hq9n2dEQPibfYc7HkdJu8KUI4Svys1ZDjdcn2S8pSiAgo78Z/wXxom0Yr5NIn
 6iGWFL1vFtt6v+CHQJE48rPb64s2qdsXYdjiNJ39dlwCwLzpk7Nri7P43yTVVbQ57Mw+MYQ/+4R
 OMcOJmzMvMgGOQmhtciTiJpqwxfNaURQzOoViCqZ6f+UVzbknQ85ixcCGND0OdQrvVlm5W20E6b
 eu6vCXMvg07XnFX16lA==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa02cf4 cx=c_pps
 a=xqIz4pcv3YTcvFGvps39jg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=c0zHu0wbgw2R5NnQJfYA:9
X-Proofpoint-GUID: t7OdWvQ-libYUJ_1xnGMceNksPIAJQ4C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX6F5J/SA6MNxU
 VQrgMTzagR3iV6SY9i8qsHnln3oODcsqd4nmDxaoNUkoaKbsnVlMg5iIkzLXkZHHhubFZNtqArX
 xdBIy1VcqaypbPG6tO6Ft0m9j8u+KFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

Use device life-cycle managed runtime enable function to simplify probe
and exit paths. It will call pm_runtime_dont_use_autosuspend() for us.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 68b0a043f1e51..e03519d939755 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1376,13 +1376,13 @@ omap_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	init_completion(&omap->cmd_complete);
 
-	pm_runtime_enable(omap->dev);
+	devm_pm_runtime_enable(omap->dev);
 	pm_runtime_set_autosuspend_delay(omap->dev, OMAP_I2C_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(omap->dev);
 
 	r = pm_runtime_resume_and_get(omap->dev);
 	if (r < 0)
-		goto err_disable_pm;
+		return r;
 
 	/*
 	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
@@ -1496,9 +1496,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 err_put_pm:
 	pm_runtime_put_sync(omap->dev);
-err_disable_pm:
-	pm_runtime_dont_use_autosuspend(omap->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return r;
 }
@@ -1519,9 +1516,7 @@ static void omap_i2c_remove(struct platform_device *pdev)
 	else
 		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 }
 
 static int omap_i2c_runtime_suspend(struct device *dev)
-- 
2.39.2

