Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAF34A77D;
	Fri,  4 Sep 2026 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496526; cv=fail; b=kcmQsLVH7i1x/nky4Befq/ySy0fstlYZzcygHQSN0ApccAGRsTyeSNqZgVLUENJjnSgPKhgwC6uc5m9vryMm77k1IBipnQLvjSGgNNR4yEEhBohSsRxrEsp18ZgIWcyFjaa2+euHUlUgy2w6T5QP85SImmjrL9vCs5Qz7ZP6VVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496526; c=relaxed/simple;
	bh=X2tGOPeYkSK/5P4ikHxtIL9phozkwDWiXjXdGRlWv7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+QgV34GG/klciehQaHvdZYZdvsgbZEb7NLawNiWMAo6+d4C0uaeLiVN2e39IOuzlgmfyY+QoSOeJW6ZZDbpKrIJtCkGARHd0H9eIxZr+E2c5jd2VlxK5i3i7RcLZDA1JaP6dL+8dQUJGqESqEPl/zCt87D+FOKpN4GkQ+NEcM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IiOJkl7i; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GJ5Muflx; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IiOJkl7i";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GJ5Muflx"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sdoZ2738028;
	Thu, 3 Sep 2026 23:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=u+zcuTuK7kNFZikVrSC7jDEzr5ADo2JBCgpF2vjsv
	o0=; b=IiOJkl7ivAsPrtuVrDHxiMO+NPbJmr0TRpY/DWtQJdjGeiEcJc/b9FcPB
	CjtVR52DkKXewjqVcySjnxGOWbpZpOnLyjsyI0QbRxJey0yMtW6jfYHM88Rb6p7F
	FhpGhA2dnO1yYmduZLRJa70Y63NmrfrVCpHIQHhyMYVJmaoepFPk0FgX8k/UYcY4
	qsg4gdLFZoSxbVnZf7sOtNVNSEKfXNtAIxAsQgz3s+u7dNBTvnhRoa7EUh11K/q7
	YECBvplGmzCouOgOdU833hoEF6ObBI22e7SclziUkB78qc5IPBCc3tpdIwPyDyH2
	q+uYcwbJ86HPZYSc/bJOMWg4Peqgg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3msf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:35:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNMAzReWRgk44Jn9d6jzZfQRZ1Y8kZ25YP8r1wl7Hkp7BJ0OOcH+HgpdGLGVFbQQDQ/YFb1+OrIwrC8U/DRes4IEcshb+0tVUFej0+/URDEtORFEmqUtxx8dVaV3aG3oCjdSjX2SBIouhsB2gTQiznGH3LPvrWe/V0AaGugjkdYgo/4qdEnXrq66p9LLSlFDajXbr1g1Qf/altY1e3jcRgcT/1+v0nhjE1+7adBOI/YKRPXWnb/NHq4mxLFtOSa1pD5yopduILrcz4VFMNwxMSybCpF1CRngCC23A7MCwgVaOtyxJU5AJdVVSsF07xhZnPlfz67rbhSZ1K+JiVQ2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+zcuTuK7kNFZikVrSC7jDEzr5ADo2JBCgpF2vjsvo0=;
 b=uSVORd4Zjvenfqj34Oc3Pt3V+/TFFzeCaSpx9WVaoUYuw9UPogUKcLOon6hEiz59DnEtwifSbmCxAKPNDYcpd7e0dxamWJRqTDUR5L57t/g1Pryq+mBuSaGdmLcUqeNWFB+4v3sUPbKbLiGS/SpCB9QxaXwttPO4Psp9l7Pe0kUIysuxtZ1WceN/FTfUbjQiEMWtcSh0oLUnxnhP1hhTWJ88zHBmhTRfnoyKWLBotKAjPNpfBcIuZatOhol4am3J0M62H61IhfgYO3uTe3pW9PigZQOJX+uE927HsgPwouRfv7x8tPbSR1IjzXG86Zpl3dfW/xr752cQgFeRIFK7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+zcuTuK7kNFZikVrSC7jDEzr5ADo2JBCgpF2vjsvo0=;
 b=GJ5MuflxM/cRmYtKL8yB4QkMmNBipyxtnnMoapG3C6dNsqKCvGSNbT3U4bK+bxrgrk5D+d9YaHmGO0cXoYHzxi/jtSHCwKUZFFVmUl4J+nIQ8uDdEe2aH0KJfD5ysYzAZEeXmVTOXomzrKFXEbQjZzrZ5oMtlrvpRV3Rd4ue5tQ=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by SJ0PR10MB4621.namprd10.prod.outlook.com (2603:10b6:a03:2d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:35:19 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9f) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:35:18 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:38 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:34:27 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1I3831572;
	Thu, 3 Sep 2026 23:34:13 -0500
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
Subject: [PATCH net-next 02/33] can: c_can: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:08 +0530
Message-ID: <20260904043724.2955444-3-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ0PR10MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: f565e7c8-7d0b-45fc-97b4-08df0a3dec66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	3Um9uvwcun+SK9neV0GWo4KmnXbgf/ZRpdjJ8nNd785dM71SEknGYKKlEw9fOiiWIyiwtQrjvV00gC3iybdSSQZptNczZOlnLP37I3FuaSzrMpl6Ic86Zlr6OoKqpz4zMlTJ2cm0jp/+c9cqS+0676ZQYcsSZwLEYMXrq9qmB56rFJPBecqWjmQcnfImJh7wRLq7CxrPXwDiN969UUxS4TxdP7znnoVIzRiYvWoTV6VgQSJv2keqBUZw/F1Fnda2DJpOZXvLsy0LzdcByCU1vC11yY37GRfqcYrgJzsTq1R6WribQPIksccGLnYMSOiBI17aO/Og5ZCgc2QmD7RLKsRWcJ79OHUlsH5Jch1JzfpGdL7gaZ6QjudoHXrzNopusvvV3lCNJe7gVsX4vLOstGxQUuTxDGvoVIXlAgweSGWCLcFLsE1dWYUG46YBk+3Tx/vEpogURF1HE5Tgz39Sat92RdO1k9IUP9II7vsVNUyF48ZgRWOuH3PFVmx/21RdttkLEOSuO5H2vz0hxeihD6x76k7vzdK9mXoKbyQ2Db7HwLmkM6+pZ5jHzfoC3oIaWn+WL8pqXj1AQgPC3uVUFUFsIzZdXaVlRaBaeG5Ibfeg46zCfWCDr7rYaoLILZSRQadK0Cu8PuH83G83MTfVasi5ydHHMMfI44yHSIUVuLGbs2o4KtlR/263vFWOoMet4f1LLRJ3uvNmgcSNcea+MjZ/yuUGPRcc2UaySvUPOqGt31JzDUxB4nJmk5t38fRW
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GAgI575D7TkHFEr76eBsmW9miToTn9etqrNXfq+OLWbAf527sjG+1rF8gkg14qO6kWHsG9eiapFxttuZmUqJvUysy9TN0D1ZrpwMElDDRbxY1YPVsOGqALnJ64XVY5eQbZW2QIrjtGmc8rzXKX9fC+CWb0DgNmgmI7b+PaaSLWwLiE/MP1Ry28NGhI7JWfL8MOHrDMNED6Ybs17xU7EXZ0Agi571rD0KB3G8tpOPzC+8iNEZ2eDVvbcFwDfhDaWZ8MzV68gcABTozwQYy8dd3k09vXFFGBPoghsKU21Fyzfi0/Xiqro250kH4zBVT9x4z9tqnS+N+j96mGkm6UzkiorMArN5Nj5HiKn1kQyhPnxrcaiKGQ25HyNJT2JrSm+0FjlUKPqKPrIM/aa+Z7ZJJs4VUGP7nqGK6lBG7E7ALyTeURiHN8LiIRha0VGvc+Qn
X-Exchange-RoutingPolicyChecked:
	fQy+eUV+XxfDtEKJBj5RaxtV4C/mOKWqRE/wJsTC0PMk+ONQcpy2ZpLNhL9F/Fh4Q9h61qRobykJyU+vubq3PBR51PwXrRojyhZqL9p0vgMG7lyaim59jtYkLnP3He+N38ioacM2A7oULthnP6aWKWYfiPauUGvu/wN3Onw9l02SI0dQAwiDnctzgzwNZKeWe74Jx+zVK8DZMW7K4IYMKOT1QDTTW0GO2UHvsUvDOspgyYo585SIR+8yzsyQP+MaRN0199cmX1cO8SvDn3Vq7zC/DE8rr4Ueeib7O79Ro1wy6jqAX9dYGXUC7zWDM6jGE5MumRVdzZccjw5EsUSX2A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:35:18.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f565e7c8-7d0b-45fc-97b4-08df0a3dec66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4621
