Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB63F86EF;
	Fri,  4 Sep 2026 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496703; cv=fail; b=uaJnBlrrvDXxnwwhgNp71lzmDmygYM3oA/QPOSJoNYpIUeg49m1XnpPbFeeMn37skP+A6sh349qvwcor1L2f0d3jHRBNrqA04EQpRbMZnO1mIsDZCwlXj/pEc4nu9xJuCK11XhMp1mhrF8Mw31+ObFvYOYMzLv8PP8e+HzpDhTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496703; c=relaxed/simple;
	bh=+voeZS0767IcDbR054ILTb7gC5/As4HJxHv0YiCjWZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ksa1BXkl43iZj2NRE2fM9Rg9WjPNgE5QZRq5zkMGeTx94NaXQJlR2soLjiDijj3/sC90NVuxI7FpFtWdR3cwpWZgXknOXwU96RwqEvlOKzmy9Gh4w8/DxFOH7F4h1icJu92m3rvZWRU16+hlmbyYtFROsX3atamdShGxOPt/ASo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BiIqp0IC; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bUsoi3ve; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BiIqp0IC";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bUsoi3ve"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sdX31100214;
	Thu, 3 Sep 2026 23:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=onhh/EiG5bxFis+lQeBoRNrz1SRvFQuCayf2OpDeS
	Dw=; b=BiIqp0ICFW+X9Lw6GnBgm+NSczPBwD1kSRoaVTTXWJtrh2tznRsym9ggl
	2YwB9eMWBJyXNu1DnZoAOpzxpyWcf94kIm0Fe7VhnWxjkkidZSAui4rvsAXs07gL
	q00KwOagQtrBLgznl28UvRetnjVDTYz9y7LsRbPOYHix33BH+Rbf2hMbAwc23Qum
	sa53iFJek0H6JOuSPJWBMSzyDdIIQUywOVSNc1IlO+PfVwMyXmcX4RGghcRSnBFZ
	6LnJl3FqOyPwVBLuRV7d/GCC4CgoUK9ArxsVYLCPcJslHowC3oW1PNhyA+5qJy20
	XtXyqrygJEYGRWQukTY7+lt4X1Y9w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8nn2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:38:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l//Ze5uCeug4YarcxvyeRdsszbLdugp34QPTLXiYsFlbhThMbNANwiJi9YsE4uIdi8Doh8ZhpYXWH8+Z39RuyE/YfHUVWyT7IRUv2TzXfMmC4VjYM7QT7xwTM6mbeLgR291ml/BujNL2ogaF5Qo2HPTwrhjkxn55y5cpPT2YEcXOmWvgE9LA0hu6WYEFSL4FktiwvqodRBLPMX85ZK/pukF5zW3r69gqJ4ZwU2ixoVd0IcbFjy1n/0UVUaveVk57XqhlUjRCWnO9mLy14XhkDmMk7UqrE+QXrofekG7/74/6dJaLY37spyy4x6Rv/A0dj92fee7ogMrEadCiORVKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onhh/EiG5bxFis+lQeBoRNrz1SRvFQuCayf2OpDeSDw=;
 b=i5Q870RRGo0eNOy3KDceg0UfAMuHc+8oMeYgEI3kFE4hIAykBJ//PinZZyot1U3dMFaHqoP622F8IKK+xYBzZ/5l2qCCtEsKE2m3oy8Nb7pk+BOPoK0UJ6W6Gk+6Oy+b3cj7zCx3tHAiTw3FV2y0GBQbJqVGmuFG+cqhn6dg1zllX7qW1aSHsUKCWDkiG5PIFcQ5DoHlXouRZ7k8CPsiK1NQfOa1w3zt0uGCL7yQ8l/afi3Ib0zpzgNkiPspe6SecVeYLv7pgATPEOVapRyorG12NaqBRBXq7Sstv52NgnFxhm5bYKOK0Mow5thxaPX0pPT3LDAGSYNKCdTODXivxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onhh/EiG5bxFis+lQeBoRNrz1SRvFQuCayf2OpDeSDw=;
 b=bUsoi3ve+fAriez8HyqZU1iF4x3EWk/HydWLOsamIrVc8CxJ4yWNB4xmg1rDsq/6MxoCKNGA1wEqaPSdutJqmkgs+AHf8p5HP6K7wyhizO/ur70PzYdtm9KE80QE7Fq05rl2JenUFf0LfyChFhliZ0a1UvB/aN3qPUDEqjsnBlc=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:38:14 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7e) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:38:14 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:38:06 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:38:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:38:06 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1X3831572;
	Thu, 3 Sep 2026 23:37:52 -0500
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
Subject: [PATCH net-next 17/33] net: dsa: mv88e6060: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:23 +0530
Message-ID: <20260904043724.2955444-18-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: b25fd664-3445-4236-bb19-08df0a3e5562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	bVhMv/fXH4rhy6kCFv3aiRFmKGexN3lqD7ysfZa3/KRLqBm0vsn2k6jXUcD0K3NTOCDqq+NFGPJWBzWwANk7bQ4CUS56pJNVeTZZaDLbCBaMBIM2JgjWPucsWHXofk7fXpGmqGm1fjMTqqvhTd0zz3Iwgpkm1ZIdyMMVTyLcg/pqvYnw5l9IMfVUIMnxAitA3OXcmrFkoyHk48YpUcjmA2bXNC6Omh3wxdL9Rfk7rPHHqXjlXEWLxgB2F3y1B/QLYyISxxYnNlfvWI03PS45LP+20fmtCvXtEmeFCGAohjzV405D0cLYk5tZLOmLN/zR28qVx8jFT1+4RlTue6fdURZDgOqcZA63/cRlsLEgb5LUZI7BLQ7AsDkcx1dCzrcwiMePs1HlJfZfBfTuYzwPYwTtyVamOXVy+VMMaAOGA8mQxa3N5tNVXWpPoNxUHw4epYr5M8Xf9ToPoxNVJWRKIK+F8dMWe0vvenXSs4d1zqGtZ5JrnyXyOAb8rJ/CZeKmtVrrE1x3MpADjmSe9W3/3l3PCbIPm8BbKcFQ/heMrZPH9eoVN9Z5YpR8GOpzDfeJvjerkbMDAaAW9eh53jDncLm+ndvzrVI877VxFHD9yvWpwZDH6yI11wcxZLxDaUTHKQspz0emNsZZ6X3c7PhJSvNDcMK7i0IUK0gZ6h9dMyRQkQrFzFbo6wJKdSOqzm1TMpr5qlAcSa/lHjG8moahlnJw7pih2jIK8D/dL5rM8pu5IE4xWpQD2Xts6U1XEAFl
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z+1K+USlDRmLo+aHYm6WKKHWntR2laVF2cDL8zyLVX7yCpBjQr/nrsMB621fW/9vFAoCyJAhQZwaWjswfv1BTkCncN4kqj+kXnbxHdXtEJKq1HM0HcmWY2eHVWGsqQj7jec3AUnVzN1RNBTOesdmY1j0FJN3l+eFY4YJJqu5d8sFqVv3u/QJM+MElUZR2KhAcL6c4A0gml/v7XRywx79d7MUOZshECzPTV0D09NEQpr2Rrp+dTRaINwnb4y5WQ+09o51mJcZDTuJsu5/ytqxSa5IBH/KoH3GUOXSGxcpUa2fTaGQJHtjFNSRI7pskQHa0fAqWYtuv8BjDNzmOGuyl/nd4fgG+al28NOWmIQSCvVszfskJBxf1o6BMZobQNEGl4RiNHGpBByJDbdlqHheG0FBoCZ5J0IpVZytqYTteMDBm4ZEciyBtHZnvNOBvdI2
X-Exchange-RoutingPolicyChecked:
	eVn6WcHyEnj5btXoGU679++qrTWZ2X1V5owvICHyhTYI8q4UCFoTRgveWFOgIvxWF3BDY61a91KhnrgbwTXpXD0XfHTay5CTq72MqJE8zF6R7twLHGfppYrnC8gXmRGtSWXR4ogkFwzmWe7AAc/y7ouc+CxumX2YKZCv3VZTtV8sbNW2k1yI2KYOXYH84HqIxrHFal6ZbzzbhphZUQv8hvK60JvZC5aMLsmO7nQA5L1Evh2F/be6XQq4lexKq4IBMwX2DZm01IxnhGvqUbeAsA0JmBt6eV7oP9+MOUup6jm6Fc9KDIso9qpdN872ScWLhEH2+okIxFJW3RnS0vwpvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:38:14.5686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25fd664-3445-4236-bb19-08df0a3e5562
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX0CkqQLKcdpOT
 iybufFqP2IEqc0dgxsgXAhoZ/o22RdF+5L4Fv1gu3UgdBWC3ei5hW93EWhlDg0l8jQalpPtNcON
 5Hf5ONTkcGVLmPzXFQ/ZgYZG5eyvTec=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4b3d cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: 0uTabsjH6t8ZM2FlIt3aHQThyBsfFlYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXwkQqUWRRvhR+
 3jw70xwbSnL6UXP6t3ABbPAsuzJNIKQ4FDnsI0C30bpXFsBUkjYq/CpbYLm/NZrvGQY8M4e1kb6
 dQEKsUs12tG4vZbesHKtfiJq3hEEGB58f5y+IAw2vbH288S+pfGyUK+q2K/Vwc/K6S4xq0kw5SX
 4xkYVIDuV6qWWcfrY5DtI7gWJXNLRhENgFPvx00nGkizj3ML71NrAjemnYM1KEAow9tEZwJ66CZ
 TnTG6kfCT0D1EWYYbRoQyUJ9NdJCvjUIt9Ct3jHhmrsP6LNyytqkLeNy7mM7ar7WdGnq38/6M+Q
 0nrzHDO+ERlffYEDRZ7fFhJ68NOWNrlHFjQ5NQk5jKOPVRD5hST61U70DIwXWdAOxyAbOBm3B+w
 sr96M/uhhjENMeN7mr8LLnnmUc+hCBqxIOVAlnwrERD0EOFDK4ZKmRSgLfqkzpnC8kI4IvioPKk
 YSaqq1Is5vqDSJvS4zQ==
X-Proofpoint-ORIG-GUID: 0uTabsjH6t8ZM2FlIt3aHQThyBsfFlYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/mv88e6060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 9c8ac14cd4f5..64bf3d759d17 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -362,7 +362,7 @@ static const struct of_device_id mv88e6060_of_match[] = {
 	{
 		.compatible = "marvell,mv88e6060",
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static struct mdio_driver mv88e6060_driver = {
-- 
2.51.1

