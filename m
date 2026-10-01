Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD983F788F;
	Thu,  1 Oct 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845764; cv=fail; b=K6FumMRg0dq5KQJVwRHE8DDG5amGS5ptXJdiqNzeHwGHCwHKw+e0nhhM+J2QsJX06KBHo3XcgrKQFpcTuJ/GEMbOTSpq2btY/ZiL9ziGWep3G21f1mNyjk4/Mxg3kLnEbGxtVcgreA5Aeql2WYT8N097bwS9YT164jDF5T3XP/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845764; c=relaxed/simple;
	bh=sI6XCRhQ94vaIX4oglOnKs5QIGik3yXHvRsJWZya/Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zih7JuXxrpI/+x9K3n+IdkwovuOJehSGu6EmY3zcs7ormyJDW1Nv6S4iA2qUv3+oF2aDBa0jV8Y6l7GRcN20jjdyRZZZHLhHGi4Z2haRebcQAyC72s2qrlH1Gxcio7FoUqDJrgv6bhiSCWmnFhUGbqpA5E36EQbI6C0x/OLlJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NZdi7pU+; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=Ag7fCOAf; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NZdi7pU+";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="Ag7fCOAf"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69171Go6793664;
	Thu, 1 Oct 2026 04:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=LHFH6evBDPDYItVvr646WQ98ei7K9DlBxU7UcT20V
	TI=; b=NZdi7pU+LlogFHfaV+CNfl8ETJTtgwweQTho9eJ0ANz9QWFbZ+wUhcY63
	tx/qSvh6R4ejm/uvm+JrSIsuWEG0jeAVmpj5r9a8VRyeeJhGSYXb6Qww0iMQif3y
	GoXjZrzg76zwCmixVeNtmAEdxJZ5u8Em4TLj6oIxV8zctfN++mvak9DaMSHdnoKK
	2is/tHrfu0nA8N7Ajem8OA7FSugiBrqh3hZp+6r0jWOssFdMoF7shTxlMoRTh2+c
	f+UYRx7mO7YX8Q5mcRGpPfjAWFRV6TrlLSX6pmfq8TIojQG07z2TLVF5BIl0IHcq
	kua/T7wZ1P8Y4Nn9k5ctn32KAX9xA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h17djv9d6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 04:09:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPDZ3LU3Olzw1RagnqoJoNM8D79lLfZCVdz2o0BkW65MAXeLEEOEnWE//tKtYXLTbEQC8qI0m1egznWl104oHeVLLEnPe17wp8JEGKEmCGhRbO1NCGJRCI0v0yp8p5sCDBYkYOkQygCmKL4a5jP4gH1R2DbgyZfdVL5kebA92/IKeKBA1n4fXIWpp1OKKHFyhOuBM0PrZU+7cRxeF9hyy1oAEcZAApROFFeK1FKf1lRicFbnIP56QUPZhgaD09cur5krA2eO9DAhRLLkEbJGilc7aB4cCDw0bzVFgkbmR+6qT/CrRjN199w2DDhQcIBXI+wSTpTVNRb5ljt7hDo/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHFH6evBDPDYItVvr646WQ98ei7K9DlBxU7UcT20VTI=;
 b=WpFg061C0Or92YRFx8xLCyxTVP34M/ggke1hsgMr1l3+L32k8XqE1xmQwAeXy9/ISLv5RrpHW02L3lPqahvooH34Pp2UnkMn4Y4b+imApr3sXpN4oXP6JABNlSqmVAn2Ij48F1taTRcFhIlQf6IyEbpoJi42QedUF8ud8Ue7BNNwhQbJaaeSIjF/x5S046b7Rv2VC3AIJZBlESd96rlD+PxDnkN/ZsL/1mY2iz2+bTJi1YotQZNZ5bAh21vhAJY5233LOAR08K85PJk73elIVCj1YnXNo70LfnhS2yZXLhk+BCC0HhAkYyC39mXe9Wi9xg/OE1086n7tzN2fmtrE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHFH6evBDPDYItVvr646WQ98ei7K9DlBxU7UcT20VTI=;
 b=Ag7fCOAfdtL6vttVv2b8Hv1zUXxfF4aan7PFKwh89RKrh3+VLWW6ZdU7vyQqKK+DB8cC8NAzor0V0hbeGHj1uRmbuU/tqkZZMRs1tv7poaBFoeUNhFmsQEqZtyT48URl9Vo95RFRCc/aIkyLV+Ho6Ck1GlpFCqZd2RxsuKInJac=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by PH7PR10MB6603.namprd10.prod.outlook.com (2603:10b6:510:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Thu, 1 Oct 2026
 09:09:04 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::9d) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 09:09:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 09:09:03 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 04:08:26 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 1 Oct
 2026 04:08:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 1 Oct 2026 04:08:26 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69198QbC673055;
	Thu, 1 Oct 2026 04:08:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.73.69])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 69198O7P004177;
	Thu, 1 Oct 2026 04:08:25 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>, Kees Cook <kees@kernel.org>,
        Stefan Wiehler
	<stefan.wiehler@nokia.com>,
        Arnd Bergmann <arnd@arndb.de>, Simon Horman
	<horms@kernel.org>,
        Chintan Vankar <c-vankar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH net v3] net: ti: am65-cpsw-switchdev: flush dynamic FDB entries by port on delete
