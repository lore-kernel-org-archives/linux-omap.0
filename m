Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7A212542;
	Sat,  5 Sep 2026 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788586866; cv=fail; b=GLmPfKlDUzZ0ZmgiAzI5gglsFqWXcm71VxwW9MkqKaaOt46W6dcH1ssbIjt8I/6Uk47BsvOpWTdisjoc/PwZ254AzjEbK7QSMiDRVYcWVOQ6z0xvdKQENZNMaNqZPasRYNpXq10uLJtNUAvUhhuluuTITFGZ+hAeF/e5dmo710U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788586866; c=relaxed/simple;
	bh=isES8ZCsS9qbnYGbpmZZd3rCRkkyLEhvt55uOhbRy1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QVn/JMHw2nG4HpkAoIst5sXsC9EVsVwTZa1ZVIjqsSXPmuU1Uc3IETbAWH8SXjYyOUqFqH4InzcTLW+pufvrIjBJGchspHGrQ0uBO6T4RVQacJ/7sdZMmA8h1koLEUO1R0HnifzE++cKQRoFg7u4ZEGitls9pW2eoRzmmJmF3L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aNKZdWBy; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qt6kf35N; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aNKZdWBy";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qt6kf35N"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6854o8eR3977122;
	Sat, 5 Sep 2026 00:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=yEKUGkt2hgAlj9omPZffjiwekH6H6bbMkmnHhOUUL
	zg=; b=aNKZdWByASg6SWDKyipDX2wjZeZBsqFjOaEq5j7XCQv2Qmccx5L3XJpR2
	0JlR3ZTOzhVubifmtlbDKWJ3tY47arJAEuMNWjy7r4dQgtznVqXAFu8QMCQG3plS
	nA7i+8LjhJHpyEV4yEaycTXtN5tZOEap41fOOfUh8OUXCdYbimWUo/mlOa5k6+8F
	u5YIO58uQCtwsZ+e0fFbNnG87yag9CViN6XRmUL3SSkAyAwEDCjDcyuKG238WCBh
	JeMYZLnQ54yw0E0ZxEyqkuuhyayn7DBhLXTzcwFRLO1c8DJo1Hmt6bfQxmhUXpcU
	Rj/DQ5yMgtH6SMTJ7azx2qpcNtLKw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gfyx7vke4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 05 Sep 2026 00:41:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjZIavOEsFjGf4hWls/2r+S6Z8FVorV/xU6N49nXouTb2GEk/BGN9Pw1rZAdKCS/vmLxltdXUXmdOrD1UYxeS08j46/GMYeLmLBGD6/x/h/SC3FjtUsqyjuj0BuXOXwRA8N9EqHHClTd0NY3Cs8sRoBhz9uc/f0EThB9dyNTOz92+pttTcyIRMnS/m9E564APVQGbm+QW4b14iUwerDBJ3bg6xRjFp5B027mhnoiGNQ4fFc8Dlzsb+QVCNtgAwGa6dL2vzHseA1vLUwf73AAfUnwopw7PKtbnGYAYdatXCrl6EQsm8o2XHla9optjhL59MUrIAeW5D+PBj7Xzc7tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEKUGkt2hgAlj9omPZffjiwekH6H6bbMkmnHhOUULzg=;
 b=kz6Wkna/c5cxnwzLsp6bMclN/9wqS32JHrQIK4ZL6yW9Ajg8zcSnWpirnaU3JoB2PxRG+p8Kyu0gTFdqlTQztryJ1NlDSIYo0mKubxpiAmowW/7nVVEkx0OVqAiUoRqzwFaFBhrG4kc//dKy8xIQoIMU9kBd5JAe7BKJEoGwwDekoBk1A8Xpa/38RCNVkGG5eKTBTsttfAT14kx0mnGLzwIyens8Mit/KK3X62v83EgOuAPa8fiD7NIpNJr/smvHjOF+nzomxXmIN/fK+qY/DCRMNYXeHOsdrj6gCVbuHBm96TrvoOqwSswBFcorU66X7rIuBHbD1hSqKLdCZGlTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEKUGkt2hgAlj9omPZffjiwekH6H6bbMkmnHhOUULzg=;
 b=Qt6kf35NunzjL4N1dFmKWJHojcyWI7bFS551IpkvmLPHves5YSfIwyorZMpTzKf2qRMWC4Ca6AVLCr/V3kcUOLH4l+fHaZNXotnQRavZHiJM1nh9lxxl6Murz3UqWuXbfaea1jyhypNdxKj71BmFsfuX2I8DF3NS3PZZlTvhDLU=
