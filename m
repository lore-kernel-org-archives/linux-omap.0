Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD633D0C18;
	Fri,  4 Sep 2026 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496612; cv=fail; b=CBIadgs0kl/28fqrGhsygEHGicbzxjLBUt9qkgcUXs+EOEUuKTtclKTDptPjDKDZkGM8DXcUHBJwoqnoafNkaAawXMnNXpC19OUcVGl+8TarCrf2AIkGs41f0bns0mfzt82nP9fNzXs276SiWG3ZD7csBvJK+cDXP0J4xBNBOig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496612; c=relaxed/simple;
	bh=CXTcUXNLN8eZUSLLt4vv9uLDpet7WedlH8oRIU2F+I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKHuRao+YhRwhUdT9RWlcAdC5+8u7gucDOCidExxzf4It+HQoicjXv0nopw75PE7fo9xincKU+zGGk9xqkXZ/RR7RLLETXeR1r/VxwE82+WCslcA8Pa1QpSq623K03CL6fWQUMWcUjXDaxs7MoCWNDBTrb4ymPDMp7JGyHN04eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Wk2qhdPw; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aMzBLCp+; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Wk2qhdPw";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aMzBLCp+"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sT4u1100057;
	Thu, 3 Sep 2026 23:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=2kFutCa4mNRKkg2deG5b7VEES7KNbVdCKO5cJ0aqc
	L0=; b=Wk2qhdPw9UQK/yf12z+6urDmBGcGbvyEpUGjq1xthgBx7DVpjELdjGx0i
	SBQpHx62mbY/xk7PwuFb2peWumBPemcHYZG45JgbHu1NCRvwYExVPCyareycnUt6
	ut0nYBu5VsjV9KkyUTAswjQ6+plpfWNEku9CRhGSwqdCKQzQS6IeZWeyJDR8I6II
	r43633MulViBS5oHiEsX790MaIURgpRZVGbDHAd/6QXAstKwc4cPV6q6FZ8y1bGd
	wiY8K1lKZLmRKODKl7OnJCM/RI1DtZdwJzzaq4rPotzE63VcqCF29fo6n0BEjDYn
	VzJNipHyAyCxCWlvNCnSGXUKSUsEw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gf0jv8neb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUzy2ljDyN8lbwUWGkguQbT7qIODdO2T8rSCcnkA1PYhaGB6FpTMnwZGNCtHg53B/j30xcM853/M3S7ZLodJMYJHcHZvKW5nABj3jBRhrljYeApeedk+E4cDYFcnfyQU5gjcLV57Fpn6tXncJia86OpYYSnaaUjwDQ7XbYyzBCSMbMS75moX/5xvnpSdPdLcokrVH77ZyMpv/+46nsjnk7lZi9XgZFeKrMEfzlyzPAH1H5jrhROjgvKrj0pla05byTNR2PCiqnBYs2GCqlBwxLz2EdkdU7O2yJ5FI7DsyT+fv89yfehodt/OBYcnfw1T4uhkR6TSJB+qAEg5u7REhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kFutCa4mNRKkg2deG5b7VEES7KNbVdCKO5cJ0aqcL0=;
 b=H853X1V7b8EC8Uf/BjKNHDf5jPEC+nIMfDZaybq9VSOtopvMu5z2x8sW62brYx4qr94jBuYLdqHMbowkVxG1GsM2hpr3TTt8xps57w518dI6PJh0laY8hD7C23OWPRfqZ937gHvNNXf8hSDG+XO/2Ka9lIejPnTklF8Ya6YvLRXN7RN/ihh1TN3XHSdySr2mszBo5uIC67PRjxVfP/DkjcFClng3c6yJpfHdUW8goMWT9594k+fd5EE5AWLN9w+8vyenKS3d3me40EzSIrTPA3Y+cmnkOFSAZsTAUegrwZX8c90TZIu6iZIbmpHoRdNHZSn51orEOCbW0aG9NWpFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kFutCa4mNRKkg2deG5b7VEES7KNbVdCKO5cJ0aqcL0=;
 b=aMzBLCp+giJLWeq3DS0yVL5/I29F0NDpqotX/A0ciGghsQnaXPwNZyde/5+FTq9j8b/XD/YdwPmxBI6yrgUx713vmHUHkhMPVswdPmT6zfoxDLdPsDzZ71gUu3r2eb8SaOhFhMOGRzorNbiT4yh96xGYSunRdJ5YByVzqpjCEzU=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:46 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::71) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Fri, 4
 Sep 2026 04:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:46 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:38 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:36:38 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1R3831572;
	Thu, 3 Sep 2026 23:36:24 -0500
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
Subject: [PATCH net-next 11/33] net: dsa: hellcreek: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:17 +0530
Message-ID: <20260904043724.2955444-12-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3ed6d2-c5ea-4cc0-187d-08df0a3e20d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|56012099006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BLRCRqLBlQ+YpJEBdKsxneShpXdX1w0vMDaJfQejao4JlfIHR8kUVv3GG3DawQapTXYq1W3tx9IuAT9z7KFbry25yaP/4LCRFgRoOBDckxKsOsr7NjxDC4tfx28GmpuOw4ed/E9lYSK7ztk8GMAlghc1EhroTzPVfvDa+yVm3VaGdvThtiI1OI0DFc55k+m8S9ObjbJ97lPW6zyuNxOiFPFwpPxSYJ7VPEXCFIp7LU9dgNYaOjM2I61RVKnsaspmt95496uqErUYj0m8AwHZGjDH9Xx5v6mViH+8FhzFWvQ6MzTURL2s4lXZfe+iSQy/j1ljVDJz0R5OYYvjcGLy+E9eThb3EEnRnDdW41Mku7n4VXALJb1+OZoLU8/uaHBncuGuaCRwGOC7yltn34obdC9rq20bGDZvM48QebkEjXFfSvS4BIAHMPXbs7OimxUlhgQFjHHhksPDrNPChiWxF8j/IfGc1YMyegCaa5hoAQS2jO6e9TdP9cY5GzGnGmrZ2PPK9Gj6yOOmziJANQY/hu8cnLJpaHZLuSu+rcv1xobS/hsuUvf8o40TOoUj+RjDyniea6FDGjdBlFJeZbD/MNwIO4WplW9atxa00I1t3H2NIePtIFGCIIxV0GTs+4+Jci3H2fpixrLvwyPowrJA3mGxuZiBJZu8eUWYI0XDFRlA48ZWGT6rlnbwj8LaAaA0+IhNWdt9Q1BDMGKqzGQvLfrIpDE+7ynYTz7mjt2l7mw=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(10067099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yRcgO9r8knI2EWH9DHJqqTaKGs8dp6k8tm6qwv4DCs3oqDP/yIojhSoYpQFli5KXDdq4eHiREEE28z4i7ZQ9rt8mr2NoVaEJoa4+05esyJimu7jj/mq2rbnZU6nGBleeWwenbIsy2hNnqwuWwWebFNBIUkgNGGgjqWuNY5G+Po+oLSOshqIPVeQZEOg25yPkCdE2yHn9qcfDEhwAkw4tQzFZoKm/U9uqLCNLrT7FzFNK3l+IFRXa51/QMlKda6nSdfz3viJS5tAjxEDCmBvwJKwk60y11DNKXoUSAvL9G7lMZkKslv+vtyFV61VkwcBVpl/nHpSD5tq5e0ZqR0Dk3uXYDAAO9IkeWW9Bm9Gef2dBem2lkHh3fJv1j+PlDS0cu/ytja2J+P67KrHTZW6A/vrF72oJ/QaqhwIF+NGJICfXG/VTSAHysb7VjeNMZAdI
X-Exchange-RoutingPolicyChecked:
	Xvq25hKUDbLdrCEJUnvx9ZJCRPMTDM5qlcgluIZBhfy6xpF1tuIy4b9wyNvU8GRN7EEX+q5iIc5w9kr7haNhN//3d502s0b/FV4mfjfl2kqpYYPePKkiGxDCbg0D9g1SeGKx7DgB3eH9QrdieD09AORjHTVUPqzyTC3hfMcs7/JCqesmgivZZ814HcwflfbrYq7OiiqL1rZoLDvFMsuJ9CMUz6Bd0t983XShOnj3x3PY6n0vhntY+PeKyahScRO/0/cP5LsS5XyzjHei8lREpl9XvsIq8dWgWT2932lRAhHxMpPU7uopVAZj1S3T3nTvDN+GHxNFSwON/2zFxCNNlw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:46.4251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3ed6d2-c5ea-4cc0-187d-08df0a3e20d8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX0t313Mq492el
 OwA7Xm2S6u1Isspg53wlWZZur8uCQwTzyqLJ9GvgwCS5K1Pc1WJEuQ+XTf5HwuIPzU3zB06FfkO
 B3K7HGwN+IquQBt7ygLtOFqimuZFAj8=
X-Authority-Analysis: v=2.4 cv=J6eaKgnS c=1 sm=1 tr=0 ts=6a9a4ae2 cx=c_pps
 a=M0SbpEVZuc+hi5PQWquR3w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: 4lq7SI0A0k9OvLn0GeGBDI7akXxm58Rw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX1LJMAHJC2N7E
 a9wl3WaaFIavKo9ehYwReZhesQPz28xcPpYmSKwei3il5kEqti2OiLO4JhCvUN6H/jTyJM4ykKE
 /0pLx42bNNP/2wMm7QQ0Bblh/Rg4v1vMv6emLZzH8rBSgDFehsD6RVyyjEGnAkWUsV8+zhX29H/
 r5T2YZA5E6uv+sxaXYSXE72eVm0Lle/jjiyU0VdeloW6EVNVythaXja+8hcCE2P6qxpZUEsGO6R
 9K27Iiv/kWaEdwB00KXGsXqaluaNvv1K2B8IjwnKpABZ58ntWa4FDH1gjBOosYUP07ypwSxUfYf
 wPROpzm+RjJbGNH6Swl5vF3ypxRGUVMM97ErL/yaf7HSWyjE9OtgXcy24HtoR70xFVy0yteD5q9
 m2Sntbws9Omfu94BtROmjFeenRlqYvktPjOO0d0xijNbkPmp06v7FyXaFMrqh3kZ9gcrn1MK1Wm
 6fRDgHwO9Qo2mELNLmg==
X-Proofpoint-ORIG-GUID: 4lq7SI0A0k9OvLn0GeGBDI7akXxm58Rw
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
 drivers/net/dsa/hirschmann/hellcreek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 2c6cabf61143..aec50414986e 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -2093,7 +2093,7 @@ static const struct of_device_id hellcreek_of_match[] = {
 		.compatible = "hirschmann,hellcreek-de1soc-r1",
 		.data	    = &de1soc_r1_pdata,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, hellcreek_of_match);
 
-- 
2.51.1