Date: Thu, 1 Oct 2026 14:38:20 +0530
Message-ID: <20261001090820.1605711-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001090820.1605711-1-danishanwar@ti.com>
References: <20261001090820.1605711-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|PH7PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f40d75c-895d-412d-5a2d-08df1f9ba36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|7416014|6133799003|18002099003|10067099003|22082099003|13003099007|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	JWFIv27eHy0hoNehMzkyYPTlsrgbbtRUVvluNdrS3NIaugE/L7af4USCXyYbDf3UalAEK5TY0/oGTENkzuVMkMyUg8W0CPXPj+7q9Jf0CStwajLOw/p/jLI7vJE0O90pjBFs5YDa+S57TtpbW5FEPjx6WYc41+VyOwsFBq+ujwBCpowzx0oXQGY988Zl6IVh6Lu3OIpduY2+QVlWyOkaSLAcdMbOkIVd3JP1d4+2VUp0GaxpanEKmLJQeN09DWmR/M1CKsUcqJjK/XxxLZgzJ1u1tmsl9hTbv4mPxDuy++hinEL8N/xKDdj22YSqU0y7efGXoHhUC5zsWxEn50mburNoJUrwfa76BzTtCPKM2iGuggM6RtPsq4YjT73a5ZX104u8A5MRiV+Oyzs+gHGE5YN+SawHuW9EdjHd2Rfx8vJBwKu7pfs0eSH20piV4NEqYGl/Pn8U9cUgUsHTMBzcekzuzynACD3glla64pCvwQYjB+1EcXG+RDJl4tRtpiDU09slEdZAuiC3DIX3m2mctpuGYRfZTyLBGVL9AbZt2d8onuzBFpGxFvupnP22QSYCfBPAiDu6u1KpO0Sr4VjSrYFpTiJd+H8w0gzUdmP1doHKmA8IP4u3WbX2jxS1tK0T4vzMOH05nThO2Yf/+4N64g4sx+h0JDNBxzESriB275N9FrhxqCrIqz86sLa27ODe99LKlzSa36AUt6dWhAPICQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(7416014)(6133799003)(18002099003)(10067099003)(22082099003)(13003099007)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uAo5OjUKRFm9McoaKdY8xlpiBI0xriBXBA9g1wzeJ1ZoDpnLYg1mYE5tWCc6lVI+XL0bJiZ2R2/jevTexO7nGq5fkWf09QzjM3cCoP6mpaADB+VbFWfhHklkOl/rq+/SErVqBfTtaqkdocaMZfw7w7KRJ9VGObN4vp+p5/rrL2CNERujCcOzHf2XAWXqNvOGTGzPw1b2aHjC0x+1+lRqb3BR0KmStjI6knzfmgS7rie9PJDjjCPZ7TGgKcMWZ8rNUFYv/IR5EViOVxsx6SC0aIrDQZNDJaEB9GoNlS7/Xgd/WPDKqepTFsUnhMV6cvHVuc7aNKhzHmKNn6eHIhZyCoT857Q2mENxUHkkK2RP47e4miLpb1TKfG+7vS4MXzDiCwkxNXEMZVFFda3Re/8YTg10w70gzFMedUoMef4BoATo5lhX/kE9N86qEeDuNQMZ
X-Exchange-RoutingPolicyChecked:
	1p2GdqC51eU2HHwk4sVpQKf/O0y0pvhDTqzPfkHEBcRMYum8Q7oKoQOOtQJWgGYOxuv3jnS3U1z4+SJgwWmt48ISkg9lzX0gXS1yj56D2JD615RORZl5JGrWbXxIxaqapnNlmJW8jMsjTUowLEihP/5YtrDiAujb8Z13oBy+lxbmmgZ1hRp8YvzCCbX4TY0jG1UsF0BtoB9Ze9zf2QTojVAVERKB12o30vcreE1EqAtqve9Sjz//TBzUXkeg5bgiK/rDoTRGat0xcqNfx5E/UTXLD2GNegR2Ma2a9HQjPPxQJS9q1z+pDHtZxKzC7WVVKlNqEi1i1SgNbnR6cCAmqQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:09:03.1090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f40d75c-895d-412d-5a2d-08df1f9ba36f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6603
