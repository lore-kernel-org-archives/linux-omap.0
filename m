Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60B253359;
	Thu, 14 May 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802015; cv=fail; b=GyYxrPXlucODE6BVH7+7vIg2JCbpX5nyzy41/8zixhgYeGZqDRWvhPDckB94/mGCm7sEzgbnwnVvSm7b6XHDN1lGbs04npc8at9TRgmderTwCBwkst+skfGkU/BCa6LNDQNWgVp4ZKPofHhs+anfyxOACJfh1bIEy6YWJXbRJNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802015; c=relaxed/simple;
	bh=KjU6XPCRgk4BVHeu7KXB3pQqRS4BSCU+OgL7nMYx5hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TybWbo/tnoFnIrfjzK48oMNk6JxC9l87IvoJrp0QHgdyutF87TfC8Z5kf4H8NfELVZvo8H4Iciun7ZBhiOXMApS6wRk7F5Tk6SIIH06ye6aR2P9lR2SGVUSYzkDxHwNa4No90W3Hhk8zE05uBA9AUrqSd+jasn13nUwJRm0UVrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B16ucC7x; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B16ucC7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9cIqqjNbVFxH8umdt8CPa2kVicTL3lTTu54/c7vpNnkxwVywhTEOvEYAH1BHMTYRTSy53ErCBbxMhGzpiSeTXcWUqY/ehpYFMnZpqIbM0lMj6I9COoZnBwJA0/8J53v64AUmK999ZEDzZzMDwMhPaosOgMQe/aLYSwaYAWxMGppAtX99kJ47x51Wud4LOmXOnPCholng8c1miWAMqP1z/NWSxZfSfUnB15IFafx7CJQwnHl71JSPIMszUJ0DgxiVwqq3sWUtwK9OEY0OMxq+h1s26d7rGwnIU7rrhPTO/Lln0uzQRn9pFpNN5JnlS8nYEst1Wz46CIW8YjKV1VPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UynsEM5x5aOYTWghkcywohiBayx6NcEy7Qy+k8zVrM=;
 b=rIIOBTxHy543J9CGulywg/5FiHWGYhUuI7+NXi4qLSzNuGvoQQ8JRIJc6lnmU6D94unKg4n8gnPIXceGiGfYCvEQcXI8jZN4RZ9JZ94Ybgo4oAwEH/okIYtOByms34JAworelDtU7e5gkL7Tmq3TuN+UXzAugVqc7F+7WPYYTuNPLGcMqYaFNDogdhNSKgpDVT1ZZZkr9cAfL8gLblEM4LKFZKPj1rMAGCaiixfPjm7YcEMM80gtPAfY+a8mDf6D9ceQ659WOTvlWLJ7nn8t2j/Xz0z5oJrdy1ospYdsi/iToyV9VMpKtmCQLxpTQIBbc910hAgFJc0jDBql9G3U0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UynsEM5x5aOYTWghkcywohiBayx6NcEy7Qy+k8zVrM=;
 b=B16ucC7xDpzRmu78FeILSsoYIyWLJ0ZsL1LVCnLXFv4I3G3TlHeF71OE6ll0GhR5VvcdO5Hv0ON+sLMEK3GqNEu5/5RQgCxIzNnBaptJ2kfMyHOjBMlTmpyYa9R9zrEfMCjsMtf5DRn4qpFCy4nO8PfrLtIfWYxPBvTR49bQJtw=
