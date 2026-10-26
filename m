Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793002771;
	b=BW2ZxfbA2Jbd6FPSLmDC79d44peR6lR8zbSDS8CPMpWul1GkV525ybab1Jt7ZmfDXQ4k
	 ypGeNa/TtMoyifFH2Wt7vF+HJvq+qwG5dMbciVsMp60CoPHwLft0jbmfvncsbppW4A+91
	 Xj1JlZ9lUAc7IR3Gn/Q7DvH+S4Z1F/rW8jtQ622w83N8vFD3F7c54FbihIZJ2Rd83dgS9
	 rE0OJhz9iBJfEqie4qHnu/Ai9hP54ZLggzxpL+6PqzlBKxrDvWKvY7GZ1e+i2Ft3qUrc6
	 yIIH6Sb68/WsSWZhxkL2FbLEzS5qJbAKkonfPS5uNzkCYznj+rQ8Q2obh7yxOcigzvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002771;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OSGm+j6TzrArWBMkwbVqFznJkjj3uoS83TAtX0n8jpA=;
	b=ygSK9j1h4Tm6qlN9ToRimoDQ3asNBu+pDGOu7jv77c0kofawoTejZDx7LmCUPzobMa8d
	 Fj9ydnxe+SQIGED4I+IHresfwsaCFxu4t6BzYbFKgQRTO7udD31nWFVnwG4hOIQ+js4nZ
	 BtwXcX+N1DJbrm7qevlOr35qvQy4PS0Tq9PTByaMn6tO+dPyF6gJhL4yPnF2Z9beretns
	 Yf7mjDW+9A30lSdKzNSk2UvZF5f0Y7YoDCTNKWb1YDQ9QTAT1VkLdrp8mKsDstqxx4+cV
	 OPK0zrFnTFc+9VtynTyDFi/YQ85u2VEmo2854rR1uHkDhgSEUx8u16G/xCYAn2wZP2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jT6yJUCa;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Eg+0T3Ac;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E9606A31A;
	Mon, 26 Oct 2026 08:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jT6yJUCa;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Eg+0T3Ac
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q7R4622083876;
	Mon, 26 Oct 2026 03:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=OSGm+j6TzrArWBMkwbVqFznJkjj3uoS83TAtX0n8j
	pA=; b=jT6yJUCaf9VopWwDHqxdoeTyBGR3SWC/LbYWRVTfpALVfutawmzUN533n
	b7FlK4268EEMuZ9ieQmhFspm2aYwV0Z+vdh0D/hrh3TkooXntMnnm7dnFjAIOWyX
	5MzJo6DVc4l+KTEV9NKu/Ou4gSLWT31T3b3Xi6VTfQ7nEc2aSONrdt+0uMYVMc+r
	rXAOBn25AT70qrypvOviWTVqD6zjGtGqyEBgcS3EJmJBJyHHJHIb+m9gJGhV/ZyP
	l87vwkqNP8evUlRGq+2h31BHqWfbXzIb5apfhocOrs1QoXpgM/RKWBOXhMIUm/Hv
	2G/I0IB+46KBkjrp05cxR75hyDevA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hj2g1085q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 03:19:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTuiTcuVdpfvTBxHgyi1tC4q8wljtXWlGjzB09YcwD9xPCPR7gv3EJQG4WAHCGoM9/S9NzlwNdlXCnCV7hivE2Q/mcUMQzQ2ZaP+EGhQRLkiNVH2QT5GikaPa2Q2eFuLPFTjQCKtnzShqf1mRDREZlFe0t3yrdkCvGmSDywSViprhxjc6exNcvH7qu3Gf0ABIenjap6rYJE3m68oFUCypANK1yyWou5+FAjHNkd3LK2HuGh+Yfp27pVKHeIUWOCYyLHc5a3GwId8BdfBVPMBxPHgR1wTYFcDyO3AvqLga1CBTGg3FpPTyC2Uh8fp72RWPS85b9EZYf71IN0X9El2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSGm+j6TzrArWBMkwbVqFznJkjj3uoS83TAtX0n8jpA=;
 b=A+0e9dVvgSm60LLlaURXRBCokfLrZuGuBsih7jm62FxJbEKXduCRpNKde+mRA8cegYilP21gCf+DEzB7QZBlqP2MnUSE2L3d/TYVByuwmvfy5wA+kGM7daYRD4Qfi0se3Y9m2D/Re5izCFrz5oCqR6fMM9Jxc6UOcDvRSrPudBOJC4ffDZvUwDidY2V4HFKRtHGNFiEZbCdl0UZW84fFPLUvlSXmbt/3+BSJ7a120jH8STW1C0gFv6SyDzQEtXe6bJ4Oq3tNeAoWUqnDybkmeVWiR0GXsoKSSENf5h4Nly43q9cFMNumHgx4/mcsKnLG0xTxA/FYNg1J060sSXLo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSGm+j6TzrArWBMkwbVqFznJkjj3uoS83TAtX0n8jpA=;
 b=Eg+0T3Acytp3W5jm0LCARcgRHsIyTuf1H4gUJ5Xr26a06V5C6DrAbWVsjjqkwEUFDqgANlFOps0C1Dsffgjh7D2Wp0BsHiSgZ4wTdH8GH5+62e3/F3mCL1KXpuDgHZORduTP+l8RQDnt/vZgvxrB/amDvM31Vfc9km/i03JQOBY=
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by LV8PR10MB7800.namprd10.prod.outlook.com (2603:10b6:408:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 08:19:03 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::a8) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Mon,
 26 Oct 2026 08:19:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:19:03 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 03:18:44 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 03:18:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 26 Oct 2026 03:18:44 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69Q8Iex9373562;
	Mon, 26 Oct 2026 03:18:41 -0500