X-Proofpoint-GUID: 0GflBXXh_Y6cawvK3xTANYpkY-aCHHwm
X-Authority-Analysis: v=2.4 cv=aswnmiZV c=1 sm=1 tr=0 ts=6abe2336 cx=c_pps
 a=A3soYu1h9hn2xD7k0nk5XA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=ww3g1lXzp7vuzeEaaqwA:9
X-Proofpoint-ORIG-GUID: 0GflBXXh_Y6cawvK3xTANYpkY-aCHHwm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX6r0Y1kvihJFB
 PGRehfAJAJi7LaJ2zidJbofe3nAsRiTHM6Dxrc5xlsBgVr2Zr0443Gd3yHUNn8Yb/k4N9C7F0fY
 u9avLRBI60AjtHM61hp24fYWGl5DSeU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfXyx3fOZRHmDwB
 dwwfYGR3541hu8p8MtNJhYLMfD+/dRYkfkSGmJ6QG4z8E3w3a441lA8QF/xnrW2S1OvhSeNuARK
 pOdkQ9CdAcDb0e2gZN3PQD8nYUYfmKucuycdfhbtxQkV//GKG6z2UnRdwlmHymmy2iQmRM/M8uR
 WiLBZOmwVO+3TgcEOu95PPWQAtZrByJTK5W9u4zN6MwD5QPFQlX9ExYm7J8yjzcmOgCk1jSss33
 6cq5u3LMWJ4aomAUKF4bnQ0GlUUE0Yzvxf40zAOfSwUsiUCHL4CUchfR4FPfrd8h5pCTI+GpUc0
 cfWR6+Ukk49RJaS8Qur9RHT0rcANNRw26IR9d48+G0li/zRLGCdmbkrRhVI+JiiSvnyeK6/sCyd
 n/9bMOxo+3EXGxCACwUOz7PsQ3G7heJRYgaEI9TDEFm1+gR0LoDw4shPPa9D7sv4oBC7whFBJTT
 fC7F+cs3/w1Dh0z9EVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010036

Dynamic (hardware-learned) ALE entries are not removed on FDB flush and
sit stale until the ALE hardware ages them out ~30 seconds later.

The delete path gated on added_by_user, the same check used for ADD, so
every dynamic delete was dropped before reaching cpsw_ale_del_ucast().
Dynamic deletes are the only way to remove a hardware-learned entry
early, so drop that gate for the delete path.

Removing the gate alone is not enough: ALE_VLAN_AWARE is always on in
switch mode, so a dynamic entry is stored under its real, nonzero vid.
With the bridge's vlan_filtering off, the bridge core never learns that
vid and reports vid=0 on delete. cpsw_ale_del_ucast()'s exact (addr, vid)
match then never finds the row, returns -ENOENT, and the entry stays.

Add cpsw_ale_del_ucast_dynamic_by_port(), which matches by (addr, port)
instead of the usual (addr, vid). When the caller passes vid=0 it is
treated as "no vid filter" and deletes every dynamic entry for that MAC
on that port across all VLANs. vid=0 is only ever passed when
vlan_filtering is off, and in that case which vid the entry was learned
under does not matter since the bridge is not separating traffic by
VLAN anyway. When vlan_filtering is on and a trunk port learns the same
MAC under multiple VLANs, the delete call comes with the real, nonzero
vid, so only that one entry is removed. User-added entries are
unaffected and keep using the existing exact-match cpsw_ale_del_ucast();
this change only touches dynamic learned entries.

The host-MAC-to-HOST_PORT_NUM remap used to run before this new by-port
lookup, so a dynamically learned copy of the port's own slave MAC (e.g.
from a loop) would get redirected to the host port instead of the port
that actually learned it. Move the remap into the user-added branch
only.

Take a runtime PM reference around the ALE accesses in the switchdev
event work. On port-down these work items can run after the last PM
reference has been dropped, so an ADD/DEL that reaches the ALE needs its
own reference; log if the resume fails. The reference is taken only
after the is_local check, since is_local events never touch the ALE and
do not need to resume the device.

