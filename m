Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3714014AD;
	Fri,  4 Sep 2026 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496821; cv=fail; b=VMK6P9EUueUeZ6dzgMaH24oGLdGLGlMqu78xQoN8SsBq+xvS/izHGc9VRdK83VLgh5+Ds3fob84MZ1jmXma0TjUAAnd/h3f+DV4swrmIEH9wKAox6NOy3mVwxpahK6fPagTPIQNbN2hqncXozFoF+6FGz3cloPwsZvcFuN0NieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496821; c=relaxed/simple;
	bh=wv1dQqAEFpJKQe0itv67d24Pl+9cnun6ZVCoh9eTaPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGm3pq9ZTq2xrC12MhXrnV4pJvsaFZpinuZ75AfHu3M9jRQMEpSk8+e0p8D/mEhMPgeg/Uke1KDwOGv7Z33e2RrejVi2I2zYS4jyepttuEFRW2uxqtfcYjeZPLGGX51hDjFjZ3XtlY1cDMOsIVjYVBxNbgT1AZAOPWAgCMOCRtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Z3OEJZa1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s3qPdhST; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Z3OEJZa1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3qPdhST"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842t6ao1101474;
	Thu, 3 Sep 2026 23:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=36+30dG+JzHc7dJpejbUmEgsU7Dq5Cqz7cwfBmgsR
	Lk=; b=Z3OEJZa1/pQqXzEYBg8E1loJDQJDQJrXNrvdlW1DY1geXQOH5TB2d0SRz
	3neGX0FIAwM/Um2XGZRu4Ix3lJAXgMliGVLx1qatDfqsi0r/AOsNSfFdVhtcJT2V
	WS0WMlTEORBdn7WAiyuqPSslk3SjVz1+nNrmZdWBTkyECM6CVD9PLFTn+4A7HWOQ
	eJCus30YXcS8KuUmdq3etDlByYnfw9CpO2NPUYXAXT3cyWXYC2x6B5Vyt0xkuiGL
	3ok9gwQBFi+8jPgveOmxrg1b4G9BK02m/v+GysC9Cv1KrOeC14atkish4W0DrXEo
	FRLRqNsbDxKbrNl7InGfT54YzAOFQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8nvn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:40:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0XoOcvisdbUfD3OGo7W0JdV80La0PEdMerBHUyFMWRN8+6Aa9U/GNGNa1d78qff8inDllCvDyVgYOvu3Rp8W+KxXNJeFW89wqQY71F/I3K3kUdt1mSNi0oRS2hxIdkXYWpmImfPBKDNnE0Wt00B33yIzLxr95UKJ5x2Bq5IqQZCCmN0apWjR43GzTDWJoYIV6iB9vYXuOVkN2tQZNT2KgbLdHspcdbLIRpdbRdFj9DlN5CgdewSMYWycY55jMW6P6diK6zGcjZdGWbfczexdKa+p3f95xbquhoS566FNadd4k7SOfwt5W9IpelJrUL5p4Gl2QcgJjvzRmjRJEHCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36+30dG+JzHc7dJpejbUmEgsU7Dq5Cqz7cwfBmgsRLk=;
 b=MlKSl/q3gCWHkOU2bRcjTS7+s81aydGg/CeohLqWkq8XYyKvIHUr0Mm99Ysa6U688lYhW5opW0n0jacK0DGdG43JInZbvibmk7zkAEEjYBTQs+Ri2HQVabl/ejG95phcfcRkzrxjgJGMj0IfmEWRwkK6b9p5YChCvOTCKg7x1uYmsjn4Hu5qj+8qYw26S7Wq8JUhT34+5ytMl2lVxVvrZH4OJyXbblNIq92s9TeVMV0Y6wBnyiFD1FreYbJoKlEIkPvOxD7s8GOKEvhD0rnJzb0fzKfmJiwL0sdsLq2QdtFMki4rPH6+pzO5sNPDLjA21t91xgrfvkF7duLqdAHDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36+30dG+JzHc7dJpejbUmEgsU7Dq5Cqz7cwfBmgsRLk=;
 b=s3qPdhST/wf0e8L1slnh6KpU0ZbICk4WRuZnhy8IjD+JSnrk/VozWJ0PZvcnNHeeMOpPJ6n9YRAAApn7P4C3SIcauy0z63JLMytILvtJzvcrjl3n02tOgK5Wc1gf/KMYJpT6Bogdm+EJAJfXry7oe68JYILrwlDFyISz2rQV6zQ=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:40:13 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::74) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 04:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:40:12 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:03 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:40:03 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1f3831572;
	Thu, 3 Sep 2026 23:39:49 -0500
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
Subject: [PATCH net-next 25/33] net: spacemit: k1_emac: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:31 +0530
Message-ID: <20260904043724.2955444-26-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7b7691-eb35-4bf7-d7bd-08df0a3e9b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|10067099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	ROxquFqeK074UoCWIChWw0FzPVATDdM8R51Sr8Rm2tqHna035jm1ttGVdVH9arIxbFyaDWtl9Fa4LrrXT2FbR4/hjjsusQWO+UCK8UpkHTXUkVIkI7OyT+5tPpPh4DTWJAw0OqFkSCIw0h56TX82+ofQqAPeuRqBXgaA0xG1pOEVpw6cDBKVrdWnqzbchE5w+FGyxqdprwp6ha9bvGh7VGor8iyfTUdSlxtsMxFJa1/1NuoXlyyndzuH44bHq3Uw7tyXEH4nPs5LeQK/knOr8eAMssswFIzFLJCgV2ME+xuDbbbT9X7Te02Kl+bDo5UPrXWtkz5i/328uWQGj6WObgUdrlm/LOa13NHx18EHWT2ZUXOzGpUsjkfX5XSaPUrYqt+uaK4wo4HeoregYsVc1F50a+0qp1qeZ3E3ulKD9F4R1VqViFYw/y46f8Wc8Dsb4SakPFmfa2vrJdxXzo27hWdKqk+UnwLqoSFQMrWXfpjccLHccdfwisKCjc92+mIUK+H4R3B1PjCIyquVEbB23T45+V/eavPVHQZSFSvr9/vLXQ9es1saEa+37ygC95DjLDEIEtjuvwQP/ddzkajY7Vvq0UN62eYg+dMhmjVbhxhw9yIXx+V1PVCQfGGZSi/HazGIH+XcAqTVwa9uvvgpjj+VgM1NOWs1bDnFc7ab1iIqMLZx2r1uNCwzsxf2/Akles61oZrSMhGUFFzSf3T3Ho3BforC1ibB4IzLjXs7QSo=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mAr9D+2RRZeznjIQKsxCjh/82pCZv6LuQa9m9U6e6GAaU/cK2Js0udHxtBEzktf94zF3cgKwfzJP/9IseWy4QRs0B/v6wplBip9QPaWYb47nd38o95BSIR3PyuQnElsduJWuFV7cd2OZO3fTZaxQHv6G+69NrsTe/tAZvwFb8AVZ41iJpi4re15XcrfJVzTM6nd84PpUgIhDdEQON4XxUUeg51DQV4AfsRKyMI5xeUnisjfdc5xvJCnikI73NGCv8VoeupadE05K2Mw2dmxNoOO90cS1kOpetwRHVV+73DjYfyOOIPIzZPOrQGOIyBJLPestaF0bUbFrkbeeSqjh6UiQ2RnFvoUEy9dnxpPhUczhgLhJI/Zkd0C7J/AnIig81yMAdmWTXF8QPgYeWh/UliqXFl/N8E/vVbhIGxVDrzoNZ+6MNFEe6KAs6ZgEdUNc
X-Exchange-RoutingPolicyChecked:
	bSDojsjR8phzaB7Pn+AuwZiaT+3F4RLzf3/9YEvovCMnw9Jr4Yh93SED5/1TOpfdANaYyu3V2HRS4NKdpdGc1E7MlsJ//GSRph9xkP4R5tTBOKsNXJCMSv5W9iFHqSNFA09z2DnvSJYNT4ozO/GwBn9aQI3AD5pxieLd9U58f9nXCm2OqRfsaBgo/VRL4vDw003hxI8w+JGwKAnXop5JL4kzIiyh4b0OJ3LTQm8jSX7PX4myAdka2L/VTkgkpZfmQOL0ZLmnQsYv8xHFM1ahbxiB/M84deh/5Sz+i7buoA30BB9JKRIyq0AC1eVmdQP+OZcgLwaAwD1+uZehb9nV/Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:40:12.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7b7691-eb35-4bf7-d7bd-08df0a3e9b98
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX1TznYiS7bQKk
 cZXXWbW60iJQ/i+KWELadPcJ+VRdRffWtroyw+IpMu0mbeqX/geTYK2Tf5E6oJMBjNf2jRUyX4T
 o78bb7tCZEZSt29oTDQAww1aujOd4yY=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4bb3 cx=c_pps
 a=U/rLDH1MEKAiLKQqfACAEw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=grVyPgic5qY2pTMg7k8A:9
