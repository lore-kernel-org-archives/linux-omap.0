Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D722FC883;
	Wed, 30 Sep 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807858; cv=fail; b=q67Rw4U3fdqkoi5ZdtTMHmOFpiPToGvISW/nOEXSnP2wXySGP5ZVpmUDoeYu1CWxUAN/4dQAzxoEvYXo0cV49R96Ozxoz1IH2IjEmmr7skB8XgHbbNxc9C15CmW9sY6MCo4BoQURqg1a1xZO8SQermp6M3c399VoQm+WQqrL4QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807858; c=relaxed/simple;
	bh=9k/iqCHH00F+qbO4NMWIgfGN/bTq3B1Q5oP7KEvYMKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CjYJmk/sA77MCsR+6B73+uMa6XjbwWoclVYLw8ChOzyYU/bXIauTzQnSvP1/6j4jk5HxhxllIrYa2FHRv3+SlLpvmrNQl46mVth4Pt7wETVtQsA+boQ6yS4ytCFqd/NvqCJ6hmcxc9RWdwvQ44+k1c2qMstPpzo9lur/6SY6LhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=h1GqteJy; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=EEvPTAnh; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="h1GqteJy";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="EEvPTAnh"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UKk9793825563;
	Wed, 30 Sep 2026 17:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=XrZbxJW8hdQt3F1F18RWI9YJHre0L3zATzcJrI3Zn
	0s=; b=h1GqteJyUm5l5Q0fmdH/CmcUBLqaYb1ChYfbQkHedY+wSnlZY+COMivPP
	ZsW9yN3X4Vm8N5dFbEn0BI0Bi+YYjy8jKQ34wnFdWJQTmQ1ytj7kcO0Wm0UN+Zm9
	n1b916JYfmEtTuZxtRmd7NejqeLy6LU7kPpSe7t6RwtDcFlsGrQqK4QZ5rGQBQfQ
	eAzmnoL9Py/jhfuudQyQqARYIEbMMKPs7Td7AF6n+kJNNFvmUCB39Hm/01x6TDVo
	ofgFbExuwTMCCL+QILUa9UXAjne5P3HOO1O/QO/Y5GkwXrIa9eEmnnejBccPlHAH
	yXf905rkVQ9GUBy0utoBzP78cdRYg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djsa0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:37:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us01zUZGGwkBHL7YVA802ZGizAnkVo9PyB4ukl/C1QMdO01a3Zl+A7MPvOGNovJrJc7RUGJXMyoNNOWWlR//RwwxVjg+TiaEg9GhZtkjv4DHh2xPiUULd68RDC9cI0VT/9CnwsY08SEmlLeInuasgAiq/tYV9oewU5PQlz1O8Sne7Qk5R3JQfc2TQ3MU5foKCYQSdn9vA3S5x7CLervPoMWX2ZE6MmnU1mZsKe2tqkl8YNbAdIoBAkRjFdq4+0Y4zwdXNK+u6KT1De4UHmcY9uVB+6vxGu6sbEwOGeVoe+IQY4zAJlFdwBMMTtvpOO8kQZpoH7kgIrYGIMQZd7e20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrZbxJW8hdQt3F1F18RWI9YJHre0L3zATzcJrI3Zn0s=;
 b=IxV0cdKxsDsij2+wcSeaC0UFO7tGlO3MVSCzeVf+BfYqZFzQ1OKOY1jh70mK34GaXwMIDicOfHS9RO3t/ly+1QFFKBFXlOfu5Unr3gg2s2reYAQvMSCyGGuO1YpWoOvqcpL01s8UskYEpo1kTTXMAs+HWTMY1JEeeIc/SxTQJoH11uvhHg3ZRLspRhNpkTbk79ADNf8rK2uFrFv7y770TF+8Nj31JSkqOp34x+/ujftfWSaFA1hfZ7fAMdxuVLjvZVE/8ujR1n1H0FPTLpv3fbrzUzoA7VDeqq2+GE3YALLrfrbp7FpgauT+ggAQs0OteEgcr+ESct5zCGbHcgfbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrZbxJW8hdQt3F1F18RWI9YJHre0L3zATzcJrI3Zn0s=;
 b=EEvPTAnh2KIBI2yGEG1dJNEDJypAoXfC8W/0sLb1Pq8jK9egua2+lxiFApKe1pFCF4NWv5aXxuFgyPyibuqdfxP8eV6jKawAikYQZH2+A1/9tBCZt+79EXOYpW2+sOM6DeoNi+ZLU0MhZ2AKeDGbyC/DNirMlW1JCYagjj03fO4=