Message-ID: <3f439232-75d5-418a-9581-420a9f683d9e@ti.com>
Date: Mon, 26 Oct 2026 13:48:40 +0530
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: cpts: drop stale events before the
 misc IRQ can fire
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
References: <20261026072314.663980-1-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261026072314.663980-1-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|LV8PR10MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: b147c92e-875c-4722-e618-08df3339cbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004|261021121427099003|10067099003|261009223027099003|261022075727099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	/d5FThTxXQunorU3xxmRoKgCGQT8eKovjH5p+u4nrVjvSDa/CzcBru8US72MgTVjN2D07luZQu3pLB5GK5HlrpJY8rxU2qppLpP1UDW78iq+flfEswwTtiLIxaN3eciU88nY0gjJFMqJMTNW1Z98IFQy6FPtGygsauhdop1mxXC2BsqGw0myXD8fjzUNJkO6q9j2ZAjZPaSS+9YeQoJFYhwsIkxMmHYkci6JyNgcV0bKknNYboODb2UuWdAs0lJhxBeh9b8no2NlQUxS7kAZLpeaAAlKS5XXyyfvtwKyrflO5W0+Pyqf8VlygS6YRyz+8ytDUkzhzsUs7ycnM9zUAlHsMvIIHQV/NoGWQLS/aK1hwtnLcm4GzQiz6e3iKRK+4a5nIV1a4Q0Ucjh6iTCwS9M042JuwjMNOPQ5tILF/l4IpuzxwJWdPrPHeiOKO4CqKG0r66EewPaIbJY1mbSngWatZxUWmujzNKP1nH8TaXlpRBtQUlQxoXRyIfU/QaiVydyYEwIzT60xtArzzHZ7335VwG+cbQvkdTC11VWNqr89GOaWOuraDpjbkjfYbV5mFFfnHm7ZOFToCUS0Ca9HlSr0ycQGVcpmJaFCD/aPziufJhWRsvkOWhRZaDr0jUWG6QrsqOaQbtmYNAnzwu3+0P3uwzmvf5Ou9u03ZJ+vmS5pY7X8GJUJQOHqVAvdzpQni4hs2E6mqgfeKL2VukFdIA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nGZ0ja6xTXeHy3zRHzsFqVJA2rfJ0V+v21C0pO0wjMblB9e3LP/T3BiPZp68pp4udpHxMtWHfAWuWuw4dtzBFi3Ccn5qXI+Xd5tpxSg/zB93+Doymj/muQIRT1GqbBseP/Pxk4pERYegssrde9CJtRn9VjOpGpmIleJE85aIefe+jCLFmo0tLK/GGLsqUkm0GKykRIac8rgpRxkK5mF2NOEAeaY6bGjk052UgHTrwd3q774fpfGJ9RPJE25N01h5OnxpCvcfOR7IRdjK4P8eDMznLW/JrtJK6YyTvuSTf645xRkSCjMOCbwK1BUJnYrmJmLOWLGnQSPj+UpV9OuZFbh+n3Rr7+nXvxtWB418voI1zieUn2JKMY/YGJFUbEosEcV5GZSlskyV6lMp9K8bVEffmNAMl5hpJgv0/kAD3ss5C4F4kSrGmG5uQ+38IWQo
X-Exchange-RoutingPolicyChecked:
	E38b2MxkTGBFTd4p0phsHHDcyM+AcQAiUxcXF0De7yErhL08gzfIZTLFm4RuuLtcEcUu7H9Edmht822++SOIiISZaDNmV9fHtG5h1nxO/f5WHzzErY99ciBszKMFj+gzfxVc5Fjzz1SmZ/FdQVZYEqAS9iKee0qu3GUnkr8otisCbjDFRUU9/dypPY5eiv/fqmUCJJCZZruJKGQHht8iqYLxXeUpmruc2qTnMgnSFHO39oPNivIzo+SNrEWjGMALa60f6I65czzDTUzs9Y3aj3ppjcYgfO2MLmMxaxQevd8QgW6sCo89WHle8pkHLcsXz3Mt/gDLuEqtxDKIx3SbWA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:19:03.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b147c92e-875c-4722-e618-08df3339cbcb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7800