Received: from BN9PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:fb::33)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 05:40:57 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::5a) by BN9PR03CA0058.outlook.office365.com
 (2603:10b6:408:fb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 05:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 05:40:55 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 5 Sep
 2026 00:40:12 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 5 Sep
 2026 00:40:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 5 Sep 2026 00:40:12 -0500
Received: from [10.249.136.91] ([10.249.136.91])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6855dtTK1628523;
	Sat, 5 Sep 2026 00:39:56 -0500
Message-ID: <cc1f9d12-e853-4000-8236-9e7f5a9ed314@ti.com>
Date: Sat, 5 Sep 2026 11:09:54 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/33] Remove comma after sentinel entries in
 match table
To: Jakub Kicinski <kuba@kernel.org>
CC: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
        <mailhol@kernel.org>, <msp@baylibre.com>,
        <florian.fainelli@broadcom.com>, <jonas.gorski@gmail.com>,
        <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <kurt@linutronix.de>,
        <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
        <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
        <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
        <clement.leger@bootlin.com>, <justin.chen@broadcom.com>,
        <dlan@kernel.org>, <rogerq@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
        <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
        <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
        <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
        <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
        <lgs201920130244@gmail.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <spacemit@lists.linux.dev>, <linux-omap@vger.kernel.org>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904085811.7e2c2db6@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260904085811.7e2c2db6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0e73ec-ed69-452d-c7d7-08df0b104169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|18002099003|22082099003|13003099007|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	5aoIw4zjTE0sV7kM+NLE+Lkrglurlenw86Bd0n4hkg4EsLtRKGs9Q9f4SIBxOLkpxB+jX/j6l+BhUPByeEcJCAF3lOGW87SHkoboYcCeUJbZZWSY7Y2zbcBo10xddJ3/X8OHQz+q9luBxUTQVO9/IKtpB6C9KxilhfJ7GrXc/hI1eDaUZZRH3YHCKRHhyET7ISG1OAs65HvkpaLppzTACMIDhHQFfbjQGMONXx3WyvDLaAqEASFnjX2ITlDqUzvrEX3531ZAw4I4HHUO583Tth4kI5h6COpQrkNPU2KGBNJIxKdfjoojOJ8A5++0AKIzdNrH1/QrF2Z7uNJeo9DMUnf5c2Qx0y4gaebxV1USo3j7PlunVScB1zYTZ1sUWTCL3MUj9l30zLV001HarKofqb5X6GTdnSFHp/ccJIp+2z3qtrzw6b+6JVYWFy5zGZqpq4wEaCNlViJqqkm3B7oLhBIpjEzEFSrVhdijioDqrlOH7NKsLIJogPYbCrK1/N6rUl8DYf5cd7Jj8nW7s21NJxOamz7n5HAKf85NmjwzRkYlExvG8iODaL3Q6tvsAMLvnf30aXvj6meOmDhFAaAecyBBkYGxEbh72F0b2fkJGeYYA5+sNjZDP6GDowDrq3Fa0bb2zxMhG0n2THPUNB2rMHDIxKVFOLFqVBrabwJmurw=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(18002099003)(22082099003)(13003099007)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ODhVe2RaV4dkUy6kAYpAL8dmKc2nIq2Rl1ygJOZvuD4PGc6A9Oe+DRSUYVV+S9YRQHRkOkmd2OKoil0AiXL9jD5vxWFfdxwtRYr5e9ZYZ1hZnnbTEkUH040ejZNwOaspEEhYM3PDaVXYII0g4fHztZqjd2VKKRVOMkvsB3YUIzLRoSWSHFqdxgw6JO6saULfGY3H+CQajNJ2yuhgnX3A5MZPZECsrPfXyLiH2CDtSM2x7XrLPpdNpQe5OmL0wa0NbxR1t075SYwh+uX6WQ2sZGd5nuv4lMoghBlg/BdGbKdp43grEPcEQZIZPsXxgJftOoUE+xqh8NPxLMGPNiaDAWai0wtPzyvvnRAZcWS2r0orL2ehnxaSVH2oSqVxAIrNrggtTEf7tDxjX4R/wtAg+XYNONSiXHdAhZy4kjKLj6tAjdACPHRvqCrWPez+24Nw