Received: from DS1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:8:44f::12)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 22:37:24 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:8:44f:cafe::3d) by DS1PR04CA0014.outlook.office365.com
 (2603:10b6:8:44f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:37:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:37:24 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:37:13 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 17:37:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 17:37:12 -0500
Received: from [10.249.33.42] ([10.249.33.42])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UMbCUw3972558;
	Wed, 30 Sep 2026 17:37:12 -0500
Message-ID: <8cc00d08-b13f-491a-a986-a2030820c577@ti.com>
Date: Wed, 30 Sep 2026 17:37:12 -0500
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [uL RFC PATCH v3 0/8] OMAP I2C driver cleanups
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        "Andreas
 Kemnade" <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260930223503.616776-1-afd@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260930223503.616776-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|PH7PR10MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: df158cb0-4ad8-43c6-b299-08df1f4365e9
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XcaQBpQgfBbIR3oB8/Ivrj+bs7txFJIkdBVQZoaVNaGxdK3rTrN1PWvLYplEGLi+eCRKyVl+jesFajF9By2ilJGxB3PRexX7anVDDuCevS36tUz/ExE36iRTMKxyI2huIvoAjbcrcJuzyy4+iJ950bmqnkss/zf+PpmOqjFoWwBs6V/KfYkFfxfl2qEaXzWYSHsx3vwgooOF8XszvPkN7kYPu+OsHbz1gRemcsXuTKIq4D5GmOT//2/boeqht/luxbV8B0AXQAkBPTkK3TnGgs9K+EDyPgjg0ZHGseGUINBFEqo+jlpBrPnfrajDLKjIsQogDl/dcbIApGdlDXYN+ZzQEM6Yynx398Kev1Eq9uSuSsKTNOJLzy2LkqWSGPr23jDFZNIr0rK+40Cn+DUWHkFQkMI3eLXcDhk14Y/TsAkgKFy1s0kG8UVNsgOO7M5LfkT5fMyTI4rrgp/jprv2QIMboq25dfOmtyCQHZ7UPCT3uYuvdmOLNIlyZDStmxfCD1rKlb21wQV9+CSCQ2UychQ4abKczl9aS3CTEpoLiq8bRYYQWbL5SCw4+OpRIAS/HtNlrvWlPRiuvWhUHg/slZbjg/EUEKMHv0C0ZjMIxnegOMM85AoNIqSanzr/7VOXfWD+nljcfdA2Oy+irLNBY+TNiygJTd1wpeyGgnDQB9lAnMXA2cCztbs4BH8JTKxF4HCo2fEhi3dL6TNJUU+n0Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0J/PsqQUI1Fzc1Qlz0k69TcdW5bHMzfqoSUsaweJtZqRZAx3s2JEjXI0TJwEjWmo3kIXz2A/KQi+qtXFPHyir1RuWJgyiP0uIoFsq+koNyn7N9UETzGjYqoPbHU7yknpeDxGUC0+XknEFE7nwZXMWmy+Ku7DrBQCsrM5ko01bt9VVGcBCdbXPE0k6jRBLQkjRpWeeHU4ujXWeBT631d6sKAdGSjvLjg/hdy/izDWz79A6VXdeHxj13VZJItGCcMEqdxe8KwgT7Z67eHG5zauaM7dY29IImzistJgv+jWzE9pcpt731dACNV0QE2rbkL1Ff8AS+o65HP2M7g08SEV+3d4SASXTixx+xXOOtwJb5c2COoLzfQOmEtp+FnaD1DKow9E5+7MWaBnmVq9p5LS3kFuuFTzIQjysXeRFWCN2lE6EU5RgMZxrLZVF1QX5/74
X-Exchange-RoutingPolicyChecked:
	XxvHlAi4/vQZg7wFboIvdkacfQiTmRKVZGvhWam7oQBTzCjfZppsx42dsLtn1fPWzff2T00pn6PyBPdRD0OFTQgEeYfAzn78Kr6hx0eEKVtzDcRy8sdZjqSCtY6sVws5dWXk88/vBHVdpGw8J8VpgVvNN59X7QBAvRy1j2+NYBJcyJJ6sxJmhZoWw22C6yOF/iURNI9Dn81nSrE4pvI43iIivAPFrcUsic0kfCVtWKpc+XW8He3sv9vv51sWzEIEdmUhE0hGyP+Q80EHfJnjqkoCqLfShu1nOFo6J6N0K/Mlqbs57eOwcfHCbXl8sIfLc40JLd622hAT7NPgaxfiEA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:37:24.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df158cb0-4ad8-43c6-b299-08df1f4365e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-GUID: U7hjaK20wYGrW3lCn3Fec1loJ6AoTQ0j
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abd8f29 cx=c_pps
 a=FgInDTms8P7UIkhGxXY9Tw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=pKSzJ_ANfVItlSVHzTUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U7hjaK20wYGrW3lCn3Fec1loJ6AoTQ0j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfX+9AzrXPFX+/J
 m7bppzPSd6ZzHavDr7yf5PB1Ijq/wHiPZWRffZizzAFro9Cfbuv1kfTX7s9ohlmKBgZYa6l7ZwV
 QIhgiQ1OgUHvJ1FR+jxeDxQLZJjsocw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA5MiBTYWx0ZWRfXynt+CGFQrm6W
 mph6uULGz6rkEJi8af6EPidWf/ibQnWuh2rKF9/SLx7wG+x1ASr844kxBpeC0wb1C7qLQ02RWRh
 +tGjqW3rCtUIv8hdyJXwPI4ptMIBR4gMo0ZcpcRY9WpaIVahmhIeqYJ+VD94loxKs1pZ6htyFQU
 hEv0UW5rzdcivbqLb4ZkBPplMVbfjygZJJYX904QjBzn9DacZFPAUGC8IG20wf2hnz+NFWiJXeh
 o64ThAGDIY3kYXJ5elp2+34o2r9WYBZYmInvhaqoCRZ6XOJVzTUtb2Lwep+eJOIH1/Ze7ueMwzB
 slBTVkgc+y9p2+rwUAsQNOKvNMkTN/g8cQeH7R/vbQTLuf0cWDGMytzDkQ0AJWd7pttOVMAkb20
 3kFw7iDEjZqyXzMAx13Ub833jZI1zgh+fkdSviEKy9thKB100vube845tVqw1ZLMqcjgnJBysRY
 kA+JXynO0+AZNM/GQqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300092

On 9/30/26 5:34 PM, Andrew Davis wrote:
> Hello all,
> 
> Some hopefully simple cleanups and updates found while using this driver
> as reference when porting the same over to Zephyr. No functional changes.
> 
> Thanks,
> Andrew
> 

Just noticed this was sent with the wrong tag, not an RFC, let me
know if this needs resent with just [PATCH v3] or if your tooling
can handle it the same.

Andrew

> Changes for v3:
>   - Fix OMAP_I2C_STAT_REG value in [1/8] (Sashiko)
>   - Add Acked-by tag
> 
> Changes for v2:
>   - Seems bitfield.h is not indirectly included for all archs, include
>     it explicitly in patch [8/8]
>   - Add Reviewed-by tags
> 
> Andrew Davis (8):
>    i2c: omap: Drop bit shift for I2C register addresses
>    i2c: omap: Remove unused is_rdr and is_xdr variables
>    i2c: omap: Use devm_pm_runtime_enable() helper
>    i2c: omap: Combine event flags register definitions
>    i2c: omap: Use bool for flag values
>    i2c: omap: Make reset bit name match register name
>    i2c: omap: Switch to using BIT and GENMASK
>    i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions
> 
>   arch/arm/mach-omap1/i2c.c              |   4 -
>   drivers/i2c/busses/i2c-omap.c          | 255 +++++++++++--------------
>   include/linux/platform_data/i2c-omap.h |   5 -
>   3 files changed, 113 insertions(+), 151 deletions(-)
> 

