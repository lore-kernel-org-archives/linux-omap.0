Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0202DECBA;
	Thu,  5 Feb 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291314; cv=fail; b=IgirKp/r+YzhaaqmzQoumBUE8LiSuRFiKIvEcayX1D+iiL9nG9RTnYTKASq/3C9LDYiptkjrIjtonA2ug5zNiZGXCjYDPbmf6jkkmpiFdRP6vrfZ6w6kuCRoqwILUGFI1oo+Sq83r4x7pyAvSlmNCwV1vQ3hP4ajyA3DIVMbfjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291314; c=relaxed/simple;
	bh=FwminPDg1Pbq+7wbYO8vg0LFEWrzWTIMwGAw7cJedww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IZdOoWZzpuy2w1WUSTVlOCf9+SmmBgBWRdn2d0SSrvxmn4cqBz0RTzbxvuH1OvBb3WNttIuGA4AYsfZJrUYZ8Nr7yKvNmpHJNL44w8UKRrR8axDM3fyeMkHwuHryMajbJh7TJnJoGkIfs2lA9Iwwg01ETS62vH8vG6j6oPVfJbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mpja+n88; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mpja+n88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXSlnHe0lvqBDEp5YeToX19MQLzW+INFPvQ+YsPET7MRWkVGI3h70ra89godsYMW1gQ3ZMS+/pSCy2iJB2b0P4qaM0v7B2XIXxG4dlYGZV92aKrk6GSfnZYHMJP9SwhhbDyCoWoCm+wfLcOsGwC1+35mwrWiHipA96mQwqlf6GtdNbFyg8NBpwL8jb5RsxZH8SZ8tcYOHdQLlNorzgztJIObrRksdM9Hjjg9wqwLGcEd+DTVEe76je+0jVpiLz5ZQVRGP7w1QT3y4jcdctpekXE8jtvLsLvCJbQoiFLhZs36kH9X1gi/rzuY4QzUSblWn4eLeVlXC3/E+mgwbEQMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdPUFZ1T3FjUQgJG/a5GWCN1Tpb1ONbKVsaW+lyMuoE=;
 b=hUqUkWcG/py+Rdcy7iemsS9qEgCZkwGbcOf3xCAxEexkGQKw2QfyQD+yrx/RoYgK4/ZJ7mdCXOg602wE5W3Y2KqKiri+cVSi/smEk5UgGk9M7ZaAOLjSM0Go9THjPzmHYwAUFUStSwZIFNlcRdVLRvvdoQL3KlDvtrOl/DaeBeGc2GMvU2eJ9eI+cwodNV4DVyP50REgWDDSDQXOHrOKnbc9ypqgIXtpk7KbJmpjE2ioLXOwz3CRWCPBu6BVFJN6hPM9Ql5FSEbZvuu+YzBQUO8QT8JffNwQ7lkHNcfZVfGGwsqQfiQjqHGUxcJVlhqB3X5r2eGx+pyXx5raKCChHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdPUFZ1T3FjUQgJG/a5GWCN1Tpb1ONbKVsaW+lyMuoE=;
 b=mpja+n88sNMEo3rRHzX1WlUNM1nj41BymjKnavzfr0nVxLNwOzdGroms+DAe8aCOPS5CtO4wEBsOCKLKmt7hSDgSMnKoj12HYCflq0mLvSG4dKS5LKPIiQHu670Qy8mcXV1VaySduoch7/9xs3cGAnKs0P24sIKqi7vlY6tv1ZM=
