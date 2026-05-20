Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D73DCDA3;
	Wed, 20 May 2026 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276296; cv=fail; b=XYhKxU91gw5QiA5A7OSKGq4Y1utYmvKlAHJ55CTdZOflKKiubH+Htj5wF3SPDiqUU16tCJI/tYNe9XoE0zor/+L127tPJIUsTzIRhawPWRSu0yCY3Nk+Q9UF+hHMQjxA9VrgwiT0+p02qZLEjqx1quSBYH0LOAqTYOjWJyyWTdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276296; c=relaxed/simple;
	bh=xyqRmrc/SoHMS9DvjiiPmMdpYcUlSrvPaeBzkyLXZh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GWfRpF0QpGiFOjo60Lg9be9WKrXQ8+AoyudhysFVaWCbUzSPHLG8SZCsUXnFHZyq/mxfDSKDeDaveBBZPaskE3AZnV03OT7lD2xP9tbj6j92nam3MVxWbZvmL2x3aWQ0cKhxEVgpk5ggaTFYKR8286MzWvTW2/gX6jkO/U6RSmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OWqINoQY; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OWqINoQY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G597oNL0K4kCmUz5hLEOTQKwLpA8aRNlbVAW5hbr1wwhy5e5vTKWN+fBL5jtu7wAXuf0Zy9VYjJ9NE8r8mEqO4SMeh355wwbsPqFV9nWdpPu/Egw0PxIqceR5e3c+kqv1T7F8f1OyVhUIEIJtm1WNISzSH1NTwuDbXGRYqVg6cSKhjRP7uZuceNofgaRlukaaKwxZl4k1jYFTp5PUECGSQjol+G5VGy5o0qrPCaiRYUlyqlapDul46Td1KVvDLYBQfI2ZXcGMillU4utxYO1AaMXLDvC1RHoUqLzPi7veaPNrDhne/VW9epiHotB1Ok3Ftbi72ofhZmEZ0sVipcU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEWWEUGyXIpYjIqB2rL6YOnMSuAZRG9G/KZjSdGWEEw=;
 b=dER+kQwcVvOALInloKzQQOqqp1e2Hw/mPcpULXpq6HC1uGhdRfIuTkr2BZjWFESkAoS0DXUj1jU71gE6m2WkSQotNf3CRSRaIgAd4ldIY25wqhKJ87pFuzv+NS3rayrHX57uoy91jewuBCY/t2oH8JhFyNyRwozre4wmpogKl97BQ1rqULdQvxRmEMY0irYnD9/q16n/i9SpvrP3Mt0ekNV0Hjq819yhvSNk2Hn1j/msWMlbGxhN7aCd/9UYlR9JtOWp9KiW/811YbzH9KFBRDOnbTuMI33Pp+aXFEZ1dJMevWvu6yZFgJZJyuRPvZQYZmKX6cWl21isS076nAK4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=couthit.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEWWEUGyXIpYjIqB2rL6YOnMSuAZRG9G/KZjSdGWEEw=;
 b=OWqINoQYu2yRm/SSiyACQozpbRy1k/DP9d1SWuI/jvve7lfGgtOfCSh1p1iTIUUNzESwwkjP0Nm2c9HDtvL4qwNHSmDDcyTNqxJp+imEx3W+dTcIP2ccjTEN40G9HoeFxLNMQMcPqgnpxxrhrvzayOi4yHkmR2L012jliBWqxLI=
