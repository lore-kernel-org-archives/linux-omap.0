Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE93F86F9;
	Fri,  4 Sep 2026 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497072; cv=fail; b=XcSrD4OWAQ/sbfTw4b6LtAW1OEe0mY+q/U/1i0yT5HKn0V9bZgL1jqURMNSw/fzW13PREsQUdowKs2IknYimwFk0/zXgmeInmVoTgqJMYOQJ9D8yTQoYYaqlFdPQqg/IFsH7cq9W0ROW3/zOEKw1N72nmq1qKbpZpfowU4pwubQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497072; c=relaxed/simple;
	bh=DRp+mvdsnTsePrsKqqC7u2+77kcj+yxS/+7NSnodbu4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fOTxXv35gpV+670usXTtG8MQWKaksv8Nyh4ylVCDDKCAB/3R33KCLr0GMlWlFCDyB5fz6TgFe81EehJ96LX3mnj4Xnz4G8OkOcrVuCf33A7ioXfIQEg/lG2jC4ACiX4WHhY++pxkXXB2qhmAKEMu7BFJ8BfU4Flb6d5YqHZ0QWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JAEUyl/b; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wocqch5c; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JAEUyl/b";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wocqch5c"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sdXV2738015;
	Thu, 3 Sep 2026 23:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=eSMMZ/IJ9B/grx5l5HQbUhFI33Evqxuag27cxs4p7
	I4=; b=JAEUyl/bHdVpatv252XNbddEMtMI8kjPmn29VveFYM8FLThiqigh/oOp2
	q9ZuAZdyP7zK4ZiTvvz2cKbJD/XJu90pvskHM98KpGjlqVctpqNvQpNytiPi+lb9
	aUSS3uztaXOfS0cwnVkmeB0y9NXCC1r42HYVq/qq9f1hZ0yTsekAJUAbEkWmuzp8
	ZiYblkelqmB6W8gcXtnQQ/7VyJqDPF8jCSsBIhgjOHU8LViwQm0LkesOehm7kfz/
	k2jnRfFT/vHW5w8LZS5+1szBBpAY/CFnxLs5yJJro9F5KSLMeyjCuWM9WrpgbQyn
	0yo6onmNmIp7QRDFYpRtlZHrziekg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3nuw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjfUbJuKw+RVPB9XCehJt/GArZ7RLs11pjTDizGhw1kaEI6aMUvZYS88ohuNtMVwLpXD3eFOaCt0d3Qz/7+hRr+uFTsP6gL38KsXf9eqkfSEQGqeCintEULmEqjoe30xAjvB5XeHLpHpcL6vuWk8dDf4R6fgExpJO/FE5NcnORAWeowqnnYpQtasH8Ln8MYXlTpyJHe138axywc+WUtt58DfsPWGzYWwvQwfyR7x03Rsoor7ALdV4MUtyPcb1w69F2hK1O1N8WsjVlNDpfKJs4slBZlmItaQy8iiCrP6Wi0RS9IJ6JE3W8EDaTwRkjiunnALWNX4qqqckL6NNj5DUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSMMZ/IJ9B/grx5l5HQbUhFI33Evqxuag27cxs4p7I4=;
 b=GzV3O211LF7FfTOglAodFZIcoo4jZbOmaaf2liCMo8Ng4YqBSW9q7anwEyTrf/Ixc4F6ub04Tn0IAJ7/3nynvxjOZSlrxyGFYwEmEeQYbWI0Y5+5/TBOz4O6H2zCDRax2MUI0lpOyO28s12UKBD/gL0b+3p/MUhdvJLV7BZ8x86Olgwk95SlI5VFRr4fX6/pB+TtAkUZAeur5TOfx2TpsulTFiXvcB6Z7VZayU4wxk6eJEU7LR+2Vg3QXO1iT5ySKN1RWJWkXMH/EU1r0HjWkQxFfQ9fWlxcCICnTDHY4+EnK7OnnB+zj1qrYzWKwlne3MNChiIvNIwC8xXCZg1hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSMMZ/IJ9B/grx5l5HQbUhFI33Evqxuag27cxs4p7I4=;
 b=Wocqch5cu4XmULW59bCyJ7GX3UIAd3tY7cyI82y0lgdWuLOqM5lbpnDee4nAXErFDcXkBJ62iYPyqNFLmFjonLWIXRVuD4vY8+OxJqNmOaw23F8BUHg6pJEoCs0kQwvHQsUedmoiW6l1a4uIgrNdfDPXx5LNJ0XWouhGC7bjj+A=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:44:15 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::5e) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:44:14 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:43:44 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:43:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:43:43 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844heBw3845735;
	Thu, 3 Sep 2026 23:43:41 -0500