Apply the same fix to cpsw_switchdev.c (older CPSW driver), which has
the identical issue.

Fixes: 86e8b070b25e ("net: ti: am65-cpsw-nuss: Add switchdev support")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v3 - v2:
Addressed comments from Sashiko [1]
Sashiko gave 2 medium genuine comments, 1 pre-existing high and 1 pre-existing
medium comment.

Addressed comments
1) This patch exposes a ageing related side effect, which is a trade-off.
The same has been documented in the commit message.
2) Runtime PM reference has been added.
3) The same fix has been extended to cpsw_switchdev.c driver as well.
4) A pre-existing race was highlighted by Sashiko, that has not been fixed
and can be done via a follow up patch.
5) Local testing with Sashiko highlighted some changes which has been added
to the commit.

v2 - v1:
Address comments recieved from Sashiko [2]

Sashiko had 1 High and 2 Medium comments on v1. 1 High and 1 medium is addressed
in this patch. 1 Medium is a acceptable behaviour and not an actual issue.
Sashiko also had 1 Low and 1 Medium pre-existing issues. Those two
pre-existing issues are still there and can be planned to fix later but
not as part of this patch.

Addressed comments
1) Dynamic delete with non zero vid was going through cpsw_ale_del_ucast()
doesn't use port based matching and no ucast_type filtering happens, so
the row that gets blanked may belong to a different port or be an
ALE_UCAST_PERSISTANT row. This is fixed by calling
cpsw_ale_del_ucast_dynamic_by_port() for all dynamic entries. vid handling
is taken care by this API.

2) Added EXPORT_SYMBOL_GPL() for cpsw_ale_del_ucast_dynamic_by_port()

3) There was a comment about cost associated with full ALE walk for each
dynamic delete. The ALE size is small (max 512 entries on the largest
supported device), so no change is done here.

[1] https://lore.kernel.org/all/179057463349.3145.13175831323497920715@kernel.org/
[2] https://lore.kernel.org/all/179006497666.2160803.14768308117153644313@kernel.org/
v1 https://lore.kernel.org/all/20260918075926.3616434-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20260924052146.594157-1-danishanwar@ti.com/#t

 drivers/net/ethernet/ti/am65-cpsw-switchdev.c | 34 +++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.c            | 49 ++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h            |  3 ++
 drivers/net/ethernet/ti/cpsw_switchdev.c      | 34 +++++++++++--
 4 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
index 53cdac272b583..bc4e19e2373f5 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-switchdev.c
@@ -9,6 +9,7 @@
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
 #include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <net/switchdev.h>
 
 #include "am65-cpsw-nuss.h"
@@ -371,6 +372,7 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 	struct switchdev_notifier_fdb_info *fdb;
 	struct am65_cpsw_common *cpsw = port->common;
 	int port_id = port->port_id;
+	int ret;
 
 	rtnl_lock();
 	switch (switchdev_work->event) {
@@ -383,12 +385,20 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 
 		if (!fdb->added_by_user || fdb->is_local)
 			break;
+
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
 		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port_id = HOST_PORT_NUM;
 
 		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
 				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		am65_cpsw_fdb_offload_notify(port->ndev, fdb);
+		pm_runtime_put(cpsw->dev);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb = &switchdev_work->fdb_info;
@@ -397,13 +407,27 @@ static void am65_cpsw_switchdev_event_work(struct work_struct *work)
 			   fdb->addr, fdb->vid, fdb->added_by_user,
 			   fdb->offloaded, port_id);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
