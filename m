Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D113F86FE;
	Fri,  4 Sep 2026 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496639; cv=fail; b=Sy74LDI07PaJmOaEPXkuTrthDHhtGO1xB9hrJ5V/lOWzypEK/apYbwyjoDiqx2JBJFQzoYmuSiDycXdxXl7XyDUfAVV7KxvbEb6eHF6tOT/jqSIte+7363RSIxJS6e9IJalF3HHIfsw2PygZ6iRWodNJ5r8mD2W2dtAbFZwUmfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496639; c=relaxed/simple;
	bh=/1gHNa/qNkQ982Kkj4/OphbjbD+kzvDs0R5B16oT3ZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+ezvOzDtsPmahqdbNln6nFWLC8qI2tzh2eJ5Sk+RDEsdTB2++kLf0BKqy6HCyv1gYV9FKq7AOanbswXP0n2VVhvimfvszgEJdyz3RtVh/tlu8UCL+MjgDFaYIC4LBtKaoHDpRliGIieJHjOTsDztL98W3jt+MdQqxTQZlk6qF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=X8agI7s9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XpwcT4fB; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="X8agI7s9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XpwcT4fB"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT521100057;
	Thu, 3 Sep 2026 23:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=R7f9lZ9JfDd4HdI9Ys1LvoDIpu7PK0ivSneOy9N2f
	5M=; b=X8agI7s9q7G1kXlZN2GiMBY64da6W/Cg8599+VT0RPE9El20r8p2WNgKl
	3MWDyTMfY63l6j6YT6/FtP/08vNDTqNIgdtl+jGSVYEgD5QKnCBGgoR5vQfvGd0N
	M9sQKveGF+LIzfj+XbHvrbGli37VKvDiFjqf90cTFjKA4EnLZo90BBqPPYEzsBc1
	e1GTaH0vBb+uAAI1EpWOJQCeaTvblbGA+lQ7RBALgicPjupauc84yWWXFdXORf4e
	IWtE0bWHHCaw6BoeNNRkpWY0ob5t0qw0Vn4uSpHOfJo7KBbsXSj3Kr3Hb8cDeOlB
	RmGnD5gFBIvigW2eseYSrN8cHxmTw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8ngn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:37:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3lFVfaM+BB0KBs4WIWuPqJGuQ4rd547GC+z7j6ptLrQq8+Kkg1Y7/NLQPtii/rvkdp/WhRU+C+fFPjPKYxQjryVlFitSRbz25gzU50SAwhQ5AbTdYZM1IWW2Ojcout/6gg6djBt7+Lu6cVn5Z0cayr507tgDbWq+MYzUkc6s191KbTTgWH1d5uyT4dUFwJuhVoq7Bd6UCCBHx20d8apwnr0qNXu45cPGdmiHwZ7YBNmEydQHczQy3qudsL663idk8o8+ZxwagHOUltuoorGXWLCKkphN1UbaGnNYP3Deesl4ea8pZzVkAJIlqdoEYrTFWSMMFckMmik6nloyw7pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7f9lZ9JfDd4HdI9Ys1LvoDIpu7PK0ivSneOy9N2f5M=;
 b=igP7Vso9tqe9AqcMVWTXMScgCbUteBNELVKzK8fycQt7waFvqG2bsE6adLy9MOsoxXVbib8H2SzJHIo7QketYRmz7GNTmneEVjbsDhDSJX/ArZRwYfAmyu/IiozbiXW+p5iq9/x8ugTNlX+o8qoKvoD0dPPU02CJ8drm+DGrbh59NoXzL0ifmCaiQ2jfpLoJkEFDLiZd4X0IgVmlMSTD+V3xoe9PjTSW9Rw+DrRmDMPhQpe1UYs3C+kvDcqh8GPhpFAvRwIJgkdCRFIVzvTlCPBrN8NrYSP7iBC18Vyo20gR4NCw+KMeNrVVAJvQX7s6mAJrlcqsMwwZCayQbBOj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7f9lZ9JfDd4HdI9Ys1LvoDIpu7PK0ivSneOy9N2f5M=;
 b=XpwcT4fBmOWRYRx6E18NjCcIJ0BCHbo9UzGm39hsvmhy7yiRAnznIWpl0t54e3rgfvp4tV9iiC8+VkwowRfVcAKG2qyot7qCRTeXqCVnsvEFP/+XvRMdZU+YAztQ4nr3KuEEjaQmGllQxahFROrjpmCUIWShZPDlFhGSBiQbFAM=
