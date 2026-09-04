Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B5314A90;
	Fri,  4 Sep 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527634; cv=fail; b=kJJ/i3+VOI6I4HTf7WR7TZDkCGqPTCHIRdcS/Cayv/kSyFUmsi8cxxCqGbeelt50IRS9Ic7X+dzHWVYQhA7Q0kdQYA2LhbO2Hn41gzxvR6UzZea+0583piMZrxT2KeQ6kp8QQbxrHW+iMDBnLfRpbHaBgx2+0sEA0TX60jfFWgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527634; c=relaxed/simple;
	bh=yeKHCBS0TqqoB2XJ3DGvhcLXRusAzwKaCCmLij40ihY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dYrj5jFEzobKACCcaY48dzUYF1OPCnAnEdfjzaAsW9+quEouyWLvOl4yFUTRbD0irTmvIKMtGFdeaw+cvMog0TOJaB1YVXEzChcoqGTk4gOyGyOMnDnnCCTGTHmh+Zic9ZFT7HpkHJk/U22BOseLwn/ObxBLjEGcmBS8klkyq9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pBz+dxef; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lfHDR9t+; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pBz+dxef";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lfHDR9t+"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHCDI3456746;
	Fri, 4 Sep 2026 08:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=JNGj2IhS3vC4Y
	j6ufoE24lZXeR7F8veWt+xPCEcyqXo=; b=pBz+dxefI3uuxxjczg4kRDqmzS3V/
	bEOW8aWZCGjXKlDC5WSffdAAN/q9RndtE6XKl/LpwMpdXGd2/HU3C20NEIyMMF8+
	DW8yaFxWkYjyd2/LNFB2ytVw54dDLsfE+k9de8TFdXJdntqExWdDZzWRK2ssBpvK
	YNREg+2RE3qyP1J6Is9lUR33PTJu+L0HMkvf4wInWatmJPiEl3raaMkUyejzMhw4
	ehL8mI8zTfirbSkfGRBpe3UwoIHq8ROp+yDlONGdNF7qPMuFoolaWGKJiu28ubaJ
	wMI3ptBWpJjbgiOi7X08ycmzQXwUc8VQ9J0Ao1Ew9Xy2YZ8ZRswL12/5A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xv3gd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7pG0zMz/+znZ0c6/lia4H0M2LnKXShtBFaUeL8ga2h+bD90VssmFCITirqA5YPx9Jzi8jxpy8Ri4jU4DdVD3TTvRmUqI7LrFkdlNS02TQiUPsgHdCeic9P35HpaQ6fJvF5SS367i2XvmX8G/IUqgYONlBncRiKZok7chNeqeYP75LnXYAlc4jL3XXLt8fJP9lqWYSr3+CJdoXfqcWLoknOgcISxV59z3gVg7+B8El0TsMb8cW7Ms0soqqkE0h/grYEx+8kfSFHlCHdEIrYpzC9TKoBFjyHQnQCLXSuRSpbKdNfiWZQKOr0EvUE6uYRPG7PKoeMUiF2AinQ1y7enPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNGj2IhS3vC4Yj6ufoE24lZXeR7F8veWt+xPCEcyqXo=;
 b=R1v0rxHtZYnXH0OkjPjFmzfhRnF3XPlfW2aIrXXK4fD5StEPkqVgBPTAB0t6bkhGG7zH34H660OTlFN8h+D7uZWfeCj7hKMwu1zWLECIqx5QRQ4vKtTxOH8m/2Sa45a2VKqoZuwThQBQvbwK2CrF1u8sremukr82iz4UBGgDAITeLZVXr+Mq2hKap+4b5e8HYzzaDADYZJXQr1MXbALHzLWXOZS9/wefVKCy+ps6zhkWOOGF9xwsUAk//3IEEq+yVBw8UzNll3x+ifGyTerJNgi8DPuF6kauQKFasHF0tlYhsfqSQUsVtxEqW5wuiuBefp2BFT4J499JvyQocKV55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNGj2IhS3vC4Yj6ufoE24lZXeR7F8veWt+xPCEcyqXo=;
 b=lfHDR9t+bVOq4Y/fLiSi+jl1sBdTSLJjlD889drj12uaOUgK2C+uM/Kv8lCrW5Pt6gedLwfCX4s4NR4bTVUQG4gwLiiWCEvYbQMRLpl0Jgx5UTGWugWUG1jaM8Q0xVVCEt5NthScl6XqdSQsIVw1H3f9M2FehxJpkK9bzySXd48=