Received: from CH2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:610:50::19)
 by MW6PR10MB7613.namprd10.prod.outlook.com (2603:10b6:303:23b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 23:40:10 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::fd) by CH2PR16CA0009.outlook.office365.com
 (2603:10b6:610:50::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 23:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 23:40:08 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 18:40:07 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 18:40:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 18:40:06 -0500
Received: from [10.60.31.46] (ltpf5gwk6l.dhcp.ti.com [10.60.31.46])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64ENe6iW2678364;
	Thu, 14 May 2026 18:40:06 -0500
Message-ID: <8a3538b3-79d3-44a0-a822-6708ba505217@ti.com>
Date: Thu, 14 May 2026 18:40:06 -0500
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in
 omap_dmic_select_fclk()
To: Ingyu Jang <ingyujang25@korea.ac.kr>, Peter Ujfalusi
	<peter.ujfalusi@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260514185215.3753998-1-ingyujang25@korea.ac.kr>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <20260514185215.3753998-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW6PR10MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: a6833918-f585-41a1-c557-08deb2122236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Sy7ys+VCWMvMjqd3aEWCo4keSKwGYf/emHI8HM8Db5meXSfNbbSTmhqJplvHNo2HpBWVQ9SWiSLXp2axkcv2eILfoDfPucSPackqYEPTz6wY7Z7YsF7oidcEO7DC2ERaIsQiyWUEmm0GaFtmw40hcGOriGilRbZw8zaDBymCG4bTDmSk1CPXH6tj1XA6tptQCiX4Cbl5rozBSwIHgu/xXJBtsbPXaxMAuSBRuoWnq5/OQvR3r6bwysUI6OHESXumUXs4AEI3Lmhjs7/DSgQJ6fp99nST3TjPaYY4/VNy+ph1rh9ZkEI7u3kSZ0KeOdiexfsFd0QK0DO5vxjOSBZImkdrC+9M+dYh/ukavXNaVtwmZllVi+fhLQdXoH2cX20ryOIB51qUM+qg84l3Vc2oaD0XuBqqJjcBMYx/Z6vA8ce77JMp9XcKNIBtreQWGxrXjivvSV65l+32/WmyKQYrEpstuYYUJTKp/5Y4GRPc9uMGU1LnJwQlmqiK88q+CuXLeuCtctp+P9FQ/KLvI3BH2eo/MlO0ttpNwcXPudDQLJGCQaOT0JblnUYmlrV36kYMFqns1Tjsv26TYIyoQjvrYfe2xw+eay5r8K2ylTEgGp7LK8XLF5v9TwHfsOrTDVStC6KNRDqZ5pPsA9lJQPHf+FNl/FXooBA6DEaWnILHAEeGFFn+iXOihfIDnOCkXniRN9eTCK4bDHqoo46lzc4cxdplhy631cel6tdydBjl8t0=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HwlDomOGo9TVK+3mnZlwOsKRztPmgGAg5loVdGi5jMjq2T+9p23z4uIg5tGt5EoTE3IglEszLUmTUDEzmsTK+gGVQ547pnnQdVLTgxzexGrkWHpx0rdSP09X4L++TqZEnebJtXJ0l9b+p8VyqA7hoB8xS3LgmI1PIa9uQGp9sPOAdVxWxTvNlz5ryFqlFLOQCiUI619L8v++SV3/zzEYRnesgb9TMI6LcSmTl5/SuT6NT9lcCWtfbXl0NkcRlo4za//29x75Dgv1Spb6OiWInrbJ4hdX1yAcsnCq28jbelDeIDGWZwYb1oLD74Df+ggHStd0fCv6tjcux5MusRk0Xga6J2JTF4Q3xE/Y440aYtcBzUql99CkAYrL8aiG+kluizX13DdXtiIzVZTgtPNt+OJnEJEgYycRvrqgEIR4zDBmym+4g0dVq5Pr3xSMKFz1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 23:40:08.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6833918-f585-41a1-c557-08deb2122236
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7613

On 5/14/2026 1:52 PM, Ingyu Jang wrote:
> clk_get_parent() returns NULL when the clock has no parent (or when the
> input clk is NULL); it never returns an ERR_PTR. The current IS_ERR(mux)
> check therefore never triggers - a NULL return falls through silently
> to clk_set_parent(NULL, parent_clk), which simply fails with -EINVAL.
> 
> Use a NULL check so the dedicated error path runs and the prior
> clk_get() reference is released via clk_put().
> 
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
> ---
>   sound/soc/ti/omap-dmic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
> index fb92bb88eb5c2..f6c393c9489d6 100644
> --- a/sound/soc/ti/omap-dmic.c
> +++ b/sound/soc/ti/omap-dmic.c
> @@ -328,7 +328,7 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
>   	}
>   
>   	mux = clk_get_parent(dmic->fclk);
> -	if (IS_ERR(mux)) {
> +	if (!mux) {
>   		dev_err(dmic->dev, "can't get fck mux parent\n");
>   		clk_put(parent_clk);
>   		return -ENODEV;

Hi Ingyu,

looks good to me, thanks for the patch.

Acked-by: Sen Wang <sen@ti.com>

Best,
Sen Wang
