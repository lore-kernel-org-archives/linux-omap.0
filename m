Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A593F7A95;
	Fri,  4 Sep 2026 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496779; cv=fail; b=uLzJ/QG8pL3BcEJTYFH4Gn1deuQHERNfsl6lM222BSq8iX3HYOPUgekpyS6PMaUKupy/mGQjjfduwSL7cBjjpsuW2Dk9ErJbauayqRuZJ2TR+olkXbXbucpJeVP4nOrR9xTfHaPa6BKZzfxR/nW8Mgd8GawnbvUxEeLL/iUWYCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496779; c=relaxed/simple;
	bh=pJrQsZv4gW43zauQSSTgzMNcwujoH1qJ6/H+GuXRgZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejw4kJ8Gx4ZIyqfOaEQ0aUBnnIAwkcnS2q4pqVtXPvm5xHjPMdNaWQWjjgvWqWnathnbAe044QWHgykR539Bq+kHqIJ/rMeAaQxldNuJvf8Wgu9eV6vFi2egiOOZvQ//InKp7gEeBzRkbUshe6ZChypc+hd559HYQP9ul6p4YWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CF629SRj; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LhuKJQ0f; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CF629SRj";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LhuKJQ0f"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sY762586904;
	Thu, 3 Sep 2026 23:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=caZcUQpJ5GKs8rpY+p/nY9YWVXQUDgHnL6Fdo7229
	qc=; b=CF629SRjs4ftL5ErAXClVps5PpbOC4COY5yVsDjYYEw3bm40uW2+sDTDM
	PeMTkZg8PLiz1PYpM6itiVbnfQ60D15vwSmqrWegMItCiBbhS9CbpndKv/1bxjmG
	xHdN3o17kyeKrhZp/tD8W1zWu1s7IKLWQE4UsW9KYVuwun0D5B3Aark7OPaoOjRt
	vIxX1D08taos+qRX5O5O0Qtu1K0Xwb6hyRfm1vzO0njt12iTMD2iTc03EUtAJ9Yh
	lYSW6NEpPpR4KhKRHkaa7Dt1NZEkjnukZDwkBLX9DKdR1mSYcaQKg0YJO2bK3U3B
	vil4UNRC+Us5+Krt8CsywNH4QgRPg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs919-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:39:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLS1z4WcQe17X8cHj884Ledt4WA/9gHlPRInP5U5jO4g0fVIMTuOOU9T2T+00eEw8FLsF9B8nAzYQgLVKCLpbU9akhMIMs/4jfN2SLWRnDlHzd4izLc8to3/0iYZed5m5/+9Wnu8uzgcfF8E2Tvvdkt81iu+yZYRDQHh07R1o8BhYFGVddzBTyO+OqWA8q6ecLD98kS9mlRM+rLuZ0SgpXHMu2nd/GeKqEkG/2WOgVqT5M1C8ZKReoZyFwTdwxurFnF+udSs6UolPJrLYwxewtA3OeSPfaNdIyIJqfux2QU3LUZ7BbhsZEUMLiJ4oPuOwCQu0Q9eRobtkJZTmmp+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caZcUQpJ5GKs8rpY+p/nY9YWVXQUDgHnL6Fdo7229qc=;
 b=lAKH86l6ZzxdtuMfcVzBEXNDzl/DEFZXRuXkHIf7qumByC3G4hKuGb/SRwA/mheCiwDAVyaHLTOHWG/H0r1Ny4cbC8UvkZiNpRzdBynJIQUhwTggI6pQI/jcs2QpyMtm+8HO//jaQFt5yQ9qro0QdLXd/L+uYWUf618jkvTqt+nOdj4O7VDlsCFvdaTYSv/Kd+8KE3Ls6Jj0/Bm1HNWLMe9BiklDrFZcnTtWuaDU43MyKn8boyKTVjgP4ZDSbLnsh6SWQqEDOVldjyIcI6hmEhoFcGPfdGOgiHmK+bbBd6MDX6WZWgwkiflu/rFebLZbvxcXSmgO3eO2Nc1g/NBc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caZcUQpJ5GKs8rpY+p/nY9YWVXQUDgHnL6Fdo7229qc=;
 b=LhuKJQ0fXn1xA0fmXRFG0YmZj75xf+EluvHQgjTTxLcHn3CidM4J8m/aGS7cNin9Dbb1clcbXOmTuba5nBx9bc6L4wGbt00jwJxtQTRMkTFZkZBA36W3YQHwKA/JpUS/pUcL2ELxv60rEAQNiAmBvZ3Bi2jjZP+tw4LmQVPtlhI=
