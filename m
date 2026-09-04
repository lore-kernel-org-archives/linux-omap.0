Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4663F8881;
	Fri,  4 Sep 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496814; cv=fail; b=SZVj06VpJQ/s1qDUZ5sLZmkwJ5MFLHI9fOX/mzoo1w4bMc5HBFvKwwYJQpZKxZVHXNpocCtMl0/5/JM4j6m8wOo1M2cpRm4HtySJWS27LpSL5U5ZeyiZmE18z0ql2ndvJQHWcaPveOGuKCAGx7OTtL235784GbjVojkxht3Ahs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496814; c=relaxed/simple;
	bh=avrBRQt9a2to5q7sY/Ra2LtqU6wBd6MiDXG6Njhl5Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZscnkVcQXhj3BINn3V6NNF5E0KuUFffXyI5ObiE4zk2XL3iH5fmDJmLnTzYJwMTQxxrXwodRCuQafaCQ/wf7jqnTLZUHc9J0C51ZPzvvUW+e1PlF8EBflPhO3NmhHr5BksYzjyzvv+x+8/FnojMzWlp+HRRs6DGyFN6YLSYElV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Zyk9T2Wb; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qjrodgrN; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Zyk9T2Wb";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qjrodgrN"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sgVi2373995;
	Thu, 3 Sep 2026 23:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=p0bBUvxcrTo/Rl15B8B4P3H3Del/n5WxoPgsY9ddT
	UM=; b=Zyk9T2WbIEeZYGfT7CVz1P/vKjpVa/d5X1juFSyTrBHUBWjs5JD5TcTQ/
	QoOjpod/2TKWSOmqXeGFSI1N63wxs3ckdG72fsFHGYFpzrcKOrZSxbfwFwZ2CAQl
	G6OzhhJvCbTk4O/kudVW11L2tZNKALchVqryT4tZAbCrfh6WxP2pPNUwdD8Rys1R
	kEp7J8Gg3Y6/w4F+2AcXHIDikfUAQSTuE6wlG5pdOPi8Pg02epK9AmIxug17J2EO
	/X/UEJ+zsGiDxZ9y9UopkfoGIWWiy+xVvqG26C2UChUb5E9bs2dyUJmxnFq00YTs
	1UGcIfYJ1FR/eOMNEtPl0oleG0GHw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jey0t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:40:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIEHSqQHUtIZjeiQr3OSldJPSxV+Cn0Sh9cXHZMjcfEApgsNNOeqZLyq/bbSHEbRH3g+rQnM3AdvvFkXFF5q6+kXU68qfaG1KQjGkOvfEN19c5OBwu6O5P3tYKEwKAuQtziH4Rls3AJLsPFHERCK53qABezmHOQhtFghz6zpRJZC7qrlD4Ud+89PaeSvLLHk+dHhXgettiAQwSWeJZJujwMGaOnA+Oa4S1bM+a6kbIozBu7oLLKT3xQivm4eINCx8JvnVXzYxrbZp2D3rna+K5YNpQZzU9AMNodWBAkIv/aS1Ix490JwX0/ZqlxMOdHyp/7dwuo1bHYWcXoVsCDEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0bBUvxcrTo/Rl15B8B4P3H3Del/n5WxoPgsY9ddTUM=;
 b=o4JYdzbYhtb0yBSIDMNDjAOdVzL3Akx4AdBSwdh6KFRHO7E3XfQCurWCmgBZjfDqsiVAuUuz6QFhj/pUttdj5mb6LURO0n2uBFG1Y1Y59YzSV+pXWlymRtsBLFNSAr27jMaBUtjiqdz84vdxCbJ7nNz5WqW+o2ThaGJ44Ipm2+1YX0IBN+U80ytruu23fGiCzQlG4zQ6WFD4CgDHyFT+bylZQlZCz3nw3ZOnKkTDsXZCf4v9e9PbnCPK7VAx+86cKBNKuln8YZqq9LB6VJrayaiEc0kfkGR4M3qwYEJ4XTqAi0nFIpg+qRjQwuNiobXAjfc6dlfU8jeIHTW58ByZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0bBUvxcrTo/Rl15B8B4P3H3Del/n5WxoPgsY9ddTUM=;
 b=qjrodgrNUbQ4uDqkSAYcrqeFa8EZ1/0G/pekn7RckPsbXvmHocBgWa+DxMM63bMBZvt/f3u4nFRo9+yoiZt7D+Ggr1EeDYNzSUqdEyez9xYg8GCJcnTfKBAjH7XPuqRQVOiFlDpmI0gOAgQtDEDE1z/TyNv7H3L3zXLSghlDCPM=
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:40:09 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::82) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:40:08 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:34 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:39:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:39:34 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1d3831572;
	Thu, 3 Sep 2026 23:39:19 -0500
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
Subject: [PATCH net-next 23/33] net: dsa: sja1105: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:29 +0530
Message-ID: <20260904043724.2955444-24-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: e68ae6cc-cab4-42a8-45e0-08df0a3e9989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	yCDNsR8q2wGbv9xKAWztUc0BH/PIhT/uCXswjc9xVbGmjkv/8peqaNy20cBC99BunZ9hSSywwXuhWAJIMzLMr40n88/Ad+FJ1grdJdi/yVhEUq3HNhVWVqqTX4Q6DG8nRZgq3ymN3NIEEtZmhivZmHNLncYyqQp2V++OThs+HEO+nn/pQ3kaPNKgLLX/BM7b/910nzjZGNyzQ/DBuwEnrnc9T14z8L1SX1Mr6qNvvCGs58U1fLJqn4+ihDWRRy9jDWII9Js/TTmDGv0HVHPlZSSXh5f/KuYnSmzXKfXMu26LTzxTmYFUmSIk/EimhYOS949//nOaTvNOvzc2AewDJZHoIZ/ctaoAOLfAiykOsqEZUQJU9pI+0IAUa3djMMlCY2lAX619pMc+hWtlTImqIQ4bRO2C5t9FpLkHHHkLHHDQRbjeVJy5k9sPtfJ0zY82OpfaNProiJdfiB4SgTDZfV5kMVyw/gRdlvrPt1CXikFGxZ5upGccEK1AWOMDBZSMn8elzHMDb6I9w+uayH/faiRUKomkCfB2C5ybOo9r741zPqokD2qjcFxnM0LRZT19fUeLjFuYZrjVy7ABAiG+aADa2Rfl43ihESa7HTORxp45ennnL6Pn23eEA63pgAuI6uRtB8QF25MzfIEbxdNYClVY8rj5m1uXHfMN7WJYDH7Fp9fbU9ngpo+WrEIG913tlHx3SX7o7BmGLpy7W1sncwLtKbG0SUFCvW6UVcJVJGzjwf9bLatm6N3Y/Gtgg1d9
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ygxjFwOHIry8Sd2TnA7B1a/mRiYCZxVPGsNHwClIC57Jh3p0+2O+GmS7AE1lVnBMVkwFWRqjVZBGHK/makg577a118wUUUCN5DvcEjk36/DR+xakn48PlOWFvuIu96/2kz13naTO2IPkLB3ivakO8MR/9LU6+n0HweNvNAzl1r6JEi4bqLTfzXCYjfgRVS222b9A4jn3kfYzqw2Gc0cSz7Z9gJNRujhufqcJxVLprN9fK8BSSvjamr9vWROXkqAED0FDo69ruk+2ASRBuz2yJKkRhMyLEne2QSV4pm5QSamoyD/AAfIogf2Seai6SlWqFgUVDPi4R48FQnz+tGUECMWXhenoZoTjdXQ4RdHyNtT4d5Ku+INA2+v/m8x5k1UTlJa+VDDZVxi/ElyQFjZbBgUBl2CFGVOw0v6tqhamm8duPeb6FXBY7k1FhZeC6tPf
X-Exchange-RoutingPolicyChecked:
	haj/6XJw4N718mUFVFVQoDuASqk8aTxLVYiITSNuYRVGT5H7w/PQHnXx6gykm5F7W+nIaajn2pYQYtCBTkNR88/Xg0FC/XiW5c1YqbuM5MjVuw+0xom2PrJ2BvDo15JpC0Eaq2MUh4XgUKuA9mUSNnY/3zn8aeFT+2+ADWBKejNVT7j/VxqepExetlcEIx+2H3sFBLgzI41RGt38UekxmCGv/8FRc3C2O3R3kHj/gcdcOA2NBr7kloM4rTPr8Asnt2aoaNMSNMPs06+Z5Z0FHgQ3z3aeMqY/1fhCx5LP4YKww+aN11hLbj+6S/0SIMcLLZ7ZO/TiTQCdI3B0sIwkHA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:40:08.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68ae6cc-cab4-42a8-45e0-08df0a3e9989
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4bab cx=c_pps
 a=+UayH2mdqs80qU9+PBkj6w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: TZxjIbVB_OpkOoiiJuHWPom0_1YPdaU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX1aCOD99BA+nr
 FKmihDqieGfUI7V4gAdpG/wgZ3CldjBjU+yI2SewILmO0iFIca3ogr8CLgf1TFNv98hOLxaSwWp
 QRvKqbYJMWBAYNxaXFJ53UmL9j8jtSinjKOj4YINRXtVGmWMWu8UlAJHAlu2b0hK2jYy4loZRAQ
 1246XIBx+RK9GMkHikHkgI7OCKUJuMtG9eslGe8d6mP3dBPauPhw5TFVAX0FAXSj77GbZhSHuL8
 ygkC4UHC/LcZH1ZPq4pdM5GUbwniXMKg1xBxjpxYG3NkxwFeCW9jqDubfQGQlGKiTbI9LEyG8av
 TcZGHbQAtHzW5BVoTySRhBXpRfjldkLPODN35SHdfvwJu1NbUrQa2lySJKs+d0hFxAuhyPIMtOw
 RFb0vLgAK0Rx2XdgvgLyzW0DA8IwrCnsLTFU6oFFl3hF/O8iVLf34Qsox9j+auQplW6u8zXlMh9
 nYV4OfE1fYWc7G7MA7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX4RN9MiDGAihY
 DQU64m3Y5sZ0kItLljsOjSrEYceroOU+GNtb/Lo2qgGjNRLBEtqBbKlsiDFC/Nc3LSeSfW33kz3
 L21SjjIpV0GVpupj9nrDE6Hbme9MnHc=
X-Proofpoint-GUID: TZxjIbVB_OpkOoiiJuHWPom0_1YPdaU-
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
 drivers/net/dsa/sja1105/sja1105_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 1653e83d9123..8984ed55ad59 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3374,7 +3374,7 @@ static const struct of_device_id sja1105_dt_ids[] = {
 	{ .compatible = "nxp,sja1110b", .data = &sja1110b_info },
 	{ .compatible = "nxp,sja1110c", .data = &sja1110c_info },
 	{ .compatible = "nxp,sja1110d", .data = &sja1110d_info },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sja1105_dt_ids);
 
-- 
2.51.1

