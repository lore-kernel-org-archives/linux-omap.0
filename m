Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0A3FB06E;
	Fri,  4 Sep 2026 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496927; cv=fail; b=T++EQnLiVoTCnQazL+lRpxaGUWmRJXuDjyL8V/xyQEg85z0P9ObnH+ltt4FMdO/FZW6pJ1LMNf8ZZgFbptmRTRR4FA0f98qVEc9OvdizrrZRRugx4EHjSpTHqOGV3ugYGynt7cKegqSlmTqe/cIgWmE7Hbrmo2B2LV42pugrJhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496927; c=relaxed/simple;
	bh=DBBqx7E1fmWIdPuqwvFo1U1ubh3t7GWv8gs5pwUkels=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYZLFLjchrEN2ce2oGAElpWpWYtY4daD5SCVet1AbRq57P6glwjt6DSYGO72eUKmofGcQRsPaAkuSGJ858BcGlA0XoLvs81AvUdPd+etdPxmkSMWxV6W5h5jqgAB+9lrbw9/OnDyeI9iOhpdC1sa4zMzh73Or9rNVZ0jI9T/PDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZNNk8cmd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wEyqOM+d; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZNNk8cmd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wEyqOM+d"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sdQ92738042;
	Thu, 3 Sep 2026 23:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=EDje40o0AsfQZP5Sf9uP/q3bTyY42xt9THd4sCP94
	eQ=; b=ZNNk8cmdRKBhJa01YxLvm9z6htcLV5Fnku8EZj7gNhsUgmFcBHTVbaD3s
	lW/TWK12zHSt48+q37HtKcPG1bT3VfE/cfQdq4/QxTgHXnPQ1d8tnj1kXpaLxn/N
	3JzoEatT+lJXo/qSKGCP0Jt6f/zblYFPRamEWP0BrfnoKMed0K/ikMh0XZ6QwrRP
	DmNsJe60GeM/Lk+/oKrccf0fLIgXCoKPthjZF7uvQ2aAL6SpRIM24SzXk5qIJ5Z4
	Y5IiSd1USiCKYqHnKKUlpVRzUWJL1OgZUGCiPTDDVirqcqjEqIA5WPLWyJYfgW58
	dS/EzMjG3+q93Vuo1ZV3U/kvGuFCA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3nka-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:42:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgzo+RR8IQQD5Z3GxaDXw8rCsDhcdEzy/o4AtC4M2L0KChYxo4HJM+P6T110t1GBjhXPZic3luIFTE9ev3YQEKbGW5HfQHOVOEY5mmMwM/37wjZa/o6tGpjiOkwG+sy0l4hspFnWggj1wBmlUO3gtFLAy7X/7x8ZnL9Bv4jgQkiWNyAgCL6H66SNTXRo6srx3+0vUwOfqfDd9wolvEeLQeULpCZZk7c08K6jUe7Nezc3gNy0FJHgyBBsI/J2j62XbxrrWFp2guJeC35ddDdVtRk2u/x/ZkWgJA8ypowNAWnFucekV44o2yPSeiFTvQc2SMmHu008XjsalocbtKgiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDje40o0AsfQZP5Sf9uP/q3bTyY42xt9THd4sCP94eQ=;
 b=DBdTvFgCd2eO9BFi8CuTJWeni2lDfxlyjlfOzj6I9qmxkUbLcz7Q23Y1JVG2NxpZlgpGE+2mAcPOqVB+Maq2Zi2GqcvzJ+ZLBzt3h0TGniQwr9PcXGw3FAvPesCbc08Xu/nNoL2F3fjqito+npoStF+65qUYxso1x9XoSV41nOgza0j9vZ1MVxMSBGZxd6yjNHwWo0Oi+GIcvZ5gnbYbp70NcJboUJAPwpcEMvx7MJjK3Fg+S1tBChLoo4F1KMvqYY4qAlaL5MhESHi0j56eoBSyYN82R8NlQGz0lT8LiNthMF5l/cB1EhON9szS6HAhNyZ48+SnmaVIcjdVgwO9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDje40o0AsfQZP5Sf9uP/q3bTyY42xt9THd4sCP94eQ=;
 b=wEyqOM+dJ2iSQvkUmbC6/FShC8y7FnbBCNImGgXyk/rqmAauAdG3vDlFKk3Kr9OoXRhpHU7Ek/rc0hpw1EiRsAwCqUY52/7Z4T82UH7Sv/88y100r9PRvEW9bvq5RZ3HkR+E25oCcbL+KQX1wHn8Eje5i2zWxi0cjTq0l7r8yTE=
