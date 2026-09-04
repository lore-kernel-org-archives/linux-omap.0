Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB63F8EB9;
	Fri,  4 Sep 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496799; cv=fail; b=lV/lIZhblilYauK22jAqoLVPjtPC07/LzbJopiGWK1Mu69DQXvQwwObanL55x1x/twse6qitHeL5jzNJEaLRGOhEVXNtae6HBVkKLKb0FI2lbbQnC1qq/xlFuRbzMX2TRWIAThVwrerOhHTa+5spZfm5c7rB7miEAbXMFYXOlMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496799; c=relaxed/simple;
	bh=985qkiAcCBvFYDdhjIQLnmvtqGi0J9wiL7znPNHnzOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPongPAei9Vhcn5ci+THGIoza/c7HPpa7Lysdu0v0AQr5Ne4idjkSKqSMf6CqbwYo1L+a/qzwKMlvOV7RLv38hTsgajjmfaXLk3L4b3PBqpl2R3lyjdgWtQOUxtbw4wCR92xhTLPRBMNqxxHWziM9y2sSG9mcn8pIeFtF3murHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=i22PeoyU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O/FNZxt9; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="i22PeoyU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O/FNZxt9"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sbKv2373872;
	Thu, 3 Sep 2026 23:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=MBD6xEoE43MqACoWVw4bBLHuGKuTYwIb7OYNHzbrV
	7k=; b=i22PeoyUmlLlao/hMMjLK7zzehcNO3eCt9EC2BLHcvxTQ/YMSYJ0ADBnS
	PeTbrGghFPo8qo23yNLVheKbz7x6pr+XxwDATt0RVuRxLJlRwRhqPr17XnnLHsu6
	47zqcO582PqEzMbHvRKO2N9ePpX++NdKiL1dDivk7Ufns8oP7b9E12u3mj6arySn
	ewmJzPWnhlXccsydj0b703Z5Pgai1O/m7UjRIO6yKSboGf2aZWXmCUOHw6Y9A81N
	X92/zSoOUzMm+2WKY5Ys/kfCMjSaChy+NSyhtfm57isFQZqRS9ks/Y2vOH/oqGT6
	lQ5oGtj1/TscTwDX3WSTYdTYavoEQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jexyv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:39:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvVMqzWcr6oxYSNEJYMZrTv8zH+CfjqvSpaEeiYPqtNwuHertkq48GWodkZCKAcpI6HQfKTf4rwebM+0tzyaQyi68zvfN8pLdpd9dDjTw4fPblBRv8S3/Go/OnjLBluQvQbsPnpNBI3s83ZUp05LSwMHnesg0Wssa5vqtpTHC2T//5bPrd9/yMO9GzoZ2duy6nE0Ph7ih7eXwIy7bHGjiAwpK+nF6sleps7zwR0rdkUyRDnIbLiK6sG7THAcg5R1feZNqRqYNsdcC23YaqvnFEdtFY8GDhbGO1aPe1KSwrtIykkeU5ywjltdAA71UTcahdcVn0SowqWovTNK05I/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBD6xEoE43MqACoWVw4bBLHuGKuTYwIb7OYNHzbrV7k=;
 b=LOtxXcqyBpwb+rAH8Bqa2fsHk0E5vB1fuhKNQ3BtO5PZ+s8w7xHNyqMUqmoLX2FeWbwJNPjuWoS7Xa4Q6HLF5mey/cqkkvKlijjJKBXoFVkpNqFR18MoVxKcBRcrKZ8Ga+SmXi5YuhmmMq8Sonzfs+aiC0YEpS8SuUARYbtgXwpoTTYzpyEJRogmIQ3Y9l8SApTaUS0wY9djNXk3s894Sh+iuZaAyc1TodE1nFULugRXtozCQT4rIraJSDeVsAD9mapL14wwlWR9+Fv06zPit3UeC5WW/miTyp2PZUxh0sWI9nISO72usUWZW9QYqmBmWhZOrmjARQs/vmcHGUJvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBD6xEoE43MqACoWVw4bBLHuGKuTYwIb7OYNHzbrV7k=;
 b=O/FNZxt9wnulHpAhVeUFdZ35AJzyiXFMHZepDD7d41jZccenVYLM2eRc3ROL1ju6xCe5UjNVmKly3agdvmY8QLJeuQFuSqrKekNx+PA7/0G3gABabH8hcvkyWcVRC6Ucx7CenQhgJ0NRwghJxc/SXAkulvIZUSZX2dqHYB08aGs=