X-Proofpoint-GUID: x0PcGl1HyaJpfV1AMvvyzMBFZVf6LBwn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX3U6TjDW2Zxuh
 t6sbqRUnCJfTVZSthYhZnIVuIwzQWS0hlIAJYt+9cWg1MMg2nNYqoIQ3t2GzccvXcPjnRuiIP0+
 N2NPmnj1Q6FGl4q473GxytnY7wkqmWGHjwZg1DyHcYH+jM6iJ/z5bOFIQrESuL1qz/vHK8rqnfX
 faICkjcz/YBE1Qp/nRzeBsN2wtPiyu862L5AjqvUXC7ubVPt6NdS+p89M8IPCJW0GT0RdL81OXB
 wL+nC9FEE7RekHHwbm3XtCNL88Jk6qwKf5FrqZNkC3GGY2R37AYUBz2WWQ0ZZnMN/hmi2hUywQL
 TSD7plmR+LvEKYQbsEWjXrmpW9x5+yHg7Mq0Avm7ozaIdjXwBkKizQMfQ+8ZhxoOKTlGjqnmrFG
 qsyIr1YCQBJjOsGHZOTryLdNSQ5KQCkw+JIqHozF9V/WwA8rzdVXozDdQYSkweiWFMFVxtpfesw
 pEviXVHUyEHbwxhCtDA==
X-Proofpoint-ORIG-GUID: x0PcGl1HyaJpfV1AMvvyzMBFZVf6LBwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040041

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index f7f16397a2c2..29385d78fc4b 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1161,7 +1161,7 @@ static const struct ethtool_rmon_hist_range emac_rmon_hist_ranges[] = {
 	{  512, 1023 },
 	{ 1024, 1518 },
 	{ 1519, 4096 },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 /* Like dev_fetch_dstats(), but we only use tx_drops */
@@ -2066,7 +2066,7 @@ static const struct dev_pm_ops emac_pm_ops = {
 
 static const struct of_device_id emac_of_match[] = {
 	{ .compatible = "spacemit,k1-emac" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, emac_of_match);
 
-- 
2.51.1