X-Proofpoint-ORIG-GUID: QS8mnfiMA3RgWp_g3e56XJjlBNXrsqQL
X-Proofpoint-GUID: QS8mnfiMA3RgWp_g3e56XJjlBNXrsqQL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzMiBTYWx0ZWRfX30DnBOv3pPkZ
 tMVeWRRE49kNC43Yc3/HugWiZ1dqlNgH2IA4V7IWPQHqcpoK+jeR3DMVkAAi79harEH8QwOHR7G
 wsz/qCQjAyvUlrCntxe6FGozccHZAUA=
X-Authority-Analysis: v=2.4 cv=buPZl0ai c=1 sm=1 tr=0 ts=6adf0cfc cx=c_pps
 a=tFiMKzbuKqM0PzijJMXBtQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XM9J6TYdycIBol3m:21 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=pGLkceISAAAA:8 a=mnUfda406AYcND7Nu2QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzMiBTYWx0ZWRfX75BLUL/4KN7L
 sYyWSHpYqWgs8uZeosZsSeRMFa6LQxyf9Yb667DjCyG2B8ZgQMLiInQwQOjQwqn8te7pD1axyde
 KxsGOgowfivTorrGxNA9fs8zVm5xE1WGNwWpRsri+MrjhJppMZBPuLYrDUUXxb6m9B2QyeDvvgn
 j4Ms5uee54N1h7aeoMobT94dZNn4Vv7B5pbU632vGqkRqMEJ76sIfMGQmV9fO2IOURU3KoaV8K6
 n341AQz26sQYdgfStH3EYOdxn+5KMdhjiw72DpLoiQYyNX5oQTBdi2dl4ET3hUabxpXmOUKCyoN
 7ciMh3phU4YgUzL6om196YUZTGqZLkXbKcwr62HoWzCI5VdsdVFt8J9TfXs6tEuKFrTUFGnPUsf
 fqtj8Q+76g7A5bABZeHOObAQH810FbxrqIyYjcnxdyML6dvOvCCRlGpeHPwJaGkW2/u7/BCfEU+
 hYTd709+KpaPUWBdHJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260032

