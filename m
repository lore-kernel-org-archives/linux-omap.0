Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215533E35D;
	Thu,  5 Feb 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303760; cv=fail; b=F6lIYN7QMegeZF3AW0yyWlfcnQHJbt+FkA9AsWvH9QqLf26y+hXT7/0bLDbfPh+4WsbcAIetz3qT9+jNFbRD/ckgUswrMFT/juIHGJyYErTKz/3Dv5K5S629sRsWM3ceIb3srbdapt+RBE9dey8JPWyl27dwydfJCSKDDEQ45IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303760; c=relaxed/simple;
	bh=hp9RYjRJuGWnj5o3N9GrGPD3BbQAUS0uj45Nl2nP9H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OHyKsQU77vVwGpfW48/z91JNHA0abKuCcz+lLJwy87SR2C1M2gToukqiy7NADbNKGqGvD11qRTu+Yyt1cMj420KKNKVyT+aC579Wi+A3yspLLvM9nPL6oQ+aSLzbDSE0mpMuK0pijErFeVvDFb7MunsCZir5d+i+LQi/NtpN6vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L72mac4X; arc=fail smtp.client-ip=52.101.193.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L72mac4X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azrNHRQUSzHgs/e7gpb1iUJGakyMwxw4C0JFF28AbDtAQBwM8088w7cF5ECYSU5VTB4KO6a2uSKlxDE5hLdKdOzF20ErgGpK7OxEL0VpAn/C/w8Az0O5EmXeE2jI4/YtVHmG8nO7lusInW3nFvNJ70nOlmhMep5vj7shXQdze7tsnnDuGlaB2yYmGVXxezMrvfds4FUH50EMCHnmgJXXnfensDkZF6bzgXZCRKRsRyM2LAocgxg+QGlqEW3IuBA1Hcc8tXO5t+rbGOdhu1ByVWqYKBSS8O0UDhleD8CsEgheMeWmdg9zp0ET/QBHpfd3Q8w4V+DHQ9GzTxYfM9QVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rkPLHd4p4F/oKAe/mo1PxIcFAhhypKoUsaxO6kwf/w=;
 b=KHl4A7IZ3s/RoIqA+yrQK9AxJ+DKOQLTdcEzjK6499iCpQORHNDYqNTvEqqWJQWSKkG+HG74Hjy4hjkMOUuchxjU/wrEL9py6VGAS5xT4TyGS1twl3LXKVnh8j9QBcC8+DmrFkwfg0A7wCFwg3mMN5uMueYT44LPOj/ecuoDzBhfEfoe94edBFTNF1acqvqZIOR1qAO15Ty3EgYOYUR/HzBB79f6Zv9Alu6A63V62tGfSim9oeTWQiGkywlCTgqijwzbUHV1Ysx6h9DUx7Y51XBhHOAnAe8U5hDgeV3jJoS9fgTUgTaobNuKeGyfmqYUBoUSG7bXyfGB6XwtYdxeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rkPLHd4p4F/oKAe/mo1PxIcFAhhypKoUsaxO6kwf/w=;
 b=L72mac4XXobiECoU6eLtrLcfQdw/EgRlIGUjKG/2AY1mwyBW23u62873Bx7pbRfoMvXvVnlCLVBuvJWOIzvFlptqRkGO5uGBwTvDNSlTPTe/ZCBS651z8gB0YeP0hj2eKHcCEA2CF3YopazSFwcBn/BitPw6p7dd7n/vPgHeT+Y=
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by CY5PR10MB6192.namprd10.prod.outlook.com (2603:10b6:930:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:02:38 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::fd) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 15:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 15:02:36 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 09:01:59 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 09:01:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 09:01:59 -0600
Received: from [10.249.139.123] ([10.249.139.123])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615F1rVl3606912;
	Thu, 5 Feb 2026 09:01:54 -0600
Message-ID: <fecaeb94-c004-40f0-86e6-6b7c553a2fd8@ti.com>
Date: Thu, 5 Feb 2026 20:31:52 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ethernet: ti: am65-cpsw-nuss: Update
 port_mask while adding multicast entry
