Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44E3BE620;
	Fri,  4 Sep 2026 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496493; cv=fail; b=gRENbC0NPxDdFcV9fVhFIosK1p6n2Mij2jAd7JTP+54uzgYfyZ7ko5QylS8rj6GoWaEWuoFIYn/s22AIzrQJq1zSk7VpX2Xs3IsZK/kILsATw/v5chZBo0e74dvEzofgHGIAvVUbXbDXISMpeNDlTdd18lD4ZYOWB1jY9YF/wzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496493; c=relaxed/simple;
	bh=znrtpliYEkNJK/uAoTFzwCKrNhdDcpn1MK7GsREtW7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ/44X1gQTtQF+ZYawHwjFINeF4ACZ6jdANLRc2MQFbWFTqiBBgA22NrNEJA/mZOiFDPmzbCBI58JlToWIvcyjshXbOpQuzGKTL/elTJvzuuAcXpX/kCLKyo94PPlxH57OEOe5GZR31znWMlUBPGduMs6hRNjeZqPmbV8D8EhrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JC5hGSqS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gfTINGxC; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JC5hGSqS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gfTINGxC"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842t1pN2374230;
	Thu, 3 Sep 2026 23:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Gmbt+5xFQMd8rV8QfC/rDx08zi9V5hqVcFdzbw2pJ
	QM=; b=JC5hGSqSr3Cxfrf8V3+fIT0esZTlvmCwvBL8daVc+LtSuZQXtOSjegorz
	ulKL+ASUa+t3mt0qPnfpEDkc3X8fP3T8Kann4+8UQWLrXN3if3cY7e0DQY8py8Ca
	lhf+IF/eFmRcF36XyyUL1uxIOIQwiNJJtOOPoS349qDyXAxEGqprmVN22SPxtx9t
	2gJnNXqFwcZ/VDvoExJ8Ugx4O5YxqOrd7W8f/u/eBOaOKTbuSs0+jZd9HjC3Bcd1
	FkAz0QKuPlviP5IzXBUsoTTqXvg2GRWBRPL2xPc809a1dsgajSHPT9fwaUXFiZ9/
	7qgxhgSoHSQNtUL++djH3lLAlc5IQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jex9c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:34:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sowXrDGc0NGy/1PtZ9qE9/6lB7VoLl4aQU1vr1ezY/NhB9jrUrvG5IGP4OWFRjCmfRiggBIPqZPhsPQe5PqKTSZO2hy77U3DlJbtC1IcmH9J+KVEfR0gECWKsU2c/B8ncHqrectZP6bjkiNChHI+VpzzfkHC17FFsIDAIXJdPpw5uRtRQ0n0RfXo05mnJUWLc/nUKzGgWlX0zgrKys1A04YhFQTArc0X5ykdmGOovF0DPZ2VkkfhKkCPB0gNd5rjx9pkzezEKM9a74euJabH15QtCu7p7A9pXmP7ZjXe56Eb2LtdvestgKi2ukwYBGIUKAEI9d8ovARscQAH/2MePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmbt+5xFQMd8rV8QfC/rDx08zi9V5hqVcFdzbw2pJQM=;
 b=IvXQzTagSk+O2BLtFnY6WaAhNB04rOCt77X09TWkW4sBsw27bRefj/t/rt7RLAQrGXEUzD7Id8RiV/zEK7jxxQxU6XW8QrpjtOR7k8X+ihFDy3gxDKvknU7A9IexGhbi+vXCwTIfLAyh0S/lsUh4kvsZfKzuZl/Y2SVLyg+YQqlc+lcT+xCQgOea7XkttZfF4i53vdq3E3KB+cWdxLtGrW0aGYRjH5/7tzB3Ubvp8rmhsUY1IIiuIlA/1hEG05NPC92JIpniTA3uSn4pkmFaK4U7qdzH1aTPxpHB/vsdHEV4stsTnZEuL9eyB7C70ZygCBGRc4iFVWkWUl3MuX9EdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmbt+5xFQMd8rV8QfC/rDx08zi9V5hqVcFdzbw2pJQM=;
 b=gfTINGxCX/8Nka6XcGfjc3rinVTF66uJi1/dnfDj5S1inTECDnn4FjDb7gsV7pIDo1SXt+dd6KDhwddqH7fNdweCGMj5BkKvlxjFujmo15V2Fc7BJICCqMAyVucBmAaFWMJ3mj5Dv+PBISLzZbqZCJ+0KHPVmtn0il3jtXMx6Vo=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:34:42 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c5) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Fri, 4
 Sep 2026 04:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:34:42 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:42 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:34:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:34:42 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1J3831572;
	Thu, 3 Sep 2026 23:34:27 -0500
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
Subject: [PATCH net-next 03/33] can: flexcan: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:09 +0530
Message-ID: <20260904043724.2955444-4-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 46576fe3-9fbb-49fa-8202-08df0a3dd70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	TizQzZdcOP6cDhaSkz20dI+kPA/nrjjBEjtJmNrXcrmNeylFiNGY0Sxd48xka7dJg9N37LY7cGawltbl2ozlEtnTIp0w6ca5gPt/HpfG+myLcqEFo3H0eJP6VMjSD+ZY6Wsp3HiKeuMPM4jbtnUp4lvoIlNu4UFGF2pTAwhdjnurrIsSddCjS6pDmjKRoQtPosZRmeHlbZHLZYmxa+fyjPml8KZy3xGAHZWmTqclyD3awVoPV0QOg6qIXwrJfqJOzy9ag43pyOMGhcP4dd2CpZIHv75lQtWQJFjlXRQ26W0y1shZUGxVfV4B6wK6GE/WHm84AjwllOCU8XuROr6hKGIsxYBSCauzZJ89g5rQWensp6Oywe/a5csq9t73YkWt+iA1Y8c0tfVnX7GaIv1dVnjzbgUIb9SMaovd7KRd2D184t1Em5QEq7dRgdXPkBN2PfV8W8iZJ+hXK4AygZQV3U60Dw9cD4tBa8ig2drEl/bJ+7lpuf+4d6IpQHH8Zylj1Mrxr/YDdG99VRObvW0SItGrgqinlBs+U6Xnlu9CNyEhdh4NKglDXqZat4Gf7BDD72x4LSG0ER0v4fzg5JyutALIcrv/fw/s4w8VUWUemQ6Fmx4jUVskXWr3JA0edeoSsox0WL+bZjJg0wLooSSvvRrV13cS6K2FpfUHly34J6Cx3jshyBIr5c/l1hbh9kokx/0K2R2l6PMEPX14uV19kgvvvcRSUXPaHzMNJuplcySmODPguG+CJvHIfHYj9w+v
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NybSwpUDwguZo7acBzsKcl33G7hCEmh8i0KpoygR/i1YxeJbUbfaLB1eW0TzfLTYqanJIWL81T2vSFL7s9ECpHE/INuf0IQGHatrhL0n77LhvGBCoy4Zdl52yzDku0aIKZ+rfTv221/qqBTlcr0ZR7HT9UiaHv5nMVO2aUnSUaKEgfddxN72cpRshjvnBIe06c4zr9Lek9SSbe5nRqkcp4TlKJk20Jdn8KQLq0SRVx5mcgwob62V1oe0Jobt3+w5lVfBMK0e44InA/hCuqxEJnEhGjb3/ZIVtmhF2EppaXrT3peYPQIKY1atgzYnrYQ7XGMzyHTfaReT/ICjjffHG8exJux1Z/s3i0GVHkokTKh5cWEgNwUYVzRARYvbcvoOa5rL3oV57DFAg3Up+TOn7kzslEmLo3cwIi9iwglqZnXPalrFJjIm+KKeZ0EptDHY
X-Exchange-RoutingPolicyChecked:
	2JU9YnOCrusDn1WxJR+yxCI1W8xjlyr5EqYEd69rXotTpcGDUJfm4fTtEX0V/NApy/KKpP57+IDv5Jm3ustt9XHYpmcfWp2udtuLBgEFVxQoMNlg0jbm5KCZntj8V7VznI6pCmgsV7B2aOcfv/41zxmLO8/uqdKcjTGNESQOFR30fQ2mqDU6aZQyuX84sIHGm15lgzQ9HcEz7qhfTVKBKYIyFcAq9ndH0wQyOiXX/yNoXnVFBBEeUw/xTf1uUe1vSJWh4omGlGFibLaVKoWPL0Cf0ESdrZw30gQf6zekWHro5g0xq7lKR2jcEHbNy9+9tS68uddIi1gtpf92vu7Gew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:34:42.6320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46576fe3-9fbb-49fa-8202-08df0a3dd70e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4a6b cx=c_pps
 a=SPERBzkolnWMWDQhIvzwLw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: CUhVXyhawdERjIN9sMTrxircD6blHflY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXwEK2hf45Bf/A
 V3WqDI04CZPYFfIHy/1SNzOJWVHKaFeqx4HE6YwpseBeP1gen6UgV97dXOL9X0mrn9n1Wchs5Ch
 JQgGJh0stI1hRLFKtSh+2LWQ9Wl4IAbYYgfbXsG77xP5zIQWRInZL4UMMdqDkJa4Hb2h85ixvcx
 eM8Bbv1nRUcuNoUesGhAKVglxMVuSb0gTcpwDIjR2zloasNDXSgcWQACM3EHon71VCMqQuXchYz
 qbl5xLTne5vjj8Sj5T+js+RKaRlIAd/w+utfCZCeCXXRP4YgY/FNoVPvclXigIkODrO9HKhkRjV
 H5UQgz7N3epWdjQwz5Kcg2k1oYQGYepcS76E5KyRJAg4Wj/V4OwtxEdjIcHwfoORj5qKQ8JaJJ9
 72hUuDFPrzwj9EImKoRY7BUh1y6WhtBf+nt5gKyzBO1VoDDcFnmlfdH0svxZ441tjQxhzc5tpl8
 Hz6JdwNHGwXxz9Gy/kA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX+zy7zWFIjo48
 c5bMH6ODURy+0/zNW+TdcSt+aL2yaagdOYInkB3JwHUJ0Zxjv8oAqi6AOXfDZ7u5NPkkxZ/lQnP
 f74TyUp39wucIiEgtRrGm3RTXh5JHNE=
X-Proofpoint-GUID: CUhVXyhawdERjIN9sMTrxircD6blHflY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..86b40abe9e76 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2070,7 +2070,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
 	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
 
-- 
2.51.1

