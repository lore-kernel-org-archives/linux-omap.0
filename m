Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34826348445;
	Thu,  5 Feb 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279266; cv=fail; b=ryEypv6o6lJIo+gCWZ5TTUgqsgtCos/ImhXPwdCKNct76OP7NWelVlanPyKP6qNO94k+5ZePcSbPyy5QVMwwjP85JB6p1cL/UtbRF8ZPQzRLXdthcEwK1z5/7ffWwRn0PGh0xvp6pVJbDc37okmu9VXEXh+G27hvROwIlJLqq3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279266; c=relaxed/simple;
	bh=I5jiOsJL+Tebapqv9nazQqIRQt9HW+9VQXh5ToxZpJk=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nON3P0fRJRsjfb+xJYl8Cb5aE35ddgfJyQxmh0RODLLgP5ToYZmeMYBSfdRSHT2crZ39C5zR4jdCiISFcWzAfAMPhGeQXNGOubg2OlUgVZfxEVybElSEXtQ05sGKDJiFm/veAv3b371skYk3YyttaIkL5ofGJK3pSyH3x/jl/P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v1nEBPcb; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v1nEBPcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq4Y//orXNevq+3tw7QaJ0UNz07cKBxtX0BE00DdqqD8+A0+yIQ1AlBb/7y3YNHwTHHONWxfPOugIcHk1zEsYjwnvF8RXqu6pH1DvQoUPVPz8pN+E/mmKlBXSiz+21WZn1jZfi4j+s/4RAEisPGh0vcMD+zVeJgexWZrIgv41hbTek1zkeNPp0UIdF8BYU8uvbPjjZjQv1qtyh/yYgpYuM8W/cF0GJZ1wDNLLPnX3oXbPneVRj/gYz132e/CrzYBy/bNqgUAjbscIoJuecabUf7TsavO1us3tgkm9xVLNuSfBZL8nmPszRdgyQK7k5NmJwIbxBGFhnMHPyCeuc2Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Dmenz4zmNSiBtWgjXH4/vhqOQCFBZ8IDCvp+wa/Vw=;
 b=nHrFscKdftaW3tHJyNNiMs3YxUCG/CfNFiHd2/0BWTYRkxtWuQQqZqbb35HOEgbDcW+mKxCOsOsbGI92rjNKVke5hkQ4hA0IxVn2udpUA2gEQ3OP9qCU6PzOtMiQMWavQ9liqFxTYOekF94OlSvddRDL2TtWt8t+oXivbqMMZZOqByhhRhsQsR7wtkXcOVEAp/u+J7j3DXgmde6uxFurqYcv3LJexC6esEGET9ZFTaXVykckugtOKTNni4JfDsmPLQ6ZY9FT3ZxYCT6DUQ2aJsl3vmpQmXuZeIaj7Xi6RpyBi7nvy5YiURZ7yjD+McDaMzpApb/ws5QI3zQyG6jROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Dmenz4zmNSiBtWgjXH4/vhqOQCFBZ8IDCvp+wa/Vw=;
 b=v1nEBPcbTLurA0IAiOeQDKgIC0DmzuIznVMypTy9Q5n53I1F8qy0RGmN3uBbUhHfR+2ZSvptIPdYky3Bl7lNpkgVkzzrGgogATk1064oBGPF4DTEnHvpWzcs89yuYzCnn1HfALi4jEPgL/GRc1SYsbA4O5Db/UdWSzLU/+bGDOk=
