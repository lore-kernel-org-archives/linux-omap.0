Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452F2F8E98;
	Fri,  4 Sep 2026 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506765; cv=fail; b=RS+o7J/iu+swJd6PtlXfHpqWp9VeZmPVwRgRch9/zmiK14tY7C/JQFxgLUZoe32dBr5g5brNepvoi1fvgUGfTwXZaxJmgWmTrmH8L6Xofn9V6onw+XE+RkHMjQ3DAzd7HNhejgc6MmVoZAKW2amquvr3tV2P0Bo6LtMtMTjqNiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506765; c=relaxed/simple;
	bh=QNQWo2WB34mJsyWOEVcvswglQfM6AzL07DPUQGJIgmo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sm1+tzstwOi86TDXfXBDLDufhIVUHh+fZfObQ1+ZxK98/dTRtffW4K4H4qHS0xFQASIXSWZbGpc9bNzYnx3HJB6nlhiIxcwwte4C19DKASECVezBTUhufkWj4ZuZSpzzcRJjJiqMam+vSowGD6NV7pI0whBpuqMa1FNnT8Z3wgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=P6odYd9t; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ckSQWk98; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="P6odYd9t";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ckSQWk98"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684618fO3096622;
	Fri, 4 Sep 2026 02:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=cJu1PFGoJr6ShpJYLO7fVuVf9bhse82sJ9XbO04u1
	Og=; b=P6odYd9tXV6LoLB4f5RTOGUrBLr40OYNVwtwRYhwBuWeVtGQISJ5kXPve
	y3u7oCLgSWtqQTVZiBbOVbLFfdKCsupZwerlSTndNlURAphZ61kKWW4UM6AEfRPX
	GcXf/E3d3yqo8i9GsIWpgizhz7X4z0CBTsGANiE7rM7oPGeQtuQclIqLb7wBwHl4
	F2HT7pqSFHPbZzpxHaZSF4Cq550UT6cpHn09gPMTnxk03U63o6+eUw84yT9bmiol
	NHgwcHmy1tXtxq4uQB+IaTZI01GtmVArNEY5ufDIU5/HhxO4Ntj19qQcE9S49MoK
	fgz8B14sQmZ5tw/43zKVCTzoXVJ6g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq4g7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:25:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl+wdvAIeKPyCMi0t5RLafD8gAbRqFKOLHIHtzO6c8ZTswnU1OznnSa9r9eUTogH5sYOUoj++6xChA9pseMe/VOal/do7PzG4K05xWauFERQ8PbOOitw2B/GQdRFFhZEoEYQlyCtA+tMb6viq2LPqWhStYeYyYwR499Q9pDQOP/wkm/G1uLHOqGH1T+SaOa+EOxQiBQVPC6zIxWIC5hFc1/CJoyY3iOzcZu2Acf+hfBXeRFF2uv4IHcaRtPtmA1Zxk6nnI8sHsLe4w2ih1Y1kr60TA353RJjY8dAdGwsJCF2lJpZOv3BNOSGL+J8mew+aMyjmGD2Ca7HXYiUvoZ6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJu1PFGoJr6ShpJYLO7fVuVf9bhse82sJ9XbO04u1Og=;
 b=cIOyphRm9UXaExsJhI3z1hB8CKguK4LB7l5USIX+Jlq0fGpg0lAwsdkM3NBVEc6a2ejxvyguQwY+qNseBrXHAfxmiItjleMPJfNZjwvz2t7xFc+rC+2h1tjPr1bkaTVuJ/aujPKNtDlrvw/P1cqR5inSSrXgJwalDroRCzNZHU90qc6/OFlKJeYBWtHkXUs8jBC/O1V5l971k8gdPrIgU4esQ/kTqKvvQ+2gz2SYZnUTdK7OyvFRdIX2hRYelSFN1DKO+PLnd0VxUM7y33AVGvd27I5VB9ENe2f8JinjCXHUWeKSywtuwepRpDoFdJwCuuZZOzXgKVYWf9NTyawveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJu1PFGoJr6ShpJYLO7fVuVf9bhse82sJ9XbO04u1Og=;
 b=ckSQWk985BP4WaPr5Q3A7EcpfuXxobJ99+7zp+JnynDdKIw0A5UBuqBaThWVIb8XHheW0hU3+t73/7m2ZCxsjk+RaismYQUQqU+73OrM3AecGkQt+4HLaweZo11QCdNMSW/DVM//K2CTBbIRk6vmdVKZY6MdbphxrGZmONsSAQo=
