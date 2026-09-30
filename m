Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABA46A601;
	Wed, 30 Sep 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807757; cv=fail; b=f2FwvNQ6YPz1zBre6RgwIm+RnSqLB7Tc5DKW5HYvt95G2VALs83d7xETNekF3Sn0dCuVRjOjY34fWW/TOF6yaZZVdb2Kwow8cP8ywwbTwij7++/T4IQpiB7AG+OIq0BbCzXXkJQ5lwlCqBbpzNZraaVhluKdfxPQxWczQiZGi6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807757; c=relaxed/simple;
	bh=cmM37ranKvijkwDKFtM5RmMmZBd72dI+n4OfELovaKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZOPPhzyJswHqlWX0CCAd/vbMVXyQIrBhrkLHfBpNspcf/iQOHmJ2YRZiJO5/FXCKBnBAM2fJBcNYkKm/opQq9CqnfFcdlfVYPkop9DaOYfgPZ5JF1fMn/R2IXrXQghSX+n+YW5W5YtAIT8mE3xANz1Bwgce48+ezJox3W7XKSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IiUWBwDt; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=cjpwTuIW; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IiUWBwDt";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="cjpwTuIW"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKk8123825543;
	Wed, 30 Sep 2026 17:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=C9joxT3+2gdy+D5ipdeIOR1SJ2Rid8LA0KKzjfMaW
	Lo=; b=IiUWBwDtcJWCssbrg5yXLA+J2HBFmDIb5ubeHAFEiHuBWKz/qypHx9saV
	GAJE8a7mMt1ZDbwVuRwiPAvxwXiBTRgdgZ2hGljnCjdlCgqZYGZMTOTq/FlnHTOD
	R0iZOFLWKAYh1i71tc72nkKTQeKNMd4j07f8i+Rt+5JxGelBGa+7isl9BWgp+SF/
	cbInsPhoCf7kOf90DTgkC5ugkdaTjTnYY9Vz1A4+xPWWF5q2e2VUYuee2RdhW9NU
	BWqn3qDse+d8vsgwkboL+qBLVhA67M/bWQoMj4nQ+yGSzcSncQuPAERalg0MbBPO
	eHnKMoA3M3Bz8okLzB43DwOk2glAA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djs9rb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=limQMCIl8OwMNO7Ov+WrCHILAXaAYM95v50fUcmA93DccOg+5Wg5FgU5lxxuKCVTTqPLkSeXmdHwGwvSB6FhEz6s7idVLAZty94JydxXRvSh/aBD8hqo1raTeDiU7NpwSg5FmS1y2hk34vLEGjiZW6FiMakfrkp1MB2gl4J0ADZWnCD+1CXt4w+1Ga0SFzyUUg7VtVYEos/RpidAiQogmS9jXuBwnk+EV0bG5hJFRhtaelewgbt2iw1GfN2rFaJdwjjXbALZtZuX473VaRJkUR8UeDyz/frnQv9rnpaK0nwnLHA0RgE99L0Nn+bjPwv7uV1UGVcRR/d54Hi46/p/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9joxT3+2gdy+D5ipdeIOR1SJ2Rid8LA0KKzjfMaWLo=;
 b=Eh0CVdCO7yM8EzW1G6RP/crxTrqyvvwTy/yf9/6K+XnjS4qWAeQESOGAY0WIhfV6nubCQvfh+iB4MCN3/Frln/thUXqLJgBC56VHf53DLSAlO/ImU1i2bur2AVoqf0C0WOPrhYZagU2M3ZzRzaH64shNtA9VdK6gsPri+FS+iN5JL4YirJqQsSNPpNj3KjfmoEr9PcNl2yR/XXOBFeP2AFAyn9oMZiuKIkC51lgOKcAkozxzKFZIhZJ0BtG28ckb3LrZjqXngI58qPbib4YTrGmSP47ApOoLH4+Gz5WGLDajqUMUai3J+ZbC0CAN1u1QlMzLqx38d2iOZ/PvX5C9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9joxT3+2gdy+D5ipdeIOR1SJ2Rid8LA0KKzjfMaWLo=;
 b=cjpwTuIWHdzXN2FKz4eeOcOP3xP7s3WsymuO+0CsU7InbSxkwIq1T1HpeHwHsqQv/duN8LKUS1RPufj/UYlSqt+tARVsWLok1uJukCSLfFvXL/HEubJvWiAgIHfnv94eFjbHnsW8Jz9P5/KSh491Now8dUUWmg6Zu6UV5VbsNZc=