Received: from CH0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:610:11a::22)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Fri, 4 Sep 2026
 04:42:01 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::1d) by CH0PR03CA0331.outlook.office365.com
 (2603:10b6:610:11a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:42:00 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:59 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:41:59 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1n3831572;
	Thu, 3 Sep 2026 23:41:45 -0500
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
Subject: [PATCH net-next 33/33] net: wan: slic_ds26522: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:39 +0530
Message-ID: <20260904043724.2955444-34-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH0PR10MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 144eb431-ea12-4711-b214-08df0a3edbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	mSzrn8RuC99X5AQc4w3I5cBUYCHJgwxWioUiOD7AH+aAAFikFQrnmW8z/AWx4+DWz47ABh5INPD/7hja26nhpf1Kv4lSeDMAyApiya48JhYl5zApcIS27BY5vjnucpGXjXh1N4p118YDZqw35RUscEPYVdtFgxu68QpgCoV7VdwFXmMT4i0J5arpXfaA9Kkl0Vi6eJA5fZJsNTwph3zo5cazBT2iWoo1kAv09HASe8c7VagJxxpvWGL6/ZkSUcmni9WFWScbwujbAzK9xaMDijOCW9r0G/jKVcyklzNQ4Nc0tlJVGCP0GNaQrsJUNh8HVrcVajghtQ1feMQ3shyyFa2TLa7o4zRYt2EMFRz7KNMvks52uaeNYx7tbfO59qZbx1TwdxBbMb9gqr3sRv+NT620NZJT71ijzlBVjDD1fynFaA5aR1zUkOde4uMeI8KAnZzzr77Fpej3hs85AJ3FkIuS9yDsGtgehT7p0tK32ja+kc0ESptJuZJmjiKdHP79MRuvfDe1W4I6W0J2K0S55oujXH0SO7DRvjotP1Iaa7V6c7X45Lsl/erJKG83QyvkQ5q3SqWS4gxYaHtorXopE7jVXUgxSMsC424B7VlEEI6A7FIRtcQs5N1JFJiPKewN325L62y1h5TVmepMoSVXOliom+QWUjWcdr3SEpQ1ZrRVX8OrvYYPkdztY3yD2RMilXi9nGKDm3dFMsOECO5xEdHBipe7SIq0vIDp6GRD1LsdPNOhHF/87zXrhd1wgi7S
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qLBlSd4jWBxLfcyrCKlN1cELUl8VUxd4hXCCuFSlybxWLfs0UFDxi8hr64VT949/t/QmRMDUMsjQAKzAZUvIgHiiScnSKYkh7PZ7FCn+xUlb50evS9xdb8/O1LPTmI43A9weevJHM7z/rjf8+xmjKbN/YDiToMpeQGI6NpFnf5zjGt9Cgt03GRSPUZSi322iJ+qfUm490QK+sBxYNKi7HrFXWLyyJ24zZUqxkPKU0UbNHC2fvWM6JPk1H8BFARZ9fwM8x0fVFjceNOXgdKv+ZI27UD3OUSnpJ+mUPP1i1/lH4e6a0zZOOwR80HU8JlTfEdtP0E5DlZWm0g4P/8esditiDs9zRIJ/PSYsTH5X01JVSB8HFMJbNzPeXbI9TDxBp+GVKBct3IAv1PQv2ueBtEw4FQE/sP+geNcK1nc1kGemzy/11k56/Yh2X3KaITsh
X-Exchange-RoutingPolicyChecked:
	EFEOGAslMOSntFtRcayKfIh0Xwq5jf9PNrxCe+QOnHMg0kEZT5G3AsY58Vdto9YS+HWgSCopE1t3wmAQfSJ2Sd2bT4GxUNlqZwmTr89wnA24640QaMbpWbujD+eNWSw0mDCskbFNljP6wtITssZpbKuj1LqGQlcUoPAxWE0CSU+M4P/gEjyNzNSq+YT9TsyOKMLAXgLRFnQw+g2qzYuDFeTjxP1bq7tg2aMhxDnK8f9Q3sPA4qUd5RAY/XKm2At6ZbMwJbTpMAIUkGAzo4EKhxQejX9StRl7SETH0u+yw+TsmY1ef9uN//zYe7I50XEY4ojk/5fte8yHa5YTWjnSxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:42:00.3784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144eb431-ea12-4711-b214-08df0a3edbf7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-GUID: JtoSDt8kGCcrNN8Q42pNUDoi7kfYefMx
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4c1d cx=c_pps
 a=FzHw5hv2FvkecWl+Aalm1A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXw8L5J7bewxPk
 49NnwBdqPtL/06NXvz+xOOic0O5jiy7MfwhLBwpxVVD//YpD3zZLqL7L32Esn0ci96Ct70jzw4z
 XM/zUvb5gcfBgfgf3R5Z+YuQzv8Qjj27LqgeHGpWeLWy5GBzzmF/mD/5OI6g3QYt3EFzKw1r9Vg
 lOcuEjDIBGvas00/TyUXmqWl1uoNFEzfV60xdOTIKiJ98NwgDQ3hrCFsQcrgjJIsv+bqCuNWYR6
 B2Bzj5J4ML/KjFO1O6VLmDQiMBUr5XwLIKYxhiYatEMottORW4YpENMgR5dxNeDLXZJJ1oY1fcH
 tHSIOMMkRaSe8IZtaym6TOGTvIWI2QKtpphh0hp3TMsE1DOP+Dyh0P/1zGbIMDAeW9qlH4S9+Ri
 5crt4ADprxiI2hHglfBFxY3yyWxml6xIxAcVOY/llZKKZKKbMzBQMoW2NGvNDP/P2B55B/2b7uK
 FqMimnqQLr0nRG6TYSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXzaYSFfxj5+3c
 tsq/+TVNvqMavP+JzI2wkfID9a+6/DXurehKdMZbhaS6s+R7Cd+aI+cViKDcc17QSxWT1S3Cw/y
 Dgwq7wi4nzlbTrSCF/moZYEEIVjVFKU=
X-Proofpoint-ORIG-GUID: JtoSDt8kGCcrNN8Q42pNUDoi7kfYefMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040041

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/wan/slic_ds26522.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/slic_ds26522.c b/drivers/net/wan/slic_ds26522.c
index cbb99fc5ea9f..c57e7cb98410 100644
--- a/drivers/net/wan/slic_ds26522.c
+++ b/drivers/net/wan/slic_ds26522.c
@@ -219,7 +219,7 @@ static int slic_ds26522_probe(struct spi_device *spi)
 
 static const struct spi_device_id slic_ds26522_id[] = {
 	{ .name = "ds26522" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, slic_ds26522_id);
 
-- 
2.51.1

