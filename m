Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191B23AB88;
	Mon, 16 Feb 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771265762; cv=fail; b=ZBSU2CHBAy50rWSG4Dc+ptSXS8JbCJPScHCOSq5vNpDjbv/1CftliMWURDhIltAMf5cdYbgFLqqO/onan9ssesh2zFGECf4bcHFlthfKaFvbcWHcsluXQjFcqJLNyXVMXYyitMzqzWUpN9qT1Bhg5WYTP38AWsz4vcJbiQ2Y/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771265762; c=relaxed/simple;
	bh=R+mXBH+VmtZ5mx4q3iITxG0uym9KrBkmg2pE5gHut70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6+ADB4JdcBZWt47oZf3JB41SWS8aIta7aVwAUVLNfa3J6eXQosJQa7zjKnzW75fgLzsw6CyPD6WzZ2zvoL01T8XA+/mNmp5QoIzCZ9T+xBeRdzbAevPVp1Lduv+Q/HMGzMmp8/VChztDvuPFm1Hc8W3BhEAQPRc5BXZaHspa3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tY8ZnOor; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tY8ZnOor"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSOO5YYjhu6TQLLnesKZjRivn5sUsGxJ6wfLFJY5uRtw/T5T4tjCg6O6pAKJMpr5kGjHeECT3nZfc25e60noh4W9OetvBP57etW1q63QRKYwfpcSIfJ7gMEp9NYyL24BpSoRGfkwgfHboVhUg6/HU4EB+a5Ousb20qfcklnH6wDjGl3z8bKVe1nJISyai/b6RuA7LEEoQiZ0/amd2VW6vFOWO0saOBbnwiiYKHam9zCkAI/TFxMZCbJAps8xeusJgzW5JRSjaTSQN/FhkH5XLYxkm4sRACXUVVhwdr9gBW6Dm3NvRDI8GaEM55N9kNQU4LNJwo021gYPojLBywyyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBxceX5dGLr2HSsiqm9Y0o2roSPqeccgXOBPigWemyM=;
 b=sj5KStMC+WA4XWMWw/wQdqs6qfCw/YCx6A3MveBVTD8vZ+jwRuAIMXssx+DgpNbRaRPPw2oEVpZxVz1+64hzAoO/03a4f+X6h+m/B4RPdIKd08QvQAnBKkNniR0kvcZuDVVYnCdAxFHR4xwTGO3LUTNHL5b1K3R4xA2MhZmgkos9eZ4FBgsigFrpKOFajYxIXTtnTGUoAm8XFg/KA98PqC6C9TglhdNPUUiMup2rLuUMbstgLtF9iQ63mQv/mOcB2J4NIHjFL2t5caeqiolAx+0AS9iui5JtWkK/whl/xP7uRxMJXkf4SZXQnNSc4pVyE6ziWWqTOkx9wQg9qetXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBxceX5dGLr2HSsiqm9Y0o2roSPqeccgXOBPigWemyM=;
 b=tY8ZnOor8lSAchZiEE+juRWD6dJDPwrifKeankW+NFnL0gck2QGrndDdA3xL2JwOkO7T+tsNsD21qytel3hjIpu47wq3lvP3Wl62bLqJapMewbYGD+gfrq3NkC2yrvNTYV3Z3LC4su8gZ5DRpFwmYPBSIpce+sS3RlPOTM8sDwQ=
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by SJ2PR10MB7735.namprd10.prod.outlook.com (2603:10b6:a03:578::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 18:15:57 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::e3) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 18:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 18:15:55 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 12:15:54 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 12:15:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 12:15:54 -0600
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GIFnXf2129783;
	Mon, 16 Feb 2026 12:15:50 -0600