Received: from BY3PR10CA0020.namprd10.prod.outlook.com (2603:10b6:a03:255::25)
 by IA1PR10MB6685.namprd10.prod.outlook.com (2603:10b6:208:41b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:37:14 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::36) by BY3PR10CA0020.outlook.office365.com
 (2603:10b6:a03:255::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 04:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:37:13 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:37:08 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:37:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:37:07 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1T3831572;
	Thu, 3 Sep 2026 23:36:53 -0500
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
Subject: [PATCH net-next 13/33] net: dsa: lan9303: mdio: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:19 +0530
Message-ID: <20260904043724.2955444-14-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA1PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: e954267d-e27e-4a47-d88c-08df0a3e30ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	NSdDccsqlPi4ztZbFr1+Yk00rnSgh0xtDGUZW/lp+Aikzo+imEdfrtdDewfK/Od9uysSrs5u72tyghxtNDlbKb8zLBHf4WC03+lxc0sfNxl0SMI32elqMS3a7cMzx+E2w1WGKkGDDKbepcEybvg9mL0zhVCOlPg7KQzKMCmqZRxdWa7KJfe7cdL4Nqv9FftMFA6MVZbXuWm7fvoi3K0gZsAwqIaU50jNOT/usv/E12FZDtpNymhxqGUJk47Wjz7ANVZqo07Eh++18+I3xA36rboQNFgM70o6w82VfRncuh8QluFGh215CH2W1yz81UZCPZ9Qkvr1t9zzPWmI6ijFSZ/4MQ3iY5hDsb8zbxSNEJH1z2JGvkuB5McH/d9Is9etWimbekQntMq3dmR1Fvav6f/vIfwPk+nOTqCFyd9SUXAgTI9IoYIX9kM/jRVHRNqbR0yetW0AvE9PHdiqGG/ohseNekJshTKGBIfELb7NBqP9bYGi78TPbDnSR1Yo4TiJHQyHwrKJHaGl20hpM8HwrrsoWObubNXNj4TpoQC+n60v5c8e3GqujEcZnu7R6uyMAhkJA1nsegEJNcZlCEy5NZ8F9UBjGc2ADTIFyv6DVrJvszq/2IwnzYHmICcOltA046G+6mLZrpjDT3PgQGTqlriOIFeF+yhZi11UJq+sDsrayY7XxGJ9YX5SaktKtzV2mKyfEdusBjkkQU3Ukh9BhNVXHOkkBvvuDLWXFUlNp9akOD8sVfYXAsv6z8YKTsPD
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jb9+1tMBm9+DcBAbko1xen2S7IK5H+1pG0UUht7uLBjst7+v0MGqsudDF6Uuwji54bYiPMVijVpJ4l5K1O2nTuHzwxY2hiDTa1htdgggiM353qG7bg5FC6KQ4dCLLqGrek+6Si25mxeBlRyFMj7+19vmHtd4tE+KUZ/zuFlwk5IS0D5OBHBLw+7fxFlzaNNaBEGXX0/Jg4kOgByzd+edfqjOdn+85vhyigUuHPy001KkEAuRgk0F55FnOIx0/fLlagstxhOQkfBtHakfCL0hDNhkcygGX5HZvZDl2TGBXg8OKRW0F/AXwOqLpRAfvtUOfhZ1uKhu5HQJedq7vrtKN7maE+yagRFxxYNJ+TPH19S2VZUDkevDzhkeJ7JozuPfcu7/9bUxWq64A0QQVLPvaKXwg6VtiDhcrRswdyvMWxe29mHe8l9aFv76Hdyf+hOW
X-Exchange-RoutingPolicyChecked:
	VooIoQ2Sfv+jSUALAHeRvdkJvb08ZP09h8N7+ilgMNavNPe2Ug7woHoN1sxtPrriquvtZdzd2nJB5xnfeZvaMC+5xop/63mNjozb5+wIp5ekulIwJqN3AsDpgysHJ6IrWHulNXJW/YpTDsU9YCboW2p5/OMK+JA/MWxfCg95Z2PxoZhzZqFSBuzkkIznZXk9Om8hy0N/X3H2+Oqf7+S7Has40Se1XvUGmwEj8cJMt4Xi8oLbocSRWpTRyGaURQVAoyMoov6x1HNylJdEgIaZwGfsdqEZu5lqhMPUDZb52gzfsDHVJbUPQcUCZOL1e1gU/9XJ9jdsTXH+OG5Jf5+5JA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:37:13.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e954267d-e27e-4a47-d88c-08df0a3e30ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6685
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXyN3pqaJsZJ8l
 w6DyANS3QIT/HlAvnw9keVc7VV+QYTYR+UrOB0iVHv03sUREbXf6YFRBggOHoWEPMm9AZVSlAvO
 hg5cCpqX1qPW7/E+Q1K+44iqJJTIZkc=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4afd cx=c_pps
 a=USxXWJl8r5vV66mO10fP8A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: 5EB6y-va7JOlrCCBUK6AHMaoBpK6CclZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX6XcXVl7mYbsx
 zP5XMTy3a01yXBKqohPY3BZpomZvRX2BzEsm6KOOwu8xvSzQTmtSM1ydO5nG5auQnm8IywDEsHg
 ICIwEuG/Aj30d7DfNIKDvsSn3//ldvwwDvxdNMF63bZWT13yoHUtW0ccAM7oeqdXE21+YztuaL7
 thaVYyQCKRAoiIpE24k/8uu5666PyqWFIARycy7i8gCmYk1QKhbjcubJjPoVArBU7TptrtGKGZT
 UJaErMQsztI1UCWM0Xm0h0XVdlk4mj4ZQ3j9koJtj08GmSuDmxV1Uv4X3SYyJn0WQYTjWBG5QjF
 uTocI2do3rz4QCn4UhxUdIfGncMAvihADZioq46/rwqrDsdjpb5MSAG2Pd79uJO8wLvFurKkZwT
 X0kXagzZA/QG0nfTzg2nn+dGcmd0QRUxZpopd5RylY1BqkPPXQq/U3bIlL7UbP6Enij6Sq7DM6G
 u0Nczzp1ZU7+FYOMXxA==
X-Proofpoint-ORIG-GUID: 5EB6y-va7JOlrCCBUK6AHMaoBpK6CclZ
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
 drivers/net/dsa/lan9303_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index 0ac4857e5ee8..d3b5062905b1 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -157,7 +157,7 @@ static void lan9303_mdio_shutdown(struct mdio_device *mdiodev)
 static const struct of_device_id lan9303_mdio_of_match[] = {
 	{ .compatible = "smsc,lan9303-mdio" },
 	{ .compatible = "microchip,lan9354-mdio" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
 
-- 
2.51.1