Message-ID: <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
Date: Fri, 4 Sep 2026 10:17:21 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
To: Geert Uytterhoeven <geert+renesas@glider.be>
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: e51b41a1-ca23-4f62-d83f-08df0a3f2bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|23010399003|10067099003|4143699003|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MOKQZI6kX9HUQSzgL11yosMisYlYHlEVTzczz5AIVfxzqiOG0XG4gHQ67WfwI09uYP2YLEbdx1RaVXTi1A0Bj1mrOgea7/E0Bu3cYtPiDlYB1Z/4DUBwu2P7EtFgjHBRECiqr+i5GWPHfSwZ5+y6AR8BPdkAGB+eoWKB5h+wjz4OEPiCIOzjPfTpTA4gSmH57LE8/tUYvVAgDn44fzcC0y1+N1JB6V50h58eZe9BApRqV4lyJEQ4gFfjVD+zlxhlSISIep7V8O/Ky+GvRPEXRlbYiBtBxeOnx8Zl7wpx2ebGfXaImh6Lr2TA/nerPDj2HuOf0cpSFSH131svIwv+Mq/+jrf35KAk/ZmMK7fWUyVQn+uIE2/JvOk7uDBzlD1qgOyjpE/1w0EKDR9IZM6OTQx3MU3lzAULgQ+Rz6Xhl1CoJXPpQev52O3V1cyghDAMvwfJviRYIGTdfKiWvT2dmLX9ZkTlLPINKWkVT+e+6DC+nae4Ob9evvdGACnhUvqy+r7V7wVj5n+MkquIU1+juL+YvTNmkbvk1BWToFp+6XQyVSThRBVuIACy/Suyzs9K9PQs0MzRRwEE51UgsKC5IgxLek6+y5BEqfQO+Cluc0TmepE4lafmORuwtQQVaBvw5qcLUgIBhswp1LAS792Hcg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ir1LKs7yUVhzuN9xfZ2rOrUyTD4B2Goe1j4wFmrPnoeZNXb99g0Hxs0oWCHB+i+IWJV2TtvOrAvwlngiUxf84DfTW8hFrpzK0ZzFDd2uQI3BpeGnpmyeIPtiM1DImc3LdpOFHgYytHbqx3o4l8SUf3AzQ0KiUYDXR+bWCHWV0e71TLbKBxE41anSvL89tOiXiEk9xhs7EAmDtehAvHPk/s/3/4evpwhr7XY6LFYqRNz4dzyxQu8mL+jOqfw8tcbNxuvpeCMgpX8AGQ1UM9vwiU+PmFyEMPzKAtG5nFBnKV4YcIla5aQdRTHsHR8+4h8rKzx9Pzk/gMRleyBu54HcpWPD2Jao3bSpZVHN/Ho+vaS3x6afNnnrARTZp9ESFNWwV22mi5oDWBFrSZufDLfs7pzvaXeM2pIzq8Xmbs5XuRMkdWyBJCMQmfY30yLW2ZQp
X-Exchange-RoutingPolicyChecked:
	Pz/rfGO9z4b9TfOD6CvzVwaugqYBzLqTwba/+CdWqHZR2T/PC0GwLSfhiHmQXLaSErvmh0RP44yMVVI3pgbyXqfa+Q/VLWc6wba8OHlAtRPIbg8rGzKbSsBqEnGsh3Tot/aHIAE26SFpztvgph4PvJT8K8rNpcbmSx/xPCNEHPpBplht2vPjf4dYytuj1tP7CFwj3puYDfFyacRMOVtKVAf8DBU6mTaXCga4aWMUv98cCVUEkH99N47LbWJ/2OMnDWr3DxYrjaw/xfcr9zTBOniSMGKC4PUIyuWXBRG4oJAMK4AcDIIgLOfVjGJ9S7Cmu2/9w/bHSd92vgFR1QBB6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:44:14.2672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51b41a1-ca23-4f62-d83f-08df0a3f2bc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-GUID: KTiZhLUFM13kdheNW63tRjksxSz5sd4H
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4ca4 cx=c_pps
 a=VmiGRewH7mEIsprpaxNw0Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=b8d_EBilQp1tbfDJiLYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MiBTYWx0ZWRfX7yedZwZQgp1Y
 3BbjKLwRBMq8vhnzs5c91VRtgN2j0dWdObaNsbgYI3ZJcwKz/ghZHo+rF+hC7C0iyeKQthDJlW4
 Vvh3lCbH+73y0Rjk3jDcUTMnkyO2JmsUB8TrDZLeHrrs3CXEW6LMXxSxWJTnCvADaCPPnf4V5/6
 AP3G3ZUKrAVzk1MJ+U+A0aiGRM1ZHyi/gTzX1Iq3mvHOsDddNTqrHYVlt4kdzHdhuVGfq84zrXb
 3+doC5S/yNu3vHTozL2X2qZhrtMfNNyqoPRDw/gRnN3Qfnmy2fqQNTP0liskrrIWuGv0HE0Dkz5
 ozxdHGlISeybGvS6j0xBOxyO1GfCv+925eC/y+/YzP0ochAts2yRpKm0S5UncNJh2UO/vzuZeae
 kWU6vWE7NtSsmEXsXzT+r+waxGpb2WSuAFnskVEJkxPrm8Qy2T8AlOznTmVVQw1uaRKKabUDjVY
 /FmkK4cayUK232IYVmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MiBTYWx0ZWRfXxCmzHi1vEIz5
 jQW/0sWTDhH1x4Ws5FwmEFNu7reVHM3UJ8LzMJihyYVY2rVjiaV6dzwFXk6g4Di49LaStMYz5Ov
 72REkK6oC9TfxzxN6ocBtluN4PEkNSQ=