Message-ID: <0249c0bb-ca88-417e-b5d6-903882f9a68c@ti.com>
Date: Mon, 16 Feb 2026 23:45:49 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: ti: am65-cpsw-nuss: Update
 port_mask while adding multicast entry
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Vignesh Raghavendra" <vigneshr@ti.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Nishanth Menon <nm@ti.com>, Michael
 Walle <mwalle@kernel.org>, Simon Horman <horms@kernel.org>, Roger Quadros
	<rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20260205070951.3170631-1-c-vankar@ti.com>
 <20260205070951.3170631-2-c-vankar@ti.com>
 <83a867729ac8fa08709c52e2a357c97ef1bac27e.camel@ti.com>
 <fd5c557f-b6a6-44e0-b66d-8fd7defc7203@ti.com>
 <fecaeb94-c004-40f0-86e6-6b7c553a2fd8@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <fecaeb94-c004-40f0-86e6-6b7c553a2fd8@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ2PR10MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: f284632c-cba7-4631-03dd-08de6d876d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZDekJMbG01L256YnFDTm5LSU1RVWhMcDREVENhZS9UVVZ1SUtTS1phQW9x?=
 =?utf-8?B?ZWVMUHRCVm1XbXRiVHpyVXFJeUIvdlZKNWY2OW5ydXdzYitZZFZwYVh6azJv?=
 =?utf-8?B?OVI3R1o5VzRVaFUyMGR0c1UyM2hjeHBBOUIyS0hmVlFDTjVueTd4cWdvNDdj?=
 =?utf-8?B?cjhpM3FnSGNrWWZIR01WM0ZDWE5GVU50c3NLeGRwK3JkcWNzVUJEQXJYdVhO?=
 =?utf-8?B?UzNUYTl3aEpGVWhZKzhOYnZGZWgvVXdXZXRpWmpjQVRoVlNoWHRxMkJLMnRE?=
 =?utf-8?B?ck1WRURwdGFXTkI2RGtveUE1cGhjakVZQnIwMUh1TFl0dXI1by83S0tNa1Jt?=
 =?utf-8?B?UXplblBSSFlPN01sZnhPdEpzQzJzeVMwbVFvWWVMb3YwcGpFR3ZYd01OMTlo?=
 =?utf-8?B?dWhkZDFRUHlOcGtqZ3VpUGhZVHVnUWdqUXFrOGV3M20yQlJjU0t2cGhZL2V4?=
 =?utf-8?B?QkdIbGdEdVg5YndTdCtPYzNIYktIdXFGaWhBakwrak5ISzU1eVJZb1ZuNDRU?=
 =?utf-8?B?cTNQUTdweVpsWjVJandVNmQxcTJWaXhMVUpTR1hEcThDYktMUFpiWFB3RjNl?=
 =?utf-8?B?cDFOSnR4STdQWGVEZm9abXNaSFBNTkEvNGpTU20rc0JMUEUyNklhVkRjaER2?=
 =?utf-8?B?VXIxaFZIQ3RqYmIzZ1FBbkhUUUdqWHFmY1BGRllrblY0TjJJc0wxQ01YWFgy?=
 =?utf-8?B?Z0R0U2RHVEZ0MTJlQXRVT2tTYi9GMHFUZEN2SnJSTHdpNm1TbFhhVU1ReTBv?=
 =?utf-8?B?SnZJSFVqR0F3Vlp4Q1VQVXI0L2xNeUlBbVQvNEMvZndGYjQ2Q2VSWjFabkk1?=
 =?utf-8?B?bFdLQ1JPUHJtUnNvOEc1UzhwUjdENERFYUNXbUptWGdZZjJBNVNvRWZSUlVz?=
 =?utf-8?B?NzIrMzhwYjNUNmtVZkRkY3QwUWhYd0RHZXhKVWpxejRlK1JFSlQ5L1EwdEMr?=
 =?utf-8?B?cXlENk5hWFMrZnR4cllQRFYwYVlBRG5KR0dLcktEQjZmcHBUN1A0dkxiUEU1?=
 =?utf-8?B?SkxJY01tM3I5akxHMjB0V3FmRU9vaXdVTXQvY243MFNzcGlZNGZVMTgxb1ZR?=
 =?utf-8?B?TFY3dXE1WS8xcmx1ck9MUzc2RUJWUkdkT3N5K3RBN2E3WkFxUnUxQjRRVmZX?=
 =?utf-8?B?NUlFd2NwVllNRUZ0SmxhdE11S0Yvd3VpdjY1OFpLc3RUWTdramNMVzczOFZv?=
 =?utf-8?B?NVI1SmZqY21aOFJyMFdxK1FSbndPMW5ZSlB6QXBKOWs5Y2t6SXZwY1pRZzVF?=
 =?utf-8?B?S1h6OUhtR1BGNkN0U1VPRjBOWjdpQlloblV2clFqT1YwNjlNQ3FvamRZVUp4?=
 =?utf-8?B?VFVvc04zNEhFUkVBNTlnQVkxUnFRazFlemo5SndCUUZ4UVZHOUdXYnRMSmxC?=
 =?utf-8?B?dlczQ1d3L0R1ME1ibUtuUC8wWVJXblVFM1JGSU5uZmxSQnJ5QWFROFI0dnFp?=
 =?utf-8?B?OFVaOFMrYWxKS3paSGNZYlhUM2hjR3hWRU5BTVhwa0lHWDVmZDhOcllGSndT?=
 =?utf-8?B?U0pmU0NrS3FsQUZwRVlHTUFyeERIVkRsM0hVZDVPLzBhQmhyRDAxcVlnUlEz?=
 =?utf-8?B?OUNBblhQWmIxOExNaXcwVkxhYi9oMndzWk1OM2IvdDJwZWtSVERKTHQxQ2Z6?=
 =?utf-8?B?aGRNMWhRMlRoZXhqeDNjaE5TMHFuWVkzSUY3TXBwYi9zNnRQd0w5WjlUYUxX?=
 =?utf-8?B?aXVyTXpNV2RFTFgxc1FYOThCTE1PaEZHUnhyWDdudklUL0UxSFd2TXZURVZI?=
 =?utf-8?B?Y0ZMZnJaNzczTi9jUUJqaWxtamNvb1l5WWRWSGpXNDAvc2NZMnN1UmVTbVdm?=
 =?utf-8?B?M1V2Q3B1NVZvTDFwOXQvblQ4SURCVGdVQ25vTm9uTG8rVGhNMXZCcmQ1dkVs?=
 =?utf-8?B?QjNNaEZWT0RmWEFyVGd1bVg3anlOaUNRakNHWnNOMkFGYTlLSHM0ZGJFVHc2?=
 =?utf-8?B?am9OdEN3VTd0WGtSN0NRTFNoVUVlajlyS3FkYzNUNU5zb2ZrWmM2UFozcDQ1?=
 =?utf-8?B?eU9iNEtObjV1WGdzL1I5bDJiZy93S01YK3VUK1h6cFpGMGticGdUTkVGZlYy?=
 =?utf-8?B?WDBmcGtJbnhONGdBaFVXTjdNOFlhdWJ6ZDk4Znd6MVFRUVZBUGJ6akNqZDE5?=
 =?utf-8?B?QmRwZWlXcjNyMlJwemducTlIamtHazIrSkY4TUJvcDVhdlRYamdFajZvSzlr?=
 =?utf-8?B?WFp2N0lDZE9rR0t3d0EyVklxWG1KNGkwcG04MVlzNTlzYU9LMTd2WFBPRk9H?=
 =?utf-8?B?QkZMRGlBbzh0NTZSREdtN1JabFRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8G/FZZ8QnD1C/OCDK70w51Tq2H3+fDzZU65I4z/LGjxEYH6QsEeSC96gSS7YCLfof9cRT0h4lnTJeylJ/Cd4jNZLcvsBNAlZVQHpDpqaPCnUxBfOEFep5Y2aauDVWOQN4BM1DPQ72tsgok5AQMDnt2YSPIG4RNZG+seFvP61HLy9o/pNzRL73eF80rithPYr7yoSoKFHcHO7MjolcvF6fjRlwOGD+vjoi/8MyxV+X5wU/SGpW2QOBpkbsl9LPkJBsYc/bqeSd4nXOE2cLYz0SiwKxxw6e/ktyxucvt5ZlCUYwS26ZuuubyiMu6Usbs5/igHB7nm3D5OgcGLOSeth8+G7HUUBJP+qAr85qmRuJZ0TZLE/m2km6WQgoPlhuKUkAvmLp2Q6awd7FhFjwSLVI00qVn96MlyNGtzhx3vjqfK0twY61/fwWGO0bTMc6AEj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 18:15:55.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f284632c-cba7-4631-03dd-08de6d876d51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7735

