Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFA3FFF9D;
	Fri,  4 Sep 2026 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496874; cv=fail; b=nEdmy9RKIWj6zNWrNp6BBUT5sKEnJ2p/+J9zQrTVJy/sqCjJKCz5jGRkfw8GmvQie/bh586izSCpSrjNHCZzASdw5FsSrSWekSqezLRPMESoh80ljuu5HXE31Z5OKp/YJjsDxt80EVxiRb+7J2w1QqrKBLcFqZV1bzoqbnQJHaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496874; c=relaxed/simple;
	bh=61jKEGKK6+7/Un/hfYKfFwqCfq9mp9gwlCcuLaoSl/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1BKZnEJzedUBQDtYg+dV0DDcemeg4yTMo0l72Ojh2bP8zBMLUbXt/HmerKNvZnEP1tWzAiLiA8Vh27RYY5Pm2m6eQlZe1erfLegNSprA5yypVuEf9nVXVcot189mN4dRQPvBhk7TRPiuVWBkVRy24yinOScYcD+ptfVRPHstlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=PffdueiH; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L46qukdX; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="PffdueiH";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L46qukdX"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sQ6U2586769;
	Thu, 3 Sep 2026 23:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=kMwlYo1RUGPHjFoZN50H6baUXKXHaMndHUW8OFS3j
	BI=; b=PffdueiH04UoPZZUIHmawEgEqmqqJe2nqIQ1/rS6Wfhan2f3hy7HaKRUA
	gKVvrVeMKPYLfQSHh3TF7xfv8+N+gDDE9c5vGWjlegW7j9r0gnN93Ko7eobXOHpW
	U6K+hl4vZzycOGpXYAMTTPnEsg8wcXDcClYSZ1ZzTlElwx9F9F/Uly1F5/EDpNnf
	rlfxWmIgTF798rIoZ0QJacvRM84aTpOdsDcC0y+Nehz7LbGcHfCvCyRhSdeRQhuP
	5TVD90AdmKjjO/a07RFuWDT8a6U/5G31G1KeksTRITdvXp2bhYYMDayZF5C9nT/B
	Zy11QPlQtNQ4IaJncfaNaAOqERAsw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs96t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:41:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7HKYPGk1UhTKehFKei/pPgDg7mmuKN871gPmbXPhfEgmDstcXwNSdbQp/qtncfGR2kLWxejdYDPHM4sU2Qfg8JXDVEIhioyw7Zol9bXH3m3TVnbtDbCRBu1xg0Vn8wN935SU9///oCpun+XvjgolNE2KzdzAZ6chqLmojpfcipNnnrnRaUnxCSCUbcsRbYp2vdLw/yA6s2cTQBA8qqJbI6XVj4EhKY2N8mb9sf9wlF2EwPMxe3iP/R7UBMqg6zkqhnuiMlTc8dIpwEEz3Jx0KGsuhg0EJgVfx3octdqOwI9JUmh3DUOx0w2tSpHss2d+KYincd2Qx5+SxozW3iLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMwlYo1RUGPHjFoZN50H6baUXKXHaMndHUW8OFS3jBI=;
 b=KNGJNblGsooe6ZdR8Izcm7YwQ5ApSLow6mwtBqL0B9nTZ7yTNkjCyPUC4/y3bY5ai3VkHeRQ8C9Wfwv8SrHXQM7evfxjyritc5qQdEvhSbwkM0vKLfl1KL3IGeoZk41Jvh6zPHUOirwlXGBepKYGIT/SW8cZ3lozUBI2Ph6L43vTynEDfYvH2mgxbpXsIO+eDaw7zWUGX4ZRJ5xDCLwCET8IqMXXMGGJevmNw+st4YJGLjk1bi8im8e3neSmlhZ9KSwdL4pPaAvXJTcal7RBFDRVpMXwtStgqhj5MMbaX4BAwYjnrLcuA+yDtLf5b5r/S0r1Xkp7LfQ9c/1Wpfl8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMwlYo1RUGPHjFoZN50H6baUXKXHaMndHUW8OFS3jBI=;
 b=L46qukdXZphHu9kPw+w/9US+FK0k0r6kNaKnvqzwUFataDrwP0XU1vEp9lPX22viff4UA0wIWILhNWD7G7DIxOWO/v5ch+1xXyNc4GqVq+Zw5UZkd71IcQQg125ujo/DnzvP7iUnDxeAAlBHZqzYtLLLT+AIiPaEXkCwWmRu4xE=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:41:08 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::7e) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:41:06 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:32 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:40:32 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1h3831572;
	Thu, 3 Sep 2026 23:40:18 -0500
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
Subject: [PATCH net-next 27/33] net: ethernet: ti: cpsw: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:33 +0530
Message-ID: <20260904043724.2955444-28-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 608f50cc-a52b-4066-31d9-08df0a3ebbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	hDz9K53kaWEY5BdChAb1xCZ+M/XXRtcUenN514gbUpOkgJfSLD//mzPaMy+WOwx1Ec1PUJ3klpwbyJsn1roWAO50P30J6clyMURXexzSoOiKngtyiApdNOxSwT/Vm80Swa0KnGXHaHjyu/s9G/ubU3PXmMHQ0Whdm9RUOCUJxhD2daCl1nwfrVLUJp+inqSQ2/qDo40Vk0KEMtARb4iDWbycJIvinvHUtVK2hBvKbQHv2Ssgb08v3h+5cPX10gxpLrNL7lqRflHGgCWzS1JeDOec1AX8GzwxeFVjj41Z+3ktufHZ2ulg9HD03iSLeMeTC3xj8ufBfUASe0J/MbeLtZ9yfta5GWZvmHB1T8yDrKYp/xrRg6WZb3SXBFR5r2dQXbV08/OgjdEQhCC1+kj08rp+4j1lZQJhF0+0jDS4asQGXVA7QIjg4bpAk1QXnOLG23y2j/2zIUwgV86CL5c/opXsQa/aXXiwF5ZEjqn6z/7YjOLiYIo+bPwR/s4WIyREBk6P3yc6//Ap8ye9NuXYBED9J7tCtEVbPZQLLedKgBkZ3isSWuHzTurB6VET69OhdqgSJ5d4d6kakbC0yL6dYJlcjuH+B3ojzH/gb5eAO00JI2TBIXWL6FakCW599g46V0VYqC9JYtCU/bVqzb3NgpvbBwW6S4+T3XAEc75aVzRsYPYBeOsID2in/0L9YNeb9AAoTr3+gfcNPinLGb4tOe8rn/G0AtIkOCZZkv4I5FvB/yzwi+QhaGnxQ/B3ScF3
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ekD8RuQDMLb9xr95Rrn293YIBFfzGpZwAijisF7kdJO5yINe3LjrIlSIMH0vXB8gtCz0T82AlCdWsKX7EYsrBAfptiu0KecyVkNCwggwoHgxCLCo1k+vDrUOiAtoBccJ/FE04uiEacLQ74F7X2mLbjUNN/BpnB8U33CfPSUjW4bs631cpiEotzG6e4dRV8u5mVhukKCx/hfcm/UEOQekXTTSwxJVilDB9bnCElNIE8QpqnywE3HLqHoWQLj9xatcWo0OJc55XjChoydzudOeMK8f1LhJmhe0i1axTOcPIreT6htGJSDMLKK6GEvodC5NxRI/WdmJ/fDeDcHLsdww8P8LFoYvuKLDbjNEp0SlGDASBHru51zunXx0x/kJgEUcbvoNmZbOjEKlfInaarloe7tpDWuWcziMvNYoEf6RDcYx14rUwaq2QbdjDTbnKyw4
X-Exchange-RoutingPolicyChecked:
	jwTb3byHW4SgltQauT6UVNUrvNjBbxjJ4V2o7nVMV56SciHY8dHwYl6MkofzZxB+nNjevVTknSpqHm4XCOAyebUm950olpnPx5dlWuq/Pbz/+n7RO48J1q283DfMqXujkQqYpaMlYEnghpQqg8bDcUKN/BgWzR2B0u2rqjjzyble+ZFq34tc2yNPa7L21LaaBFITny0lq0Z5RYawPdYExR+KQ4yz8arVAFk/XJm1tdCyIBtY+amiTTmTT/R0LWecTsVzJB+oOlQvzlQAuj1yRonLVUI4JWln9QWdZMWfn/yWUW540EfX3D2kHf8FV+EZIW4JlXieAt166HXAIhn3tw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:41:06.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f50cc-a52b-4066-31d9-08df0a3ebbb0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXxcLYzEScEqZv
 rjFvUb4SccKmJxtDB7G6w/ZixLgSGYIyW6iV0IzkgSEQ57/cZiz6BPy844kxdQMG3qNTpT8u/m3
 8l0Wc1KpvEtjRM9FQQibgjBA9VC/84w=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4be7 cx=c_pps
 a=NvljgnbIoj+kJW4KAcm4xw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: zpVNpdZQJS1NJ1UZrJPdLFr7lQjuIEht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX9GUyu/0ipXtx
 9niRgdcmu432+IRBBelTWg3+F2HBFWkxy+tByrijUdfT7IJ9PIQcDEje7nxRxInsi0hms3odnOE
 QBOYssD1TZ4wufavaG1xDFIgt8V7NztkImDc5xWSGKxzr+QxNcTx0Z4BfEaAaNWHWNe6L4zDBHp
 mi2h+v/78bliSQTFSXs+v9qxkDnG9KJbO8JfZNoRLdWSrPFxsKoIziJ5/il4V/ec3bD/Of8KzFD
 IklL+P7T9MqEVACCEHDqPuNqDSIkm12AFOIEAA+ub9hdPemYbBbk+i0W4LEOHR7DQLGVZ667Ttn
 Cefzh9azJM01TtL8M7xDZ7tvTglwJSNyI4S11bPF8bfGZplTtCskMiqLU33AW8+GCo0Ll5Z6gZC
 W0OxOb2R6RD85SkqJvWFQVICiocgOJ1xyBnVoVb7X2UieJVF4lCzXcQGo9NyTH+ZVkQTRLyCnRU
 kVyTMVrvIpz9bQin7ng==
X-Proofpoint-ORIG-GUID: zpVNpdZQJS1NJ1UZrJPdLFr7lQjuIEht
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
 drivers/net/ethernet/ti/cpsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e8..63b64faeaca0 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1529,7 +1529,7 @@ static const struct of_device_id cpsw_of_mtable[] = {
 	{ .compatible = "ti,am335x-cpsw"},
 	{ .compatible = "ti,am4372-cpsw"},
 	{ .compatible = "ti,dra7-cpsw"},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cpsw_of_mtable);
 
-- 
2.51.1

