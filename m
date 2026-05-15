Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363267E0E8;
	Fri, 15 May 2026 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804229; cv=fail; b=NOF+JQx19GdqykMZ1pq1I/q2IORn1+jtNQN4SJk7UuXpyEVWSgOL5q2lhD+zzG599PUsLDdGdQ+r6LjAec+uo6PFpnfsjAk7zmOEpqxKvBkGVjQcufM3qzdm8RSvqEIHTKXDpFojnLdO4TbHO8HUHQ1mxWY+89Bbzl6IjhPYTpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804229; c=relaxed/simple;
	bh=V2gG5z4lxo15W1pWup7cucZDgAZ3n1MVCkKMCdZqEM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dT295RKvqmmxvFh2cWFncClhw5/F6XDpt47fO1/q+N/HACtmnQhpgu344HjB9tuNB7xrL8xRVe48qVxh1+wPL/R6aMcEKD0S4IQZRpckd2mD7Ylh6wsSnXMuiPKZh7auCRfxQ9PVpbimcicpVgLZq7+2Kwbvw9VzdPzTctFyfAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WGN0apRF; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WGN0apRF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDyVdiiyDgR1AfOJ3/lw/gxFHCrUtUGqqRT5ZDDoCadUsLkT1SFRzxFpAnIPm+C511V5qADCfcew27ekUC1n69G3Sl7LUY9qI7Ov5k3SOaDoaVM31bh3VtCr1fdaZtfYUznNWB9Of3QcZLDdiFgcNvZNbNwst3IfV3zL1Vr5gohYyo9j31y2MY0zKj+5517IO8VrpbDqD/yO7XRv4/BrvGV6KChQIqHAs0+ytwY+7wNipfL8KWBBsGuK7TWQXbqdHJKWoIe811QhQhxSTOMZnZIXNTgn0P2cyyrjY8Lqjh65/dIlOoI8XZaDJywiPeFu1HiU/3Ky6+QPtVW3/sDhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IAB6xlFRTNCiEKMeSXl8sJRPr1+TrDjoQgZaj0rHtM=;
 b=c5MX7QYwHNXA2rHpG9WT6p6gMwLFYAQmw6u06+kyjQ6Iv/+Ut0bNSD4s6W2DwvN+jX70MWd/ZGC/r0cGgI+X4cEtP3ZWNPB8aIznTjRQM2mRNvqZPMZfCtKl1Tmm9nMqtmVn4p+pcxAOEPAc6OADb0AoscRmM8qXHbGokwACPYSKp4sYwLalUlaoKO0+8vxyFepLuZzTeQpnGipWrMz+AzbHoS+J6XHi6pYtv5iOCGeYgskXUm6fRdTnbzeAir1Z/KLRIHu8847dP6jdcF8yB0fQQ+uzI3qna8dpVwjRaT/5G5lC8LXGvg/nqEtdl6wqx4H8F35vGZi+bzKrZ7ngcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IAB6xlFRTNCiEKMeSXl8sJRPr1+TrDjoQgZaj0rHtM=;
 b=WGN0apRFcXV8HM0KygQhm4woC1wx/1PhoWEB9UGF0tLT5B3z+sda7Dzj+8330CGpLulSwq3TnMx8Q9gGD/oSpYkN9JFQUmPDvQFK6KgrldA+Jd1KKh4QrJ+rGstynGr40PqCO768XoWGVsHeI49NDfQtjyxS7sOxVOYynru9PHw=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by BY5PR10MB4323.namprd10.prod.outlook.com (2603:10b6:a03:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 00:17:04 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::40) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Fri, 15
 May 2026 00:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 00:17:03 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 19:16:47 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 19:16:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 19:16:46 -0500
Received: from [10.60.31.46] (ltpf5gwk6l.dhcp.ti.com [10.60.31.46])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64F0Gk3e2732364;
	Thu, 14 May 2026 19:16:46 -0500
