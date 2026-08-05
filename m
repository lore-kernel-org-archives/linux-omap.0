Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806D34D384;
	Wed,  5 Aug 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940448; cv=fail; b=DoQ3i2iTHydhg2vjWj6L5VChD1p6RlQU/wShw8+pZHKj1ptzC5A+GZMLhR1Q6FstLoZ37NH4yKL5dzNL0hM6qTEuVfYI5cH5z267ZfEC/nrlKy7KT53/6xFWT54yeO/l/QzBViz8AXwkpPvgSomnEo2lf1mbilpehfjnRbLnFw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940448; c=relaxed/simple;
	bh=AQTt0yEUJjz4jG7BO2IkpLX2LR4rHE2pLdlJUNIqnlI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSETyg+KnYC9d57Uj0aLJ1yMhyH/SK/eblsV1Cr5qE4zV9q28BjyU95AXZd7ycBf5P1yKv4qrNujJTpgJGyMHqHruPWOT0QRKSrRkjTaiAjR6yGLy7F/ZA266FhdpCaHb5qIn3jr8tsDAMI4AcGBMp89RiuLXTjiXkCjcuX5XkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kNSQ/5K9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SN7bauan; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kNSQ/5K9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SN7bauan"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 675D6sWE2363876;
	Wed, 5 Aug 2026 09:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=PO425GtqebwnIDX
	N6RmSfqKusVQ7a0FzkAVQ4l/seeA=; b=kNSQ/5K9cTwAfe9zfBM1sLtmcR1bVz9
	NEZ+va1qNaATRCH5BQgdhy74xQPsGV56EknWMuEX+mBrXNv/bR+6q+vk/GaODU5k
	iWxU0k1xiLOFqgmoU9mvStTg36gtKE9yTsnjJ4eBEi3xly6BRkKOlelWQNgmnYph
	JA10pH6HpxOJdieLLcDB3Mo2DMQbtpth9o0ok0Csf6oOA3ZCSIX5LDXeyVyLmSu8
	qk7QyJjpY67C/XiS4oCWgB5L+36qixNoFwHHqgvJq4K8uCRrglWCLd7m9J4zU/i3
	p+WzjKJ0L77fMMYXioZdskpf1dTYwbdvl4bkUj7wrF7FvfdKbaDGhuA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fv5sa8pj6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 09:33:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvczx3fCe18rWVO0vqQ3BDDvTFS/FuIBrlv9deaumudu3B+/DbnOXahAjzXwvbatVs5ppfeX3PrZoxdTWrZycCTwZ6mEUBRcoXJvWi3epvtD4wgI1d745hGt15HSMc1RflrakKlGZhFVNnZWl/O+oR1s0EC0LgrDlFXD82hna4QpHYhLsAEcYEPSszn8fU3Ly7Qt42S782xH7/+T7gWy0fclZaX103K2ziMXJFTdWKFTu4q6iC05iZHjtrBKvgHmWE3fpo/3jWjhhoT0C2U5iA0s6E4TE+LOeiJt/hHHCRVCQ7wMJjiS196M3iA73Z5f2gnkEu1T/VR2zOPwoG2HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO425GtqebwnIDXN6RmSfqKusVQ7a0FzkAVQ4l/seeA=;
 b=WnjgI7mmDtPkiRMPcHvWr5F0wijYG9HDx4IpPBfKIiWuM4MsZ2gOFwf/+T9H6/zhM20MPaOcJCEu88JXVvZPl+QQmijYrTCf0XO1x7GLnET1thO3KYKddZqOQHZ0metd2/14G4ZKgae0GbYCnf13/WLmAxvoTRSMmItFVbY4cziX6w7iFy1sDZOlfyHD5QjJL+3GfinEsgTqOBOqd1exZHU09jD0Aij+niDgJvSxBW9Xaq+cpuPxHvtJew2Ye+rsnLR3Mwy2AIwrX4nXtHzjfCAfdIefkasOmhybdHQtY3YqiP7D49BpOmYd7DY5btOCDFRMbr+5AQuI9ODWdFEqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO425GtqebwnIDXN6RmSfqKusVQ7a0FzkAVQ4l/seeA=;
 b=SN7bauan/T4pkdyNG/xFr3LoPqXehTbfK7LQHugzhPzHJS7kUIpl48UpBZEJMrmHe23LgwuJAtp6we4EVa3C44HFkTucvoDiDY+Y/voPG7Zg+PJWw/EgtCd6RYYGI7KdDRtnCRQwQL7EKxyFYgTAbKB7KO1xQYt+dRxLeeaQmVw=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by EAYPR10MB997926.namprd10.prod.outlook.com (2603:10b6:303:2d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:33:36 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 14:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 14:33:36 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 09:33:16 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 5 Aug
 2026 09:33:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 5 Aug 2026 09:33:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 675EXFL31566787;
	Wed, 5 Aug 2026 09:33:15 -0500
Date: Wed, 5 Aug 2026 09:33:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        "Tony
 Lindgren" <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero
 Kristo" <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: ti: Correct white-space style
Message-ID: <20260805143315.cophjbfukfjlnbpz@hesitant>
References: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260803061910.13973-3-krzysztof.kozlowski@oss.qualcomm.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|EAYPR10MB997926:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fd5f02-51c8-4e1d-053c-08def2fe88fc
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1b+M1xXNNT5I1QrCykWS4sT6xlYcbBZy2bX98UjexGPAQ0xUNk6Fm4jiK3ORKrJaBZb2qf9EHKYiHdwyZnoj5SMKs1lFXC+D2H9t5+kIvmCBX0tww3dCa5r7hLnpbAJLtyF5yPvkj9IwamhKVWe50hbvl13dLKgMEpaIkSX0K8Oz4NV+pc0nbP3F51l1ZpJuT/u12rRYW0ZcS4tZVxD2ZFKIjdG4oFQCy9gM5HwFoVVIS/805wbkheqBPx7f0Yte3pFE+ANJAMeXa/RfaB0OzjDOtn8Kvehd4k2C5Ij5PFV7qZshkumGSE1st8j/kyKr3z4r8nX6BU6nj2drTyqIvCRQe3pzwiOTlx4Q3fznWCIfHuWLzycRRwiNcZoR8KO/D12FbxIjUZwTXkAIGc4PLCz5dVKX9QcO9MaH82fIGQRUm/IwBL+2DAUI5AaJ51a2YGPqEtQ8/PEeokXZUWccow370MOCI8ukfYPlJliBlpmdUmM3Jxvjz7bqreXUiJTbjQRM9xdwsR+JAKuSValU7bSobBN7b57SQaFyeFPi6lWxTMFkPf6ckWS8G30sdDJQsCE3aq4B8xaH0DGXpH1Gl+jNzL5FYeD4YNUcXbg+lbKX9xknyNd1e8s82ci9NvfUGYPbSPHyKuPUxu8nYNVS5WIyjZUoPHfNBNb9vD8bU4cL8WMkqbdTqd8e2ZQ2//7SKuilX1Ym3SIzQFh+ohl1yQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IppndK0mXo2W+6FRwXKfE0kGNXgf7vphS/74+irN/BcWtNjYiWAj98yiS7YL9O55cbwLQGiSuIGQKkcJHvVnfvAkO+VgYcL6ETKMNoaCxjUHbibRKo4lggaNVdcoSpcMPYjmoW85J6OQcOx8F3jhakNPVWxQlVY6+3VlJSkn4+SoSUpZ1+NK5IrYcae3KIF8Q9jNboqYMxAFTVbqVbfQlN3MDm+upo1reKMfBa2qzxfI0EDsP9C4ZAjfcY5YFwR0gX6ffF1qt1nN4FGcZflCNUUrUu/0Z+Bp0WLUkf/JzjDf12QvH+3KOSKZQ8U+w4TBQ8mIkx0QcWEgAVbewIagWlq2zE3PfD4Rt5z/3SrAcLQyXL8hJfHmQKP35wfC9UYKpLmTLfC4hZCQm25RndHypRSvMBQg5dWat9rprWJdgW98ZBbv6mJ5XmCxwVIpWX9k
X-Exchange-RoutingPolicyChecked:
	L42j2bs007p/xsRx2hRK+U7F9kuWBzSOzu5TuWiUlW+k9bEQAlOr1TgcWZocg96fFWrpqvFKaWzqON2IHHNv5oajmekjnkz9lyakvsnGvuU+YllVOOpOHYRXaVQ0A3XwganFSRHueK+Q0JrpTGfXdB9twLKvMhKvwYED0dUZqrYNA1Ga7vqGL46u1u1fOOlq7tW5vWVjYVcDE6K80OHQrwwOBk9QfVdKrAB66XTA3L/0TGenBQ6ZQu7HOxkCpvaaA6io9UxyKJaIqmk80b79kFIIb/QwjzFY2wI8fg0fDQlrWAEkeIhN9XSLHSBg1WswQzL9pVFEhhjVabxBTEliKw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:33:36.5752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd5f02-51c8-4e1d-053c-08def2fe88fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997926
X-Proofpoint-ORIG-GUID: App9PYErhopvDT59WwH5FxmeaZTJq3Io
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=6a7349c2 cx=c_pps
 a=F3cLoQkZAZJ9C40TIYDoAg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=EUspDBNiAAAA:8 a=aAQ-dF5up9Os257qQuQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExNyBTYWx0ZWRfXxKt1yUsQkG1v
 1oVGAyIT7Mo9voshpt7Zrmywkc+rA9cu2qNnKRt1A6/IiCoKrqvDYb9PuCDiDmpxilZcXK9yjPI
 LC4ImQ16auaJLj0f48BKjDqUlE+kJiSEz10rcDAlslM5N3O76kO7+s/dJ/+VfL/9RCKKar2Y8Pj
 sXrIjNAjtpJ+DSxQwmFYbyKgrkFJyumSQya9g3L7hVyhcDrrO6Pf949tM3iOOM4f/ZBU4mboa0Z
 l8wYxiu3ncP95USHOMB8fLQ7vflkQtH2/jilfcmkk7ntetsrF35P51fvouQzCUTtthz+r1nEivF
 h+stnH0lWFKoRyKIpLjdPlq/0bJyofRHIHJsacU8/PN0qjki9wJ+xG6ytk8XoHReM6DGefZcN2h
 fzm/zUNzoqB5kWrX/CRlFiw5Hh2mP/VIxFD8u27LM577Rn4gQvN6Ou8p/Rtt6NuPFkSfUET5uH1
 zqXxbGFYd6JT83W8Nyg==
X-Proofpoint-GUID: App9PYErhopvDT59WwH5FxmeaZTJq3Io
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExNyBTYWx0ZWRfX1t3YzSsHP3NX
 8nFwHXelwicFP2uRkPpmfV9UNKThHZjAGq9Pi6U22zLlgznwXvus2jSghu9nwZ0QhsfW0aeFB7s
 7G79pyxt+fEASIyzuyvO9wJEUa5b1hA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050117

On 08:19-20260803, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like missing space before bracket '{'
> character or spurious space, which will be flagged by dt-check-style
> ("redundant-whitespace" warning).  No functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> 1. Missing space for serial@2531000 in keystone.dtsi
> ---
>  arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi             | 2 +-
>  arch/arm/boot/dts/ti/keystone/keystone.dtsi                 | 2 +-
>  arch/arm/boot/dts/ti/omap/am335x-boneblack-hdmi.dtsi        | 2 +-
>  arch/arm/boot/dts/ti/omap/am437x-l4.dtsi                    | 2 +-
>  .../arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi | 6 +++---
>  arch/arm/boot/dts/ti/omap/omap4.dtsi                        | 2 +-
>  arch/arm/boot/dts/ti/omap/omap5.dtsi                        | 2 +-

Goes to Kevin and me - Do you mind to split the keystone part out probably
for the next window since kevin seems to have send his PR and I just
finished my tags?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
