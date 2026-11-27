Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795742731;
	b=KcWJTV7oezB8mcMPKUU6lhQkpobSZA6fSq+X3/v1VcgvHprFajDJGJTtjnSigQEaCrkt
	 tgNfXTS/YWM5X8RtjDaGwwDbjeB+OH0z4TrhFLKZaDwsOdiCaHYOUPq50odRiVWgFtSUS
	 JyFJ2x7fmeAMiY+hR98OyEqwiaxo9ClBuLYwI6sgUmNFbycIWuyTKbX0zSI4q/kj5rysf
	 4qtzQWpCP4FQrAYLPC/sV2zof1UWLAxpDdAHqxg9CekYo8iaUyCpisrF9HB2l0B4OViHg
	 7bPPNmbUiirxZwDzp5jMZXDjhJVyxRDG75gnoImYTyCJy0YfG4ooq1b6fVW7RAheYzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742731;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=q5nnXyQwGUwcjYGxt/EufMOGHXNEswmcNpTtZ6k+HQo=;
	b=o+qx1rY40E8ZB+J6Mqqv/SB6mLtCQyXSb6S2G1XTOp5oxOWphuTd/nFY3ZG1PVABKh8s
	 ueZlIjBarmMwr5hcK2UslEjGyXmdxh9IuTSvOxhcauxW29FCULMdK9AGKHxft5Ji3Kjms
	 /g1adRsD93n1YHzH411NFYwx9aOmakXgZxa2/+dxoSby4ijwfUdlmfW6gAjjobiFJcTO2
	 tEsnTk/bkROH0+Jpj67WCBt01oI4FUiOn8CzhaRIVvjyKL/g26o54l2aQBFQPy11yHXL/
	 0vnPxJDi50o+v7dEujATqiwQwlEUihQZUbcZrb6U9q0AdnEBBzoAOs5D7WJoavXwQFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=BikY2ygO;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=bOcBXaQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F123606A321;
	Fri, 27 Nov 2026 01:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F123606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=BikY2ygO;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=bOcBXaQu
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQK0FP7617319;
	Thu, 26 Nov 2026 19:25:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=q5nnXyQwGUwcjYGxt/EufMOGHXNEswmcNpTtZ6k+H
	Qo=; b=BikY2ygOeHCaUD5QP+087EYOmkCNhIfcFYgBf08vnONsmd5odPw6HUWLC
	KvQGv1fnLeo/s48hOksLBQT31eQKlsfNk2OCtnIsgGgr6kIiek1DeoOcsImsL/2v
	1tOXWsXz5VWqlDJEMuOllvvXu5DEn6v0NRy3cNQcfAvfLauQsg/JIlP2MziCVxM2
	MwHBZtCSZv+oJnk16YLpVwqD4Z7Tdng73fxucuLBRsP05vgCFbVVMicMO4DKzO8O
	R7cGZcvNIvOazBdtQ/9k+SwW2oycn+BIIexjzNrXy4SMk9sxNnWNnvg6z00MJvvh
	GoNiseQp5YWJB7OFywIa74p9ntFiw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j6hud3k73-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 19:25:05 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+gtDVO/IEUGM33DLV5ajYVZ80Bsi4lJLXM8TpCO22069HjIZNXg77ndKwqsJBGr+Y+Km1Eeknp37w/gUSHDmu2XoJURkRlLOGgjtmkycLVUg6I6Q3Ym7CaN+eqUmc6xB58O0cwqrRs+s1G6Q47RDfF7++fa6xjr5NM6B/Hrg+GntbRuYZQSTKIzmudV8kzx+OJsw9DuVjm+Zcn1mx756d87qCTeI+6qOYFL0p9h4/VM0DOmnMYeZCZdHnfZ7H0JNMSVf8zZYOtS1+15tHO8VgPjvOZkpAWh3m53YlcE2MU+FJKIRrJjWADQlZRDwTP0klKPtRBHxJL3/StV1A0P2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5nnXyQwGUwcjYGxt/EufMOGHXNEswmcNpTtZ6k+HQo=;
 b=iwcRquS8PuXJaw3z/cplx5V8jIZ5HsLJ3TFy8toc3bHl9JZwfkOE8rdlZEFsuukVe8T9Hj2Mg0wt2DQYdnySrB/LLcIJMSLlBkciQh8eY5CZAvwMoV2oNH7My12nJgyUg4wpV6n87SmFtbrsW0ygZx8eyNWY/X5XATa6GuwGX276DTVhaTVARYhXPsAUA+nsTT73yG8VrkKal8gBuGZIVwlDI1ic662rEHOXUfmf4bNxLZnWKZ2oiuDR/iCfJ+PGMLhKYVEQGTSdq/xSYp/BgFJrpB8pYaAlU5tIDFbRwwG9wtMuVxukdVRoGX/Vl5oMLwH1t0E8D1zG8Yks17BXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=se.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5nnXyQwGUwcjYGxt/EufMOGHXNEswmcNpTtZ6k+HQo=;
 b=bOcBXaQu16CflMxNI7Wv6d0LW17dlggB7TEdZ7tzDjfspJJ4cQzOkzIh7ExEQFYE2dIQkD7D3wZHtjmOJtZCrO3kYwSqDAUyfE9NboNRb+5D+FQlNB3UVfqivjMkPXyG3tJRhf/Hd4YBZ5woRBiVZR7DPXThZolE0lE0bC/FIGk=