Received: from BN9PR03CA0900.namprd03.prod.outlook.com (2603:10b6:408:13c::35)
 by SA1PR10MB7585.namprd10.prod.outlook.com (2603:10b6:806:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 07:25:45 +0000
Received: from BN7PEPF00000093.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::37) by BN9PR03CA0900.outlook.office365.com
 (2603:10b6:408:13c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 07:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF00000093.mail.protection.outlook.com (10.167.245.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 07:25:43 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 02:25:02 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 02:25:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 02:25:02 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6847OxxM4078032;
	Fri, 4 Sep 2026 02:24:59 -0500
Message-ID: <89471ba2-460d-4794-a5cf-07cbfaf8d3a0@ti.com>
Date: Fri, 4 Sep 2026 12:58:39 +0530
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <b3d19098-eccd-4619-b667-ad3b7e0a4422@ti.com>
 <69f7eabf-95cd-4bfd-a1bc-a1227c4b31e8@ti.com>
 <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <CAMuHMdWyj-x-tm4E+ZC8KMkzx48hpAxkrK==0hjXeG_HQYZDLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000093:EE_|SA1PR10MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a67794-3a06-4036-90f8-08df0a55bb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|7416014|36860700016|22082099003|18002099003|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3wtNPEONxPi9ioE4G6g9sbNN1/ykJktdnteSnQpi4552HgXlzRmSWIeGVbLVW3mE5L6Ty4SxBFwcCv9KpYks4w2vWeg/McWUhKjWYtljBeShVMqIYBCx5uB3ut9Hcd8HjvXbpo01Kc+chJdGXK7nl9ihYmaC/zhPGA1aCUgd+RUiO9HdRSkXxjsJszfcRXncI3kNQULupzzytnexp/QmigPhjsi8o+wyUOwY0CEs4bRlaEWQTXC4iDJXWaIhKb+8XMUXmJY8rhn3TUmiQXb32ri5HHMPMRBpHiFi4QrWG8h2mp08qgfKj0wvUKnr7+/M0FYqDjkWkgHd58ZXQVvjhoi+YJSG/zbscc1zSD4ZTAWQo5juT5TjuhDkNAK2ysiYvqWjlC4rNNGRbe8s5dybzJFyvjHJ7zJhfs18G8MzF687bS/vUnXrC/4CegY/IOXSxnzF4vtSxwkemJsbVIjZDlzEIDmk1nI1fSOky5wjUz7JudUtF+EkbvDdy/aGGDqq8pY50QHdjGX9YqHgViZlLPn30I521rF4f+uvi2DcY/jwyN4XFh+OYYcBP8u5jq+ohGHArJSJkjpQJ7lp9bw2wshLRetrqUNVvFqTqp1RHTJkp1Suez3O9PbPuZQrUXXO2AfrKBxDfm55EMSsQs96qQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(7416014)(36860700016)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lAvU6u7JEbe+tuMWmCR44YCn/kYepx3yjDiqFez8E78UB8L615FHHNP5ApGJOgJ1jMp3DYrArn6LhwKXGM+by3jwFrqyA3af6MAnaUECR13Yj3PIXDk07zlK1nFRN1/Ri1I4R+nNM/HTbay68vIzJzSojNCKGepTT7EiK2RYdzIu7xVVmGBJ54XL6cuiWdwzbShGgc6Ka2D33loybYREIYOdW1vAAeamqTviSvpKgzq/Jg4xnIvkmQNviCE1DsLBHlIs69sVG+MTOubfNooNSbQ9SMGwfC2ljAgcbCb/fHUmrWRNBZ8Il7JOmPz7PvCJIb2Hzhslp5F00kI5Ze7A/NVBeiJYK22TWQPGGioJBtois6m7S+o2t9+Gn1P0mc93Wdd9oWmYd0+4V4F9PlPn/T46GD/Ct8xICEj3UO/NDcFJ4kLXMAvErffUavft3KoK
X-Exchange-RoutingPolicyChecked:
	VOQPdSCreEs4nZCRjOCW3R/HGBFIzo0kqh2xQa0oKJQh2faoxkBuJAsnneuhLjx6+NOuOdcN1BtmqQTTgRvSQHjS7KIyLpcLQ/CaP+Jsu6AfJyr34HDzFUwB2YA66O2f/puI27jWhalIpIHAfpYOBWljN1aK3bMtXqYZQ/nbHbw+ZClz+2yRpoARiseYE1PYfOAmWIBbysbbyIaDAdACrus3XczTesQsEGjbSaQ5NpHubTh3WWGXJuDRoLjz7twZ0vDAN4t15aHGUB4f2+cSn9RlRZ7/tawHa7QJ3pQTPsEYlxraucIGAZoPpIyk5K2rWK8ZwTrwLAoiRwmJKvhJ/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:25:43.9486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a67794-3a06-4036-90f8-08df0a55bb4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7585
X-Proofpoint-GUID: oeFz0wd_GyPY6z8OAftyUEdrDd-84s5C
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a727d cx=c_pps
 a=xjw7YmzweVlW3QpdpNkTiQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=IRhX6hrLwMwoAyvZubUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA2NyBTYWx0ZWRfX7Zo6bn/+qMpj
 2Xmd4oM90Od/JUuGZRgxEZn27BZGkiBdL9S3tJPqeaJn8Z0J7u5/xvBRMfwPUVIHIyYMrz/IFll
 Ra0+jJixZfg/y1bv0dZJQQ9Mni/D6EFIXG96x7v4vpeOfqeRf6KAOnt5tJubXCw38BrqBAzYoCV
 8RZqxdg2bECCJJBd5ISXk75tYaASWbc1oW8Wlr7Mxf0TanfixV1efB60Y0YrkksKNMyuG2vW2tK
 xM7njjWRfhYSmxZLfwpkBHfPyJKkQ2IYCrMfANfC+lbrtU1JGcNVHPTTXCQOj1fSvkjxFcLewP0
 5nizGH1vxRpibP3MmoHc+Q46Ol+nhVHDsk4tYl486P6pcHRIt+VwXVXP8oQIM7WXxh+b9h2VJsU
 AHxDLXGlyf/5Pf39aCBIMuAyaZDnJ19qXqPOGYekq6pDtQDz0jPi7YUc+5h0rSAk0RkDM6SLSB1
 osPWSikDmer8tLox0pQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA2NyBTYWx0ZWRfX5Ekn5irkgVVW
 64jRzpSi/1d7MgAEjxrJZVWnY7kvtvAt1koiu68818f/m+3rwgeP+aVWy255T0mfXkEyT3SeS0Y
 Y/gcmlwuupPvzE/hYvNRlr1s/+l0ESU=
X-Proofpoint-ORIG-GUID: oeFz0wd_GyPY6z8OAftyUEdrDd-84s5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040067

On 04/09/26 12:50, Geert Uytterhoeven wrote:
> On Fri, 4 Sept 2026 at 06:44, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>> On 03/09/26 18:00, Siddharth Vadapalli wrote:
>>> On 03/09/26 17:36, Geert Uytterhoeven wrote:
>>>> It does not make sense to have a comma after a sentinel, as any new
>>>> elements must be added before the sentinel.
>>>
>>> While I agree with it, this seems to require a 'cleanup-series' rather than
>>> an individual patch, given the following statistics:
>>>
>>> As of [0], running
>>>       git grep "sentinel.*}" drivers/net/ | wc -l
>>> gives
>>>       84
>>> and looking for the ones that terminate in a comma by running
>>>       git grep "sentinel.*}," drivers/net/ | wc -l
>>> gives
>>>       38
>>>
>>> So there are '37' other instances (apart from davinci_mdio.c) in
>>> drivers/net alone that require a cleanup.
> 
> [...]
> 
>>> Since this isn't a functional change, I am not sure why a specific change
>>> is required in davinci_mdio.c, unless you plan to cleanup the remaining
>>> '395' occurrences in the remaining code as well. I am not against the
>>> patch, but the reason for picking just davinci_mdio.c for cleanup isn't
>>> clear to me based on the commit message.
> 
> I know. Over the past few years, I fixed several of them I encountered,
> but never got to fixing all of them. After rc1, I flushed a few patches
> that could be sent independently, so there it was!

Thank you for providing the context for the current patch.

> 
>> I have posted the following series to cleanup all networking drivers
>> (excluding davinci_mdio.c since that is done by your patch) at:
>> https://lore.kernel.org/r/20260904043724.2955444-1-s-vadapalli@ti.com/
> 
> Happy to see my single patch triggered your great response!
> Thanks!

:)

Regards,
Siddharth.
