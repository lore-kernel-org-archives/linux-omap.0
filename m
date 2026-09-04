Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD83D9521;
	Fri,  4 Sep 2026 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496621; cv=fail; b=SI0sSsjXNfejMpVe76sLgfloSHKHjEtjmu3fAA7DEvPkrJlk2uExwfcdavYZLZ0zvfUWgh8OZCW+tzFiL8HD02hLMOvh2Qq5CSDto7QXntNX2FgwOz00A4YOhmySWPKHn/nLhMph/aK7BU4wLc3bhDgQ8nh0nHkOX1Gb6n3/q1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496621; c=relaxed/simple;
	bh=roy5aSlBGpVVVMPhW0mM7fgGuIiHaPbIAICiEb5bCjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex8+kcnoPJHta2Ed2WOfcxF9LJzXx6GRqAPiSqhX6LOrmZlitHZdsDDZy8zqSq4OpofdQ6SMK2vfhpWH+ADerDZ0nQGV2vtixhnVLq89af796jDOXdLlrvzpKFjMu7wvw9tpDAAl2/XvMwFoWTwACJHtLajLFw0s0VTLFatvr1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=mioUGm6x; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HFCYQFDe; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="mioUGm6x";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HFCYQFDe"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sd1G2738037;
	Thu, 3 Sep 2026 23:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CoZ3LHn1z/qYLq9T+63mN4yuqZO/TEQrAptyOpG1E
	kU=; b=mioUGm6xIeaQybvHvJ7roodwYZxggysF0KNTR+hADtrvw3rRMKxiG0y73
	i6RtkehaJX+11Pl4iQic36MSMeEQaIh6hPzWjNTATu7vO0f91ogStPGPU1+kpyGh
	TdUPOZynGjObB8BeYHH+resNsWmNXyZWR+3LxL4qGTojcPOymzjriAjDTZwNwt/J
	dbj+U+imBlkNNuLETb3jYBC0mEuOEMdvfbRKdwLwLBur4rOEqAlulo+PrhFSDVNG
	obNkPh5KPiM20M0Ft53s6BPvSST/cbkmirbxXsWBr8yv1rzWxdgCFj/Fm36pPjBW
	5iRV2agiBLshRELm/VfGc9MVZyNmw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3myb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGvnKAP+925wP75/aiil5RP5hbCyyJ3swynwmncTiDNkKyWPYi4D8ZtzO4vEDYbMTa6m/RBb+ZLx42qVR4BNoz4BndDJVD0UFJSnu4uODGK0NC0VERgfvnVydnSbIaM/eQblfjjXTO61UTJugeQtklaXMQVCJMVERNb+3u7JbAP7Eelly5rXmAmKiZ7E1FbvWfO5nv8HXTwCl6GJUFwOUI4zDIhlSgGTmFVEuseTwp96HX8z1zQ1kj0S7ZUIlfwX/l0xUPi5C2RDoBFOfysTSVqU/4UKqbTcMEvyY6pgFVS8NRGd1irJBpo0XJcsA5x4lTJNN8bmV40T9fkDwC/osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoZ3LHn1z/qYLq9T+63mN4yuqZO/TEQrAptyOpG1EkU=;
 b=uTYcaAIvqYs4WWMsdrfVMEnjKpT9/haULtWDAOLNY1ugObWkC6pTreXeXw4Z5YvJ0/15erJJAxqCBaXDyNYR3UEFahlJen/TQNIURF6AOXwMsMZPzgrVtrEVjwgcPWUFRSm7oHQCbqZHHcYWhWXUkH7FmdT2leffFepsN/CLy7GUZrEkKD4o0rtLBS/yaZ+JnWviFMeeaCbsADzyJ1WN38BoYiW9bTqRuzEX+Emu3dNGpFRfCcduJ/GCS91EQ0J6WwzKGHJ/AwpgXfFgvGu26CnodF9riUpsxUR3hpW4WnEGyJoae/0UHJI2P9yj963gjLfWusWN1k4+arMrQM7lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoZ3LHn1z/qYLq9T+63mN4yuqZO/TEQrAptyOpG1EkU=;
 b=HFCYQFDeLKd84KBBnedQmQ4SI20WEHBm8oRwD3vD9tY1rxd1LUsp1NOkUs6yhMnjNtpmUDFX5D7AUjjLc9hIQzG7FLEQ4uW7PvIjnrEe1NZh/QjMhGY3HlagIRpxaSWc4w1N3WVBuqK2vhxWQIuPu+u+xN20qunvUJTdk18ssnA=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by CH3PR10MB7929.namprd10.prod.outlook.com (2603:10b6:610:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:54 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:53 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:53 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:36:53 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1S3831572;
	Thu, 3 Sep 2026 23:36:39 -0500
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
Subject: [PATCH net-next 12/33] net: dsa: lan9303: i2c: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:18 +0530
Message-ID: <20260904043724.2955444-13-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH3PR10MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 816ff424-f487-4243-bd52-08df0a3e2550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	URCKRm06CxunpfGP+UWRyujmIDmBZ+pn6pCidobCOACEvOjKiNPw5KbeHwrdC4BKN34PTsN5k3sk9qDURn1EJ3msjEGi4LcLfpzbBebYu738hXPq6uwvfwHlsy8zNY0aMuJQHsDekjQ54jBTnbABJufBIPD2aJIjK7Dck2mXrCpTBelbF8K0CdwhhigZrT/UxiB16+N45pJGYPNAl8dbDgUfMyCL9RC00phdCWD4J/T0Z+c3CfN+j6bjd00JThRQKjyYLXuyIlwVhOkqlP7puknMg1/DD/L8MxZ3AIDADihtRywxjxBAycftL6mpWZhQFCFxnHqjibcfBwjMqhfPLuBHHWnjfkfh5QsYadQGG6JSOSBRWMIiFql7/f3J5ECoBvR/qqLkqZSUjJtEEr2Fm7JnHW+3FvG21p4zb7Jz9YkmpPJpOVHo1v0uuF70Mzbg6Xd2cvfRqpIv2SKDiJpk9M6LIKpObBGHOvonEOQSm+il/zdkdbHktYq3dpNigj2xE1cEFiVYEoSEZsTzTskXOYBohzEzreb97iUhONU4DhZw1jhR90PD83lPEmre76+lraTkRLsTMvBKoCSt5Lsft2OgJSdP0adg/OMwjRQDCHm+oWaDeeKRkHjJyS4Xcmyzf7UOBUZEIVlZA0Vo8TcSy3HrzqU9Q7dM6AKbjti0xGGKsPiXr/JoO3/e3nAkNBIutigqLr/UeOo5806e/FPNjiiRi0lVvpNUWCVijN2KQosP0QSw+ONL1YqX7pJHVkFJ
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T3LUeScS0l61lQDTR3jfC1nzkmgq/EpyUH88ub8NEFI6hEq/wdzsglNCKcP3xv8dS/B8eyIZmDypCi5dpZMFzI3igeu6Fy2vF7gRMogDF62KYo1FGWEnVL6ibgBw7VrzKNBB6L+Hg7hCxfmKRi4Q+XMJyCAqVA4oXLvH6DsHjuWbAzBaw8pT5L3PyGEaXMbPPYHYWrca+5W85q8fCXiJxJB9g8X9IY+0BGOze2HAbUdQ5LOUp8Cc65EmywDO/6qmwRnNv5X3RprjghZ2HkUjzkJBi3CW/S3B+MDS2BK0M6gFKLYlf3LxCYueUgaScFDnR1WIt/SoBFaiHx3+F0uCK9sPU/muDgjDxYmk/Vis4vvhkRPYXc3hy6CWW6E6tjq8ytWRyL6czEvme5D+L2MtDpOhz/NvngHTxhfegYBwGvj44UXZW1g/9J4Ut5R7qPYh
X-Exchange-RoutingPolicyChecked:
	CqJF5eGLCmy0l9O7IidRwQZNmF3ig+uofbbU7yya3TiBcGQWFNeiZHsBthTaVTx+cbeftPFf5FY0gecQW4PtY3ZgNPoveCjq/wvchkcf0YNiS6LfUU6dji0UTZduh32Jvx8kcdlGi1HXYzfy8sQnpny1afCTPbu9iZ6uQVN7qYBOKw0SsWmqpwFCyh1N203h7uQ5IAm7wXvnI6UoMmdyyD1M9TCyhTJgRCF49mB75R9VBKysCDUicSX8QHzF9WXn+2Hj/8RQbTa1IZcvAydsKr5rw9ogiSUmqhuiP3L2/9cDO3Curheu8eTgT7TPfTnxmCZV1uNEQpmuyc16RUMNOA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:53.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816ff424-f487-4243-bd52-08df0a3e2550
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7929
X-Proofpoint-GUID: rK8Peb071dpZFA1jW_4ysk91brSWShX3
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4aea cx=c_pps
 a=RshLvFd9jIxZgmNOnSXiNQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX2PHOfV2r3QBo
 eUHOUK0AnceFMSE7m75rYn/L+rOEb7zksVevlmQ9ps4BKQ7r1eZlON1IjNwDoIOVmTxRmcb5CWa
 Y0fHksyQaY1I89qUFvKr+yL/qE4Xpy30p4JNRHg/Qlu5cZ7Ivvdd1P+NFIRsymRsNp6OSix2NQK
 bALYFeSCLa4svr327Pgj4oUdYTBlR2wwap5oOPnsHofsKYye1Zim7O7WXDlJaWUYb7uT7i7D227
 59gKEsrOp5kwcjquNT7ueaIvi8hARUnKCcYjm3OoDP/cLwFj8m9tQ/av4fveyYjpPxMOzvjzbd6
 Vctq7pl8s3Suu8rRkAvMeiS/4RyPxs3MePz0QYw7DmkqhvABmSPi7kriBastQwZnl79x1HvHUtM
 8ReWgqKhihMUi0djtW1rLHt2vwBePjia22gxQGHjo0jGrEerfhMyna0zPN7/OW6Vw9AL48+Avk8
 5bXgEPwQYVlTsw1n3iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX4V9/BTFBukmy
 Keo8XbzKb6NCRtlrkYJUUPbTxNTygdGlINL6sEgIbURTdQwxg/F+/8ipL8iBU+u6ZweJ2QaYJ6k
 qVLWBDNR0LaqQCr6ydJab6jiHHoHHY4=
X-Proofpoint-ORIG-GUID: rK8Peb071dpZFA1jW_4ysk91brSWShX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/lan9303_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lan9303_i2c.c b/drivers/net/dsa/lan9303_i2c.c
index 3a09f3907f44..7b70e22371fc 100644
--- a/drivers/net/dsa/lan9303_i2c.c
+++ b/drivers/net/dsa/lan9303_i2c.c
@@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(i2c, lan9303_i2c_id);
 
 static const struct of_device_id lan9303_i2c_of_match[] = {
 	{ .compatible = "smsc,lan9303-i2c", },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lan9303_i2c_of_match);
 
-- 
2.51.1