On 10/26/26 12:53 PM, Hung-Chun Tseng wrote:
> cpsw requests its misc IRQ at probe, but the CPTS event pool is only set
> up later, in cpts_register() from ndo_open. That is fine from a cold boot,
> where the CPTS comes out of reset stopped with its interrupt masked. After
> a kexec it is not: the previous kernel leaves the CPTS running with
> TS_PEND_EN set and events in its FIFO, so the interrupt fires as soon as
> it is requested and cpts_fifo_read() takes an entry from the still empty
> pool list:
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 00000010 when write
>    PC is at cpts_fifo_read+0xa4/0x3c8
>    Call trace:
>     cpts_fifo_read from cpsw_misc_interrupt+0x30/0x4c
>     cpsw_misc_interrupt from __handle_irq_event_percpu+0x74/0x378
>     ...
>     __setup_irq from request_threaded_irq+0xbc/0x170
>     request_threaded_irq from devm_request_threaded_irq+0x70/0x104
> 
> On a BeagleBone Black the CPTS registers read control=0x1, int_enable=0x1
> and intstat_raw=0x1 in cpts_create() after the kexec, with one event
> queued.
> 
> Mask the CPTS interrupt and drain the FIFO in cpts_create(), before
> either cpsw driver requests the IRQ. cpts_register() unmasks it again
> once the pool exists. The CPTS is left enabled: clearing CPTS_EN at this
> point made TS_PEND_RAW read back as set, which would hand the handler a
> bogus event.
> 
> Masking alone is not enough, as the interrupt may already be latched by
> then, and clearing the wrapper's misc_en before requesting the IRQ does
> not help either, since cpsw_misc_interrupt() sets it again on the way
> out.
> 
> Fixes: 84ea9c0a95d7 ("net: ethernet: ti: cpsw: enable cpts irq")
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> Tested on a BeagleBone Black (AM335x, cpsw_new) on top of net 7076f684d5:
> 
>   - Cold boot from U-Boot: probe and link come up and /dev/ptp0 is
>     registered, as before.
>   - kexec_load from a kernel without this patch into one with it, and from
>     a patched kernel into itself: no oops, link comes up, /dev/ptp0 is
>     registered and its time advances.
> 
> Without the patch the kexec'd kernel oopses as quoted above on every boot.
> 
> Not tested: the legacy cpsw driver, and Keystone netcp_ethss, which also
> calls cpts_create(). The CPTS_EN behaviour described above was only
> observed on AM335x.
> 
> How this was made: the investigation, the fix and this description were
> done with an AI coding assistant (Claude Code) driving my board. Three
> earlier attempts (clearing misc_en at probe, clearing CPTS_EN, draining and
> then clearing CPTS_EN) were tried on the hardware and dropped; the register
> values quoted above come from a debug print added for that. I have
> reviewed the patch and can answer for it.
> 
>   drivers/net/ethernet/ti/cpts.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 2ba4c8795d..3cc908ac90 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -747,7 +747,8 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>   			 struct device_node *node, u32 n_ext_ts)
>   {
>   	struct cpts *cpts;
> -	int ret;
> +	u32 high, low;
> +	int ret, i;
>   
>   	cpts = devm_kzalloc(dev, sizeof(*cpts), GFP_KERNEL);
>   	if (!cpts)
> @@ -779,6 +780,17 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> +	/* After a kexec the CPTS may still be running from the previous
> +	 * kernel, with its interrupt enabled and events in the FIFO. The misc
> +	 * IRQ is requested before cpts_register() sets up the event pool, so
> +	 * mask the interrupt and drop the stale events now.
> +	 */
> +	cpts_write32(cpts, 0, int_enable);
> +	for (i = 0; i < CPTS_FIFO_DEPTH; i++) {
> +		if (cpts_fifo_pop(cpts, &high, &low))
> +			break;
> +	}

Thank you for posting this patch to fix the issue. While it will solve this 
particular issue, I believe that the underlying problem is that CPTS 
remains powered-on during the kexec sequence. Therefore the proper fix will 
be to power-off and power-on the CPTS module (to perform a complete reset) 
rather than fixing this particular symptom (please note that the remaining 
registers of CPTS retain their state as well, and a subset of the 
underlying cause is addressed by this patch).

Regards,
Siddharth.