Message-ID: <c5a5feb1-fbe0-4085-8aa9-f8f06544e29a@ti.com>
Date: Thu, 14 May 2026 19:16:46 -0500
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: omap-mcbsp: Remove mixed goto/scoped cleanup
 handling
To: <phucduc.bui@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <asahi@lists.linux.dev>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20260514110602.30480-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <20260514110602.30480-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BY5PR10MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae86c2e-45a2-4d3a-14af-08deb2174ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B4LXmqO3PPClkDEJe1AtORphyp+EF5fzVyzI8YPi+IgBO+Vb8RTy743rYXN8rWtFo0IpjfGlq0SYmO7eIautrdzXbzaEsrhrCMbnZMvJeWq+1wkU+uBvvMP6NWSYy7VQJnzYztlCT5Ip7tny1+TQ6mexF636IjR4U7JXsIXt2DrMyjOcsDVtbk99e4y3veCUHI5E+qui0AwxgUlahnz3TYnSOhuG6i5UpNc23QZCNZzbqIpqLHm15ZrNV0ofDpQvZfpMbQUTtM1VEk3RstAiMsU5ff5PxkppeEz1oeyY23V7BsJGvUtSd79vAnFQoThCc6AzBASnprUd6sIIKQ7SHDPoQofeFBsgtBTxv7h0hSsZ8uJiU2NRWQ1KBCEgJctHx1c/FzbCDtT444suE42sCBcrrBXCkCBakzApD5f4C8He2RAlTI9HXpN5i4hhw0ol+GWL807w12ijhkyhSipvHDo5ljN7K2dfHjWSEyk1hSIX0WmqL9QoC1HopNq84HKcJe1sitHBFP1AbDe67UHH2BnnFls5SaGabvfB8dY3AUW+7M2BjUmfGiClOWq+tX1FbfqhYQ43M4iiBktKRrb3BREJLgiK7EoV3fWqeC8dIze+tR/9r9eBNTXwljB5Xs0m+QY80jXI6NCPEjFPErGELYhdplEjB86594PdsYkmVuJxC9LWqob2uEv2jx0c0VtAncyOTCLKjtRwkOXgWmWg46RGqJnOiIbIpXB+UGSSprE=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g8rdpJm4DWnFnVss7BRpkMXDyRk9c9luj1Gpu/WrCr1iqe41XZwyRtNwloTvoQjRivnKm9hGz223fAjs6W6YksOxzifLAlbeVgtGtFIWYZqHYai0j+AIaX3gE2peqc4kWO/EaFxikTD73hu+m1C1tN8qLnd2QsODnYl3LPh/1qGAOngIajDEjA2NDljgCPQvbb0m/YbZ4/Vn7OrI3oCL7eN3dBapIZ0N5I8cErkmJmFtMZAcYNhJU1Th2KC9VXd7DHgn9WhkKpwOi8h+bcC80hv2txhj9l969ZFwAgF/Qp6ICqVUOZnt6ExFH5qpAmZX9c5OvH5utZGCPiSwtkZjbD7xS9dfOXj1ziMqO/2s86AagNT8y0V2RRePwkLzscZmDCcUShSm93rCACDOrMMfsxDK9JSmpiHbUgNTIS65LcaeSD1NE87CDp6CH/SV7eK7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 00:17:03.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae86c2e-45a2-4d3a-14af-08deb2174ab5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4323

On 5/14/2026 6:06 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> After converting to guard()/scoped_guard() helpers,
> omap_mcbsp_request() still mixes scoped cleanup with
> goto based error handling.
> 
> Remove the remaining goto based cleanup paths for a more
> consistent cleanup flow.
> 
> Suggested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   sound/soc/ti/omap-mcbsp.c | 46 +++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 24 deletions(-)
> 
Hi bui duc phuc,

The logic looks good to me, thanks for your cleanup!

Acked-by: Sen Wang <sen@ti.com>


Best,
Sen Wang