Received: from BN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:ee::9)
 by PH9PR10MB402116.namprd10.prod.outlook.com (2603:10b6:510:3e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:39:35 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::8b) by BN0PR04CA0004.outlook.office365.com
 (2603:10b6:408:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 04:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:39:34 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:19 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:39:19 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1c3831572;
	Thu, 3 Sep 2026 23:39:05 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
        <mailhol@kernel.org>, <msp@baylibre.com>,
        <florian.fainelli@broadcom.com>, <jonas.gorski@gmail.com>,
        <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <kurt@linutronix.de>, <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
        <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
        <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
        <clement.leger@bootlin.com>, <justin.chen@broadcom.com>,
        <dlan@kernel.org>, <rogerq@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
        <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
        <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
        <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
        <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
        <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
        <lgs201920130244@gmail.com>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <spacemit@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH net-next 22/33] net: dsa: rzn1_a5psw: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:28 +0530
Message-ID: <20260904043724.2955444-23-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260904043724.2955444-1-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH9PR10MB402116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5ec5bd-77ff-409f-a739-08df0a3e8504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|56012099006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9KrqjhYS0gC22F8CgDVqWqytFOf0d+GLbmOPRKD6a0xb85rS95kVipDN2i4kWs0MMZ52AUPsa/hmtEDZXlUIIubI/oISGlhfLdloYQlcEIddQot3BmpsDxepLlNlS7NxXNBR+//hSCfcq9u09YTZj0DUOurIGWeAdM9vXh1Btb2cwrKqhBsXF2xazZPRQTXi3ULHLSdfhB1AvaOv9vSjXEaPliHU+lafsXy02d31tuhG1k8U22uyc9og171b5zEmFrATTZbf7vG99speZksJyRq/+xaed/Fek0SfCc7uYt1jVn1X3/JPiVwecOhiB0AgcHJSsek1VhvHont+50XR0+VsoZ2GXt56s5oEbmI6MofJ68FK7Gtb16SawxKDL01NU7GsqGs6GOEmfuPOw/ldCGLT6kkMJNVsJ10HRfc+9qYVGpy70nWJtoe4cP2DYMMOj4J5pQjQ3V8kZzHRD+oD7S5KG/6AkfYGJC7ozMWErPMlAmhYS07rOMFmuukQKfLBmSYxeSyF0sGvSAvPP7ZajWEIxfybNCd4O+GIAR0A5FlweX4L3Wp3wimQnnYlK+DOhYye54mARnQ6yE4NSYMNTIsAeCi0voKhO4rViZi7qPAwnbtNJVdlftLp1DvPQDiIYNMvSE8y5Amv/oIg37XOQ2WZPAiIxMpSUXQLTmrnKcBKuw/IoVCzRdB+2Fuj6de+Ecw/ZpnJMRJh4vkGKY50M+9Wx6r6qbB/v9Ehk+2357DppYMb3bqRkuTZP351B4+R
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ae8S3P3LxofGmVHI1JYK9ksI1P211HCtTsfxDdsHu0ON0vdbIMiLo0mUq/7cqcFY6+bpqXeGDvePwjmRQmLfh04fTp74eUt+u3nuzrh+dWNnb5zaGLmLnJ5NO4EMhI8qKyL0rPkdDsnPhNg3ifz9b8iCYN71/mGQulBVttpjy1UtGDnp/GdS4gwPuATrb4TdQF14bp3npIuf6Em+tBTNkvSu/q47qMjRv+JahtrtJ1sNQJM/TjkIM2qnUg9GjwfZ7hBnpDItSAC5Url2oKgHvEke+PRWIrhJbVj+fv4MbuyWk1sclND9JOUeOooYRC8IG4lf7uAadw75E7bzHvKQenJnkyvJgSUBn3i5hmsKY1ZtZdzffe6OgcDJvzaeu5zrF2Ajifae0E825/pY3qQBBzJoDJZxRMil09L0JMLk//w+MfGU1zTCe3YWeaEjNTZH
X-Exchange-RoutingPolicyChecked:
	DcxH8Rvri8WVddc1ewFYf2Jsaicys1WaRsejzhMWn2TPSxQDXrvZhPeaxGHzy8UwgFhoE6F7nSDDIjXAo7c4Vzm1XQAQnFeINp1E9+eb0sh+mJqQfrzY7uAMsVA5QnyQ9GarHk/WwMFKZHlcWqfv1NO7WttRqYBovO+4f4xq+2EtQnQ7NWRHlpoRQPMYyt5UdRsFEigUy7rgeaLL47Wy+hxN8tpvZvc7WlynmG0rB0R5HV+7wZBQiIuaDl5rZDk8O8ocoYJJZB9lQKn01V5V+s7BBlXo9fAnkf/vNTWV5BqwFwufKX6kBKe64h/n2qpefn2VCn9Au7VhEVU9lXuN/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:39:34.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5ec5bd-77ff-409f-a739-08df0a3e8504
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR10MB402116
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXygkXUkFB/ax0
 WtLCnD1qJ+AQIEEVaf3qfJz50uI/LYjuB5NL51YSw8hafgq9NkByZBcBvLSwS3x3Z4D0S0ptZOT
 Bnh27TGCRuM0dMtzrCz/lXuIPBgLVh8=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4b89 cx=c_pps
 a=hqbemJ87bpGpMWfnijcotQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: h-lv2XnVjSlfC14t3jV3YvGccx6aJWfS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX4uhxazuHO9tw
 cR32chyJToKa652LoM05M5eLgfMEqVFybkBamWDQONkGl5yGss9Hl+eNmwuQ7WeSq26JQe/Vo9J
 RtIjLOjamHUqVgHbC+t3JJaM+9q5ZuNPkaNdORddQ4awoSsq03XJdUYA8390+kYd+fr/gfXD/Fi
 /4UZfpaR6FKmHbJxTvCB5BUgc2tco9h4IZTD7fsvfoIMqnYr5QpxDIeYt6jCH72M1xMVH+hL7wV
 ARcOhO2QpgbaVHPp3Sul20tzZanLm/NJGuwr3QDybhZrRUAxWrIT8tytpZyv3rPrTU1vM0XM6uG
 mbEUFTxfX7AZ63FwpisGo0sBlap9Zbqk/TIHTES7DgF0bkCYmVmC8rz01dbawqTBI9OayGQUqlj
 YIPRM6qzNwDtZTdoaU8ruhRbM28GKNZML4NlXkg66YHcvJcD0plmOkjbn4hUvPOdo0RaeAh6MU6
 smUhYaXUBTCbcwnTqUA==
X-Proofpoint-ORIG-GUID: h-lv2XnVjSlfC14t3jV3YvGccx6aJWfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040041

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 4d857e3be10b..85ff1fd2bbfb 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1299,7 +1299,7 @@ static void a5psw_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id a5psw_of_mtable[] = {
 	{ .compatible = "renesas,rzn1-a5psw", },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, a5psw_of_mtable);
 
-- 
2.51.1

