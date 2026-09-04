Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0933F8EC9;
	Fri,  4 Sep 2026 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496855; cv=fail; b=LsVIMAP6iKvr+VaS6Cd7SlrOr7DFUFzNDSG6sgxA8BxZftxHOn9CPy1QUgwMPWnGEpwF/WvkhChkmtwUf96BV1hZ1IDh1aAZycX/NnvxeXnXZUEe8G8UpxiaAW93efeTwQWrfvZpKftwQMKKAw2yrlV6UBmmb14GgTOF2coIHWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496855; c=relaxed/simple;
	bh=D7UfJ2JhYYswhhlLDOyGOrZGhOombmxSFuvCHEWgs+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG5Y+zjB+s8dcKs6ELvHhOq8r3EtMafVDNHC4iaV1zXkcaVrEzCJURcvRMl1JgNu1FlG8Y+LdviZ9KxJrjV0RUmGdnOqONLpcl1JLpHS2PGRtj98elpvt8YGGrsPwzyrSGgGpAvY2rhmKBDIty3kezFd6JchpqSjqTGOyilwvJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EpUk9tm/; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tlDW3RPz; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EpUk9tm/";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tlDW3RPz"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sY7K2586904;
	Thu, 3 Sep 2026 23:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=yTBRbl1gRst9I7bTZSdLq+IrnmWbskcaTqzkESe/I
	Uw=; b=EpUk9tm/IF1HlEqr5qubk2CvggxrdW3En1lEdT4i7hlw6yBFNB9TDUyfq
	Ljku4oA04++O624uDZ0jH13FoUVD2mHPCh2jPpGezHEuL31Ywbjqu7SjSVHaeSgZ
	C5wf5/5a/wiUwyW5fuR4Ys9PJNgb/eokWho9ewBRsNGXWfnc9qGZgiaV5ppNaPIr
	EqSQAudOKslEV1biOQd42d5JBgePyhVKQKhYKhO6Q8hqBpOK6+IMOqiPgb3NOXP1
	knbd3DinExzBZvtsXHruuQywgcXN5PzdjGzDPHBGzdJgPc9DitAmhiXwB4r71fB3
	XPutFhXl0A55qpyRUnfrY7JFhMaog==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs95x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:40:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMkpC8qxmc0a9813oUQWlH2yNp5xAlUyap9qrjCYcyIK/k+QZvS/j0CNHRBp6Uqyxm2IJ3AcfXjFyr0Ti47aa1fb944iaGkE7TWOuBrSdtukGegv3mleCZgBz4zdyrUsSzTFa3Dv4Xdj98EbIqcqR7lB0Nt69451hZ8HaocUtHe0wSuOeRZW1hCr9/G9ezuMczUHzbmvxuhgTGNZ6xC2rSbI+K9Qmx8NTFBe6tFdSqQQLQbATjdgPeX99bAsdehkJpp6CINSYHkYclg9DeF9R5238R8pSu+J/UIl+d3/+byV1W+bluYWSas6p2ISRdR+uMfe8ZYaK4aGSHjeuJSWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTBRbl1gRst9I7bTZSdLq+IrnmWbskcaTqzkESe/IUw=;
 b=eMejKNBTp3eJzkRlAPGhj+BX9LEh7TqM7h7tCkGFAtVn+//ibHGqoyfeMg9TKUlz3e/Hu9lMP55QbejRbBcMPpwzgaf/qsGnoSOM//GRzd8lksubtPtht+cfN9zDv1sKee3vqWPEEYDSHaLuNEIp04kSWUcA26A16keFYeBH0xO5t8gKQbkVmQgvyxI9iOktaLykHduyi4sY/TF5LHaOcAyyXzo9orNR3wwetG+OnQU6iua47bzoh7LbRipzN16oqNgTSTFuKt8hBp3B0uQMCMjukh8z7FKDpP2qE5G41aJUpL4ZX+3MAXI1RJTz0GVHTJRD/OQ6cDO0+Eq/zI14QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTBRbl1gRst9I7bTZSdLq+IrnmWbskcaTqzkESe/IUw=;
 b=tlDW3RPzltyzf4HzimqafiazQNIfRw1TVu5DElqsSa45QGdl4rduAxQF9Nn2AH230CXM6zYM76Fg7pJeZKpQgvzA1iIe1IAZOHQU/ilqr9zJyh/yu5ip88cBlDl7NgrUvX7dHLDfw0oc3B8mKfH1kxIffyH9II5T6uz9T8xLwM0=
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.7; Fri, 4 Sep 2026
 04:40:50 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::1) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:40:48 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:17 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:40:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:40:17 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1g3831572;
	Thu, 3 Sep 2026 23:40:03 -0500
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
Subject: [PATCH net-next 26/33] net: ti: am65-cpsw-nuss: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:32 +0530
Message-ID: <20260904043724.2955444-27-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 298d2430-c878-4dea-9444-08df0a3eb13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|36860700016|1800799024|376014|82310400026|921020|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BN7jONPJRKB9dqe1hDR5JZrtB3h7+6eyHF1ctFU88QL83EEq06bBBiPVjnmuNoH4i5EUNoHXAP4RsA4V8MSD5xZU5uCQwAP9ih6bZsEi0yJRZLY8BG7DZjwhDtzO2KicC5aqV3lUt6fOh+oaU7R1+H4bsz7Vvn4vFalAFFoIBTsynRp5SCO1IjaD6iRcUoleraSYsY1JhRwY4QQ04hX9BG1WVwBGdGOjUVtmhg/9wo5VFHmIES95kJXqZou2+Ff9SrCFNIDkqHDCaBaMWRYmILWYcGWKQPsvGg0nOFKS5SWE4e+Tz+afcghIQV8C12O2/Ssbl5GYncjDtZEn0RjtZOgHH0p/uTPZOY41xuPfJZXRm0vH7+CGePmLTEJl76VyID1Rdx4rqYKu8o2HX5aNb34xWnAPCGlLjs4H7KEGRkhw8gIkh1tmsxNR9cybdMJL3mjQq8Y4quNjgsNbEH6Q+z62T0x8qLTFAlOn37JwA0yAq/mEUFpn9WOK8O3WlK4uFQTz1SMKpX1iKuv4LmJaWt9tX2Hk5olhF7+9dlO7LQJ/1uDvudzaxxq0MQ2dHF5CuIhK+UpyLBQ8TunoUM1PcIxFPBYcvqEqBoe8q7h4DTKy8ZS8DYPMG/NxmeZmV6t0/Lez1hCinx4m+hTvX1Qac5LLuzcuWa/rHWrZAoipuAGMcM7u1foZOThdDTSUIOzEr6yhRdOOk5m27gXUo8KfgQ41pfD1brBokJNmdJ1i8gjJZV0guLMn23BdcWzmrT/e
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(921020)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RTWDG51Q6dxHQPitVjMDIaXwQJow6oLXU9PFcQ+yMmZrK9ieh/itFq6PYUlqVIL5booF38oWiVaAPGAzghomTQBux3jUquWL3Jhgbt+cT+XJhc/4Tv6C0UQFGz85eZK0y4VQ2oEQ/0YMfiGKgKjIJxuzTfU468mdqWy4XKYpN8xkV1KmavvTMJW55qRhxpl4LUyG5AQqp8+8wUelEnLdlaboSLY5JZmiaNk8aJUx5g4oAWxOCr+0GkTevi3r+yERPhqLflxVNSIVcYAz4wmkfWcmIHMwqhh8cWG/XehNOegNwv9QKYD3kQeLIFDb3o57wZNPZv1sJrdrROzm2zWSw7npXVFHktiPSYvne33B6SiJbrUguZaqG78tKBs4Us3i9Uxhz2aCl9oB/HoW+QrkYQsWWqHU7Zyxnu8lexWAlhMIr0nc5U1wzbaihfXuNncX
X-Exchange-RoutingPolicyChecked:
	Rwvbyp4/JZh8EAZvwK4gkFCAbIVJsGGw0AAj65Zy0e//PZrCLCeHXs6CU+E4hGMz3lIJLIs2fosoF71hpcX74T6diA57IlWVHRKuVwxlrfrFRr6BIUcMSxA4TsPbM/UY7DRqJZ76j04BauY7BZPcuLcDUZ08Bkac+qB8hPXkRmtJplDk5kTRgFyOaCyzswzFX1ljRYwoNIgINcOdErH4zVezGJSEhXbl5xv5BMFFmw6tR143Rb6duLUZiowcb/DOmUozhvC0vs1p5gqmsRM9DfrxFJwWS6DOiF5J9lVM3GIecNzkDqN4yxCd0zDszqPOqv/WJGmavkSwU8Og6RO0Bg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:40:48.6853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298d2430-c878-4dea-9444-08df0a3eb13b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX8vTEpNZbtH82
 qo3LpUqz4jI8K9n0GsUoWe+7pNc8aV5O53IWMEGEoowsP/bgo8Bo1k1FtnFp5VLn7e+HzUt64ve
 DBtEfSBLkzfRDoGtPDcVBpu8rflw304=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4bd4 cx=c_pps
 a=RBuBYZrARuxyk0NLsDi/4w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: w9FIWiFADl5UdVQo2axRNDkMhOiHXRxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX6eaqvN9w1eYX
 brA+uar8qnTvNb0utSHpHa/2U+h92BT0SkSyS1oLx7SXSjTRVBNDw1M5Q3yjwLZVubMWwEhN8ZM
 UGP0X5VHKG1enZtTayqIiBbPF2nJer4nv35/+n9ErdFEiswX+tCrlQHS0oyptFaZYdn++iNgT4j
 wRYpmi4QatTh6DQNEZj/okFFL7cU3YVYdy48Cb/RM0ajDCIIX02BQ21xTl7m3b3F3n7lT0DTgKU
 DD0MNEbnlsFxm0RjWNoAr3Vmm3L9hEiaJW5VBkVDQ+sXKtLy/xPsa6XFexU5U8EHh9SxIu6n1qf
 hq6mKcHpv4sMWJLWdbSXy9VhlKcHA6tDBf1CLBljMBDc3DOF8vEVtkykyWp4Ck3Rp6JZgwyOk3P
 5OzxApgK3CA+Vu2C0dtPCw11w6494t0JNDddtvS69t0yw+oZATrgi6HDbmlODE6vGeeIa7TR2od
 qqq0oMWFEsWJH5VnY2w==
X-Proofpoint-ORIG-GUID: w9FIWiFADl5UdVQo2axRNDkMhOiHXRxY
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
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 6330540979d7..2551554add17 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3506,7 +3506,7 @@ static const struct of_device_id am65_cpsw_nuss_of_mtable[] = {
 	{ .compatible = "ti,j7200-cpswxg-nuss", .data = &j7200_cpswxg_pdata},
 	{ .compatible = "ti,j721e-cpswxg-nuss", .data = &j721e_cpswxg_pdata},
 	{ .compatible = "ti,j784s4-cpswxg-nuss", .data = &j784s4_cpswxg_pdata},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, am65_cpsw_nuss_of_mtable);
 
-- 
2.51.1

