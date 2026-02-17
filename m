Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C1B7F4;
	Tue, 17 Feb 2026 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771303868; cv=fail; b=u67C6IJYntqZF4cNyX18L99H0GnL35xjdxAbN6HoWnL1sO2Fw8xqUy2FpL58CXzq+hAZq9pn0byKt3Q/dQ60i7clGJ3ex0EdsIrXjJFhl5o/X98m6Xg8ygrmlzMKmTQPc1p4ZR0yFtEaCsdrBjbmw/M+kE6I7WbZDvwbo+SUSwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771303868; c=relaxed/simple;
	bh=eJ8vw0+c5icazP4CHHMS65puPqbYfpb9Qt5KYfxHkPI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elNmy7k5bsOcnGpyn219uaz0FU9pOKkr0JL1vl35mpZoDA147y/jbOiR711Ko8b8ZEdkjLac64x35f7TiOOHZPtciwSpUcpIgcGSxUEi9X8sOv8uOUJJOdvLQd0KPF5y9fEffGdEYS58aXrKVT1o9/KtRNBXsGWoe6q/yJk9YfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vjDiX+6O; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vjDiX+6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXjE7yUtVcLacAuBg/TI8oYGJjabGln2ykWJ678kvgVMRVWL1sGgw+3l3MZSkuO8K9a8/pVGHtcvuqgStQkLD5rmNXcbpB71kSCpM/GPm5gQ6gdTwyfrf4blh94DHCp788LjacQXHF5TKC4eyZuTEobFGU3+hUW7ps0L5v4V/lXCvQNgf0OswK89OBDIEc8q2hTiCu2FOSz900DJRAP8FedbMwvzcbnDL277YpEopQbSalgq76X4KRx6Zu7yFDYQUVDaERuw6dvaZP8l84cZMCP7FhoWqqQgHtutD4Sp55slgPheD2B68ViSFEGKhXBZ0omv1XTa3DQYYN0PE1kHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mErqGxx49utwsOyiTrov9/TM+VkEM4vq7A6BgYyqiLo=;
 b=pW4/yYfMaumWSd47H771AxaDcIsOLwBmHEOW0+4L/4joVUg8wKeyPr4PE6vTkjvDaUlngkSN+JbGbMKM6y+LVy3RdpMgGGpdbXAcXZicxACx2zHrFAjU7df53kA21ToEU7foy1lE3apmgkhOV1WDNQqsUdfqO/QAEPCUZFpxZRBwkEohycHZu3805wIQ1O4Fh587DUBQkJnvKETcCccr1U2oGTJzZJcNppXCfAZxJUVM49s2lQyf+JqpY+idkYV1uzXm6VtQNMUkvewUhDlI5aVqV6uue7E2JSlbXqID8bxwuuITtBTIbfoyLiP2i06rLVSlpfGS8kda2bGqWEvOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mErqGxx49utwsOyiTrov9/TM+VkEM4vq7A6BgYyqiLo=;
 b=vjDiX+6OWhEeDFQ3H5hGrRdz2kRJH724dJUmfq0PI1FfcJ9kswFi/fkY+NqsxorVazY6kjUvUcdpdjGEBGi7MwOfx0iExz2jUmNS9Q9OZV+sgOp41Dg1a4Cq4gSmFrK9etyc02Hph3ZjX2IXgRHhG8cW0qmAjzkM1CSEVwI2WVc=
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 04:51:04 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::5c) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 04:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 04:51:03 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 22:51:03 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 22:51:02 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 22:51:02 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61H4ovxc2325954;
	Mon, 16 Feb 2026 22:50:58 -0600
Message-ID: <69b26234b3646bec7a1dab9254c2a66818515627.camel@ti.com>
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
	<netdev@vger.kernel.org>, <s-vadapalli@ti.com>
