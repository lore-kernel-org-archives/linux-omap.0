Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBD44C659;
	Wed, 30 Sep 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807752; cv=fail; b=Bq1a9TuEqEI9CKXyziNMPlHLeq3/KdShcy29u7PRmJXsAQTxZ4tdrZk0lzgtZeGAwdg7bxg8hWI+dap680LZSE707K+PlCxZ4FWPuZXCJnW13XE6YlV/4CUs2hzJyrN5OiNnw3yselfwOZDQ4Nngn24K0//SviyNG0SN/726/K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807752; c=relaxed/simple;
	bh=AzWX7xomIQ2m8Ev96lIWb4f3FZCOt2Eo5u4sWFkjNy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBUtQTUCN4ITMRylcXCAIBzABo4OobafHacKUk5H6IXzcy/zCCjM1ALJ1zq26haIoOQa5g8AOnAHlsnp2m3kY/1j4EZ6d8moFxO192myIG4ihHjnRlPDS5E9yA1kxv5iBn/a8debxJ3YkCXj2jDdzDMAf6N3W+HMWAM3rpCpo/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UL/oy3AU; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=VXyLktlw; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UL/oy3AU";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="VXyLktlw"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKkQI0130209;
	Wed, 30 Sep 2026 17:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0J1EIKPTzTUITFhUbjGc31qEn3hVMgyKdIGfkPFLi
	RQ=; b=UL/oy3AUPhh7KC2dwHV7JT3JhmVZcFGJZgW8I0LacDPZGuFveijXB+RLZ
	qNaSEK6byKr8tR/KqqyjYTCQZ0n/bM0pndl/+JmToG3N4k7ORwRr3Lg6Y/pqQupY
	oXSG7h4VbRa24cFELIM9c2GlPd6Ic1lDQpyTfNl0a+bOAV0ABrP6PU8MTa5vlwKW
	r2/xHnGqq9yItnK7ky7sbvuS9Z9anwl24bOuTJlyA68LemEeFAP1ymP9zUYiV3SU
	kHwWdOiEGr7cxv8RLINcKVr6uI4+l8cSTj1yabpInV+vLu4aj+HgZj/lO1JRdTJi
	BXPaPdcebArF9HcJGrxycH2eVu/9g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0ydvcckv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igDgJA3oTNcrGSLmq7q30ZQbiKV2Mvn0ufvT46arMdgDI97XeKPz9mG9Yy0thPfqWycpRnd+QzXKU+0GR9K56Kt8aKBMfGww3G9Wuzlvip3JzH1tNp2XIEGOK4Wg20k1bhzDoR4ZpbLDO3aScOp29hVCSnGqPf5P7V4LrbLPXGMkC9ilA4dzzXeq9fSl0hJ7uj5FiI7MU6AwGgBM4An7e8zhr+8c4LDmRuqq1ZD6glvRHyWROFpXviVL/R/DuTgogu/Xjnk44TBD+oCTmBXm9ts2W0RM9t8HKurup0ydM/Jt80G1zYVV7M7YYpNVajcQYh6akYCgoeqC8M8/DZWkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J1EIKPTzTUITFhUbjGc31qEn3hVMgyKdIGfkPFLiRQ=;
 b=QVX92mHZJsmb+VSATqVpbnzfi25OSHIb9xgxT+Qpe0HR1mXpCnYfEWq4Kv6hEUNhRwSmv3DtX1WFq6qf51U1m0ni8ls7uxlfdtLkVhKO9f/qqEJKQV7myS9KBh2YHp35L7gzSWMdOK3n1mXpxBFxedLySpY5yrfN8oVcLikEZyHJgIj9wmQ5M9ggNHKXeflkVAuCkzlK+4J/UEJqHjjqdlMq3qSyX/zzinKvaN5agW5m3KpKQptyxqSYbr98yrSD9eJyyDnRr4TQEloXZN+tz0ojECgdE3hULCu+H/wvdoKSd4gb14l0zP0vCyg2MedFOirypnylKpx5l7Gd2AAu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J1EIKPTzTUITFhUbjGc31qEn3hVMgyKdIGfkPFLiRQ=;
 b=VXyLktlwLAaOHYHCcqHx+Bmw38Wz4Fddnmo4vCpeg7araoEFJi2UI5XkeD50xsjCD77Ymzn69XM7i6huT+PQ0g4cwwtOmKz1opg/PkzPIHuCo6nD+MVqzv2dVyslINe0QV2890KW7bz2ztN5Euk8O89OU3CSevK95r35j6Mwrdg=
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by PH8PR10MB997955.namprd10.prod.outlook.com (2603:10b6:510:3cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 22:35:36 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::23) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Wed,
 30 Sep 2026 22:35:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:35:34 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:05 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:35:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:35:04 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMZ3Ts3969567;
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
Subject: [uL RFC PATCH v3 2/8] i2c: omap: Remove unused is_rdr and is_xdr variables
Date: Wed, 30 Sep 2026 17:34:57 -0500
Message-ID: <20260930223503.616776-3-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|PH8PR10MB997955:EE_
X-MS-Office365-Filtering-Correlation-Id: 532bee65-3878-45e0-ca93-08df1f4324b1
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yfiB/ioknyaHL+AHJPAdrvOUquSy7zWMETWWy0fkgsvjKWvhTIAfFFQk9xoGvdEGkzIXL2XtScyaZmimyEaLKIKGz9DVRUDNSMInZbCV2RIGG9RSQGo4FrlAdXh2dllLF51vY3SI8Ym0m9v14/WIoag8P6KLDu81R7wqlTwOhKp/uLpUUXdgPnV9s+0V9feniTlhVFqlbJVt216eIzcgI2pcGCjHnkNUFXpxypfBVen9zFINKXlNhvVxg7P5XnEsNitDaATXhbS+Dt3r7P5lJXPPezv4v9Q+YDJuJsbjJZZiFxei9R6fb+WkdVDv6CKUe9ioo8I8MMZLdKseIvYzZ6vWq9nGXZMqmdAlfhsO8bgjflgS6JlaRoUnjvGN7hpst6bplaSKuxGyGtWUvaM+DJKQa6mghja76zkJRNFNueuEfI9gyh4zBaj/uM5FjtJV3JPj9BJLbZhudNOA+O8hF+LNkz4qIuCV6JZDO9R0SoxKlwsRbNi0gA3VTNefthgBMq8yj/3sXY7gVFz8Nx961DzC11IjNaLfrdabLcK1/afRQV8dTCARtJzrOoRKoZu2SK++whsPt6QsbRPR580kwOHDhBiKbc4WCrH6E84+rdDEdK+PHtN4e1ML9nH584gFk4LsXrpYt9jHn6oc6mJw0/8tIm7uw1NjWxxc+6pqfe3Z9wYUpcF7T09koROjYwu7SiJJoVieMc0nnOgitRzyNA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XMmc5jUgjtvih8xiIiR8jDmY736ypRnMFtlrCtO76tZxvI56zqP8ndiX/9lmmS+FfQF9MVpV0CWQHS37RMMbQQ4QkyJj3GxQqNcg3dW+PTkXjcAaleFbyBLX9OGoAm22d80XMXG1UBki27seiXlcU7CBX0SGyZD2iZtvXeawTLERECb1mAVvSHeZQsRhd1XuyvvGgXI+Gzox3gYkjr8ajxoJQK4y22mpSe46gUXGXioWZPPmw8YP4/Ju1GvqEDCb3Blrs8vVMP0zm13o+Ec2djTr9sGhnC9Nly0Uz0dICVlg7tmRK99jBlvPmYAOwaPkO6K7swwhfEbDyeRh6k1MI6IZpvGS/FdK93zRvpTwiGUgMTbsW4SFbOcJ1Nssr4Vkr70JddLDqFZCeMbkQWUVqGeMLotlddYnYR8xHoxPBCZiHFmZgttKBVxcyiV9vzNR
X-Exchange-RoutingPolicyChecked:
	bqLBFPKD5/ALdb7s24JclqyC8jMH6avULoUebrB2V37HvR0BxrP/yKCVnuq00Zuy7//iuPV9yr5UkYPfdNbJ0A3hg1bQRlHw7Rih/9bkZVBXGHmAggTnqCjpoPXxN1vjWh/riCX2U5k8L5hccHz4yparZeBJJq7KwgI0ffp/dax3X79IipSCbKMB7aVyAZmaSYQN7785k2xhMNjXVzLIKJKdvEJUo9/PuwAFIB5awc7rznQ3YsxaTwqvkFw1+OEc6h2pCJxQnA+ycFHkgt4j86KviiXxfQopXDzNzkKh9houk7aA17L+Hl/tfAFAVuvCHSaIopEkUWc7zuNKm+92/Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:35:34.7687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532bee65-3878-45e0-ca93-08df1f4324b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997955
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX9lkYq76b/Wya
 3vwOGFc5rq8iZUq6uduSQckHnOs3CsOKjiHcVDACJDQKkAgnKshBjuddn+IlGSOam/PfT2q+iHV
 dGnviQJbmhHskjygys33X3JpG5Iw1R0=
