Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5D44C659;
	Wed, 30 Sep 2026 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807762; cv=fail; b=E1UKV+aPnJKJaA0BFFAMSWCWvryn1XggD4O1K5S0WraZobfVtR3eJREU0Azzmne1flI58xoCLmXdo+JahxrG3iNlGipdW+80F9ZcF+KAmlhLGdnr4ghntxTavvMW2AE3F/a9wAzK1nt3ub3y69fK5PXdG7zveyCNNybgjsyZnQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807762; c=relaxed/simple;
	bh=QAjHG96N2iSoUlJdSsRc17aP8gRGUGGNexDZLXyBRuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p42rY7XF8lbCDxQB8GPxcV0gUtG2oIiu/2hreS985rnhS22f4vWlij4yL0/0wm8VobvymyLspowR77v7wDaxg1I31B0P2ORmldY1kO5EoEJ+hS4lgkrvmg9KPS2LC9tR3EfnNHJTMYS4IS9onccSvZseicpOc1RG9NOd2Lnhju8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VdQYn+dS; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=B0l4nDXj; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VdQYn+dS";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="B0l4nDXj"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKkQI2130209;
	Wed, 30 Sep 2026 17:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=l6FCcrFKgNn95S/5BSLSOMZ+mw8Z4BClH/ISIBth4
	NQ=; b=VdQYn+dSJRz78CyZ6PwbrhE5x04muRDAToW5nqWIr02uYzBh/ovwj4U4Z
	1n5EF8AtD5FP29APZUnysPsL+3QIrdHgo3XjMqYFbOCm23o8P/QR51gpjMvvrz3U
	/SqSHLuwIj2MKHt8uRlGXXlcNv33Q1jD8ZKWD44Wr/fNA5sc6Zoqrl3+Lj9bwTPq
	GJ/Slc+IE2eUrd+fShxjLr9yRISlSLfxsZFq2FXYGSDfT3a4nOD3jfcbPq1GAM7O
	z7pmh0Zfphn2JPHZzZ8KmvDRLT5Pv4UKhx3/rMwLr0TiFDxVIzDmLWfroLX1JpH0
	OtK+6aKhZGCfRlsH1ODA6anbE2xfA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0ydvccmw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7nMRx5OJZNgeeCEnB9yOY/1OJvnUO3OnfZShIfvj7d9ANtdUlb6NmadC+N3rWbboOrgBXSZCPmfVzthzjbpDbcCaIi+KYp8Wy/9Lo3/x2cdZwKeGfJtercIawe3luXHofYY6B7bWAN/6OqvMvzc1gbZWrTdNtYbVM+o9m3jy/IwXDKm+6hqw5XrCPqtpSW2gBBVamjdMtRGVzows7PB+X9BXYDlt9CUXsK4N7dLxm0+Oc7Ljh0zQcoZrQjXleRxXjF3f72FxVHbSZAlgDsGCcLSGEdaEjl3asd0QaLKS2RWDEKUVcET7/YT5+UwYhrLDQaOd8y2sdRaIxxAIaDYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6FCcrFKgNn95S/5BSLSOMZ+mw8Z4BClH/ISIBth4NQ=;
 b=au0yPcIcJCZfcgPrMfesT0QUkBMrPDuumbxLeTVi1u9dd2gj+zeeKoRELOA8+V6F2eI9fz4mppPOzu+nCgtvaDoH//dG8XY5kojeOeKMfAym0yMXVopHYzA+/ldFeO6sXzgPfYVXWgU3Xd13/YohFNjeegi04nctX2+PZfBmxOs/qp3r2fJnlTwskuiMz6V2lM5VNTqCvF5vJq2y5WWEW7yb003vT4Jz6D1nq+vbXG5jVwra7jB1hMUjox58HzM/EVBz+zXd/mTm8KBuXlKgxVYiMhwzuaWpnpZdSsDANqlGS0eIs3oioLz/RORMjgeCvHp0yNsRd8tq5SrR1wnDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6FCcrFKgNn95S/5BSLSOMZ+mw8Z4BClH/ISIBth4NQ=;
 b=B0l4nDXj7AAEVxYCbqzLU6Hexafreq0NxoMmpjqoqv5wPlN5vdKnhm/h54j5WgtEqIhVAPi1BAVDy5/TNEBq+j3OKkNlodqDK3itkKEnko9UzLSdU/EfG6N38sYWuLOVfwguOIEiTn1riRTAPE+OD85WyJSxzr3d45che6Ia11E=