Received: from PH0PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:e::14)
 by DM6PR10MB4219.namprd10.prod.outlook.com (2603:10b6:5:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:14:21 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::58) by PH0PR07CA0039.outlook.office365.com
 (2603:10b6:510:e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 08:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 08:14:20 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 02:14:19 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 02:14:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 02:14:19 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6158EE8f2652079;
	Thu, 5 Feb 2026 02:14:14 -0600
Message-ID: <83a867729ac8fa08709c52e2a357c97ef1bac27e.camel@ti.com>
Subject: Re: [PATCH net 1/2] net: ethernet: ti: am65-cpsw-nuss: Update
 port_mask while adding multicast entry
From: Siddharth Vadapalli <s-vadapalli@ti.com>
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
	<netdev@vger.kernel.org>
Date: Thu, 5 Feb 2026 13:45:38 +0530
In-Reply-To: <20260205070951.3170631-2-c-vankar@ti.com>
References: <20260205070951.3170631-1-c-vankar@ti.com>
	 <20260205070951.3170631-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM6PR10MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: e88f5c3d-31e3-4a4e-37f7-08de648e9056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VVWEVWYzc0N2Z1N2g2Rk5OcWdHUzFUQkVoNmwxdThYN3FNZjNtK1lPdFdD?=
 =?utf-8?B?ekdtQU9Udk9MRFRhOUpMNHBwT0plZVFoRGF4NEI2ZUpqbnNUUkU2K1FaZ1B5?=
 =?utf-8?B?L3FEUjFtT0U4dmY0QVN1T3o1UHpyWUFZakpURDMrKzJialkrdVpkWE9TaFRT?=
 =?utf-8?B?Qm5Qa0lZYVZKT3dRTmh0SlJLNnFGWmIvVTkyb3ppUzJXbStacmNmcHNRcmNK?=
 =?utf-8?B?VHNJb0tnaUh2Z0RQckVOS3RPSlFDeG11RFBxYSszdWpVajZYTm5FVXdlaFhz?=
 =?utf-8?B?REp1SmZuczBGOTloZnZDVmM4enVNZjRsMTRJd2diMi8wS1NhaHdxV2xmUFdy?=
 =?utf-8?B?RXFzOEdjN0JtdCtJTjRnWmpPZFp5T0tiWEZDRXBJSnk3OVdvZVpYWWNwSk04?=
 =?utf-8?B?OExTOWxSMTNOOUhZdHIzS1dJQmlrRy9IK1RLd05TZzFJQ25JcVh4aHBnNmFZ?=
 =?utf-8?B?aTJPSkN0VkNNaDgrbFBhYkN4U1gxT05aSm1JTUhxM2VHOTBFd1JTSi8yVFdB?=
 =?utf-8?B?SW5CRzVXeTJ3ZXY5bnRWQXdWWGk5cXRvRjVQS0tzbDdTajBnWGQ4Unh3NGZ2?=
 =?utf-8?B?WXRyeHRISWtnbEZZWFB4b0NwSlc3YU9XTzF5Rmt2dkdvOVY3N2lGTlExaGpt?=
 =?utf-8?B?bHB1MzBSVGUyWkFvNkNyN0h0QmFrUkdkRDlWVFp3WFZ5RzBQRG1zK0cwRTA2?=
 =?utf-8?B?UDBPVSsxMVNyUUJ4cE0raEk1MXVwakpDY0tHL3pORmt1RUlFMGJldGhacFlx?=
 =?utf-8?B?TkViM0Z4dGxpYm11dml4MFBMWGJjaTNDc1cxYUVBeFVuYUR4ZkdiUzVJMlN3?=
 =?utf-8?B?NmgyVlU0ZENPM0NJNklGUS9rcTJubGxkb3FzVkxkU0Q2b01Nei9ualdWVHZD?=
 =?utf-8?B?ZE4yQUdJVy8rME9hdWFycDlPdHZrYTYzdEtveEZ2Y2VFKzNGU0YwUTdXOHFF?=
 =?utf-8?B?TFZJV1l1aWxxbFVoTE5UWFZkZFk3dVEvNndYa3dTaUh0MHhZbFUwQVBQMkF2?=
 =?utf-8?B?OEMrUE1vMnFyeld1eVRSN0tQa1dSM2JKcWNXMTVwSjRYaHNoMFBLZS9sZUl6?=
 =?utf-8?B?aGNSd2pkNlRjSFVRQmlMWkdnQXVES3hRVm11cUQvck1xU2JZRjNXOVZRZGVF?=
 =?utf-8?B?aVdUV0lZRURsdzR1Wnl2TWVxSFNNQ0NqQ203ZnRiY2g4WkdreWdacys3cmhy?=
 =?utf-8?B?eEdpNXpVTFp4UzlCRkJaNlVaWkNkSlRSaWM4blNvcTAwd0VIWWhjbktyZGRp?=
 =?utf-8?B?UWljTm1zZExYQ0xCWEpYWjVicVVLMGlSUVcrbkJrY0hHMms5RjlBaWNRTjB4?=
 =?utf-8?B?dDRENjYwVEJWNWwwVHVsc3hrVGx1Znh5VjVVWmtCUUJKQzlaNlExNDloaWRk?=
 =?utf-8?B?NE9SQndnMTR2UmZsUGlnZWltWnNqY1FMUjllQm1XTTk2eDIyQ2NESjR0RFAr?=
 =?utf-8?B?aEdlT0tRSElBYm5IeFJhU1VRQzRaTHUxNGtTK2tWNlh5M2J1b2RuUlZuOUwx?=
 =?utf-8?B?L3hRZU5IZE9EM0F6T05DMWxqcmxxeGFlTGRYbG1kSUtpNmJlU0RDRUE0ckxr?=
 =?utf-8?B?SlNrKzYzc0RvRWR5YW5iZGRBWFNrdnpYQ3BSUXNleG1xbmkwa2pmSk9raWQx?=
 =?utf-8?B?bDZpM2xCdWZoajh0ejJsZzJVdXRXUmdEMzgreGMrZUdIR0tWbm8wbFVHc2xq?=
 =?utf-8?B?cllucyt1M2FEL2IwTmp5QWxwZ1ZscFdZd2tlRjlwbS8zaFl6V0Q3alFueEQ5?=
 =?utf-8?B?RGxwTVhJeHdtdElGZVdmRFQ4K0hubUVlSFg4Z1AyaGRsWnNRZzB0bm81NDRV?=
 =?utf-8?B?VTF1MGpseWxvNkF1cTZiTGRUUTJ2c05SaUJmeVc3TWYvVmx3Y3c5Tm91Qm1t?=
 =?utf-8?B?ZnVkNitPQ1hpWGovTlFJOWFwVjFhZFMrWE9rdFNieWtBNWp6VWpuNkd3RG5M?=
 =?utf-8?B?UTFmUnYvdXlVVnZXaGkyZGJSNkNxMEx1OTByYkUrc1praXl5b0VDb09WK3pa?=
 =?utf-8?B?LzJyaTI0cTl6Z3R4WHR2U291TEdBMTdFeEtsYWlYZnd2QWp6b0xVekF6R3NC?=
 =?utf-8?B?Y2JITWVxd0VHMWRzWG8rQUlnVDJnZGRiUFhHMzhzYWxRNFMwZVRqdDdYSElU?=
 =?utf-8?B?bDRvc0dqNE9YZ1VkQnl1L0lmQ0o0elpBdUNOdmRFRlkvOXl3YnVTRFUrL21S?=
 =?utf-8?B?Njg2U0thVUJ3K0ROazU3elVXdDlvTVBkd0tZZDdScHV1cnhGQkdpMkZITi9m?=
 =?utf-8?B?S05UOCt5N01KWTZYTGd5akZMM09BPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VL9gFUahfasBZvbvpP+tV+6nQ22aMsglyayKPyvPY2qMT+YFv+Ky8I1dKBjeWaYaS9oILZftXjgMKP85pimmy4CSvHGAVMf6rxo+WUhWDFEspvuFFvmhcgJT3gGRluMcWhjtZJtwVQTxLiVOXMxBFcLF2WR+uuQwT2xQN7SJ5x45oSCMqyjs3AggPNSc4OufqfBdxJdia1dwoLFppKvjJNGTiZAONLUnFbzs4CmyaoVxBwI752LY9Z90yfaby3MndxZnOsAZfRYo38W0Fs27xEqRXFWV5TRDFoE7PUz5nyZFiA9Soz549HfNgkLLrp8XcH/pIop5VOeJMjEEBiPqsZIgiSy1YpsMLgwCp4yUJG3csha3/jJV8NhzKjcuLeP5DANs5OhmlGXUw/77VESUFZLt1MkwZQ3QHGRxYZOtLNv+tWkrQoB+cyO8E6jeDhzU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:14:20.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f5c3d-31e3-4a4e-37f7-08de648e9056
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4219

On Thu, 2026-02-05 at 12:39 +0530, Chintan Vankar wrote:
> Multicast entry rules are mainly evaluated for receiving traffic and do n=
ot
> require MAC ports to be explicitly associated with them. However, setting
> associated MAC port's bit to the port_mask of the ALE entry ensures
> technical correctness and helps maintaining ALE entries linked to MAC
> ports.
>=20
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ether=
net/ti/am65-cpsw-nuss.c
> index 5924db6be3fe..967918050433 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -391,7 +391,7 @@ static void am65_cpsw_nuss_ndo_slave_set_rx_mode(stru=
ct net_device *ndev)
>  	cpsw_ale_set_allmulti(common->ale,
>  			      ndev->flags & IFF_ALLMULTI, port->port_id);
> =20
> -	port_mask =3D ALE_PORT_HOST;
> +	port_mask =3D BIT(port->port_id) | ALE_PORT_HOST;

Since the port_mask setup above is passed to 'cpsw_ale_flush_multicast()'
below, wouldn't it temporarily cause the forwarded multicast traffic to be
dropped?

>  	/* Clear all mcast from ALE */
>  	cpsw_ale_flush_multicast(common->ale, port_mask, -1);
>=20
>=20

The code in the driver following the above function call is:

	if (!netdev_mc_empty(ndev)) {
		struct netdev_hw_addr *ha;

		/* program multicast address list into ALE register */
		netdev_for_each_mc_addr(ha, ndev) {
			cpsw_ale_add_mcast(common->ale, ha->addr,
					   port_mask, 0, 0, 0);
		}
	}

So we do add back the multicast entries for the same 'port_mask' that we
removed earlier during cpsw_ale_flush_multicast(), but, there is a delay
between flushing the entries in cpsw_ale_flush_multicast() and adding them
back via cpsw_ale_add_mcast(). During that period, the multicast traffic on
the forwarding path between MAC Ports will be momentarily dropped. Please
clarify if that isn't the case.

Regards,
Siddharth.