X-Proofpoint-GUID: SVXgm9KJRletY-BPA8ImTnKP8gITuRv0
X-Authority-Analysis: v=2.4 cv=TegDJhQh c=1 sm=1 tr=0 ts=6abd8ebb cx=c_pps
 a=1XVf1DeqYCuQPrRRBBNiYg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=50gAi1W1AAAA:8 a=eUdvuMK_en-A6lLaKTEA:9
 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-ORIG-GUID: SVXgm9KJRletY-BPA8ImTnKP8gITuRv0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfXyP3UITwQEdQG
 adVUIvO21M6vp+Ks+XRxDziJ6bQKhkOt+Qzpb2qIzZPQJ271EA4bWuNOsOKskk9nxtVE7NnCd56
 4/K+nv6+Q4w3xIKqDmL0UZeHEiaVrEfERDz1R/gqzRMAJkQJLMNdpl6VRU0faRiMVyEVIK3APV7
 YD93A5/VVaGFtFBEXnryisjt4cmlRe9ItGMu3owp3A+UN+nCqyd8Hoj8og6OxhkBPaiXWMzVHER
 5WhFZpalz+gbtGoEfZjkRmWBXAIkw0e7oL7SUKvjcHCf+zFOY2d8czrBoqisU4WHpeWCeAkrTeO
 uFErHH9t/rBlJY2huRATFQaI4XjM4+pyXUj3GABxUXIn5TK1ppryPcrJOEu7/dQUApUKsXLzjSv
 rX48irj2auAZj0G/ss0RmHTlYWuHO4G3yrpF48gBk0vveoLiz9HGTSldpPQbVN2IbnqlRrso1Xz
 amLOTYD5gNyZ5RZk7gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

These are passed into omap_i2c_{receive,transmit}_data() but are never
used, remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c443f88267d6e..eb20b789f3a1d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,8 +993,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1014,8 +1013,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1119,7 +1117,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1130,7 +1128,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1142,7 +1140,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1157,7 +1155,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.39.2