Date: Tue, 17 Feb 2026 10:22:25 +0530
In-Reply-To: <0249c0bb-ca88-417e-b5d6-903882f9a68c@ti.com>
References: <20260205070951.3170631-1-c-vankar@ti.com>
	 <20260205070951.3170631-2-c-vankar@ti.com>
	 <83a867729ac8fa08709c52e2a357c97ef1bac27e.camel@ti.com>
	 <fd5c557f-b6a6-44e0-b66d-8fd7defc7203@ti.com>
	 <fecaeb94-c004-40f0-86e6-6b7c553a2fd8@ti.com>
	 <0249c0bb-ca88-417e-b5d6-903882f9a68c@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac20558-c793-4146-6aff-08de6de0277f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXJ6OFR3b3R3b2dCRGpIUkFJNjdLQ29CVy9lUTB5VTFubTRUTTF4L2t1U2xh?=
 =?utf-8?B?NFBmNzIwQ3JsdEhDUmdwL1lkWU1ITWFOVGVUeHAzR2hTY0tLYzJxa20vTGRS?=
 =?utf-8?B?Z2szQnNQMTlzbzJuS1RWTXFOTlV6bGZXMi81M0ZHK0E4Z3kxcWhsV3RPc0Rj?=
 =?utf-8?B?TktXYU9HUDdZUk1VcmxLNVA4MVpmMXRNMGtCMTVvelc5NzJHZXluTVd6QTJi?=
 =?utf-8?B?ZUpYam5aZ3k0VUhQalVYL25wZ2tleWhDVmVsK2RaMUZSWGNrQzZWM294ZWRT?=
 =?utf-8?B?ME5WenZDYlplMW5ySkgvcnNVU0w4OVhHVkhCMDBKdmVabGxKbGErZzNpU0ZT?=
 =?utf-8?B?TFRGRUw5aFhRVFQ1QWVtRytEV3JmREZaTFFxTTdKTHBoNGhQTnZmN3ByekMy?=
 =?utf-8?B?NnNVemt3aVJkRUJObGtuRVdwTkdhUUxMUXVFdkZPbWhWQVc5ejdJSUFSQ0RS?=
 =?utf-8?B?a21OMlFjK2c3MXFvcVN4SXRvZlMwaUtNbEtUcjhZNWpUcHE4NzZOWEVKZkFC?=
 =?utf-8?B?TnRvK3JWWTVoVTl4VzVPMlBzd1g3c2dOSVcwM1AyR3pXQ1AwSnFKbWlEc0pp?=
 =?utf-8?B?eHEzUnkvSzhObjhWMVA5eSsvVE9Kc0F4SVhMTTRoUC9lU0FzMnRRQUthVllq?=
 =?utf-8?B?emJWUEcrdGJDRzlsdS9iTm9qRTRES0pkOEZRREpRVUF2SHNjKzJQN3M1YlJ1?=
 =?utf-8?B?NWJqOU5ZUDRBeTV3dUxtd3VNUTh0b2REMzFZUjErTzVWYk0vYVdjQkNsYWg5?=
 =?utf-8?B?UEhhd2d1ZTVFeFZMYjFrMXNvSkR3bU5NOVFrQ284S0JqSWQxQVFUb0VCVzF2?=
 =?utf-8?B?MkpVS3Z2NlZSdkdPcmFUUlBaWWF4QVBhWnhnWDJDL0lUUXFWSGJyeUpNTkhB?=
 =?utf-8?B?QU4vSXBLWEhHRWRSNXVxWlRXTlJaSzkvcVdwOTBvMUM4dUpSMENOV0ZQemo2?=
 =?utf-8?B?Z2xXMHZHMkcrUy9uUTRoa0F2ZGhESlBWMFMvVUU3YlNNb1B5ZVJmU1IxUStm?=
 =?utf-8?B?ZndZbTlXbWtWa2l4RkZiU0Y5ZWxGYXJ3Znl6b1VHeExoSmhTK0UvSWpGNGIy?=
 =?utf-8?B?K2hpeE4veUdQTWpsVlIyTjVGQ3VjZ0RBSTkwTnlvWFFNV1R3THJDRE16cGFi?=
 =?utf-8?B?QUlVeW1LV3lIUjhhMThhZEpnckw3Q05oOFR3bnF4OHdlaXdxRG5VRGpRekIx?=
 =?utf-8?B?Z1RBZ0hNbUZ1YW0yN0NOWEM5WGp2MUtkWFdtWjQ4MjFzOU5pKzE4RFgvK2h0?=
 =?utf-8?B?dHIzRlgwbHdHSnlMbW1xb2h3Z200U3BDZDZ0Q0FvSXRPYkhtZEU1OW1WY1Np?=
 =?utf-8?B?eDZQejlzUmwrWEJkRUo4YTBycjFLc2RHVkJlMU9BN0xHM1ZDa3dIZmVqR01s?=
 =?utf-8?B?d2JYWFVoQ09RYk9ZRThhRUhvNDYzN0NEVWgvQ08xbC93eXVqdTZ2WmEvalQ5?=
 =?utf-8?B?aGtNYVkvMEwxNVo0V3dTNEVEL0NPSDJVM3RHdk1sODQ2ZXFGNkJqbXJJTVlH?=
 =?utf-8?B?bTR6ZFBLcU85TU43NkU1ZVJMc3ZWTWFyU0RLRWVKSXZZRm1raUg5Z00vU0V4?=
 =?utf-8?B?bGJsMUh1WkJFQU81dUN5d3dQS0xBRCt1eldFMVQwSFFQZ3E4WVpGZmpLWmd4?=
 =?utf-8?B?UVR4ejhXM08rVk8xVEpDTSs3U0pHaDVXQ1hFWVM5WFRMM0tXaEZHMjlYWkdB?=
 =?utf-8?B?Y2dpV2VlUlNLc1pzeVRPdEllY01KRGswTDlBS05xNWlVL0ZGei92amh6cGNN?=
 =?utf-8?B?ckQ1VDlxSUM1Y0h4VnZidnp3eFBLdmI3L3IxNFY4VnVyNm1vNXlLdTZXV1ps?=
 =?utf-8?B?WW51OUp6L1A4VzJkS1Ntc29IS3h6T2pqeXR2a2RZS2ZYMjlJKzVGY0UzN01D?=
 =?utf-8?B?ZlNxa05wQjlZajZBbE0rMlk1dTFsYUl6bmJxOElrQnRBdWUyai9SQWx5OWVB?=
 =?utf-8?B?eVZBanpZNGt4RjIwTHJwcFhVK1VxYlA5OFRqa0hXeEU3d0FKT2tWN1dJT1VI?=
 =?utf-8?B?SHNaNXRIaWJFdDFSRWQzT0swNXlPYVlVNm9qSGcrYzQraVY0SFB6bXlIbnlj?=
 =?utf-8?B?alUxTjhoNndpRndYUzR3S0o4VWdHOVp1eWtkOEp4OFVaUWhnWjRkWURyMVkr?=
 =?utf-8?B?b2V5cjU3a3hyT3VqRDhFWmxlQUs1dXRpdzE2N0dDRk1yUG5WcThKbWs1VHlZ?=
 =?utf-8?B?UjBCNTBnQkt5RjZxWWh2Z2FrME5jWXFpRFJMTzNwTG9TQm51OHJDOUQ1VDJ3?=
 =?utf-8?B?Zk5LMzVKSkExdktoY290bng5NDZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1AGrM8X9fmQDT43ZFT9vX8lm9kKdY9HORck38+KBHxZQ4Xzs098nuaOLSM5NfdQVteRMOXN0LqD6Ayfet8wYr2VMwEpjgaEzfNxR5J2y07W7PSMrlYOSbJvhMAzgTKIbUSLx/+dymSx4dW7VhqOO0UJLze7+zX9UxXVeUKcljM+EMjDRt1ToUfbtTuNuClguSvCZo4RM9hcJSeHEF6meaC9UrCYfDn1oPam4c/6nBuOo4PcgrtIDd4S1arfHZjKGzTqaXF57g4gHz8qxIyQJP59Af5jyKLEWUTbm5QgEE3TyGi3JN3woXvi5ZrSJp6AHE8IyK45cTna6XY6k+kDj33yjiGNv3J5dM0fn9q/2TWOqoLitO0Bn4P9NH5ovOp4pdxWCBNrQhn0cQ9dIHLqJrp9ROGrrCY/O9fvoDdszMY/OCEMHsQ1TZa0GP18h6sec
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 04:51:03.4818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac20558-c793-4146-6aff-08de6de0277f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630