X-Proofpoint-GUID: gOrcRTVS36mkuuLKyiED9uYBrzgfaMgr
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4a8b cx=c_pps
 a=64b+Fh2X7ngyiwpNPLbe6w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=grVyPgic5qY2pTMg7k8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX/tEqc13m9pJc
 1N2ZaGaZ1BaCLjGLqemnnXadr1rxs3MdYM46Oda7HTl0ATOIE+xOdgIa2z6mHUWt22Wpuy+EsrX
 u4NjPxDzmYjAMwnj0Agien7kXyRhkWYPZksBc+npKWgqzoCG/eXJaZ0KiZB3YOjCQeLL5h6lKHw
 dp6Tgl8aSlo8zpXaY6hy4kMYO3qEzf75eRoF7mhwUxVV8ZiOPkWGwWL18cyBlHOBxJYfMru29hH
 gLR7hc16S3TSRHA79zyu6c5mT6W22zgoRWwQZ3uO81Y7aHVMAZoNO1IcDn/rAEk4SF6KprRWITc
 BLfJMXTrkvtVpWoR1cIk+0xu17p8fTE+4VxTaLa9lBvOYmKsxp/vEnf1Nv+pSx/MG4YF7ygiTtY
 3ScoPKnSYtXgd5XtZz4K5aqQ/2wspHLHCqEdvNb/+PZyt5OAG8DLbyZdNOpzcamSZPHSHQMhVuz
 Hd+2vMz8crIleNLXQPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX5PqksQaXGAIu
 gjP8hD2jaFQicC2rIkYRdhzyikBZ8VfSJ51CAXUwD66ZHmH5GuVyEiL5Nemdxs2xX6ze26N+D8h
 Tx89TJ2ySKlwJdGhoBm7iTspCHbyU4U=
X-Proofpoint-ORIG-GUID: gOrcRTVS36mkuuLKyiED9uYBrzgfaMgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/c_can/c_can_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 19c86b94a40e..75607b1afd2e 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -239,7 +239,7 @@ static const struct platform_device_id c_can_id_table[] = {
 		.name = "d_can",
 		.driver_data = (kernel_ulong_t)&d_can_drvdata,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, c_can_id_table);
 
@@ -249,7 +249,7 @@ static const struct of_device_id c_can_of_table[] = {
 	{ .compatible = "ti,dra7-d_can", .data = &dra7_dcan_drvdata },
 	{ .compatible = "ti,am3352-d_can", .data = &am3352_dcan_drvdata },
 	{ .compatible = "ti,am4372-d_can", .data = &am3352_dcan_drvdata },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, c_can_of_table);
 
-- 
2.51.1