Received: from BN9PR03CA0516.namprd03.prod.outlook.com (2603:10b6:408:131::11)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 13:13:41 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::8) by BN9PR03CA0516.outlook.office365.com
 (2603:10b6:408:131::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 13:13:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 13:13:38 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:53 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:53 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq51371029;
	Fri, 4 Sep 2026 08:12:52 -0500
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
Subject: [PATCH 0/8] OMAP I2C driver cleanups
Date: Fri, 4 Sep 2026 08:12:44 -0500
Message-ID: <20260904131252.2126353-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 19971467-f3e6-4a10-6517-08df0a8655c4
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1QAJ1HGkY5+aZtiEkUjVq8YOAJ5J7sl0wbaq2tMlX3nAXHERdNl8zP806imVHiDaYJRfVzx64S+GGkc+Q5P06B4T6Vbal+kglaSCvv9sqAU91rU6e82W9a3V0RudUh0QTmBQywr04+c3Ja2rSQl1Gv5gsjTAEGmjjMQguUfRxDNRKiq0Ud3BPReU9+R6+I0KJgp/P3ImVY3kOQ61bvimF4nkWF16cuYSYH5yEKP71d4pBbx+4gksHWbAmVGcFZdakqDyc10yiz06VgEmRHuxLAd9YK0cOI4llw/v2OcV6VfqiXUtBqq+U5gFU7XaYIl9QNL/SoVmepQH9AeYQtkEV6hwBygS2Vpj1tC7ioD/rijykgcedZT1fbp32YchgncWAh5bSN+BM+FAUQI9gHC3AmRndrEf2c71YH/CwN6ksa4Degpbn+XYv+J6aELNdSiVdBaHXB/RUEho+y90WbET9pWUXZ6mUYGqxJ9pdV/QdltsqaVgFONRaJwmlMIGtgSWTT9ifWRm3EQZLOf1o1VRo6o2hpMA6uZ68FRxg3wiA1Ynn+khY2LPnajlH9+xW7F8TzoFEKdUfLDwh4Ljs4VFWf6w20Y48+1D1NjwpNDI6U5TfmwK2jJ3GiihlHomu+ySFKLPu3ryxY5dcCIOBzyMwWsLZSMNGy/zJ4G+G8u/thnpO48E5GDV0TBs96lgufKDyRosuEljJWC8cBC8/ENuZw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L7FcqtzEFSsoQ7zTHqTiN61Iynvz217DnRS0YXqTQZ6zq/PzlIqO5tyx/9XsZycMpo6zcbQg8ufRcp8MDwuHULolR9tjXUnnuGFZQLujyMr21qxrKUemidL0FKG4ubD5iHFAopzTvHPcP37pxYGsmmaazQx/bF1FP/t+JNuXYdiT3JxlP/uA0m8OdCzY0vnK0v9MORTGXJW97VNbP1v/PXINn0PVkZ00Hq1+kqGZxQY0gabAZeb+lHcDzjJ4X067q6dQizKzaHwHqgqwE/XonXRQ56v4YrYxOj6bS29DrrgMbkw3+51cEvrtzmM3k5HWsjhZZPL+FtzJhTSQ6kjtd/Hd9HHqMN2GLZb9Ax+d9heCtuPiXfmdvkG9KMx8H2jDtPcno/g8AlnSHoGXhVR2O1UnmBJyfTOka0U8036MSwfe4EUSq9fbV6D+ry25xihN
X-Exchange-RoutingPolicyChecked:
	PYXH9wT9VEdGgIcn3eSmGs3c1+4Lwpk6DYLyyyGVzAcspbP31D5E6DxVOqPZy+lV7a1syBILi8aLNJefsIcICHlFgLgsptENx6YlD0ZHBogGjeseiVcbPTgH3Srz9coE42wGJv6U7q1ddVdcNIwpVkdXiEqD3DuCgYzyoVHjGN1iAJ4H3V2LcurKjYvT2rVuZQQ93empMmXGWwlYxq/axO5BmZge34KKlbHQKstS1f9/dDrbkYXbEDReTedzqClYxm61AtS9uBc9rq7VTBJ9NaJhaEUGrPpmt2Q3r7oy/bmxHUDKAOIRQVMEVoR4JsUFi1HLYgfUxtIb/NrG6RJ1kw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:38.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19971467-f3e6-4a10-6517-08df0a8655c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX3O8as0W/PrT4
 Q5ZI6ftERWy5AGLk5dc90X8t4zjWrd694XXHqDmhEdGciq2ez0wERY+enown9Uxr8fq4Lquub/T
 ssUcdcGJd1McXPPTuCqtKO2fGN+wfcw=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ac408 cx=c_pps
 a=ixsBY7txtd2I+GiPRIsFOw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=l6gr9uAX0ymH-lfYNPsA:9
X-Proofpoint-GUID: Pyemfi8xyvGyYz2QzHQ-Vv7qZ3N-nuL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfXxKjF/OYIc4eO
 VI/bYKcfUki4a9c3kt1mW6spVobw/z8fp6ARO3DPsvC1Vf7LcYcnvkAfaDy3px2RcqWl/mnkm0w
 ijvbNP990rjh9Yx52cpKKS/PhWrgFtEBlDJ9S/b1mRufe9aKTOqs65374vqpwIEcQ17JT03zEQ6
 tYxxH8F6L7ectVHzxGjFYd3I+7TmjOQv2HNXCJJFualf3+xCUFHpqdOW8kgf43lyJ6pfP+2ej/c
 Iw/kfIT/H4edAt1t2RHnTONV70zg4md25z860ssM0PFdJ8rT+hMer+ZvU4BaHw3sHlAb69rC7TI
 WBYSnqe1L1kwWcuqW4KTo/MLZNYpTopNmTbLX3Y2RUaZD/3iCwQZtYa/Kb/EX/XG8+GMh9iA6HQ
 WvzYfdy42tyIhwZU8jy+E7gVHXKN24JfPswRtgL18DK89YV8pTqec0eHCwDHme8FC4efKgk4FTw
 BtGROEc5JK9pfKMLM/g==
X-Proofpoint-ORIG-GUID: Pyemfi8xyvGyYz2QzHQ-Vv7qZ3N-nuL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040119

Hello all,

Some hopefully simple cleanups and updates found while using this driver
as reference when porting the same over to Zephyr. No functional changes.

Thanks,
Andrew

Andrew Davis (8):
  i2c: omap: Drop bit shift for I2C register addresses
  i2c: omap: Remove unused is_rdr and is_xdr variables
  i2c: omap: Use devm_pm_runtime_enable() helper
  i2c: omap: Combine event flags register definitions
  i2c: omap: Use bool for flag values
  i2c: omap: Make reset bit name match register name
  i2c: omap: Switch to using BIT and GENMASK
  i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions

 arch/arm/mach-omap1/i2c.c              |   4 -
 drivers/i2c/busses/i2c-omap.c          | 254 +++++++++++--------------
 include/linux/platform_data/i2c-omap.h |   5 -
 3 files changed, 112 insertions(+), 151 deletions(-)

-- 
2.39.2

