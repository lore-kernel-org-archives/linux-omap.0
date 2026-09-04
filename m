Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABE3F928E;
	Fri,  4 Sep 2026 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496918; cv=fail; b=qF8egZTpGs68e42f+t/b7LeLotymFT3lWNRxrzRR/WL1a87Xx+XYU9ZefPn+45wvLZETnGjoX1S2HZSse+PQyXDY3gn76Rd9pXPceQ4Zjm17E6he2YVLz4r9oNeCJL3oqWIPmDHvBcIjLySUDJj450C3pAED4WgSZ8zQUWs5Fcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496918; c=relaxed/simple;
	bh=fre/wgW5O8Vu/I/qjxOOR0qdsSchSMVH9O/wT4z6LT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYW6iL0kOPT/tzMgny/vt/yeaUke5NAg9KfIF0ngi2G3YLC4HPVEt4EW51kXPNvPvejPBIRPV6zkitTcpMApoflVmicYCQGTIlcYc4y1Xe6qggECK8tI4OuiF89mqo8XLGyw6brweYCChxDAjRZsm1oEGrfuvTZ0gu+4Nr8TcTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=T2u5754j; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NV9rDCKy; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="T2u5754j";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NV9rDCKy"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sdpP2738028;
	Thu, 3 Sep 2026 23:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=BGYfdfyvtGcwu2Z7/tvQxY+Jtap872iAHTMGRAcdJ
	sA=; b=T2u5754jELvB2nVqas/DWuak409lZZg685gek84S9TxdvEr869B1yr2qC
	/xIZWSQ6Nz+EqFm/1Rt03Txw5Kvlvxu6n1erV+Ol5WOe2Rtg2rnrDU0aqp1bq6Si
	LV7MYJd7hUKMV3qIAiJL148tDvR8g71ONfks6wmYnzME59eC/YNKUpexnScdGF9z
	j3iKwCGTjj1kA5hEWFCHr2+W/cXwN8HywyQ+dDz751TdiYArp3uHJf5wYDn8w43j
	DG+yhTuS8y3K1BnpF3Sb7BMfAbzX4oj3Lt8Z8O9cbOt/GYhSvL+HJUDktv4hajpL
	M7Y57Bptsp065/QDMwbMVlcyJIJYw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gfdfq3njq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:41:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr3UFszQT83PXwTfzmCPFSiBd4Qh37KBFnPj2wKEFBRbuuP4ASiFsg3cgNbnn9GDlGWYlT2Eqm3nx3/Ck3q38gZSg1qRv8VpTmtoHeK9PDkQvDHRxPBMze4A8mSNZgeguf04qWPtgevMExgGhXUhw9fepihptSMe3hHrZFt9EGgptuWAqK5yftHRIN+W5/ATg1Y6UlL9SvK8ZpxF5BK8B240vZ19GoZ9SfrZbXU7oDAAnnpeysps8WPDnI5sPals2tNj2LNSqkTpz5Zzmd0Yn7bluQ5hzgNySjPt01IxPY2BXthzFSG7oL3iXbva9fuZgtIPBxF5x2Ti4qYpD2lcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGYfdfyvtGcwu2Z7/tvQxY+Jtap872iAHTMGRAcdJsA=;
 b=r1guAC7tKtoIH95BRgEkk1SOhK536YHkD9TNhJeRlkwNDRo6EvMC4P0PkqvZkBtrdrF2B8LndHBb45LM1Jlfa/JPZCd8KQ2qTE8u/FSw0VY/pvYZjDlSUFsL4m489gMj2IYVz0J63U2r/egcuD6Ia5aVzZclmCNs++Vv+vs3547bMbvDZtElPpto4Cfb0HsDN/KYDZMyiuk4nGqVStKgyec99Gr3zH+lGObxZBfTNhBn58OeVnj6qVZotrVs+nSOfcArjNIXT1jEzgu8VSJzwIvZFTscP0hZKm99DkfNZh44P7jeX16NxySfmUVuzUcVpg8duAymbEq3ibsthHfv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGYfdfyvtGcwu2Z7/tvQxY+Jtap872iAHTMGRAcdJsA=;
 b=NV9rDCKy5yP8n7/6CR99dy/5UhR63Ig+3p80IyM8yHd+yddLcAtxcNuRW+Rdjk10l6DLaDWNWk8+Fb+zO0xhoc27UbNeIo3pZ57+nnVpuyUmZ2YfLlVgQ5I6FRbRvM4ewWXRI6ufBnJN0krItA3A06aTCXc8adnjs0p18tlt9zM=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:41:48 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a5) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:41:47 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:45 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:41:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:41:45 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1m3831572;
	Thu, 3 Sep 2026 23:41:31 -0500
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
Subject: [PATCH net-next 32/33] net: phy: nxp-c45-tja11xx: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:38 +0530
Message-ID: <20260904043724.2955444-33-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc82839-e6e1-494e-9431-08df0a3ed403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	40EmelOED1IeChWZWBWzehlDEiDBjrrxg+mvjHIs5hJKk2DK2jNyzSVW8vs0pE4c0lXgM8M5Q7XvVTwBZtABsq0o0Q6AKorWAFbUXr+Drz0jsrSOmipLzgfU6dlvmDJaE9XzJgXNyL4GBnDvZqYJtTTwVKtl/ggD+JHAO2Kw4pRtbsadEoNC19uCKFo7ov4U8asRInlUmdduEU5tawRcvbgM3m8tdEtaWeAAEqshiv2spXyHff8U/6ANxX10s3CmHphreqZovsDyLGSxaY6gy/sIU6p5eiR1hd2T4Juvr1xv+Ty4xcbhq7yumQkXctqpJaImxDaJjKGuwaMD8rnAbNPTopPU45OCdphfXy5Vr+LvsBLLKqrIBX4VZCoG/WnJA86yB8wjXRbEQrUyEsBsW0boVc52vvJZ3HZ+7vHeV+Oy5V3i/saKG5vWL3UqRvql3dG3GDqGn+VyGc+PRu42JJem2l7vGKv2N7GroUxOQTc2wPTAQhwp6I2XYLCUXV1Vg0EMBo+QW5iAnenylVAiuCLFmOTw//j23Z5X9MZwLAd2jZxmoOKb0/CV+CC81D9owrvf9fwXXjCxgJoEIVawUWv2u9OjXHJJdvFOzHM/58jZ9Hlsnbkj2LzCqJGIfbI+fkwD20Ly/xG24Vfy0qrSi2W+OuphJRPKT1bC3G85NEmcpendOmCue1NRxX0eybjhq3gwWZ25YnW5jZ+t07TN8Kz0slveKux8xrVsorcb2SdQ9RmktHEdek2WDg+oE/z7
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qfvSGz5M/8K0+PIUBBfwsxVke2QdOm0M0buf7VwI0r30dRDa9bLtrTUOnroVa+fx9iiJj1JpQvWAsAX0wNQXFjntyLlu5t8f9/hKhlpvxQ1g/XDI9qjkQ+HVMOI0UQEV3/ovMxKZdpeaYcN8oGbqM6IBfYbdBuZud6KDRK3+4AIODqiqghV0wkU1anxORIUIj0tOfxuyplg+a8yj+Y7iMQLmrGHNn7/a0r7oCNhudRsn54DZxAlqr2ioPava7QO6GBbdPPL1k9MpTGUJQiXNp5+/6GZZiPeg0AkjZ9Us/Ga/ZYTgex+DGU1G5PG2kNVVrg+2xPnwfzwQZoaDVy8mJjxDe/MqPTXpr6Ux25vU1MW1Mpnf4c3AbhpnHlqNmQkgjLD2G/WfxATuviHQ8Ie0cfJ0Ox6Wz3tW8ONMIlUkF/SIZPGYJIWi7aFyllZUyETe
X-Exchange-RoutingPolicyChecked:
	FbNm8S9+Vc1sQo3zjnSWdjlXwaMLaIVJVhZmJbc3QLl/pbO4Q9Wo8jXJqo2Y9LSe7wprUDIk7tgAf0ulsBDvHSVF6RgTP8cvVAZIlB3D0iuryTSpdgVoh9TzM4RXIhSqdvFwoJ/FCBZcTRf6WFdXjK976eEk3puXDpIvqXokI1S88djYS4ul9jO1W0+Rr8I2AAMxZXI0GHU4qf8eA3t+5p19rZoDErwSu5cBOwVXnUIL7NnS+CjW8lOTg5Q07r5xOrUwzPPXyPE5UWEzSlANoQN5O3BCxUxeCvF4Ywu0L+55iyof/7LZvSbdNSU3xZ+P9h2MuZNeLo29Jv5KNArS9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:41:47.0507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc82839-e6e1-494e-9431-08df0a3ed403
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-GUID: hzXDR6Ym7Me1mXnLVrkKWcBzVB99O_-L
X-Authority-Analysis: v=2.4 cv=K8YS2SWI c=1 sm=1 tr=0 ts=6a9a4c13 cx=c_pps
 a=uej8S9duoQdrJ4czObxKNw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX3MxnsGw8bQul
 Y+sx57VD3vrWqgm+1Bsz1XsV2/OnJ5VqMykX+yzYKG0PmeSkUhIlGwv2xjj3h1iVa3HXmi+BsBa
 2q6iV62XgFyRgioV0eghycAeSqSWFZQ6WBt0oClnFzBHAs9WSMHpOmHykMuow57HcgiZyjmAJhm
 Ru0ZVPG3HqfJ/B0zRE/Y/8V88pniCWl5CUANWgtceP8qviLnpNvksP5sWReNsk6sYeVCKDTu7z5
 MPM6XV+7+eJ89gxroJl/6tKKTw+v6uRNlUMRxqhQO+DqLmwt6OcwV+5I3xI5EwVO1fLJIFMQ1DZ
 Ty2uS8nNpYoHvImiPAH6vlPN9Gvn0XdkXm9PmqHSZDJs6vhWY5Ub8ngtza4y6Apd7s36uOjemVm
 zBodpkQv+8dDScIy4HsXBP+JXXW8DuzaErxYB48K5EFIyKOcwYg+VIXnORlY/QQWGEKOW54xFJZ
 twtIHv56MzRfs3+gQKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX2h9osuM7RbCt
 4/BeOhzB7vwIA4Wo8OzPk+ZeAFgWkvmSOOJiscqYmptz5VfDHY39ryayJF/GE3adeNaEcVY7OpS
 M1owC6pjs9pwDOU6zVAExN/hm8mEwLw=
X-Proofpoint-ORIG-GUID: hzXDR6Ym7Me1mXnLVrkKWcBzVB99O_-L
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
 drivers/net/phy/nxp-c45-tja11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f526528d2e32..8df152f6671f 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -2180,7 +2180,7 @@ module_phy_driver(nxp_c45_driver);
 static const struct mdio_device_id __maybe_unused nxp_c45_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120) },
-	{ /*sentinel*/ },
+	{ /*sentinel*/ }
 };
 
 MODULE_DEVICE_TABLE(mdio, nxp_c45_tbl);
-- 
2.51.1