To: Chintan Vankar <c-vankar@ti.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Vignesh Raghavendra" <vigneshr@ti.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>, Nishanth Menon <nm@ti.com>, Michael
 Walle <mwalle@kernel.org>, Simon Horman <horms@kernel.org>, Roger Quadros
	<rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20260205070951.3170631-1-c-vankar@ti.com>
 <20260205070951.3170631-2-c-vankar@ti.com>
 <83a867729ac8fa08709c52e2a357c97ef1bac27e.camel@ti.com>
 <fd5c557f-b6a6-44e0-b66d-8fd7defc7203@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <fd5c557f-b6a6-44e0-b66d-8fd7defc7203@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CY5PR10MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9c7aa4-c71e-4a39-ea0f-08de64c79931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3Z4MGhzbXJOYm1zQmg5MzlMOTVDbXArSW9xVE9POWVjLzVSOXFBQUJKOWVs?=
 =?utf-8?B?UmZuU3UwakRpM09HOGp2OGJFWDhyTnhtaCtjYU85NkNHcStocElXV3ljZWxh?=
 =?utf-8?B?WWtGMS9HK0FJSHJYUDVZeHN0VFkvbXdKTVVXeGJqdjF3OXVlNkpKSVg4ZmRn?=
 =?utf-8?B?VG1MSWw5cWZyM2grU3hnMi9oSXRIdlRZYzN6OVRLNmd6eG12Y0R2M3RLcWNj?=
 =?utf-8?B?MXdsbGNwTU5hU00zVnN5d253bE1icVUyOStKQ0dNVzZaRGc0Z3ZHb2h1UnV2?=
 =?utf-8?B?UzIwdGRFYXVXZHlhQXBNSnpWTWU3aU1ZczZVeEk3a0VIOHI5S3U4b2Q3RlFU?=
 =?utf-8?B?NngwRkZ6bzh0L2tsSnVMajJNSkRidG94eFNYeXhvUERJeVV5WVdwUmFOZzl0?=
 =?utf-8?B?UzJNanJaYXd4bk1qejc3ZER5dEFQRG5LMFFaQjhod0hibGdPYVFESFpaNjN1?=
 =?utf-8?B?dkh0WlBlVW8wNEEvakdJQ3lNMHBBTUxLeURoc3IxSWJ6ZFBKdVEweFBTODN4?=
 =?utf-8?B?TGpNVFd1QmxRS2RZeitKSWp6dCtCZ2FtemJJRWF5RUJQMVpKYldHSVJJK2di?=
 =?utf-8?B?NW5nRGltYnlpWkJrb2QrTTl1V1AvSUVwWVQ5bVIzdWUybXBEeVJ2b2hNdTN0?=
 =?utf-8?B?czRhbExJWTBhVW5UU3kvUzVDU0VSMXpmc0QxR2lFMW91TDFhaDg0TzhFZElv?=
 =?utf-8?B?UFJsUEFDakpXUGp4WFZYV3NBSHRNYU00ZmJRcGZ1ZTkybERRbzdUaHFZSmlR?=
 =?utf-8?B?TktMbnFDZFlFOCtiTldHUENaK00wZzdkNDliaHBnaGx1UVNRcmxJYzM2a2ZK?=
 =?utf-8?B?OEhSUDRYaWgrLzA4bTlaMjdUT3RObDdrT3VpanlURzBDQmJ0TVlKZmxpeGts?=
 =?utf-8?B?eG9tVUNXdm5RTTgyalBoNCs0SnhjczNjNkcvN0J3d2RzSWs3dHFEenl3VDBh?=
 =?utf-8?B?YzNlS3F3ZjZRYm5zN1IxNW9IUUw0OURtMTVDZm51T1BZMk5rT0JVZWMwYXEr?=
 =?utf-8?B?aFpLdHRZRHlNQlVkRW1PeThCRTZFRVhaQlhuQ1ZQVEFiYzU4MGY0ZTNqNDFD?=
 =?utf-8?B?WEh4WVdzR3R4ZUxZU2ZaTUZPb3JHc0hJcTRIWDRzaVVsYzQ2bCtCQU5ZNW9X?=
 =?utf-8?B?RGtXRkJDVUxwQndoVDh2bWtmeVlIbVpSSS9IaHh0WHcrdDJHclVSeGhMVEpy?=
 =?utf-8?B?TnJWUnkxR29tWDRHWlB3QWtOT3JEa1RPa3gvU0ZkTGRuVUJ0WFpNNzBGMGtE?=
 =?utf-8?B?QmpQN05tSi82ZlNLbU53akZVMnRzYTlsblVlYWlLU3VVVWM3WSttNmMzcGs4?=
 =?utf-8?B?YkVjU2ZiL1E4anZuQ3NEWGxvZmNUNXQ4elNsRVl2cEErK2cya3JaTDlCTVRy?=
 =?utf-8?B?MTlWY09hMENyMnloQ0VFY3pXbnVqOURUZjREWWZ5Q1JuUlIxVEhqS3k4ZUNv?=
 =?utf-8?B?enBTc2doRU12N01USVdOdEJkMDNJV25sQzBEZk5LZXN0L0FYaXlrakVQUmZ5?=
 =?utf-8?B?bjVUbFppU1ZWbHVDUUZ3NW1Ib3lGSHh0OElFWlZhV1ByYTdDVHg4N0djSmUv?=
 =?utf-8?B?VFJPeXdzaDRsZ3NDWXJodDB6Yy9HLzdLeHZ3M0dXZ04wYndUbE1lNy80di9Z?=
 =?utf-8?B?eERaajg2azE4ZTlOd3ZWS0MyK21DQXdpRTR4VnhYaEkwY3RGK1hhYWxWM2wr?=
 =?utf-8?B?c0hWMGhPdy9KWEVVSVVxQmdsenE5KzhGb2RaRnpsc25Ra1Z3SmVVTjNHK2J5?=
 =?utf-8?B?NGRvY3Y2Qy9DK0RSNWt4NGRTalRjVG1TcC9JQWxIU2pHVVAwQWRudEQyMTVY?=
 =?utf-8?B?WEE1dU1iL3V3eG01M3RkZTVDR1pYZklYLzNQVzAwNzNSQjg1RWFzdGU2eUow?=
 =?utf-8?B?cSs1eU1MemVVNm80NEQ4UllFbFNSZ08yOTdMZzNjUVF1aURlMXB4TC9BRWVP?=
 =?utf-8?B?ejJsK1BYSHk4aUs5RlcwQTBzZ08zdXRzOXg3WUp2RXpYNm5WS2doVWNNd1NS?=
 =?utf-8?B?Qzh1R0t5eWtEamM5UlFMUnpCYmUrNXFmNGNSWWNyZ3hUYTRjR1RaVWsyanlk?=
 =?utf-8?B?Qjh2a1MxUDQ2b2lwQU9EZWZSeXlqbWhWQXZEWER0dFZjREJzYXo2TFlocnBt?=
 =?utf-8?B?U0hWTEd5bzd3Q2NWSG1OeFN5U2lxNWxPNVVaTGk3UnBRejRNcm9kSnltNGpw?=
 =?utf-8?B?czNVWXFacTZubXFBcytXaE1qY1NtNTVjNTJiNmwxYktxTkVLVEZkYkFoMEVy?=
 =?utf-8?B?T2NnWkV2SEMyeHU2ZWM3Sk5LemV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NS0Zb85vlL7GAL+NMSQLljLo7eJU6/jI18D2F0WPz3NMo8cDRxdJR6R6psa0fnM0Iw5cyWZlkAB9cBBFstu2dsXcpoLq3UoYVPojC2ogsZyh4M7iMLDmHgzxAHgsUlMgrK/22nFONXAS7Mi2t50KKzw8uZieLvC0zJM7IyekfH1B5KZ4xVPSxh5mzcWZGda7ya43qP8HQPoCqpNZ1hihxSfeLpF7sEWkwBNbYDvzBsS1/pZkTCJQHz8UbNZtmUaV/dAKPwx/p6gb08GgxMDus4KaX7K3PQAAcfYLopKYeR+Ff68XxlC7hMeGAOOWtiBXbebv3UbcRvije0TS9/WElaOfsy48zBXV99bBWmg0HpO384UgvlWU3QCXpmUgPgOEwNG5w8KVErSfpEeF0hc1rMhi/8+C5krKrIVGHnuZqycZgOLqKkJ7kangx0NEG2/H
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:02:36.1793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c7aa4-c71e-4a39-ea0f-08de64c79931
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6192