Hello Siddharth,

On 05/02/26 20:31, Siddharth Vadapalli wrote:
> On 05/02/26 5:05 PM, Chintan Vankar wrote:
>> Hello Siddharth
>>
>> On 05/02/26 13:45, Siddharth Vadapalli wrote:
>>> On Thu, 2026-02-05 at 12:39 +0530, Chintan Vankar wrote:
>>>> Multicast entry rules are mainly evaluated for receiving traffic and 
>>>> do not
>>>> require MAC ports to be explicitly associated with them. However, 
>>>> setting
>>>> associated MAC port's bit to the port_mask of the ALE entry ensures
>>>> technical correctness and helps maintaining ALE entries linked to MAC
>>>> ports.
>>>>
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> ---
>>>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ 
>>>> ethernet/ti/am65-cpsw-nuss.c
>>>> index 5924db6be3fe..967918050433 100644
>>>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>>> @@ -391,7 +391,7 @@ static void 
>>>> am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
>>>>       cpsw_ale_set_allmulti(common->ale,
>>>>                     ndev->flags & IFF_ALLMULTI, port->port_id);
>>>> -    port_mask = ALE_PORT_HOST;
>>>> +    port_mask = BIT(port->port_id) | ALE_PORT_HOST;
>>>
>>> Since the port_mask setup above is passed to 
>>> 'cpsw_ale_flush_multicast()'
>>> below, wouldn't it temporarily cause the forwarded multicast traffic 
>>> to be
>>> dropped?
>>>
>>>>       /* Clear all mcast from ALE */
>>>>       cpsw_ale_flush_multicast(common->ale, port_mask, -1);
>>>>
>>>>
>>>
>>> The code in the driver following the above function call is:
>>>
>>>     if (!netdev_mc_empty(ndev)) {
>>>         struct netdev_hw_addr *ha;
>>>
>>>         /* program multicast address list into ALE register */
>>>         netdev_for_each_mc_addr(ha, ndev) {
>>>             cpsw_ale_add_mcast(common->ale, ha->addr,
>>>                        port_mask, 0, 0, 0);
>>>         }
>>>     }
>>>
>>> So we do add back the multicast entries for the same 'port_mask' that we
>>> removed earlier during cpsw_ale_flush_multicast(), but, there is a delay
>>> between flushing the entries in cpsw_ale_flush_multicast() and adding 
>>> them
>>> back via cpsw_ale_add_mcast(). During that period, the multicast 
>>> traffic on
>>> the forwarding path between MAC Ports will be momentarily dropped. 
>>> Please
>>> clarify if that isn't the case.
>>>
>>
>> When "cpsw_ale_flush_multicast()" is called, it only deletes entries
>> where the resulting port_mask becomes "0x0" or "ALE_PORT_HOST" (as per
>> the function implementation "cpsw_ale_flush_multicast()" in cpsw_ale.c).
>>
>> For multicast entries shared across multiple ports, the function only
>> clears the specific port's bit from the port_mask without deleting the
>> entry itself. This prevents any traffic disruption for other active
>> ports.
> 
> Consider two MAC Ports P1 and P2. P1 belongs to multicast group M1 and 
> M2, while P2 belongs only to multicast group M2.
> 
> If M1 is deleted from the interface for P1, it will trigger the 
> execution of 'am65_cpsw_nuss_ndo_slave_set_rx_mode()' function.
> In the function, we have:
> 
>      port_mask = BIT(port->port_id) | ALE_PORT_HOST;
>      cpsw_ale_flush_multicast(common->ale, port_mask, -1);
> 
>      => At this point, M2 would have also been removed in addition
>         to M1 for P1. As a result, Multicast traffic M2 from P2 to
>         P1 is dropped.

The scenario you have described applies to switch mode operation.
However, the fix specifically addresses the issue with the MAC mode.
The fix ensures that in MAC mode, multicast entries are correctly
associated with the Host port and MAC mode, and it doesn't disrupt the
traffic as mentioned in the previous reply.

I believe I should be more clear with the issue and the fix. I will post
the next version with more clarity.

Regards,
Chintan.

> 
>      if (!netdev_mc_empty(ndev)) {
>          struct netdev_hw_addr *ha;
> 
>          /* program multicast address list into ALE register */
>          netdev_for_each_mc_addr(ha, ndev) {
>          cpsw_ale_add_mcast(common->ale, ha->addr,
>                     port_mask, 0, 0, 0);
>          }
>      }
> 
>      => We are adding back M2 to P1 above, but since it is not
>         instantaneous, it will take time for the Multicast traffic
>         M2 to be forwarded from P2 to P1.
> 
> Please let me know if I have overlooked something.
> 

The fix in the second patch is for the MAC mode of operation and it
won't disrupt traffic forwarding considering your scenario.

Regards,
Chintan.

> Regards,
> Siddharth.