X-Proofpoint-ORIG-GUID: KTiZhLUFM13kdheNW63tRjksxSz5sd4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040042

On 03/09/26 18:00, Siddharth Vadapalli wrote:
> On 03/09/26 17:36, Geert Uytterhoeven wrote:
>> It does not make sense to have a comma after a sentinel, as any new
>> elements must be added before the sentinel.
> 
> While I agree with it, this seems to require a 'cleanup-series' rather than 
> an individual patch, given the following statistics:
> 
> As of [0], running
>      git grep "sentinel.*}" drivers/net/ | wc -l
> gives
>      84
> and looking for the ones that terminate in a comma by running
>      git grep "sentinel.*}," drivers/net/ | wc -l
> gives
>      38
> 
> So there are '37' other instances (apart from davinci_mdio.c) in
> drivers/net alone that require a cleanup.

I have posted the following series to cleanup all networking drivers 
(excluding davinci_mdio.c since that is done by your patch) at:
https://lore.kernel.org/r/20260904043724.2955444-1-s-vadapalli@ti.com/

Regards,
Siddharth.

> 
> Looking at Linux overall by running
>      git grep "sentinel.*}," | wc -l
> gives
>      396
> 
> Since this isn't a functional change, I am not sure why a specific change 
> is required in davinci_mdio.c, unless you plan to cleanup the remaining 
> '395' occurrences in the remaining code as well. I am not against the 
> patch, but the reason for picking just davinci_mdio.c for cleanup isn't 
> clear to me based on the commit message.
> 
> 
> [0]: commit 940de590b839 Merge tag 'hardening-v7.3-rc2' of git:// 
> git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> 
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>   drivers/net/ethernet/ti/davinci_mdio.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ 
>> ethernet/ti/davinci_mdio.c
>> index 48f85a3649b26548..5bec72f2f51dc548 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -510,7 +510,7 @@ static const struct soc_device_attribute 
>> k3_mdio_socinfo[] = {
>>       { .family = "J7200", .data = &am65_mdio_soc_data },
>>       { .family = "J721E", .data = &am65_mdio_soc_data },
>>       { .family = "J721S2", .data = &am65_mdio_soc_data },
>> -    { /* sentinel */ },
>> +    { /* sentinel */ }
>>   };
>>   #if IS_ENABLED(CONFIG_OF)
>> @@ -521,7 +521,7 @@ static const struct davinci_mdio_of_param 
>> of_cpsw_mdio_data = {
>>   static const struct of_device_id davinci_mdio_of_mtable[] = {
>>       { .compatible = "ti,davinci_mdio", },
>>       { .compatible = "ti,cpsw-mdio", .data = &of_cpsw_mdio_data},
>> -    { /* sentinel */ },
>> +    { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, davinci_mdio_of_mtable);
>>   #endif
> 
> Regards,
> Siddharth.

