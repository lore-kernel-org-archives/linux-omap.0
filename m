Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9F3B14B2;
	Fri,  4 Sep 2026 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496590; cv=fail; b=A0HXek3rVlwG/T9McnYGC7ghB8t/1/a3rhFRnKQnXTkRHl/524nCNmH4He7ALlI1PCGk35+Q7tv6zrhpiAqviy1cmhiMejDBkG3IWF/I4aMSaVV2m3pa9EWtEBxrWsNmrZiE0QJ6E088+DED+Z4IjKN6c6MMEqIf14+nsQnfJTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496590; c=relaxed/simple;
	bh=kFixbL+FsCxLSd0nvslRWksZ2aVDcfNRXNEw97jUnxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLf3GkvD7bLLpEaZDQNRqWZzAVy/B1orzPvxgIo8BWGAtgzPxJHwyImcoYsIBaWZfQ7SXvwFlI/ySksFLvx8N9pfgDYO02JC2SCvp07A9AQWDeExDSXzK4pwOfPAShq4OB+4r++yXqnmMY149uv5fH+mkW8r/Fq0WinrXrkfl7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=g2k1q64b; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZRbrp7YD; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="g2k1q64b";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZRbrp7YD"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6842sTDG2586808;
	Thu, 3 Sep 2026 23:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iEUgPIM6vLEn0akTJoB6NpXVUI1PR54gUWPIoYsWB
	PU=; b=g2k1q64bZIq4LfQ5Mkai4Q0JyUMssXBF7HvdVDfp0G0t3wcb7jt1eCN3K
	3VphLrOLbcvFd3IsfhXRldNqklHjtoiS0X+pGI3rzA6o1Y3RsBn7x1iwYambZnr6
	/iPEWYyLJ/Q24h76qtU38PoLp0KPT1wDIVZBZueygHQ39H/zAWRBEg/YiYA2L/nn
	6r327tei4ekTV83ihPbrenfUTwMikVrrwZYtFKfgMLUYUNPf0ziWGBBof7YRE79s
	30edR4Azoh3jrYes80Htz/qnKe7DNdc/SV9thNoHF7imenaOuWIRXL1P45RvSHf5
	zxeESxnKCDoABalRvf3xD+OiTomYQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xs8k8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/lBuYLBvLN2OtpLvMawhVBjhvUlLsHhF8WKSzyTXBZxt9wXb2HywyyD/J7RCN9IBDVkGi/bj2bzvC5jfu9+LUA2O57+wTMzsTE+OwFVh4lQ5h3/NT2rZ9DInsTxRFjyKlpZDoqelBH74Cu5cjcXAE4budmrmLNPKAY7uAeQxa1HAtmOIOUdGUZTdJp3MX753mb3na7cqRsYJ+uAhJ3B/kmX6HoKSrJ71WyaRelEV1oX4Fj4AwiQUZMp/gaZamhXDljueJvTBs/Xt00wlvBSGmDeQmceyaPgOyjccLmPdsonA2C+222cPG0D4FT1J1qa/RxfPMxE+tWiUWMOw4ZSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEUgPIM6vLEn0akTJoB6NpXVUI1PR54gUWPIoYsWBPU=;
 b=bY8klSY3XeOygrusM8bp3QLIVfuAr7e8WGA+UVN+YicFpkae7i32Vefhy5yx3WZg6JieBOSaXpTdgt936us8rMzfAy5m0JZg2E4icicu3xR7S1a3c/Jzu/7pajfAyf7f+Z4IK6G7DG2nmSP5QiH+l+EcOVQg2yX6g6hyBpXj0R8LzKzhGKwBVvun6nDx1kcpvbNtvPj1npA3L+0FYOO5DldWwB3eT1Cjuij0PY4BhXjw4Z75l0R5+iYRzof0EecXnyRVj0xDEH/+FegU7asMn/4u4eY//tpO0bsU6j30LIMzm3PDonV5YVgec+54D5Yh4PkbGOt5gZDw3PRRJXCwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEUgPIM6vLEn0akTJoB6NpXVUI1PR54gUWPIoYsWBPU=;
 b=ZRbrp7YDWOErUtrijh10202JphrL9cxKQsRB5m/zvvcAanUUodS+95cevklDaZ63+vl5QDxcUNAs3aQww6mlKadg0zfG2ElfPzHu6C/TMPH/n43nsaysWx4t9/IhVuM4Kfb165cLIL8ejy0G4/wHrsFWm1/tOH8fY2Zadaj1Dww=
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by CY8PR10MB6754.namprd10.prod.outlook.com (2603:10b6:930:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:25 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:23 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:40 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:35:40 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1N3831572;
	Thu, 3 Sep 2026 23:35:26 -0500
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
Subject: [PATCH net-next 07/33] can: sja1000_platform: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:13 +0530
Message-ID: <20260904043724.2955444-8-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY8PR10MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f5356f-d26f-4793-8581-08df0a3e1326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	4xOlhaEti0AsEd/U0eBpIHHzRAPvnyt6FGwqBmqmao2e60TNhdwM+U8e+4K3yZXTuz5MsoriY2gAEArFyJE+VKV9GX6jREFstUXwpupb+RVuI8T1I7k809TPRjGzEMqZKl2KmWz0yKHGQgRfEuGJBhQo6eWUUATyzrnXDn70Lyxy0lMDvxbnAwIWEZYF0tMEy9QcajB2A0FWNJvboXrQUlTHUceUTw2HTd80REPWlhfFYlGWYLGzVrmQFl2EAMRUxFDH9nShmMPsIGBMpevXDDtEFRJ3VIvCW/GBSyQpViuaIwogAoo8QDLSimG4Mes+9kPnm/DvtsLJxSSRrY77gO0lMpeoIYJp0a9iPUKWC3ktHJejSWwS4veLvBKsRLV/NSzgHkl4DOwwg/nFZgIg04SMimC2izERN6q6S0QSCnQUpoWEAkHHd1YfX2nnaV8xvHPJsfKkYgzmytvGk8Ekd4fK0VE3qhGg13fvH0iQW3SOi5WOgTyHa7ZJ/KVXnoZwY4Zec4kN3/NX0Fr7ytTm8gzsJQYm1c+U9E2joP0QSQSHfF1ThOJGhItj+hY43Ewq3ml9TovXX9n59hhIjfkTLdicvWsyq0MbQOEYFJ2oihKqNQ+FHPL4ZfJUhkm1Ht1P808RafsgJFJ7yU7Y/6HZlBsWuVz8cuR0udAlmf7r7W/0OF42WF8zofN2wXI9DJ//PkBm4r/MW64Y9DOKHHb8X5VZho3bDvxHgn0UfASr0pBS2VqPP4+IzjC0Gg9+CQCI
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o+w952ncTj2q2OOj3FcA/yr6t9k815GJ4Qmwb2y+RxXIILuRIFtTMcAzJ4AZad3yFvvoBvYqOm4B7fKwymCJoVEnm6LmsjvYmGKCPUVNMDhCXjOvsPjXOr6nFjxXNMPUm6BZuS5cIRMILYZs9ynNDIf8d47KKdnTI3rJ12Q2Pjok/aF5CeFR3wBs4bHBGRQAjSyR1Xh8TzQ43oqvYwMEa72egP14fF2wQRBgqLX/MR8SL4BEDPayWk9rmy0E665Qsw1TSbovP9rNUHL3Mk2CL4yTn+X3rcoFe64Vs/QBwYdIUZ9mKY83QbCkj/LVaHfiOUBykCYnm3gKB0IqtLM+5Z1OgtS/elXRx+9qBnvDiVsc5EWUH4DoO2MZV9NvbJXrFKq9lEe3I1hGUylGttv2dTUQq+wP0Z4LIAq8cvTzgC3Lvm5nTGya7KOtR3Txys08
X-Exchange-RoutingPolicyChecked:
	yMyaYy0fXVd+I/NFCOpGVcoI16PrIGsYJLL6T85Ae236fYGzLvpONL3ib+T9rZ1XvqX5naMk1sOqMScjU5yFmRPutbTiFwcJoDQJMPQwQoPkXdUOqTONciCLX45s9HWS10dWra/QO5R5XHPa/N2T2TyDT3PzdoOjp6SMrlKsqqClwpijbzduMCKeC7NZ3+RZrb86rmADKRi777JY68AKgutwqNYcKHE8HSLcUTXs4NaiRftxlml7lQdmPlAgrYf4WyXnmDd/z13RSbQjUIyw6C24sqt5zuFOnoWa8gylxKcRCj0yxuSyXyrse6cJSfHNR62qMxAbjFAP77MNB4MpqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:23.4540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f5356f-d26f-4793-8581-08df0a3e1326
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6754
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXy+kMHcAc+XCm
 LjF4RRDFZwO0Dx83tT3MJmr0SQCk1FvvYN42SxLUcZKBKPLIm6/od36NvFYj0FPjcJcLfHRNOEI
 KPc1JBfFfXTVzWH2bNVuvuE/C8t5Yyw=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9a4acb cx=c_pps
 a=0TqV76FF6b88ixmMdEmTEg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-GUID: NO1xgGtX_UoOsifJcbt7pPDXG_SK6yZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX+Qzgb57ve9Yy
 pK3LrXvPqaXD6cyvB97IvdeY85AtEr93hWnIKAKV1JPzr3GM2O7ZP5QAPJBIjH0/Lrjhfgv4Y3P
 XXSGxyOiQvHXP9ZF42XaqajvL17r/MeDzNjoeFtZzL64tOKJjFJdYflpktArBB/bpWGihXWMFdL
 MvPPT8zvHge7RrhEruSyccEhw9ppv336eekduWUzYBXkr8kcc0BHZxbG8zAI131EYpGkBeEJRcX
 i7w5fdLhT2kcCBpDF1MUSZ+18mE7uqUniPVec3RKhgZ0/DKy7HQuvNgujU7EOMkORtdAUaEa9RD
 hjoxrws3qQxsHJuJwzzIxCLWqiButcxUVTG7d0JhbrOCtuG8AMoPMLZo3KYL/BPREiBTkK0Dkl6
 QlGuKHANwnHSz9fnZjjiTORBp8IloQhMHEMATFutZrYXLGR6StZcE9OXm1m0RF3dT1aGiEcyOFP
 vENh37zobQ4xhBFe9QQ==
X-Proofpoint-ORIG-GUID: NO1xgGtX_UoOsifJcbt7pPDXG_SK6yZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040040

Since sentinel is the last entry and we do not expect further entries
following it, remove the comma.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/can/sja1000/sja1000_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 2d555f854008..da4e1c820b6e 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -207,7 +207,7 @@ static const struct of_device_id sp_of_table[] = {
 	{ .compatible = "nxp,sja1000", .data = NULL, },
 	{ .compatible = "renesas,rzn1-sja1000", .data = &renesas_data, },
 	{ .compatible = "technologic,sja1000", .data = &technologic_data, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sp_of_table);
 
-- 
2.51.1