X-Exchange-RoutingPolicyChecked:
	3Lra0vQEFrhO5lzRP6Y+xM8XGfNvO9BEfYa3WCHbBNAN6A6qJHDtFStbVE+fdyHFDpEh2tSB0kP0iOBGozuxwzBEsYDRCNVvwgThKKGdRdp9wmW2+R4g/tT5SgFywz0Q94w/YiyUEscl0Q//MU3SwOklol+GvyRxHqXx+LsXstqk27gNQgmuZkD7pQ5gJ/AQ+Yb8DsXZQIX7viW37xrM94PwYiuB7hhDloyd98bf6cg0yuSEVrcOXzriqUuqmcSi0cOTq3oaG2n0KO4hqTv9llKU8A1RN9Yo+u507zrj+pByxyou/1WkAXT7NQ7uygWek6154mt0VAr280UjhMBhXw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 05:40:55.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0e73ec-ed69-452d-c7d7-08df0b104169
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-GUID: 4C87J7UArWmIdJvMevTHcbG7BZIJuQXa
X-Proofpoint-ORIG-GUID: 4C87J7UArWmIdJvMevTHcbG7BZIJuQXa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDA1NiBTYWx0ZWRfX5xGT5nrhv+3q
 qlnaCfaSeiJlw714/H9yCunEzUyHOBLsdRgOvGgsYtKzfgi7HQPygBrPr751OTV+Bg3WNUFPuQh
 F7ubzrWyv3YgO8OKCT9Bj88690osO8Y=
X-Authority-Analysis: v=2.4 cv=PPM/P/qC c=1 sm=1 tr=0 ts=6a9bab6f cx=c_pps
 a=0qEcZjvAL+vPLqsQtgLcWw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=9ttYfyVtp4DjXX0bujUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDA1NiBTYWx0ZWRfXzJvRA8SK/vwF
 SXxJFR9sFUddOE4XFhGjhsgbpEDX6h7WEMhjD7MPm4BVh+QIS113PVFg4uQVn5OorGy4KSZOw+Q
 pzMyon6/4Dh70cktWubf6m6rbTy4FYZA0oM2Yy2Fdr0cHPd80eKy8i86z/SbTfJPa2WdUc38c1s
 UWzpGIJZdtOZ1+oAxkN2x4oCdXHDdvIkpJrHA4tgzGXIXu6vNu/ElxClsOYQhmGu74p5xChQXtW
 L18oC7cQixFMQSzvhPU/mRH7L5HrcT+ZF/t3iIXZ05TckLVroqaCWbiuKswFWzIJqg91UXvV42k
 gaCne0g0NEEYdM58M60oMmgs3hvl1JqnP5EepYlvrXiWY4h+IpWtO9jSRAas6pCCVuF+sSMbuiz
 rhMgo7FGBFAMnnybXL7mhZtHy78sKdVg39E6bP9983V2YE1YLq37wNmWfyqdYnfxcfH16/ylBrm
 ISHfQYkNBsWZoRuYcjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050056

On 04/09/26 9:28 PM, Jakub Kicinski wrote:
> On Fri, 4 Sep 2026 10:06:06 +0530 Siddharth Vadapalli wrote:
>> This series removes the comma present after sentinel entries in the match
>> tables across all networking subsystem drivers, with the exception of the
>> davinci_mdio.c driver, for which, the patch posted by Geert at:
>> https://lore.kernel.org/r/e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be/
>> does the same.
>>
>> Since I inquired about a cleanup across the entire networking subsystem but
>> didn't get a response:
>> https://lore.kernel.org/r/b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com/
>> I decided to post this series. Given that Andrew Lunn acknowledged the
>> cleanup of the davinci_mdio driver:
>> https://lore.kernel.org/r/abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch/
>> and I don't see why the cleanup is specific to davinci_mdio driver alone,
>> I am hoping that this series is treated identically to the patch that
>> Geert had posted for the davinci_mdio driver.
>>
>> Series is based on commit
>> 6ebcf5074cff net: openvswitch: don't schedule rebalancing if there are no datapaths
>> of the 'main' branch of the net-next tree.
> 
> You failed to specify why this "cleanup" makes a difference.
> have you ever seen the sentinel not be the last entry?

The 'cleanup' in a way 'guarantees'/'enforces' sentinel being the last 
entry, by catching 'copy-paste' errors at compile-time rather than being 
a silent bug that shows up at runtime. If a new entry were to be 
accidentally added after the sentinel entry in the current drivers, it 
will not cause any compile-time error, but will fail silently at 
runtime. This series 'cleans up' the drivers by making it a compile-time 
error going forward (adding a new entry below sentinel will cause a 
build error with the comma removed after the sentinel entry). I do not 
doubt the review process on the mailing lists where such errors will 
certainly be caught, but isn't it better if they are caught at 
build-time instead, thereby saving reviewers the trouble of pointing out 
such trivial mistakes?

Trailing commas are an indication of 'scope-for-extension' in the 
future, which holds true for 'enums' or other structures where newer 
entires are added towards the end rather than being inserted in the 
middle. Since that isn't the case here, this series makes it clear by 
removing the trailing comma.