Received: from CH0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::12)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:39:49 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::4c) by CH0P220CA0010.outlook.office365.com
 (2603:10b6:610:ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:39:49 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:48 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:39:48 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1e3831572;
	Thu, 3 Sep 2026 23:39:34 -0500
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
Subject: [PATCH net-next 24/33] net: bcmasp: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:30 +0530
Message-ID: <20260904043724.2955444-25-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 77adcbea-9b38-41b3-f4cb-08df0a3e8de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|921020|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yJzrFC5TGjdgGGkhQ7/a4ExfvuA7ZkfaqfdmZF9DStyX+DMXwMXTDHpU9KjI3ZScJhA6FA9ty7NcFuMTw0wzOFlG2CeAS+khtM5bIrItbHi3IZCT0B611vJStHZmBdlNnHfzmHMHiYUV/Pp1AKmSlKMC1s3MmGvIKFUH4rApJ29mGJbkMYWW9HwcOSWwN329GWRD3skRQ3I3LOekOKIJBeLkPoBaGqFVSS8JPZ4UHqgI/R3pBj+UakR8rI3YG7qmHkAMjc3uONiW1L0FqMzl8hONGR3qtosdjZo5Oda6Gvc1p95jkScrEJipgBm+0O0x5BZsL3Wrst8efqZxhwxxa5DqfP7isKE/AtMuM39nyWV+/f/d5qfmNtbFMMEoGIvDkBjG0XyzVYZgGTWs1uCc042zDCiiT+pTfgMC/ivQZvfvvLPyJEaUvl4WDdrF3NzC9jfEATiNx8Py3sqQ0nfoIiaNSeensQOOhh16ZCYFHnMPFsNTpQNqsP/U4AveHOcGA3jmDL6WOSj2mE1plnAgUQ8/Sdj4TJPCbl5cjPNkafPhW5JVcfjlOJBqb1SHFhJaj96Z2T5TrRio35uQdK6TdR0M9mIHbA1o3zNNLXJ4ZowTtggMfE5N0HHZtFehcXHHf/jNU0UU8Z27DNNLRNybfu+Kv/pZalnsiNfIOdJom0Vu5+GTufN5XYC8hg06ubdMgsRncu7lAOJurFScG1Qsz6WLN3jAwfJmWl/hGS2eYkSW4zFXV+HPHj9EHViDFZu9
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(921020)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	81btRPoRZL3I6V94qlNhNrt9KvvA0zFe2RjhJ+Toskje0Bb0LUp0aGdn22aQzymhAhtxO4nLlgGsU+HZdoZVoTMbigan9LDI5NT0mT489dx1gBBYtMX+GZ9Lnx6SeFXErvFIM0O3Foi5oPpzE6THo15yTxgsTOZp31yED9Z9x0TcXaXfTz8tQyJGUH11AMmF+rnsINlytyWArp7AbS/ngxSLLX9TLOLLUwTcLhsQ6SYZTfyQcKeunSJeCREfod9En2zI2fisu5w3IsmyskeyEAmGJRmBRzQDV/g9u2YzkLJNXVXkYWgFjLF8QNzPTZp9tLgMvsmk/QFm3rlXYciZF2NQeSuFvmC30S6zG9shY2oSS2sylzZeLe0Ko1jI6fGeo4Rhatf8XyKXH4WxFVEkyVAdoaDQZoSXbrthIUxCPBxcWmnmn+Ct6dzwBftw8liL
X-Exchange-RoutingPolicyChecked:
	UxueDPp3xlOPyI6BKPDczJJlwWZWW6FfYu0YyzZycL64lWuB0+kOjD5mMbsHz3LJaUeLPtse6c1SyBs7gONzc3uAtkQPWd7nbsP0aqhpZ9uGrt3FdkJk558V6/xoZbKrhs8YbIqmnLdV0ZJtDbe2ffljPvukOIX1JX1ot2pUC70JGx1MIrLDmMRKWzRt04CfgEeDinbpCLpcwkWS1tuneFXmkAYwfMB8H0+zLAjak1dJzRtCg7J5w9xztsh6PCXYhViVQhTma1hkFECGZZH3YtRT7QK6DBGpCiqdClomrSAXMz6PxV+zLLGW7ppgHkBK+hWI1TXh5gwOtKgrluz5aQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:39:49.4410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77adcbea-9b38-41b3-f4cb-08df0a3e8de9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4b9c cx=c_pps
 a=GeWWyO5P+zJVL7v3m8oIig==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=grVyPgic5qY2pTMg7k8A:9
X-Proofpoint-ORIG-GUID: kOLYBDCrdzeXXr9poa6oxwhfumd_yqLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX4SHE95tyUp8O
 cjsGx/lzkwUI6v3HG5Fwp2ZobWklGIESkjcmdnc4NEhfjfrTPCG4ZXzx4v3EovyiOPv8CNBg1Ar
 /b4djTfloyIFOJekMj2GMcRWcFyAexvHqPtMela/giaSdeEVFlGqS1BR4cH+WHAD2cP8KT+RUha
 z8NrmyJCDNvwRnzSpYFoygCrDwDl9o8vTLgZYbst3eI+EJO1GiHGi9Ahriu1ZyPh+RxKpXuKh1O
 fCKryQaNV/kX2ejI+ka0ifEOhpeLNkJ+bXZ162vpvw8Sh0YscLI/Y+Ahjlh5vZTaILwuvi6TY11
 o+lJzu6plUfpKjHNO99vaIvApwCD8s8SnLgA58A/d7nxFEa9HcToNNJo8w7/7o9PEE/BkgEkb5x
 d8i+SZ9kePXzqPNwILMHhOcHvXufw9aGxA+fE5gpBTMQd66sQdYirsgmoVoCTvtMbtPnE7uwOFo
 hECPzCbtDvwjD+9qPxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX524X/ORKQ6f+
 VhBSbL08G892gHlaKHj2w7FVxks1ntxIV5yRk9jK9hvaxAh/yHLhZc24I8s/W53cx3HGMGiuP+J
 XCif02AOzqrW45+Z9/n7PRYbOyB748c=
X-Proofpoint-GUID: kOLYBDCrdzeXXr9poa6oxwhfumd_yqLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040041

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..3393b5dcbc9a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1209,7 +1209,7 @@ static const struct of_device_id bcmasp_of_match[] = {
 	{ .compatible = "brcm,asp-v2.1", .data = &v21_plat_data },
 	{ .compatible = "brcm,asp-v2.2", .data = &v22_plat_data },
 	{ .compatible = "brcm,asp-v3.0", .data = &v30_plat_data },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 
@@ -1217,7 +1217,7 @@ static const struct of_device_id bcmasp_mdio_of_match[] = {
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v3.0-mdio", },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
 
-- 
2.51.1