On 05/02/26 5:05 PM, Chintan Vankar wrote:
> Hello Siddharth
> 
> On 05/02/26 13:45, Siddharth Vadapalli wrote:
>> On Thu, 2026-02-05 at 12:39 +0530, Chintan Vankar wrote:
>>> Multicast entry rules are mainly evaluated for receiving traffic and 
>>> do not
>>> require MAC ports to be explicitly associated with them. However, 
>>> setting
>>> associated MAC port's bit to the port_mask of the ALE entry ensures
>>> technical correctness and helps maintaining ALE entries linked to MAC
>>> ports.
>>>
>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ 
>>> ethernet/ti/am65-cpsw-nuss.c
>>> index 5924db6be3fe..967918050433 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> @@ -391,7 +391,7 @@ static void 
>>> am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
>>>       cpsw_ale_set_allmulti(common->ale,
>>>                     ndev->flags & IFF_ALLMULTI, port->port_id);
>>> -    port_mask = ALE_PORT_HOST;
>>> +    port_mask = BIT(port->port_id) | ALE_PORT_HOST;
>>
>> Since the port_mask setup above is passed to 'cpsw_ale_flush_multicast()'
>> below, wouldn't it temporarily cause the forwarded multicast traffic 
>> to be
>> dropped?
>>
>>>       /* Clear all mcast from ALE */
>>>       cpsw_ale_flush_multicast(common->ale, port_mask, -1);
>>>
>>>
>>
>> The code in the driver following the above function call is:
>>
>>     if (!netdev_mc_empty(ndev)) {
>>         struct netdev_hw_addr *ha;
>>
>>         /* program multicast address list into ALE register */
>>         netdev_for_each_mc_addr(ha, ndev) {
>>             cpsw_ale_add_mcast(common->ale, ha->addr,
>>                        port_mask, 0, 0, 0);
>>         }
>>     }
>>
>> So we do add back the multicast entries for the same 'port_mask' that we
>> removed earlier during cpsw_ale_flush_multicast(), but, there is a delay
>> between flushing the entries in cpsw_ale_flush_multicast() and adding 
>> them
>> back via cpsw_ale_add_mcast(). During that period, the multicast 
>> traffic on
>> the forwarding path between MAC Ports will be momentarily dropped. Please
>> clarify if that isn't the case.
>>
> 
> When "cpsw_ale_flush_multicast()" is called, it only deletes entries
> where the resulting port_mask becomes "0x0" or "ALE_PORT_HOST" (as per
> the function implementation "cpsw_ale_flush_multicast()" in cpsw_ale.c).
> 
> For multicast entries shared across multiple ports, the function only
> clears the specific port's bit from the port_mask without deleting the
> entry itself. This prevents any traffic disruption for other active
> ports.

Consider two MAC Ports P1 and P2. P1 belongs to multicast group M1 and 
M2, while P2 belongs only to multicast group M2.

If M1 is deleted from the interface for P1, it will trigger the 
execution of 'am65_cpsw_nuss_ndo_slave_set_rx_mode()' function.
In the function, we have:

	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
	cpsw_ale_flush_multicast(common->ale, port_mask, -1);

	=> At this point, M2 would have also been removed in addition
	   to M1 for P1. As a result, Multicast traffic M2 from P2 to
	   P1 is dropped.

	if (!netdev_mc_empty(ndev)) {
		struct netdev_hw_addr *ha;

		/* program multicast address list into ALE register */
		netdev_for_each_mc_addr(ha, ndev) {
		cpsw_ale_add_mcast(common->ale, ha->addr,
				   port_mask, 0, 0, 0);
		}
	}

	=> We are adding back M2 to P1 above, but since it is not
	   instantaneous, it will take time for the Multicast traffic
	   M2 to be forwarded from P2 to P1.

Please let me know if I have overlooked something.

Regards,
Siddharth.