Received: from BLAPR03CA0133.namprd03.prod.outlook.com (2603:10b6:208:32e::18)
 by CH2PR10MB4247.namprd10.prod.outlook.com (2603:10b6:610:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 11:24:52 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::5) by BLAPR03CA0133.outlook.office365.com
 (2603:10b6:208:32e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 11:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 11:24:51 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 06:24:51 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 06:24:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 06:24:49 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64KBOfl51864530;
	Wed, 20 May 2026 06:24:41 -0500
Message-ID: <60dfd918-876b-4b3e-b18f-9d27dab3b455@ti.com>
Date: Wed, 20 May 2026 16:54:40 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add support for ICSSM Ethernet on AM57x, AM437x,
 and AM335x
To: Parvathi Pudi <parvathi@couthit.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<afd@ti.com>, <khilman@baylibre.com>, <rogerq@kernel.org>,
	<tony@atomide.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>, <aaro.koskinen@iki.fi>,
	<andreas@kemnade.info>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
	<pratheesh@ti.com>, <j-rameshbabu@ti.com>, <praneeth@ti.com>, <srk@ti.com>,
	<rogerq@ti.com>, <krishna@couthit.com>, <mohan@couthit.com>,
	<pmohan@couthit.com>, <basharath@couthit.com>
References: <20260428072046.3022679-1-parvathi@couthit.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260428072046.3022679-1-parvathi@couthit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH2PR10MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 010c22d4-1d37-4dbc-41a8-08deb66268ea
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|3023799007|921020|18002099003|22082099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	wRBAgxmYRkhDQHaSZzVOxQ/LFHh5O3c2lj0Xss5HFfGDJeyme9ZlQ6oNep1aZLmaGY62x5RK6Qi8gwlokzVT11PbnvYAZqcVV9eK0jdwzRbSatFrWGN0AksaBe4z4gR89aQHAkUtwb9mmvlhuBic39ggSj+jQqIN9uZnSyNhtShyw/xnKw6exjI4Oi9IiLM+OBWhkwdZnyeIHBcWuEyps0Y1GdGcl4igWaqaR7+2/N8VMv+cbQISDeaShDRbfBIOwzHXUhdeOPNnq/Q/M/NkUsy4T5L0LYDN4mPqtW5E4Zil67y4PEEaRS8BDNuyc2x/sPU6JgG1SnHYC06WAtDeZrUzB1BN5vbrXar3FpAiKG4rcXzXdmNchMxHLuRvkTNVVJlVpNo0Lk1jIV9ssETWZMXkfY4xvcq9hXMk6uZYoyt6NJ3DyOArR0KAqoYqeZrWk4z0Ep0EhHvEKR06ww7wjQDkJB+a1zAhCaVe04FGBVzj3YADLNumEZEb5YkDJLJV9wzxeTD38in1tFqZvV4tOOZj/V7AUHfGu0bERKClAyX1aPQj/r/T48/4dDJ6jYj/vxMeRk4WL7Hyxe59zAZvDroj/i3/zXJ3/9BayizW2GAMqGPYXP5NnkICX1OT81QEDFaLI7G8Wuo9G9vlXXv3urTNNQvf8CEU0z+njNpiIdvXX/PhFl5hCsU8AUFs86qP+2e2WxIBGfOCKs6f4phU/meUCr6oiwWneUNPFKPfSQKBrB4K90RUG0XNvw78o832OBD1ab9Aq2mswvMkvGCukQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(3023799007)(921020)(18002099003)(22082099003)(56012099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YwAo5eOcjqSFiSAhXyfxPuX0m6+C1U9c4QInqJCUnclUT85999cBPkLIEJ5++oOXNjUC1bPwlTu5PzRZMl5VCTJ6iKz3G6YvNiH4HbpBeXLY2Ty6NLZkR5pLHawTbxOApkk3hZlb/MUDa/JtNhd8dsb4XhNq7WzRvKY/mB+u1QBvTRpj9Y/sTsedS8RaJjUrcLxJpoIc0IgUa8xCeD4ErN0VFcsE59Pt2jXEWNZQFOowD5ciynZ+gtLabnzog8aS6owHGayJglQS9gNwHjpd0RH7JaUcZRl5RUf5HFAW47lfCICqjqLPtwilIOqAaJgyQB7yPWJCLPLXs6GW9WBULD+/mBBXXFUuESFOUOiVLBimoempis/B8EGAGKl/iuZT/361Ve4e44FN0aF2Mnd4Nxl+SDFFRFo705uwScyX2CPL6l8IhtMVro6z89+l3FDn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:24:51.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010c22d4-1d37-4dbc-41a8-08deb66268ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4247



On 28/04/26 12:47 pm, Parvathi Pudi wrote:
> Hi,
> 
> This series adds support for ICSSM Ethernet on Texas Instruments AM57x,
> AM437x and AM335x platforms.
> 
> The AM57x and AM437x IDKs support two PRU-ICSS instances, each consisting
> of two PRU cores, with each PRU-ICSS instance capable of handling two
> Ethernet ports. For the AM57x platforms, the PRU-ICSS2 node has been added
> to the am57xx-idk-common.dtsi, while for the AM437x platform, the PRU-ICSS1
> node has been added to the am437x-idk-evm.dts.
> 
> The AM335x ICE features a single PRU-ICSS instance. A new device tree overlay
> source file, am335x-icev2-prueth-overlay.dtso, has been introduced to define the
> PRU-ICSS node for the AM335x platform.
> 
> This is v7 of the patch series [v1]. This series is based on the latest
> next-20260427 linux-next.
> 
> Changes from v6 to v7 :
> 
> *) No code changes were made, only the version was updated.
> *) Rebased the series on latest linux-next.
> 
> Changes from v5 to v6 :
> 
> *) Addressed Kevin Hilman, Krzysztof and Andrew lunn comments on patch 3 of
> the series.
> *) Fixed an issue with overlaying "output-low" property in "mux-mii-hog"
> sub-node under "gpio3" node.
> *) Rebased the series on latest linux-next.
> 
> Changes from v4 to v5 :
> 
> *) Addressed Andrew Davis's comments on patch 2 of the series.
> *) Addressed Andrew Lunn and Nikolaus Schaller comments on patch 2 of the series.
> *) Rebased the series on latest linux-next.
> 
> Changes from v3 to v4 :
> 
> *) No code changes were made, only the version was updated.
> *) Rebased the series on latest linux-next.
> 
> Changes from v2 to v3 :
> 
> *) Addressed Andrew Davis's comment by placing PRUETH nodes in a new overlay file
> am335x-icev2-prueth-overlay.dtso.
> *) Rebased the series on latest linux-next.
> 
> Changes from v1 to v2 :
> 
> *) Addressed Andrew Lunn's comment on patch 1 of the series.
> *) Addressed MD Danish Anwar comment on patch 1 of the series.
> *) Rebased the series on latest linux-next.
> 
> [v1] https://lore.kernel.org/all/20251013125401.1435486-1-parvathi@couthit.com/
> [v2] https://lore.kernel.org/all/20251103124820.1679167-1-parvathi@couthit.com/
> [v3] https://lore.kernel.org/all/20251217130715.1327138-1-parvathi@couthit.com/
> [v4] https://lore.kernel.org/all/20260105162546.1809714-1-parvathi@couthit.com/
> [v5] https://lore.kernel.org/all/20260307122641.738450-1-parvathi@couthit.com/
> [v6] https://lore.kernel.org/all/20260402073853.2170099-1-parvathi@couthit.com/
> 
> Thanks and Regards,
> Parvathi
> 
> Roger Quadros (3):
>   arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
>   arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
>   arm: dts: ti: Add device tree support for PRU-ICSS on AM335x
> 

For this series,
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

