Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787233D9521;
	Fri,  4 Sep 2026 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496791; cv=fail; b=vF7RHv2RyVPCorx28/3N1zcZloda7o3U86HQLPdsWJ3cMgJ6+TxO8cr5upTKXJajiVCRFNM4V7mhEhEVdPpBBF9v4zY4+EYekecExXBe058d+LLQNWkzBJ3g5k79sFT6b1EkuXUB2Jc1D1miQOsgaAEfJN4Sydru6wGrFwt7zLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496791; c=relaxed/simple;
	bh=SHjHPFN2seB4ucl2mWW6dCY/c/JHBs59y1PWrmKnGQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bomcQFJZvR31Nvi/O+wtsGaCpcpmuCcD9s4+LTjyvPNma3ZZcbSKOZtiHN3gmi75yXGYHFA2/9clZJrnFrP37nWhBoBsDreUVpNxLS2ciOt38ALXBzY5dKG7WszrTuZ7bTqLFKC71NHwfUujWa4fMR/loo0EQ//SCW5s6nYRQ7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=YCQkK1se; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T9aFFLLs; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="YCQkK1se";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T9aFFLLs"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sSMd1100023;
	Thu, 3 Sep 2026 23:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=qmhBrEzym+ZLZHAbMAYxuApdTg+WVG+SzZ0cfB2Yh
	3s=; b=YCQkK1seQ7clXHIujprOJC04VZHORfo80Nf8BMhQ3rRPa+p4l2jBlSk5R
	ZYhyRDXP2MF4lufPBaM1Re5gIQQyq9DM99tLQnv6iZFV4sVWIgCZVWNlZza5eaWp
	D4bthAhLoN3ESj0dXZByIUPSwl7mQJcsGmXsvD2zNasUAzcFLkp4vBlayvBMt32y
	mr5mji9+OqVYdTkaGSoQzYxoGYcCuaivWZniG97hZ5smr+XL2okkaknCQVkg/jy7
	Qmt3IE4XyEc9JWOXTYWJHHZ04JcnIdxo4nMtYvZ5xkqohMXtE/3CWama4h1xLDTD
	XRPAgSHFn5moDqXPClB260XEqXVJw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8ntq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:39:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+Wy8IfzhbLYKoj4qsTNZg2K7kiOCAOyKh+eLHKdf4S3Ojn4+0Ci3dd4q0sTRawHTq33dcKHRrxXz22nNahbynBuKbvYOUFp2RxEBHBuwwZWADNdaTaFV015UzOUOzmHCrJL0MbOmOgZIpzd0FviuhupTbDsRsKAaX1XP/zR4dLYlfhxCzkehYnfEjBkBkZzrjYQQGw6UPISzjGngxsE8FbwV+VRKyP4CokLszvh62PpgoxUiV1CXbGi3udALMKunmovGthOWGNh2mKAPhJPvZliFWP8Itt78/rdqUkoo1tbGyTsYPtP+QupBefbR2TG+gcgveWcSY0/2ORuwfAkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmhBrEzym+ZLZHAbMAYxuApdTg+WVG+SzZ0cfB2Yh3s=;
 b=UpIrBFQqFjIKwOu++IeUOsoIfgMlh/YzWgzP8mWLFBvvWHEAwOaKYIVsC48suCP5HWlrZEkHGch5kvXOrBSXOQMgxYeNdKYgxPIvbmo25boVgc4E3sjgERM9VwRymBCq8qK4d6fSqYd1qeSd+EFV+l+eXS2MSwqCOqKpghRTxnEXJkjWZWBVkhKqe5emBUr3tvafOIissPemqRMRXkBqvuIb6vT4hsdhCuJWr1blVZ4l2TZqAtNRjh5ZbKKBESsglorCuhC4mD20Gdc6kgvaFQH1EME61tLrm8TklsgRKDAqKRUUIDQ3a7lvKpWT7r4a9roO6FSWpYEn/oiBuWxp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhBrEzym+ZLZHAbMAYxuApdTg+WVG+SzZ0cfB2Yh3s=;
 b=T9aFFLLs2gHwarTIPWB5PIxzevL8F9yCoy6Qo+HJgPjphbnPGzQYesVmohVYcBmyDyQBLMmROgNsjz8acgUeVUwwvyl/mZWxcouaVJY8ySjS6M9JkmDE6BHpx5WdGS+BNUyNM1I8ygWn3YGKF714fpaGrFnAUlp7f7GtnczXisw=
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by DM3PPF1A29160CF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:39:45 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::86) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:39:41 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:05 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:39:04 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1b3831572;
	Thu, 3 Sep 2026 23:38:50 -0500
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
Subject: [PATCH net-next 21/33] net: dsa: realtek: rtl8366rb: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:27 +0530
Message-ID: <20260904043724.2955444-22-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM3PPF1A29160CF:EE_
X-MS-Office365-Filtering-Correlation-Id: f5414234-c192-4be9-6d9d-08df0a3e8969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	UGVMWPxoTmIR8aBD/93nAhZtcS5MrWmgOSU0svQGJETdhiNzCVTWQZjmx983MYVXzLjPjbMwkkpt8ynoR2Zk9o7eo4bMBo3g+hSSTobVlIh9KZBYg1M/TN4EN8qkqflmB0Yy2ApDKktWwUf69StxAUwYewPr+6KZw6wYxXz+Uh2f1kXknBdD0mF/yOrmWQWPDFypIcQeES04fRFL2Hi5AQ35FZTa4wvR2uCbYlXVJcHy7xmCFtQFoINfdCHCH3QeQp0YZxG+hrUcxvbpFqxv5IoadbqMo63ld7KtwOuGsRjfOmrAagyKnPRWK2aThswolq+R1i4oBRziRhbfQ45sVnSaHeRNS1UIPxQf/+x7suD/tcrhOOXpVmoaZ0/4ZDCnJWo/bdr+0x4UWY1fcRwbggcICVVLMSZwc9mK1V3fJwn+OzuaCVu7DPCvZGlD2hmbiFITcmdZioyX6QDn/b8XnPtzb7EUH8nSWwwWiLtsgWcDwFLzQoJPMJkJ0yYXrBNOUY1QrYvDNTmr3lDpFVKvftWhGmOpJlFSWIaTD7MVqCQSPLxD7pq+PG8dMBW4DNKlstbvR4xxXc0C+BFD20rPyepXkIV4vBkIpZ1Ym63iJUh0J4WDDS83nspIL3zUYuxg82Mm6Md6/+aEsCeA1k8fSZyvkchUaz7+cttJw4kEAJGvOHacF8bw7/72UZKQtO4UCIeQIJ3KOvJ5/e1Is3ghSF6g9h7rRBFDtLPZAigkDXo=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	80TEAginenH3eIquKNgyLrCcYdXuTv3S5vveqWzsnqxLHnOEOMbpXoHWg1cXVeUBTR1xRUgwpRaxn+dDz36Tylqsc7btDFWJepHXRryR6gGULuJbKDatBflk2ffXlDKttgdGBhDpz3t4sg8Ci6wW71AeW7hEINipIa+geN9Tk4E8pERtdY88YKLXitfVNjwcQTl6ph3rlEWOYb2PIP1evjU7EUvA4X8D+E/JCaLQ/1TZsErQClRW5hYacDbYfiTnKUU0dsjLEoCSn0idqeUjmZpsFYRN2ZHFxofNiGJo7UJSjKA9DdJK+s/VBixgQEyvr9U6CnE/MxSiu92E5BqospiZt2R1fePHH8bO30g5d4pkGPmbEmUrJcP0DVPqIGGVb5vtK9bBvNS9Cib+cMkXnmcL8KSIkeiHoH7HZs4dyGLVemKiTDiCXezERSyfxpRb
X-Exchange-RoutingPolicyChecked:
	qKFpd+GApOvJBVoOAjX/FnVRH+uRb2lZ8AJrkLdEO6G0kB4jTGvdshxLR7QNXnDCXPuLNuv+ntzyWOJlQKzZm+sJBljkA4OjR5v6TkSV1nHXwNtaj/raaNLZbiAVdHvCU2raG7OkOsBGNoJ3PCC2zgFhpG7EECyC3MOsOMlOevYAyhOSdLzIcXCgoy0ANisDCwaNqjKshJPygMyONkIEu5ddqHbn37XrY7v8+3esdKuQi4ciG4hL2lWREmoQlIpLvyrZRKZ5OsF+MYYx3QghSZm5u6IQCu7wXEgy4Cx9BlZNT7eXPIzYjTXhkVFiQkQXS9C5t3iH+psuQv1cvboMEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:39:41.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5414234-c192-4be9-6d9d-08df0a3e8969
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A29160CF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX+GTXApHDI5RL
 5Wj4rgiYbVXE+HjwGguQyUTQtX+FDyAFz/5F+8HrQjfBBnzGYH8jlCnBL93Q2/wyGo28A+gNp0y
 PpMLy6Ga2cswLFTfga560k1ri8ghNNM=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4b95 cx=c_pps
 a=uvnHr/yu0CVMxYA77rd9og==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: U72a6Be4NHt_TjJSV0rCV33WrPKVfuZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX7BOqJ3CGiuAW
 kGaZEZT08rRmhJgiiuxIhYsbJwNCTyjoNhVKeE3Kijxcr5dY8YoRIkoci3pxzOqcU0bC5g1O0Re
 d5cZ5TniuMb08XK8721kK/YCfZU8+d5gLbkB1lyqR9iLfy7BAJlyxjrT2Ch1Z2BabYjBJzJv35h
 6gwyMgl8s6FoDnv9+HW9JYrzMPwnIaVrFtT0dgjyW6osRwFOUTUT/MgBKvMAE8aYKYVK9GolbFs
 qmd8bB0JtAWKOfHnIXKQE6q9ZDHV/rISuNrcgBhaB/myJO2JSTsSePZge0jHt69NmhJzCPciRs/
 UCOggv6MMaMbGOvpt1nV3vG+mDJLM88vyepWH7Dl1QkWwzk8sujn4uTDEIc0C/fijaJiP1AsM7u
 LUElxDKBaZhbM9ie+i/dMAzjZNtcA5MEGE/n7QW2t2jmJjDdo7dEWStJaW5/41uCWdMwvqaQXBP
 TrdhdwZoAsUL18p7Naw==
X-Proofpoint-ORIG-GUID: U72a6Be4NHt_TjJSV0rCV33WrPKVfuZW
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
 drivers/net/dsa/realtek/rtl8366rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index f11831b66de8..093a06c599d4 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1839,7 +1839,7 @@ const struct realtek_variant rtl8366rb_variant = {
 
 static const struct of_device_id rtl8366rb_of_match[] = {
 	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rtl8366rb_of_match);
 
-- 
2.51.1

