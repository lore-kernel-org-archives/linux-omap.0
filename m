Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275E3F4DF8;
	Fri,  4 Sep 2026 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496549; cv=fail; b=GmLItMC88Od09Z/usS9vsz9gsoImzAZwP/B815Tpfn6pBDx9Q/KIwPVF2crWoq6gg+tAPriauS3BYtbnzN2bxS4s0LLVlUcAJXbKV2a6HLgQcbitu/EasIExa5IY9lpSaoer7u+ILMbc87KF5B7kvL3z+nN+tzrSpSgS9U72OpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496549; c=relaxed/simple;
	bh=kP/3czF06VWHe8X9jkkLuAAiB/xPpMLPONGQZQ8LWJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYlRy6xfTb4q+eo42+jkDoWCVaNNWuXHRTqTyZDxjXFo/rFhHu1SmUQJVRI276rkYZWSr7qWVfSDw5/Sd+hVtn8ESxv97dA9pWqakWN4vmunXhu4qpbq6BIQwT/81pQlZGnwniJ0yL/WQ6fD4bfHoPYgZuZBX4oh8raIziv/SGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=YyRiczau; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qoX/EokS; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="YyRiczau";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qoX/EokS"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842t1pS2374230;
	Thu, 3 Sep 2026 23:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=O/sA6vQS04GJC5rK1JTLrpFFQAfH8XXfAWwNxOrZv
	3Y=; b=YyRiczauNlzPo0wrzCIsMqdaC6RX9fSBb6pClu8kCyc4240wCExSguE28
	ZCS5Q9IDqfEcdcizY12DmJ8d4R21ZAkSFGn0wGyE22Il2j+qZEGxDPuNLipZxsiU
	iK7kRtmNP5vBJkxWAC9sIt6DyS1+L9MnoaJiJV+88bFQedpcDj/E3iW510gW9SXQ
	cWr8gji0KL+06J8A/wM8oZey1XqcGrEoG6xtFx8GLvdt7z8cl8zOoW1IShkTFGVm
	lkpUBvzF2mjbOXhKPw9bdO1Xbl4KHqp5jrY0oVkPhVDyabhIuFEXSv5ygvZm5AJB
	nTNcD+ABq+YqpO1fM/yMEea9NOhTw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jexdm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:35:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp5xs1vslTu1qPe2ZFYshQrwn3m0xJ54Fm/GEwotXlXMQ8uolnOUEgEhEVoHUOtuH8uyL2hkgD56g1Y0ctAc5AHTxJXg6mJ0r5MkahKMuY70RkEjfs+8E/biQY1xfoTZGQxJoxTrwDXB6uJOckkjGayUoNFNbDraLsE7sZ7OY1t5oaSnl+XiodDsyz6Gzme9G9vsnhgjoPNo2znXf5792Y3a3TZND23kwtHrRJpSuaKt4J5rxutWOswIRgINlsaSCywgei/0qg9IyYx/EmV3XRRC/H2kWDAR8SGH+XvqjFHNMGNbh8sjSNnYpjr2/z1yi1AYmgYW1QHnm0Ifaek5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/sA6vQS04GJC5rK1JTLrpFFQAfH8XXfAWwNxOrZv3Y=;
 b=b05NlO/NI6LJ/V/1qCszrXWaYpYDrPudZQDWVoQ5pm7c13IGE9+LtmxTmMpr1DGpqgrevk71kWNdVz4RkNmlzPGKRnNiZry7d2+WfDoltYxuu2HamQWImHI/EnyhCLZCEuAHrPh2HOVXQD6G1hvMrVrLu09He6LrFOOw6GrUObUA14p/Y+h2weU/GeDHEeMd0rh4MX4YlfNUmEjDyycqSI3JxzW5MCZDS+LhZrTReRgRX/vGJ2Wgd6gu3RU6TN3taEAC/iYrXRUGkbluTGFvNoH53/lQowr8VXS76U2EGp4+UcUNZzYL7MT8jNtUwO9SUJRTEKpBbRwGtRNMyR1cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/sA6vQS04GJC5rK1JTLrpFFQAfH8XXfAWwNxOrZv3Y=;
 b=qoX/EokSpjQOINqRuADVH2AlMYuZ/RB0MEkdf6u86y3EGP+ODD4U+hamWGNLltvs/7cWYfxpYDhNzSx7mZ40PFPOHDtRoBLP34wNfeOKPUuK1THxCPiN/qCt196ltnZfLXlQ2PIjEdSdWUqLgbb6iMIqwcWOMdGfYWUN1W7bDiQ=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by IA0PR10MB6745.namprd10.prod.outlook.com (2603:10b6:208:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Fri, 4 Sep 2026
 04:35:43 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::79) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:35:42 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:25 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:35:25 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1M3831572;
	Thu, 3 Sep 2026 23:35:11 -0500
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
Subject: [PATCH net-next 06/33] can: sja1000: f81601: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:12 +0530
Message-ID: <20260904043724.2955444-7-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|IA0PR10MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e95722-9d32-47be-1a52-08df0a3dfaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|921020|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mQsRDvB9Np/5Wq96bjdcJ3lPml36NSL3EfREvWeYDVBrZah1gu1ha3h7G1KugRlvOo4Li+8J2SD6ENndCjBWGkCpLshnGyjIvEJp778fJA5OAbxFKdA+x5ppJ5LOvZLhRh2zNGlD5LnltV7RrVdID3x3tHrOVaBnhwv5bSdZmU2my2Pt07ipvnDDlC1WbVZxreJWRGaoOU2m5gKNl8XjkWHAnGoL6G2kMRfcJsbjuHOwqbQZW3VCxUfA1ZMO05rS0Vz0nmljg7z+VtEa+qK+HVB0lWESlM4Os+4lXLmntRhhfBGqHBKh7N3GrOFxfneR+kQVxYjjMudHmZ0lkbPX8hIX3tVFKVU+HlI0c10U3bxxkf1MbaHmfzyKlAZifb6XAXcat6zVcBHADCrWO4eLk6hRidsxKnhXgh41yKc9GooKeIPXd758nBX00npgYD3evKc9++l0Gs8knfacenLFVghtRqhZHgZYLWbZCpYJH75KXbZes+DsuROwCdtKTxSLyurYRChWbMTSC46AmUuzlDCVOJw2aDxVySHy8yCRW7h+njawNeV3O9ri06tAEW3BiyjwDPemmsp0hr+at54F38QYl3LV3d1mEvw9LpeOSbl9mng1MxgykJoBej5mKrySaonoWXEzJWYzfOXPEGB0hFGrZdYqXJ+E7SVix5P9UrLhjIpGfQl2SYq4lNNiGx5qgIIS8jF97mDQCvmI6OhBmhF/n2UYIwmHyF1YTIc3gvWnx8L+W9/oCiFi7yNjnZ8g
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VxTNRGOThl5beoh3ZLT23SoPA0X0T0I4qDjfwuVLCAAQIkizNgCTD5nzrSFMz55ClBjP+rRfjCJIVG6xkpRY5UD6/1cymvi+0V9qYXTzBKykb59e+Fu6nC8qsX7Uv16If10IAD7DqcDj8Dtc+AcjLRUJF4L4E+FBESyChx7C5ooSV4cqK6zHM3WGpNmjuv5DCEUF3ZFXRCIYDiFLQLrqirnGx79LGbuT+vPK0j7Sk0e8QzpUCtmLTxHtPItHtY1ZlwYx9GHxmhPaEP8R7wHSdPu7rKi6OHSB8K/UMiDpW8GG/uMtvML89mA8WXvBc0ao2aqGlzUVDOOqIE0Ft7/DJNmJ0c6QSMnHQjDte0APdFte8sOC7oVLBjAMvI8KDix3HTpjMwikOAopw3Plo5RjR86ZIRSYE2ArzsWMFH3rud+itCTkz0F5sdRYyuVIzFWs
X-Exchange-RoutingPolicyChecked:
	m9SSHdh4ygeHzDXZ2qjwz4b7qlfzj3mf4krpxaRQLI4VTfXKrqEnTOPkI44sCd6quvD4BdNpXGXsEEcTLkg/JS+mdc6QX8EuqRc8ut1X34wXbe2P6bbtzzmN1ZfZjOyHEpgF4py4DdJSpA9rglDWpy7qAKwTZ/2i2sHlFtSa7OazGYlxD13AFelDDBLMGuH2Xz/jQ9n+/LimXqPG6iV6WfYzgDRQtuRZXG7HV10OIasdwWH74NPqFCYvUArtLFXD20jkFZbUhqsjxNNahaFGlPovJIK/TzDtrftTb/Q5iV9SrUgS41tCdJUW/3Z4n1y4skqjqzWBmfqyjcZojTRBbQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:35:42.3180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e95722-9d32-47be-1a52-08df0a3dfaa2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6745
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4aa1 cx=c_pps
 a=XZql7kJaNSG894ZXpSE/kQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: e8XgyylmlMK4xQMajuKo48V45tdj_h3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXweTfDNV2HWDy
 CSHTHGk6WLvJShMOMtm1af7Ej57Nv8P3zWu1WpBYpODz01GvHQdODvO4OPI/GIe+32zr9ZmvsIW
 +2uA2iG8qkCGWnlMEfcnnr8fAn1fGDtt0kdk+VtonH76p0DD55tO2QcTuo3i1BBozJcrAepJOK8
 B53aZYML7oIt1t/a36WJQ0UWktBnHhHkDbYAkYayOSBPP2enUiEEkHwf9GDdRxRZMGh+MeltzDu
 Aux2Y1hz10yYH8yejPRf+LJLyscplimPsfFJ9qJqqqipzbtS3kPqwmwCqIpL7xRHUt9xYW04YL7
 op8KG25gw7E4PoNxZqcJZoyBhmRYjM7UAI5+XbW3IRKaPjkJ27yE3AyJqY8jum3x28S30ChG4FQ
 qi0B3oEJ+DvwoAeWN85e854kEH7d/Zr5L/Fzl8vCXqcaWI+xo+Rb6gVYc1vUTO9Dxg6wleFxZIa
 7kBnTk3TVvn0dcYwbMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXwHazgLhGKq3v
 eyO6rHXgiBwPi/mAdFgzchKgQ1cgAuWAlpP5qE3oTendZRREKaPjUvdGFHRNbczr9xGrMh1fZ/4
 xMfOb8YM/jWG9CuYyDeveSATNKKjqj4=
X-Proofpoint-GUID: e8XgyylmlMK4xQMajuKo48V45tdj_h3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/sja1000/f81601.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/f81601.c b/drivers/net/can/sja1000/f81601.c
index 8f25e95814ef..18cf170db457 100644
--- a/drivers/net/can/sja1000/f81601.c
+++ b/drivers/net/can/sja1000/f81601.c
@@ -40,7 +40,7 @@ struct f81601_pci_card {
 
 static const struct pci_device_id f81601_pci_tbl[] = {
 	{ PCI_DEVICE(0x1c29, 0x1703) },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(pci, f81601_pci_tbl);
-- 
2.51.1