-		if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
-			port_id = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			netdev_err(port->ndev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
+		if (!fdb->added_by_user) {
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port_id,
+							   fdb->vid);
+		} else {
+			if (memcmp(port->slave.mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+				port_id = HOST_PORT_NUM;
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port_id,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		}
+		pm_runtime_put(cpsw->dev);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index e202bba494807..d3d6a1ef894ac 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -249,7 +249,7 @@ DEFINE_ALE_FIELD_SET(mcast_state,	62,	2)
 DEFINE_ALE_FIELD1(port_mask,		66)
 DEFINE_ALE_FIELD(super,			65,	1)
 DEFINE_ALE_FIELD(ucast_type,		62,     2)
-DEFINE_ALE_FIELD1_SET(port_num,		66)
+DEFINE_ALE_FIELD1(port_num,		66)
 DEFINE_ALE_FIELD_SET(blocked,		65,     1)
 DEFINE_ALE_FIELD_SET(secure,		64,     1)
 DEFINE_ALE_FIELD_GET(mcast,		40,	1)
@@ -441,6 +441,53 @@ static int cpsw_ale_find_ageable(struct cpsw_ale *ale)
 	return -ENOENT;
 }
 
+/* Delete dynamic ucast entries matching addr+port. vid is an exact match
+ * when nonzero; vid == 0 is a wildcard that deletes every matching dynamic
+ * entry for addr+port across all vlans, instead of matching vlan id 0
+ * literally.
+ */
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port, u16 vid)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS];
+	int type, ucast_type, idx;
+	u8 entry_addr[6];
+	int deleted = 0;
+	int entry_vid;
+
+	for (idx = 0; idx < ale->params.ale_entries; idx++) {
+		cpsw_ale_read(ale, idx, ale_entry);
+		type = cpsw_ale_get_entry_type(ale_entry);
+		if (type != ALE_TYPE_ADDR && type != ALE_TYPE_VLAN_ADDR)
+			continue;
+		if (cpsw_ale_get_mcast(ale_entry))
+			continue;
+		ucast_type = cpsw_ale_get_ucast_type(ale_entry);
+		if (ucast_type == ALE_UCAST_PERSISTANT ||
+		    ucast_type == ALE_UCAST_OUI)
+			continue;
+		if (cpsw_ale_get_port_num(ale_entry, ale->port_num_bits) != port)
+			continue;
+		cpsw_ale_get_addr(ale_entry, entry_addr);
+		if (!ether_addr_equal(entry_addr, addr))
+			continue;
+		entry_vid = cpsw_ale_get_vlan_id(ale_entry);
+		if (vid && entry_vid != vid)
+			continue;
+
+		memset(ale_entry, 0, sizeof(ale_entry));
+		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+		cpsw_ale_write(ale, idx, ale_entry);
+		deleted++;
+
+		if (vid)
+			break;
+	}
+
+	return deleted ? 0 : -ENOENT;
+}
+EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast_dynamic_by_port);
+
 static void cpsw_ale_flush_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				 int port_mask)
 {
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 87b7d1b3a34a9..ed1921b428e50 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -166,6 +166,9 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
 int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
+/* vid == 0 wildcards across all vlans; see cpsw_ale.c for details */
+int cpsw_ale_del_ucast_dynamic_by_port(struct cpsw_ale *ale, const u8 *addr,
+				       int port, u16 vid);
 int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
 int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
index 7e06aac388a60..7fbebe666da81 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.c
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -10,6 +10,7 @@
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
 #include <linux/workqueue.h>
+#include <linux/pm_runtime.h>
 #include <net/switchdev.h>
 
 #include "cpsw.h"
@@ -381,6 +382,7 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 	struct switchdev_notifier_fdb_info *fdb;
 	struct cpsw_common *cpsw = priv->cpsw;
 	int port = priv->emac_port;
+	int ret;
 
 	rtnl_lock();
 	switch (switchdev_work->event) {
@@ -393,12 +395,20 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 
 		if (!fdb->added_by_user || fdb->is_local)
 			break;
+
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			dev_err(cpsw->dev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
 		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
 			port = HOST_PORT_NUM;
 
 		cpsw_ale_add_ucast(cpsw->ale, (u8 *)fdb->addr, port,
 				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
 		cpsw_fdb_offload_notify(priv->ndev, fdb);
+		pm_runtime_put(cpsw->dev);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb = &switchdev_work->fdb_info;
@@ -407,13 +417,27 @@ static void cpsw_switchdev_event_work(struct work_struct *work)
 			fdb->addr, fdb->vid, fdb->added_by_user,
 			fdb->offloaded, port);
 
-		if (!fdb->added_by_user || fdb->is_local)
+		if (fdb->is_local)
 			break;
-		if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
-			port = HOST_PORT_NUM;
 
-		cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
-				   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		ret = pm_runtime_resume_and_get(cpsw->dev);
+		if (ret < 0) {
+			dev_err(cpsw->dev, "%s: failed to resume device: %d\n", __func__, ret);
+			break;
+		}
+
+		if (!fdb->added_by_user) {
+			cpsw_ale_del_ucast_dynamic_by_port(cpsw->ale,
+							   (u8 *)fdb->addr,
+							   port,
+							   fdb->vid);
+		} else {
+			if (memcmp(priv->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
+				port = HOST_PORT_NUM;
+			cpsw_ale_del_ucast(cpsw->ale, (u8 *)fdb->addr, port,
+					   fdb->vid ? ALE_VLAN : 0, fdb->vid);
+		}
+		pm_runtime_put(cpsw->dev);
 		break;
 	default:
 		break;

base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
-- 
2.34.1