Received: from CH2PR18CA0039.namprd18.prod.outlook.com (2603:10b6:610:55::19)
 by DM6PR10MB4154.namprd10.prod.outlook.com (2603:10b6:5:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 22:35:38 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::67) by CH2PR18CA0039.outlook.office365.com
 (2603:10b6:610:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:35:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:36 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:05 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:05 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tt3969567;
	Wed, 30 Sep 2026 17:35:04 -0500
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
Subject: [uL RFC PATCH v3 3/8] i2c: omap: Use devm_pm_runtime_enable() helper
Date: Wed, 30 Sep 2026 17:34:58 -0500
Message-ID: <20260930223503.616776-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260930223503.616776-1-afd@ti.com>
References: <20260930223503.616776-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|DM6PR10MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 071df8a1-a159-4e7c-7ad9-08df1f4325d5
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S5xFRwE1TvR/GJi1u+QG3OrE+MuivDL6VF36+b41Hyv6SuySwougKg00OqbcUrxrO9rZwG9iZlwjbO5cM8BUNxjZU8wSUhUSHrrf844idW/Z4t9Y/2jv02HonlpmEIh8yTUYqdrCQsNuWCQxVdgHwV17/Z/SxpG81UP5HlbXO9plliRpo6dRjvNwmJHLvwQ4vj/VFXAtANihgpGew9sC5F6hqGQPojXoayK9Clw/1jPsJeJ7fuishUFL8hVkrkrUdbZC4eEM0omk3CY1vSGQUACD9Xrt+BOmsKD6v+3NVwgrG+nLaV44y+rnI1Ur2SvRvP2VjsiGr+WafmYFl9ByZ+0iLYFtR7H/KCiJ58evWSoHZhnGbUlIbOZ7PpKqjXcj4e3FkV2AexpnvxAYXOMir0nwNvcQqczwx0PLySE85wmziMIOboG3b437T9G1R+3FLjMWxjNFUFKD9/49QmSQU3TQb0PauMMVBKtEXisSKCAz+2eSl8XvlqYETJXLn6Why6vaOexwfICZ4tHQQXjyMfK8BlgUVRjg4McgzEEz5wKh9HkvLsUbIkz+KEOPUU8cSwcKkXtrgt22IUUyjlnjqHcucbK8apZRD2jFb1ZrhIhxcXACxNx8460yojzKYAxZrUKkSoDDXcXh0GlAIUNoLmxdX3FZDHKk0g2MSvbgm4jrVfIdIFgumN/H60qXv3CXFgg0fCYYALEkNDQ8dKatPA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7XDmNntC0zFyvzIPTxBQEv1nlaN8CtjaqR5v7J36e06LZwpEAee60zhQf5At83xO7QWwUQEYmhVfEYnYOyGfYbE9TcSNfeesL6zs0X8+5sSS+5DnH/UCK2WKa/CrkFKQ/SDtsoi/hvCAbveMbvYaf0NsgaSn3S+DKHam7REh2YsfVAAAWIdcSCkyG/jfrgOk6Wp8nc66nwAy6br6xFRvWNRB70qNw22jknsWz2uArjWcDLeb55HM5Yuy3RAmalIXoK3Uv0cb0nl+UB4tTNm3vY5dlgLOSbFGgDvS2DZq1kw1tazwNQOECa7enAGbvg+UI505YSo+Ydqb6diu6akUmD+QaZr9nE6E+88e+Gi7aW8R1Rme0yPWWNEjGxh8jcqGZjHZJZpZggGOeXbJ7VWXOkRKYFyvX7HRm6F29/VWH/QplYh4oOk9qJvDilZAs98F
X-Exchange-RoutingPolicyChecked:
	m6h98bGRS+/vj/kzo6HrjICZK0YalQBxIDjnJ8pwdh/2eNcxqyg9novoTEvFvsfY0EygzmNL2aB/Eys8BH22TV0DDEBJDDze3voGhCIY4EMbSRumEoGrkzI8Fb2Ra22enzgolcFURmjlUqDQzrJoZCpoFSe0WSi4/xTjniMS5DZv2vun06dmQ57n5eUBSx0seHMhUgvizoOWSPgnUXww0Rt6kJeplzgDnnTsDcRwZpkuF8EeHTFXIqXm7PsKirAMlRVijFR7bdEJ/jTYyYCT8tvrzGT8qo03rww1OhcFUlqqilHkpeZ/si5Desa/77J9pRCyGoCqxMaUArwv4aG2Ow==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:36.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071df8a1-a159-4e7c-7ad9-08df1f4325d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4154
X-Proofpoint-GUID: vObGuWvhQnp1VWfUyAYSpMx9TAE5CE-D
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abd8ebe cx=c_pps
 a=+gGuMjfID3j0L7k8h/8w9A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=c0zHu0wbgw2R5NnQJfYA:9
X-Proofpoint-ORIG-GUID: vObGuWvhQnp1VWfUyAYSpMx9TAE5CE-D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX9LoXjWjUGgHi
 e7pd2n2PTSFJktlCqLDOo/0HrC1W9nMcmt3Lfm95Z2gtg9WR09bS9+M5pm7Ox7+dnZ0riXcZmRD
 67/cCUoz7CVOa5esVa4OQpAuRNDq0Vk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX0BSDC5UxFn5A
 N3SClEEo1felhk8r3tXk+nwcuivN1AXB2tv8AKbffMKg9MKxxt4dL49Gshhlq90kLGL/kbb1T9g
 DOFLk+F6wolpscqsy/VVh72b3K6O1M+LbrgdRghYrXdZqEm6f0/sz2Y/idk1KftPCkZpHUQrFDj
 DUaHZnjrLx4pSoOtMvW3R0l1BQHXqzwddBLrgf4nNAm3lM+jo8VOkmXKthRsvmY396dK1pbnXFX
 PWU78r1DB2tR36lxufjD3WwR96kF0uNwkXk+UdnJVe7aMshkm9u4pXDf4gM58gcaaVACGsjj9KK
 rvswMtJqYl4yU1aauRD4/anGJJ9uMv7MkqydWxlPAOVMq71tXV8AJPRjFjVlrnDZkc1F0me7vwV
 8WdUw6uq4qikAMdCU/Y+dCfnKLICD8cqqcFtsd1YuQhNDljqA7jzp+w80dG0y6wmDBLEdXf5Ucv
 deVLQuy7MVQ2Z2D8BfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

Use device life-cycle managed runtime enable function to simplify probe
and exit paths. It will call pm_runtime_dont_use_autosuspend() for us.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index eb20b789f3a1d..b551fd8e2dbf6 100644
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