On Mon, 2026-02-16 at 23:45 +0530, Chintan Vankar wrote:
> Hello Siddharth,
>=20
> On 05/02/26 20:31, Siddharth Vadapalli wrote:
> > On 05/02/26 5:05 PM, Chintan Vankar wrote:
> > > Hello Siddharth
> > >=20
> > > On 05/02/26 13:45, Siddharth Vadapalli wrote:
> > > > On Thu, 2026-02-05 at 12:39 +0530, Chintan Vankar wrote:
> > > > > Multicast entry rules are mainly evaluated for receiving traffic =
and=20
> > > > > do not
> > > > > require MAC ports to be explicitly associated with them. However,=
=20
> > > > > setting
> > > > > associated MAC port's bit to the port_mask of the ALE entry ensur=
es
> > > > > technical correctness and helps maintaining ALE entries linked to=
 MAC
> > > > > ports.
> > > > >=20
> > > > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > > > > ---
> > > > > =C2=A0 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
> > > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/n=
et/=20
> > > > > ethernet/ti/am65-cpsw-nuss.c
> > > > > index 5924db6be3fe..967918050433 100644
> > > > > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > > > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > > > > @@ -391,7 +391,7 @@ static void=20
> > > > > am65_cpsw_nuss_ndo_slave_set_rx_mode(struct net_device *ndev)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpsw_ale_set_allmulti(common->ale,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ndev->flags & IFF_ALLMU=
LTI, port->port_id);
> > > > > -=C2=A0=C2=A0=C2=A0 port_mask =3D ALE_PORT_HOST;
> > > > > +=C2=A0=C2=A0=C2=A0 port_mask =3D BIT(port->port_id) | ALE_PORT_H=
OST;
> > > >=20
> > > > Since the port_mask setup above is passed to=20
> > > > 'cpsw_ale_flush_multicast()'
> > > > below, wouldn't it temporarily cause the forwarded multicast traffi=
c=20
> > > > to be
> > > > dropped?
> > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Clear all mcast from ALE */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpsw_ale_flush_multicast(common->a=
le, port_mask, -1);
> > > > >=20
> > > > >=20
> > > >=20
> > > > The code in the driver following the above function call is:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0if (!netdev_mc_empty(ndev)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct netdev_hw_addr *h=
a;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* program multicast add=
ress list into ALE register */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_for_each_mc_addr(=
ha, ndev) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cpsw_ale_add_mcast(common->ale, ha->addr,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port_mas=
k, 0, 0, 0);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0}
> > > >=20
> > > > So we do add back the multicast entries for the same 'port_mask' th=
at we
> > > > removed earlier during cpsw_ale_flush_multicast(), but, there is a =
delay
> > > > between flushing the entries in cpsw_ale_flush_multicast() and addi=
ng=20
> > > > them
> > > > back via cpsw_ale_add_mcast(). During that period, the multicast=
=20
> > > > traffic on
> > > > the forwarding path between MAC Ports will be momentarily dropped.=
=20
> > > > Please
> > > > clarify if that isn't the case.
> > > >=20
> > >=20
> > > When "cpsw_ale_flush_multicast()" is called, it only deletes entries
> > > where the resulting port_mask becomes "0x0" or "ALE_PORT_HOST" (as pe=
r
> > > the function implementation "cpsw_ale_flush_multicast()" in cpsw_ale.=
c).
> > >=20
> > > For multicast entries shared across multiple ports, the function only
> > > clears the specific port's bit from the port_mask without deleting th=
e
> > > entry itself. This prevents any traffic disruption for other active
> > > ports.
> >=20
> > Consider two MAC Ports P1 and P2. P1 belongs to multicast group M1 and=
=20
> > M2, while P2 belongs only to multicast group M2.
> >=20
> > If M1 is deleted from the interface for P1, it will trigger the=20
> > execution of 'am65_cpsw_nuss_ndo_slave_set_rx_mode()' function.
> > In the function, we have:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0port_mask =3D BIT(port->port_id) | ALE_PORT_HO=
ST;
> >  =C2=A0=C2=A0=C2=A0=C2=A0cpsw_ale_flush_multicast(common->ale, port_mas=
k, -1);
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=3D> At this point, M2 would have also been re=
moved in addition
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to M1 for P1. As a result, Multic=
ast traffic M2 from P2 to
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 P1 is dropped.
>=20
> The scenario you have described applies to switch mode operation.
> However, the fix specifically addresses the issue with the MAC mode.
> The fix ensures that in MAC mode, multicast entries are correctly
> associated with the Host port and MAC mode, and it doesn't disrupt the
> traffic as mentioned in the previous reply.
>=20
> I believe I should be more clear with the issue and the fix. I will post
> the next version with more clarity.

Ok. Please include one or more 'Fixes' tag(s) as well when you post the v2
patch since you have marked this patch with the 'net' suffix implying that
it is a Fix and not a Feature.

Regards,
Siddharth.
