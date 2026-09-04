Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C03CFF56;
	Fri,  4 Sep 2026 04:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496568; cv=fail; b=p0mJOy7g9X5ckCMyAKfut76WY2lYXwZbYdZU54W9fRcVQlKTiZ3b0fJcrE361fL/H0RGzMIXgenzd12DOM4Hp+6IBWlh3CGb7jk4x5v1SN7/UxKlOIajvGJ+N8n/Dfh+2tnMID28Q2nr4gQKrJ4UcemQ0XiPrfhNxpGlTcBBqDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496568; c=relaxed/simple;
	bh=Bl1ZE9pcfAu3SjiatwbVDje8IcIby9qU7W8SES6LtcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuShPfx573ZB27X4QTVPkAEfMITD+LfnYoefkub58FaC38JKBjKDfhFi3c4xF6BuEw0yjfjijXV99cYC8Zr6JL4YacYHfjVX3v0XaGNd/uMK3EGa8eKB6/4FAjXr+boO1S4d1V8ygprn3JSfooAblWW6Eh4y1SjUGZi0M76oTjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fL4GUmi2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W3fe/5eQ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fL4GUmi2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W3fe/5eQ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT4p1100057;
	Thu, 3 Sep 2026 23:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mOTgFkTOuKvHrMYtdddzU6d0aqmMja8kNqpRid/mv
	Vs=; b=fL4GUmi2dCqHuSoIlNoRLfvxbznbcQoT+aNpY1walBWU0jbm2A24+aj/p
	/JQga6xg5SlJqPYxYmMP9IJJ+OYTHqrSQfbOTaE+3d74BfrgiJjLnbNFs1lnjTFY
	kZR7FBAmfSZTlY+7SgYGVHnIfpacIYQ97vjG8PFQhOyIq2Lnk+su51ECEkDNeWKH
	1jrBhcX+Imh3Onu3RrOy4lIPD6RBvXTPOWu5vRvvpsW+eUBTqRrEwzDtpJL8p+pQ
	gferWtUpg4mVW00kL4DVYMlwwde0BIVmSN/H6EnkjYbIlyIl/Z4ZvQSSeJaTkXi+
	zi750YsOVCgh48oVciizxQT+o0xHQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8nbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFtpibZ+p9Rrr7QmyN1puYU3JuXoF1kuoSNY2X/DNzP6w28FNJrHkP2dnkB0fySImYxHPaTjnBN8hJEwolAlyxoTfxC5PZOWbiLE4PTNtCYXdUdfQsHSMtTrbsqH2G50Sb3QjqVB3mb588DR2kaviZENJxlGGDAqqYJOjnWEzAZjwOrSSiS1JH9xiI9GsrV/5TW7jKA6la0KyZjd6BKmniOMBlLTfEAPJv4v+IRra4iSw5Y2i7g3dG3Cqb4LED0nvOxNPtokcKtVhOiS0oh3QleIaVL0gdVNdUPLgwwJ20UFpgJiwWSXqinvydXNV9xFBgBXkZSprcMoM45cPtOqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOTgFkTOuKvHrMYtdddzU6d0aqmMja8kNqpRid/mvVs=;
 b=j7LsPVsT2O1cNXC6nZV+xBNMfLowLAwdb/cuNGiGyIFXX4vt3roUnm+OzDTEDzeRAqKy58vYH1xVeEuXKVYQhdVKHy0ODofm9n8hAonMdzWEvZ9xa9suCYhK8gWqoNjlVqbLb7i1G6NbcqhWwacjyOwu7Wz22UzIIlQjUkAM2z2LRT25+4chuBhe57zyMc31EndhZzO866Dnld3goATKK8nVb9O1kLDxAPMhKZm8rc549ZwSPUFZX4J5uH72OfbfUoB99p+iBa6S/2HgII6qUev4mPm4IrFOZFV1hkWBMDq9+oEM11XPVi1CcpZfQOMYuI68oHEPq8gN4Vj3SNKSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOTgFkTOuKvHrMYtdddzU6d0aqmMja8kNqpRid/mvVs=;
 b=W3fe/5eQO8z6uJuePcexLjMOKZTsbQgICr0C3YDdVvYKs8jdMIxocpatB05MWYMlI9XBZW4AZEqTMFhC80/HFNwVGQ2AuUTjxYMTJ4UiVNjZdfCLz0X0nLA5+e47ERu/Oazm6dB+Cs8dI2OZukkL/WtUPLrw3xGHRAZVeepI5Wg=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by MN6PR10MB8093.namprd10.prod.outlook.com (2603:10b6:208:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:00 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::3b) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:00 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:55 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:35:55 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1O3831572;
	Thu, 3 Sep 2026 23:35:40 -0500
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
Subject: [PATCH net-next 08/33] net: dsa: b53: mdio: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:14 +0530
Message-ID: <20260904043724.2955444-9-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MN6PR10MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 048e544a-4511-4b20-9335-08df0a3e058e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|7416014|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HvMbRkBsCcqzXJzGWN1XaZ4dLC8wbroutZWEC+UsI7RsolYKZ7veqEg3LWICbR4BJEYJ+ms7vm1A2MrxnzXlCmgZBwn7G3pip0gO42dqykrGXNnAToQ8Zjnhf1j2BOFsAzrMrGAkqm1TdJNjqiwClsIVhnVY3G1QoUmZSVCcmG8O1buRWBAScZnLzCQqtPiblcHhVDSLnhq2dyPkDEAeml0RDb1TrAERgRDgdcQE/3cWs2v3ef/QO61x+U/w6gDWZeFYcoWSVchI5Dx94sBqIhWuuzNFGO9bjRqWsF9UaSBeT0U3Zc22cTy+ZJbCMeadihD84+7wNxmQkttNkjC+gQmDRBJTF1Jdw1Aa14dH61jqwaO5m/SJPBVoDF3erhtvwQpPe8pXWWg1rs/EnKmCJiZYREmBT7SmH19+oJZUaRBTfEdHQlFmEJPDjQM5D9b8oKwtPFu421salQEv1rfLvUmkJbHhWGQRYIFEH38JEu8A86dnaMrUPwX/b0j8YMqAzYm0GOU466GRTAZhFwzh7xUhF2F2BOFVZR6j8jliFXP/rTviI8skrx5M7we9NLK1AW2lf2ImdpqjeBcFVxJf86xhQZ4p8JtBL+BimVrD362azolOUALoHi1LZ4/1SMkjskYkWaVQfW9N3DZzAS03u5cnujrJkEDXD0P4BRlwi4RiqpwIP0ahjn/DgEy8mMZs0NoJ5F4fpZJcujuD56bNts73g6bYBKmFD0QPqUg0fvfpilY1MaOYvTy7vXyk4SLq
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(7416014)(921020)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6YgBEvntG1jpg+/nj3ym9iJzrgl4oiz08e5y0ajhEl3QXGierJZRcTZFTx93acHbgbSssmU4gbwHWS0hmPog7Wvn1dYAYKOIruc2tvCx98NV+SN0QIZ+BUi+WA8P6OBa0sjcAQ7aIsllC2oUHTp+tBsQimlakgDKnFdqBsItPTnhSTdLj75LyQTdvCF/mdlKxt2Ax/g+VN5mC+SkopPhfIGPZnc3RshYxG0v2hkXgatD/1p5bMGPacfd5aI6QHqPzUVnG5Dd8dBaG5Kfj3yBCdCMJIfWe3LhkedJgF0buzEg7CBND5Kh6CnZv4SRoTzPckYAy5ZVNRScrBgThg0fqPuCe9jIPA2Q0F5NRiZ/yQjaJ/5jkL18ph0QN8jJuod1oSajmfh5QkXKV2Upg4XE1bs86PBd1X+/lRmNNOVME3JoCxETZJIosgMyMcoHk3i3
X-Exchange-RoutingPolicyChecked:
	1z649KSJ49f3QYjUxhbD6TAPPvBXGBMd/6mhnO/Wy/CoawhK+jDLTefpwaKnsqW/XoIt/qdGYce29SPSkRR8llry3OeJJ+oANT4eYyeppSD5XKNuwyLvfddrO+JM8TMypNtRxCT9FJD5ohw/TdRiDwcJGVga3pzCAku1sQV0SP5yTo06mJBE7NXaWDZQMgawfYo5XVgfvqCOquN76B/eI7E45cFQSKE+aBWMUgUzQDD2Aq3kNd8ydlUCfOXYsnSY+05jskIvtTNRKxBIMQy9ympWJWxI4cyDsCPAYwHodOeUROwXQZR59mb/icRYrDJAp/CHoteHAZ3yjhWrcMiGew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:00.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048e544a-4511-4b20-9335-08df0a3e058e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8093
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXzrAwQvgWvoyo
 FnswW4xOslYopmrZ8zlvxPdMaZse8hV/zIt34PhuW91tJgLcZgTo3eOcywRfB8/eLlBjVYUmgFm
 vL2c7p4brYNvTXkt+DA72Nw4+o5+9Ps=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4ab4 cx=c_pps
 a=SPERBzkolnWMWDQhIvzwLw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: 5JjdzgVc774dto8ntaee1iXq5xy71aO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX0bo3fcnG8DGM
 XpQruEdLPJetvFB+4m9+raY5SbYQubppnuxSWKZ0xyHkD/yX5u7tfL1Osk5GQ5fh/4OqIFDBFhB
 xvwF0qNWI5etXHE1WVgAOc8G8NxJR+1px4IPADDDfO4QP3Ya4wkzA+2q8Jcr/9I0FKOVZMTzutq
 roAPsFGIKqvRcm0+RJxxinaTZe9rGc4g7K/m43eLlR+Nwj1LBghqUwQLY2joCLGiwpZiUdNP6hJ
 1BYYwQ/o0FrbjE38cyLUmhw4RlZZ8MyJ9kf3hAx0cAu0iz8YwDBFWw9OhgRDUxCiXo6OuJqXh+7
 g8OwUEHubTBlgsX0B47gFpkgmCfQXHMOD0sMcQxc98zqtZBqTJcA2Um1yuzK9xkI/S+NvL/dzEL
 ijCJhSFCYwjTO7r3iGw8WXdARXQwDuKdXoBd9ARaovDegO7OiTmknzOOZ+GXIhhjyEOds6TnmyY
 pDqvIYdlT4uC35q7b3Q==
X-Proofpoint-ORIG-GUID: 5JjdzgVc774dto8ntaee1iXq5xy71aO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/dsa/b53/b53_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 43a3b37b731b..fc1ce57a80a3 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -384,7 +384,7 @@ static const struct of_device_id b53_of_match[] = {
 	{ .compatible = "brcm,bcm5395" },
 	{ .compatible = "brcm,bcm5397" },
 	{ .compatible = "brcm,bcm5398" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, b53_of_match);
 
-- 
2.51.1