Received: from SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 11:35:11 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2d) by SJ0PR05CA0053.outlook.office365.com
 (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 11:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 11:35:09 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:35:08 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:35:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 05:35:08 -0600
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615BZ3U02918490;
	Thu, 5 Feb 2026 05:35:04 -0600
Message-ID: <fd5c557f-b6a6-44e0-b66d-8fd7defc7203@ti.com>
Date: Thu, 5 Feb 2026 17:05:02 +0530
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
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <83a867729ac8fa08709c52e2a357c97ef1bac27e.camel@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd0b0a1-66ae-410c-e209-08de64aa9e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TitqWVpwUGx1YXJJWHJzdEo5bGdQdmJ5QUFNWDljMlpsRDYzdzh4bE1kTTFL?=
 =?utf-8?B?U1pqWm8rWDhkdzg1UG5DY1BiaWNqcW1BZmp3QWVSaVhJNmEwekdzVkxKVHE1?=
 =?utf-8?B?bFVWc1o0eERObjFrZmFBaEVXM01DbHFmT3JrWURFRDJlUURvejk3S3N4MzFP?=
 =?utf-8?B?WEVHdFQrdXp6bXF2UGpMM1NYd3A1bU5md0xnT0NrSWtlYVAxS2lVWE1vNFpU?=
 =?utf-8?B?MWQzWlR2Y2VNalk2c3JHQjl6T3pEMUMwN2ZyRUo3eUgwM2lVRTRiSEZlMk1N?=
 =?utf-8?B?YXRWVEVqZGV6S3paVmFTVzdmb3ovZHZIRFhLc0RkazZJb3UyU2VDTmN4TE1W?=
 =?utf-8?B?Rk96NmZSOHd6TXBFd29XWTZUd1FTWEFzSmRGSWRoZTliQStkR3ppOW9Ucmt3?=
 =?utf-8?B?Vk1TaG1ickpaaXlvWjNaN0hITWRFNVh3T3R3ZVVxUTM5SWdkUGJzQkRWOTU2?=
 =?utf-8?B?aVBSVmpXR0Y3cmZGbHBFemErMGQ5cE52MStrMWZURm1VYVVYcnM0cDNndExn?=
 =?utf-8?B?bjB1MDdmWXVxZXRaQVVFY29oaG9lOU0yWThuUDR0TE5WdXZTNFRvTmVULzFY?=
 =?utf-8?B?blFrZW1IMElhVUsxNklkLzc0N0Qxb1hwMmRLRWpzMldSd2pGbEg4SXJUNERK?=
 =?utf-8?B?NWRqaktNbmhmcjc0MHg5YzdXbitjM21SS3ZRVVpZRWgxR2hjMDE5L0ZUZko1?=
 =?utf-8?B?cC9Va0JHbEd1UTdaVlFjY2FEOU10b2xJQm9UNmRiOEhvKzlyRXFkRFhnVWpk?=
 =?utf-8?B?cndsQXdVSWNlcHpPOUdRVG5vOVlBSVRPUW9LU0Q0a0R1SElhTi85ckZ1ejFT?=
 =?utf-8?B?aVRnM3NMWG95ZjRvSlIvajNURVJwcEZtT1A2R0ViVWdUNjVsb0dPeUxUaGlT?=
 =?utf-8?B?Qk5uK1dIcmF5cTlVR3pueGJUOVNRWDZ2NDZVKzVZbG5LbEd6UkZyUUFhaUkv?=
 =?utf-8?B?ZjBiT2RqQXU3OGx6aUw4NFdjOGdYSHExYU4vamJZb01IcWZNVllOaVRZTXJj?=
 =?utf-8?B?ZTNEWlFJR1FrYkhmSkRFQ0JSQnppT25iQTA4ODhjNmNWVHR0UThZWUVOdFRh?=
 =?utf-8?B?V2V5N05yOE5Qb0NmWTdxb1M2MlkzWnk1WmpodVEyaGxJcWFLclFMdEx1ZUpL?=
 =?utf-8?B?SGFoVzdVM1FGSlVPNzhXenY3R01yVktQb0M2SFNhMktVUEpyM3ZrSXo0MFlD?=
 =?utf-8?B?ckhqOWY1TWpsOUZKQnRJeHhrWXpCUmoweFZtaVNtVmhsZVNESWdWYmFWejJm?=
 =?utf-8?B?ckk0V3RqaGFvSWtiTWFxM1hpNGcxempKdVhWTEJzTHFGdmJyeVRlV25TTkcw?=
 =?utf-8?B?NmY3aUdxZVByY210NW5lZEIxdVZDaUpzTmpNSVgxdHNKUE1wZ0hwSXAwaUk2?=
 =?utf-8?B?d1JrNjVZK3VlZVdFTXVKWnA2dkFYZ0lpa2tzV3hHRklpSDlnZUJyMkY3ZnpI?=
 =?utf-8?B?MG4rZ0JjaEdnd3F5c3lOMzkyOTBnVGIxOHlOdzN2UVU4SW9GYm5rb2tBTFNF?=
 =?utf-8?B?dGRDMnFpTUNLVFhUd09kQVFYV29udUhPZlpvYTAzWk93dTkzek1JWGpXU1hV?=
 =?utf-8?B?Y0d5WGNESEVhNHdOOEJLZGx3K3dCVUNuNkxvV0kvSzJncWdTVFNFNWVsMUp5?=
 =?utf-8?B?UXN1Tm91R2k3dDZzTnFhTk5QRy9OdHJKRWg3QkFrN2U0NFlDK2Evc0lLZExu?=
 =?utf-8?B?VGcrZis3U2dwRm15MEdsTUQ5cFUzVEYySWtPTy9ldG5COHk4YVcyRUJiOW1z?=
 =?utf-8?B?Y285VGVSYjVIa1g2Yys1elFYZGM2RC9KRGxZQStGV0VNMnFxNVFrTWJVM0hP?=
 =?utf-8?B?eVJrOHEzOU5reEJtRytKczdoaGQya0Q4TWVjbW4yRGdSNWdOZVZwSWpDVkRJ?=
 =?utf-8?B?TFpXTy9aaGUzempGbDNVMkdZT3g5a0k0eTgyNGFodUR0YXh4UUlBdWp3OHJL?=
 =?utf-8?B?Y2RRYVRBQ01TZUlOZGNhVW5OcWt6bEFGY2t0cjR0OUIzdTlhOUE1WkZFcmZG?=
 =?utf-8?B?ZXprclFOL2JhWk1tTW01RW1paHhmZ1hEWXRFTVVlaU80Vm1QNUF4c1lmNWtG?=
 =?utf-8?B?eTFMMnVnVmd4Y2VnN3VqcGY5YUd6cVE3OGhTSTlYN3RDTnk0aCtQcHBlb3dU?=
 =?utf-8?B?LzJFcFUzMUhBM3h1blR5WUZ5bU5XTTJ0M2JGQ2xITUIySmdZVk5KKzVYa1p4?=
 =?utf-8?B?MWFBN2V3ZllzSk9oSnFwVUpQNDIvVzNJaVNMRlF3dzZZdUlKd2Jmd0JlbXFu?=
 =?utf-8?B?YWp1UXdjNk9Sa0pSeDVjcUh4UHR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WIgAEf+bAoB3cKs/yd/8ZxPqIxJyjQd92QGwoMiPEgsZJKksfsnMHfJJ6spfwLjVyVv5jwOHm27v6OeShr2FLsjfpAHNq6uveKLjPk+yaqVTmQyGv4RIU5gPsz7jiHivImpeTxmU4XvnGV45MWshDnukhdRe7bET/VaS85qWNsnhKD+xm+lVkT3/Tnqlo+CoTOsidPs9qHFzjaCWWg/fGNjqO+ZVRqgy/5CAvWdmqSvasFulgRl6hhX95Jgc8x+0WNiWUrWJMYXuXJLiJCftIKmRlbZblmmNl9/LMxjVW+0UCc1+Jy10cgb6shfpEcd5jgR71vlWPdGV/x/YU0jD2cEH+vWcYZ5+vIi2Bu+w8XcY0AoMs14jQPaDTZNGrdCUzc8Da84C5Z3Vn1WNR5hOmFn8JIP0Oul8QsMT5LPgd9WeVECSDYzL+SPUVlhwT3r9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:35:09.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd0b0a1-66ae-410c-e209-08de64aa9e21
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861

Hello Siddharth

On 05/02/26 13:45, Siddharth Vadapalli wrote:
> On Thu, 2026-02-05 at 12:39 +0530, Chintan Vankar wrote:
>> Multicast entry rules are mainly evaluated for receiving traffic and do not
>> require MAC ports to be explicitly associated with them. However, setting
>> associated MAC port's bit to the port_mask of the ALE entry ensures
>> technical correctness and helps maintaining ALE entries linked to MAC
>> ports.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index 5924db6be3fe..967918050433 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -391,7 +391,7 @@ static void am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
>>   	cpsw_ale_set_allmulti(common->ale,
>>   			      ndev->flags & IFF_ALLMULTI, port->port_id);
>>   
>> -	port_mask = ALE_PORT_HOST;
>> +	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
> 
> Since the port_mask setup above is passed to 'cpsw_ale_flush_multicast()'
> below, wouldn't it temporarily cause the forwarded multicast traffic to be
> dropped?
> 
>>   	/* Clear all mcast from ALE */
>>   	cpsw_ale_flush_multicast(common->ale, port_mask, -1);
>>
>>
> 
> The code in the driver following the above function call is:
> 
> 	if (!netdev_mc_empty(ndev)) {
> 		struct netdev_hw_addr *ha;
> 
> 		/* program multicast address list into ALE register */
> 		netdev_for_each_mc_addr(ha, ndev) {
> 			cpsw_ale_add_mcast(common->ale, ha->addr,
> 					   port_mask, 0, 0, 0);
> 		}
> 	}
> 
> So we do add back the multicast entries for the same 'port_mask' that we
> removed earlier during cpsw_ale_flush_multicast(), but, there is a delay
> between flushing the entries in cpsw_ale_flush_multicast() and adding them
> back via cpsw_ale_add_mcast(). During that period, the multicast traffic on
> the forwarding path between MAC Ports will be momentarily dropped. Please
> clarify if that isn't the case.
> 

When "cpsw_ale_flush_multicast()" is called, it only deletes entries
where the resulting port_mask becomes "0x0" or "ALE_PORT_HOST" (as per
the function implementation "cpsw_ale_flush_multicast()" in cpsw_ale.c).

For multicast entries shared across multiple ports, the function only
clears the specific port's bit from the port_mask without deleting the
entry itself. This prevents any traffic disruption for other active
ports.

Regards,
Chintan.

> Regards,
> Siddharth.