Received: from BN9PR03CA0234.namprd03.prod.outlook.com (2603:10b6:408:f8::29)
 by PH8PR10MB998090.namprd10.prod.outlook.com (2603:10b6:510:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 22:35:49 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::60) by BN9PR03CA0234.outlook.office365.com
 (2603:10b6:408:f8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Wed,
 30 Sep 2026 22:35:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:47 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:05 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:05 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Tu3969567;
	Wed, 30 Sep 2026 17:35:05 -0500
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
Subject: [uL RFC PATCH v3 4/8] i2c: omap: Combine event flags register definitions
Date: Wed, 30 Sep 2026 17:34:59 -0500
Message-ID: <20260930223503.616776-5-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|PH8PR10MB998090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3eb099-55cb-48a5-4d52-08df1f432c35
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6x1MUBP2V68qjjqh6tVIYLZojixTlj4njYU4CGge38aOKdlDJRVHqe1DBlrQTurgT6x/pVUvahSZh8DUqo/+RGoQUKyw/xaNq5QWYq/S7KRyArEztOHhek+F0DOak+vFblS11GYJISVkGvsg0Zrwh2kC73Lh/VYveaoMbelTrMugpt2Y2LEqTZlwOlEvJLadK8J+96eQlu+qF4obRZOm19JcOttHgCI0ygCMSo2dYr01qXDEHg+DKI7IIGEHHQnqGrUNeMXMWYOXIdPZhUp33bikZfXH9kBj1J911P8hhbheJy/v7g5y9z+hYgUNQuq6DYDdbzKrMZAmk3ExHyyKNfCevB3qTiTITW3VoJTpITqgv7GXUNmHlsB7xMBUpeSdl6SZ2ytaZrc9PQ5LMZEpGOcmsRDXGUJBn/T1vu5NFsezexHVKQ9zbpDY+4fJ3xoMwfcnIkTTgkPJHsmFmnXEIi5ZxwjWVZKPcBz+Gc1QYvq1/oX8sB6sjhuU3hRucxJvlypuFreu16uI967yxiqmR6mSvV8bZAiURmxMevPiCGNQ53IIKrdsZVkwEsxlQkOZAfPIg1iJsv6VwyyG7e/OLJ7CGOflbgoqfRNivq5jZUrjX5R5csn9dYIYMW+NKsIChHxAUBYLxgyC8LywhTwq7V233Ao3XAkPgFk/QomuZXlOabVPpHq5uFpwTeOEvTyJwJM6Hpob75yenyHOZCsBXw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+dvY0z/At7/KYg0gjuCgbq06vKph2s55qk/cDJUGtMryAa3ZKMVZvG7FQ/H1ZFBi0BGenETzA6rcyu5EUSOLXA8/Tv6Mq4B9QDpjM9MEfdMk4NcVOrjHaIGxEn+vwHfkViN7Snz0zIQvs3pi0TwEWUosc5zV5gOLAPGKsl/CMiUkmzz4SLPZpSa8Mhim/LrQZyeuoJxyRPeF91Re/V2SP5P5BVcWgAXNr5cyOW9tkAKB9ji1Oc87WNCubfJYf6mbXyBOPaWVtTFfe9tjoB+NvV3+sN+/miDEQMyjm5+fP0Fb2cFxG2EJcc2OdlOzDledZXOmmFP9h+2RikmKWjBGbTjd0xcP/ewdVoiy3idTI0hhYj20LgBywx9trWS9jmoSi/H3a8bmGmweHgz6WnCn0wJY0dGhRh5fANtl00QrSSmQ/JXPPYUYaxq+S6Sh+mEB
X-Exchange-RoutingPolicyChecked:
	oo2ctMs8ZhsaTYqWkquLLxMdm9lDsMV1rR+web99lAspjsEeji3fzlFChq+zXq4WF+mukS85sTHL2DziSKTvpqwxDrFNEGj3goZQH/736VCP5X7Cf1IrS229rUBTpHRkTFji9KOBuVWqfjAE0jgwjQGqlhdCOppN1NVGx7q+HJc5yk05+I3xLtX9TpB6N/clxftPsBgjHKYudUns8oyZl/mUUkhGBgS7TJFsV9OEWqG9TtXPl44474dz1kVYeSAMjJDUJTEf1hJ+vcAiRYn2PAEP9lmCMd8yVP/+9+Gu2/64SP7VFGFxcEzNRY+bxESkhLeifcxmgxh6xCS9VKYMSQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:47.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3eb099-55cb-48a5-4d52-08df1f432c35
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB998090
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX+3NsYJk8zdpW
 Q4gE+S63Dba2yu9uKZ1hbApeoNaQWy6ITfINu444IsmOzLcJdc3rt4MereIWCkFCzk3r9lMStXG
 qTtgPqixkqxwBALO42j9/85ZYkiuoTs=
X-Proofpoint-GUID: ELOxnILqXgR26wRnfWeG1DfU2q4Ahmgk
X-Authority-Analysis: v=2.4 cv=TegDJhQh c=1 sm=1 tr=0 ts=6abd8ec8 cx=c_pps
 a=rpDl8c4QES63uqz6MGSAyg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=-VTgE4bae0sfXoRtrj0A:9
X-Proofpoint-ORIG-GUID: ELOxnILqXgR26wRnfWeG1DfU2q4Ahmgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX9StG5OKycUtH
 5LUwGLo4S2gD78xRJJr8oTigCHlFYbO2qLLm3d3cdbYdQAwWhlrPQwnjLtVLvkZdfQhn4YE0VH9
 lzpUbiJLBA7J62qX8FqY1MLSXPHWin6QtRBdtoTtpX2z0PxyNhuepXjqQOlHejdNzrtbqFFXYQk
 bNgxzzLbCFp4jci3Jnw3yBoVAdIWzD2CIk0T7JUFe4rsG6TKPCI91o0krY/cEpaGv3/YltQ6NsT
 JqfV5Y7IqgbC/612ovVRpkMbFev+3HAvYsnlvXjbvR7qHrc9cFUbBfw+d9zLYrHeWg6OwrCtf5w
 hyvvFISR9rUsz97idHuiLYlQWox/M6qy/l88BDHdrvUXwNffS0s9a15DnAaCzoRY4rKtq+uX8CI
 l4pV8qieSH2HD+geFmm95m6i8EATJTPs4v4AZaceDNJlYEkM4eTCG1qgtc+sYXeCh8LpWDvmpwK
 aOGy2vieBNf8PjcoyeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

The position of the status, interrupt enable, and wakeup enable bits for
each event are the same in each of their respective registers. We only
need one set of offset definitions that can be shared.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 58 ++++++++++++++---------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b551fd8e2dbf6..61e0dce168067 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -78,16 +78,7 @@ enum {
 	OMAP_I2C_IP_V2_IRQENABLE_CLR,
 };
 
-/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
-#define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
-#define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
-#define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
-#define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
-#define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
-#define OMAP_I2C_IE_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_IE_AL		(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C Status Register (OMAP_I2C_STAT): */
+/* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
 #define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
 #define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
 #define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
@@ -95,29 +86,13 @@ enum {
 #define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
 #define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
 #define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
 #define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
 #define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
 #define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
-#define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
-#define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
-#define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
-#define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
-#define OMAP_I2C_WE_GC_WE	(1 << 5)	/* General call wakeup */
-#define OMAP_I2C_WE_DRDY_WE	(1 << 3)	/* TX/RX data ready wakeup */
-#define OMAP_I2C_WE_ARDY_WE	(1 << 2)	/* Reg access ready wakeup */
-#define OMAP_I2C_WE_NACK_WE	(1 << 1)	/* No acknowledgment wakeup */
-#define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
-
-#define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
-				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
-				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
-				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
-				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
+#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
+#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
@@ -360,7 +335,16 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		 * WFI instruction.
 		 * REVISIT: Some wkup sources might not be needed.
 		 */
-		omap->westate = OMAP_I2C_WE_ALL;
+		omap->westate = (OMAP_I2C_STAT_XDR |
+				 OMAP_I2C_STAT_RDR |
+				 OMAP_I2C_STAT_AAS |
+				 OMAP_I2C_STAT_BF |
+				 OMAP_I2C_STAT_STC |
+				 OMAP_I2C_STAT_GC |
+				 OMAP_I2C_STAT_RRDY |
+				 OMAP_I2C_STAT_ARDY |
+				 OMAP_I2C_STAT_NACK |
+				 OMAP_I2C_STAT_AL);
 	}
 
 	if (omap->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
@@ -459,10 +443,14 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 		sclh = fclk_rate / (omap->speed * 2) - 7 + psc;
 	}
 
-	omap->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((omap->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+	omap->iestate = (OMAP_I2C_STAT_XRDY |
+			 OMAP_I2C_STAT_RRDY |
+			 OMAP_I2C_STAT_ARDY |
+			 OMAP_I2C_STAT_NACK |
+			 OMAP_I2C_STAT_AL);
+
+	if (omap->fifo_size)
+		omap->iestate |= (OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_XDR);
 
 	omap->pscstate = psc;
 	omap->scllstate = scll;
-- 
2.39.2

