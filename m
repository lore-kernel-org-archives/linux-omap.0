Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED43FDBE8;
	Fri,  4 Sep 2026 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496943; cv=fail; b=dFjmWkk+ZhdyxMNDaTvCy8flRhvq2EQN2HuzF83CJ0pTrDrIuX7i2FKr8T1nFgjUFuRJEIGqKZYfk/0hNTiUMTcIHBIVObsclxL5R/j1zobTKwLG4oPyvMJj+gu3+i6FAE1HEzZryKrWouXAV3uIp1tKaqwAdQnOnrh74f5UFh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496943; c=relaxed/simple;
	bh=7BtZrpDPMBgVnQbIWuvJfrjlS9KlCJ2vg6O3/yt1PNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIkzMYRPIc/Gq+RZZqy0oap8Ndvt2JfznHzR2YB0ramBeqq4xH4IlQsVHmvdkUoSYTpZk3lAwQWZOe9uB6vxhxBF4IBSJ5xR7FGJB/dh+REnqov1wdYeyFOg1kTTt7Z1ed8ZxXfLdRDMMISLqMDssfpm9NpAlM0Ji/lVkaqZx00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=A04+r/yQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o7F9fOlX; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="A04+r/yQ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o7F9fOlX"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sTDx2586808;
	Thu, 3 Sep 2026 23:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/ksTf/K3D7y6EP+WXr7pY+Ba2A5ReQz6ePta7PDpq
	Lo=; b=A04+r/yQvFHVZ6yk2ikvmR63QKUIcvPZosvdE87vckDze7nX2oPZLu0KJ
	501pYyhHwcSVVQ7lpRDDm9vmRZP5kgEoR+kphtHRf8X97udS4N0kH0+i2HGVyE+H
	dDtZ50FrC4SI9QllOjWTuZm0uFyIJ15bu1QbtmVlDaDtqhY/1Ui2h4fjxUPEaCPv
	pPGKoGPorUYfZk2pSghxrKP1mIdp1n66Z6yH7XIztR/6Xmi+7uhqG/6uF+5Oc+nK
	lvSkB30ES1J5GcX1+Djt9Z2K2osVRv4H2aKX4OlnYOuaCWGlNDArmtRlyUY9Uo1d
	+HVFwPd9ub5Sl3KvSmovjoyxNQSRw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs9b7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:42:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5cfsStjqLnjPsqFtIj1mDhRQ1g7AXLD5SS4TCpCcLC8ohtsTyhYN1p6i6MRc1riiUN9rqTNYsZz3Bw4FChJkSS2jLReGtXEzEdAl8tlg99yClpB0mpAD+SlEi2ACavwt2AOsuMF+0YuCpUJIwCrQdk0jJOoRTr0buG0OrbRfJE+CdI0Flytc7ymBZLRMxRSnGUFIneDcsof8tqovrpoXRYmCtmust1ux4vMopibYeEdZjLJcbcHk6m9rkCvP3bzkKQJ5rkvlzDqXvG2iCCbEVCZAFUfPGz7rUKSZccxLBIAb9lt8vHMoP9V5uI1n2WC20buMyveMz5N3R4DCan0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ksTf/K3D7y6EP+WXr7pY+Ba2A5ReQz6ePta7PDpqLo=;
 b=krCxEGQoEPlLyyF/0aaQ8RaRHFbf6VLncXIJot0M9/IC6fsxNQDDgvZa9plAN7p1SXeH6HyCNZPnBuCz5EgmJxSaSuyFtzWGWb+ouVYwbDOVkHr0EgEq512gKsc9YXWV7VfaU3sWuX3KoscSY1CHFQDCnq27Rg9T06gGfwhJ9VLBFzqO8pm2aGKeic6cTyAsGBMHweCUuPY5DlYOcd3w5TRZUCRsDSHkdEHgNSBqvVtIHJHx5t0SkIBPfyk0XWtblGzLAy13nsdyoAwNpdTeh7zz7TXwThm639LmTdO9/ciej2H5QGWFZAsQnHi+VKpbbURfp2ZMl0u88dQcPTLg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ksTf/K3D7y6EP+WXr7pY+Ba2A5ReQz6ePta7PDpqLo=;
 b=o7F9fOlX5DJglx9El5ca1zmdySBjVQx6OKydlOa3XhjGaUhiQX+Ksx/oVkc0jpWB/YgBAkJBF+wYTraKOKl1EOsRtFEfjb3DdvOC/3pPNhXl9teRmAyJmm6WCPcAbUhrVK5NLQMgapIHwKmVcfNxd9s4q3D9uI3xJxx3My0SPTo=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by DSVPR10MB997961.namprd10.prod.outlook.com (2603:10b6:8:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:42:18 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::35) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:42:16 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:30 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:41:30 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1l3831572;
	Thu, 3 Sep 2026 23:41:16 -0500
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
Subject: [PATCH net-next 31/33] net: pcs: xpcs-plat: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:37 +0530
Message-ID: <20260904043724.2955444-32-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DSVPR10MB997961:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ccb684-85b4-424d-76d7-08df0a3ee5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|82310400026|1800799024|376014|921020|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X6VN56PmM4jc2jKtsGnfsfCFjLzUIPX8emzl5k46nzI936faXAKxgWwyunl8jswYa0v3QoGyySqpwxOvaftaOXHTTa7z1LcFt3HxoeeCICgkN0r3JsaglPuu/xSEwa/E0w3CSA26+7bSAkP5elUXXnKBKNsqOkSNO8Y916YjLFjB2EZ4DJvUcvNJgf6sq3Unjo/xPI0m0mINqDJCtqH/ASpHkwURGVe2IZql8CxnyGfWfT5YQEhoMjUl8A7qR+nW4DchwRhctW4hNwB5khZdI05P1ZeinCV+2ktLfyMSHj5eUBEoWqIeNNcJNEgHCL19fYqwTRpNvE/hS3GCwAPvaDKJ3WHT8RQrqq2ygkQu3ALIqYQ8ohyjwzhr0p+A+GJvQYQV9V6ukP/5FOLDzHrB1h9ENF2SUhLJikaCdPRKwa7xl6Z8VGV0/aFAFZTdaHKR8A8U3WSqWcphWGYkRncDqQlyfPcHwYBIzYiz67xqXkXQFYyfgMdsFDBgYlQU5zuuJ23CZhK+1t2xk0mDrPEON5AeJpdHckHF3xmqGEr7NKbnvwx6L0ePB8JDROs3mYyz17+Q3b9r1ft9ekV06iR1ODefl3ejwD4pNMjTd0omwl9+GM2OGrHFqK4jR9hNCVPnffR6kfrQzyLwjFr/4i+5Vf0358Avm32pJLJtbo2/vfS1MKGtCWf1KOHZ5+O/IV7CYidoEe+uno72dL/bD9CxDC3hf2HyVbo9gvgE6mYYtci9BQMoTcigBHaHvWZLnZgj
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(82310400026)(1800799024)(376014)(921020)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t2sdRXMCvobiel1TV3ujcyKnVxWeHCqS1yudjphAdRuKJbZIdyjQ4oizuSiQRZWiOI/0QHxKnbijRFZcHKfidn7LowwUvNE++KVhgge5aPtDvnC0rVYHa1exrxY/vwgDa9VhISf3cbe82ocglpJ65sq8wLPs997WR6Dzs171IGk0S7iEa7DIKutKIgv4N/F+DWXMk+2tIl46DCpLodcOnifNm+BLc6i5BSjja/xiDfQJvf4BlWfSINry0grOEHs2b+jBnG2uMV0DwTBxIANf8G/XmTIGf8fR7+OlzkLH4wNmg4YAUc/hih5bOL7Tc6i5szneYr13MqQ0WctsD1Zh1GQaMQIdh1T6v3sgqf5uMna8ePulpVHAaZT0I9S1+ceexWo/aR6LtMhvNKmo0aMN7Ojk9j7MaMr1E3/T1INOiulaLvqhaf0OPTcfWmFnr0aw
X-Exchange-RoutingPolicyChecked:
	VbGyyZ0AO7px6nsSQGdaDR+UXLuAXcqzW7hgPBIDRZ6q7KL7xJyl8BSrfyHvzVfasIttz57czUft9bOkk49kd9NRNtxCxE840X5M1BLQW2qBp003kkmYaQbHNiOJT/JxELYE+oHbdxdeeig5LD2L06rR3/GomFwVlvFyIaDqlMDM28MbRQ0rvsGj6E4mKB/gKHTQYHhZQDw06TliMkcKmnZBX3Vz2p/ur+fE2KYx5I5HN+2syE2dA6gpybg5L//0tRF6d9Y9n4MTXMDhaMKwLMaYFG+iQeJoSVtFgWfHnkb7mKKS3kgXaTscInOtwV9nfwXZKXmNky66rbEOFsz8vQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:42:16.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ccb684-85b4-424d-76d7-08df0a3ee5c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997961
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXwSht/n7mzas8
 yeOgRltccWTHXRch7Nfj151jebaxGKhaTxSNLm0Qa30IMrdjtCvwpMJJvh3LPAgRDR49BtzE4PT
 I2zC10X6Sy5/1uTu9tWR+Ot5h9JBwhk=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4c2d cx=c_pps
 a=3ImmgSqUqdqu0AlmHxYeZg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: 0YfXuMUuP-7DBqbhOgJTKsoRTcnp_a2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX0SwFlfe4PPj1
 xpwLiOhr0WhVEfilhLtmk4rH5NLu/07SPcAFBdTSqgdHu5LSSdYvra33o6xrQgalW/NOGqSbomD
 XU35XSXgV5aCqRRsAiXBOr6P2nQ1YYtH0vSgpTqRBX8F3TsmXLIiRQCKJyzJntt3VJg6Fh2lvLu
 /AcRT1RkJku4gJVOhhHMgTWbPKYMdq0oad/024lKAIVWWHEN5vVIMwW1UJ3JrC/5JorrTLge9rG
 jJji1NQrdvSw0+kZkXLwV7S7F73upO0VI6URWBIgHY+MEPfDAnDbEDWDfEe78+HxBnT8ve9J/28
 uriNWzNQDpHNANfqt/51H8yYEnL6WtsfLDC8+5IBc8xFuolNInx2FHQeVetuT4vhjCKHSeV2tIF
 XPx8JxxcfQSS/I07hldFi+OCoKt/kyPRKFLFDL7+7hHVnrybI2F7O/Ho4kgTK6ykr2sE+z1vOf8
 E45mK7AkJOuD45u7lJQ==
X-Proofpoint-ORIG-GUID: 0YfXuMUuP-7DBqbhOgJTKsoRTcnp_a2u
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
 drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index f4b1b8246ce9..e669a7b248ac 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -438,7 +438,7 @@ static const struct of_device_id xpcs_of_ids[] = {
 	{ .compatible = "snps,dw-xpcs-gen4-6g", .data = &xpcs_pma_gen4_6g },
 	{ .compatible = "snps,dw-xpcs-gen5-10g", .data = &xpcs_pma_gen5_10g },
 	{ .compatible = "snps,dw-xpcs-gen5-12g", .data = &xpcs_pma_gen5_12g },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, xpcs_of_ids);
 
-- 
2.51.1