Received: from CH0PR03CA0409.namprd03.prod.outlook.com (2603:10b6:610:11b::17)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 01:24:55 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::12) by CH0PR03CA0409.outlook.office365.com
 (2603:10b6:610:11b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Fri, 27
 Nov 2026 01:24:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 01:24:53 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 19:24:19 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 19:24:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 26 Nov 2026 19:24:19 -0600
Received: from [10.250.64.17] ([10.250.64.17])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AR1OF1u2730953;
	Thu, 26 Nov 2026 19:24:16 -0600
Message-ID: <8efc9453-bb4f-46f7-94c5-a3215b287f84@ti.com>
Date: Fri, 27 Nov 2026 06:54:16 +0530
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: enable MDIO
 manual mode for AM62PX
To: Paul Louvel <paul.louvel@bootlin.com>
CC: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Bo
 Mellberg" <bo.mellberg@se.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        Pascal Eberhard
	<pascal.eberhard@se.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
References: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
 <DN57K7KTZK8P.1M20MF8V8E3U7@bootlin.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <DN57K7KTZK8P.1M20MF8V8E3U7@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|PH7PR10MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17fc5b-338d-4159-52ff-08df4c253d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|261021121427099003|10067099003|261026121527099003|56012099006|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	2IXX2KrpacQPCRSsKRL8nmKcMeJlmH7wVzVpuJS9oEkm1J15TP5VliJuOb5TuaOfWREsP5XRGZ2uOht4Iswa8Jr6uzYNrZKWdliBYtLW0x6SA++rQ2ieUrwY1Wc3Qzrm2qD5o04vbrzZMGO0eQqpQYfNmgwit8Uig6P4ATfiGA/xMAlLDWVElG3Iku0VrsWS7PYFaKTVgWlh0ss/l9jJgyQLuiGJU9wgRRVtSq/pKVnkenq7tWa2RqoEU3qoFdFSTrIOR5mSJUoGB+pMyz68y62h5mLSL0g92WV8ayp/ILzq52qOL3buPJ0zxsZeKNKXaUxLUtLvt+9HliZ5Ni0muNawt+OZNzUMA6i6wK9wEPtwObfLz1fjRzZLQFXXXWe8dGMUN0cGRK6XwBP4vM8oZVbqOvcm4kuMi/mLebfyh0ZvHGyZvC3zirRpR3T92Z+6SbaTX0IQYsJlyMS8XNbO0j3+h2ys1OsmQrek6vXfusluLXl/NDqz/H3H+UkWlIZg7VsdCpvkhYOtnx+2GpIhasX1zP8d+nbuwlqh5dIzUu7a0b5JgUOH2bzc/iEFx3UYox53b8GOoNR1Yq7z4tXrYmuaSTGknYJMZTTApi2hremywaQQygwEoIlNo4UAECzp3V52x8bNrljFBIDoxavANQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(261021121427099003)(10067099003)(261026121527099003)(56012099006)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mw5F+lfAuaBmRJM+Z+GuCYNcpgNxAFszq5Syf/34iM1xq8/bo+hCt1o1WAHM+Zh5YUE9dS6Kg5LwgD55PjrtcqFOtwhDObqmxszvhTupY1yTBua6lT9/BdS1XWMN+9u/AaimTAfq7bXFLuYQHhaHw+xgSN2Wl9gE3EWEGDuAoa6mJF5W7y6koksuObLFztnr0AURxKKisyj4wSy2k4IA4cZUQMPYrULDkDxiL81bo2TC5YaZvc0Ie129mb5oUGIZ2k7GXBv7vS0xcnsLCqJj67X8VNQpkSXUIaZDkpk9i6lmmMA9/NcOySiyu9nSLB2sgKQdrAF/emgndD+pdIUEBGFCMjgi+J9mvr6jmOrU42HvvpxEBN8XQ/GJNWJYQsbqp8dL4zGg48GgpYb1V3etNXrVmJQh3dY9xwcJWTrba2LBPSgRjnHa3s8ws6fyW14S
X-Exchange-RoutingPolicyChecked:
	N7Y5JqJwk9DNkFGCCCyvm06Lp8Jd7bfZPjQ73JasnECjTbMqdfxBNVgI0jpZJB3HpcdcBiIFa5NAms3RKKlNRUi7AIfuE/0F1qTC4SIWw5iun+KsSx50o8ubxXBE9XGxB1B3pnAmFsfliZiiv4gdFU6x9ct0NrBF8l7j994u/VsaC20GUwk2Fo5mVdPS8GbAGmKp+LjMUB9bBruUp8mmjbJhK7x060xC9eRFAc+q0dsznWdoAjxc61xPjbCsLqLGhxSeZXs/mZ3Ruhf7VnY9zCC7arr0x3E2nh1dHtDyZV9RsII4Mu6i10cQdGO0TYJeXs8XwqBHKhMZUedQxVIWVw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 01:24:53.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17fc5b-338d-4159-52ff-08df4c253d5b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAwNSBTYWx0ZWRfX2F8bIJldAAd/
 lCFZElY90qLc6OahvvE/GSKwGbd51sTjn/qw3gXO+am6s+BFPD1RRydwCpcf5L+/NHOpX6VtBjx
 9yboCA+Sth9RnPQ30anlTsXJyRsNP9k=
X-Proofpoint-GUID: dBtxceRka27dJw_iMCnDKepSeXpkhpwx
X-Authority-Analysis: v=2.4 cv=a4KlZkSF c=1 sm=1 tr=0 ts=6b08dbf1 cx=c_pps
 a=tq6IV6p/3TsKmbatKbZ8qw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=7HeyNAYEP-HJjRFcW2EA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: dBtxceRka27dJw_iMCnDKepSeXpkhpwx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAwNSBTYWx0ZWRfXwoM8Pi7bjju6
 /urgzwGCoWgIFHriG/yoX3HFLVisql+UdmGV1qT0Vyb04YHZvgtpePHxZ3FGpp30Qor2sq4pY9R
 X6Iv5E2hkFF+zzlmfD+3VyUbYYrrNt89/2iFne0/Q1fS/V6xlwzw3MgWHUBPhfdRfkUQdk5YRaW
 qx5uN9bVL8jSk7dkzKNId7HvI6M4AVV01stGxPUJ4OnUUCehJYMV5p3H4MhUZMMmL7c7XD8qLnF
 KCcJ5BmeiKUSgHbhs0HesLp7onTq/KbW4Tb9STF5SHPVS1rtctVI2YGAr1FCbFxA0MZddgSXnmo
 xVvMn14/AEHzfGR6UjyZsHKrNRmdgoEJFkKw2d0jSTWKNwe1/6pzRsu2EclyhBruWLhW1seC8Sa
 6vCUJzPgeV4kUT/iJsB1alO62KYx5tguvqcc0tcWeZuuUtnJW8PKB+KyQqu+rdfAPuYy33tZh3Y
 G5gN6m59fnnP21Jq0/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270005

On 26/11/26 7:52 PM, Paul Louvel wrote:
> Adding Pascal in the thread.
> 
> On Wed Nov 25, 2026 at 4:08 PM CET, Paul Louvel (Schneider Electric) wrote:
>> The problem described in Errata i2329 also affect the TI AM62PX SoC,
>> despite not being listed in the following document:
>>
>> https://www.ti.com/lit/er/sprz574b/sprz574b.pdf
>>
>> Add it to the structure that enables MDIO manual mode.

Internal documentation clarifies that AM62PX SoC is NOT affected by 
i2329. Therefore, AM62PX is not listed in the documented on purpose (it 
is not a documentation gap).

>>
>> Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1647576/am62p-external-switch-connectivity-problems

While switching to manual mode seems to fix the issue as described on 
the E2E, the underlying cause is different (possibly a PHY issue that is 
exposed when using the Hardware-State-Machine, but is masked when using 
the Manual Mode with Software).

I believe it is incorrect to add AM62PX as an affected platform given 
that the Errata doesn't affect AM62PX and also given the Software 
overhead with MDIO Manual Mode.

Regards,
Siddharth.

>> Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
>> ---
>>   drivers/net/ethernet/ti/davinci_mdio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
>> index c413887657e9..9b58ba7acc4f 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -505,6 +505,7 @@ static const struct k3_mdio_soc_data am65_mdio_soc_data = {
>>   
>>   static const struct soc_device_attribute k3_mdio_socinfo[] = {
>>   	{ .family = "AM62X", .data = &am65_mdio_soc_data },
>> +	{ .family = "AM62PX", .data = &am65_mdio_soc_data },
>>   	{ .family = "AM64X", .data = &am65_mdio_soc_data },
>>   	{ .family = "AM65X", .data = &am65_mdio_soc_data },
>>   	{ .family = "J7200", .data = &am65_mdio_soc_data },
>>
>> ---
>> base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
>> change-id: 20261125-am62p-mdio-bitbang-1092530ef9a0
>>
>> Best regards,
>> --
>> Paul Louvel, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
> 

