Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44923EC801;
	Fri,  4 Sep 2026 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496617; cv=fail; b=S7XpyD+KqX6jPQHL0CCMX3eeP3BtYPTr/ziz6ISRz5H40GXDE1OpVudo/mZSfNI5RuyQHhq7jiQxHMS+oGFaUbN872psdsZ7Ly8HF4pMhtGpG7ibA+s5lnlhmwiKxay6g1tBsNE1CRsTFeKCpmLDRZmykvVc35qkvDSnf7K4Vxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496617; c=relaxed/simple;
	bh=nQl6UxXr56A2T3M24rhqVGlbl7LdfWr2EGvwrhLqrTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7w+xpJBtOuV96UWUjvSvIkG+POjWKMgXVUJgz8SnCMX6HjqSYMfKuq5V7/vCi+7g1P+Gh/OPU+Qq1VQTP4eT3OcqF1J9/0KFBTUwIdjbGTC4ZGCbR5DcoxmQ8cj64KQplESWdfsyC9RMC7N8BYICAmhN9N1YyUwgxBWZrVW+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=cW8SARrG; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dhjXlo8d; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="cW8SARrG";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dhjXlo8d"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sgVH2373995;
	Thu, 3 Sep 2026 23:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Qo/rvUmfwm6RfEiGNgslF0uRT5aybQfEK7dSIeDEc
	Vk=; b=cW8SARrGtErkrf0Agql9GN+6SqlmglfVWdNxGJeFd3souu7yxvfrz6rXC
	7YQ2DT+/WXLyA/HebEpqrRyBh/kb1Op4HAomK0z5g3/ol/cXP8a4cCGXd1bYtZ9q
	FLLhjW53TsWK0mYDOVbc6lw3qdGNj40rDpvq/YtSjgSAOyZ2jxHhjmjZJOHDxpPg
	FWyKTeslJhJZw31ACaoogStFeRCRlTSld6Idg5Ejvp9pBDIJYsLhT0FtJZSkOHoq
	pRX13MXAn+cIHVt4sR4Nl7Vx0lSJC6mem5ull15bE4azHzFTw/2hpWmGNY8W01ku
	ol5owstWGomUarRWmWsRyaYFCOZzw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jexjx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNWWgLvX2xSxmF8De2eauQf189HSf5XEAChXAqEeMNbCvB/uLdtGJ7T14pu0uxBgUtLX+D7orTppegXmEYPi8ZGDcbd4sPonOaTFwaEl0dB8qf3SIX2+PT28oMnkc+ZA9K0kcBKMt4+Z0cZqUdASdCpnva149Do+k6E5isUaPWBfLjZkl3T8zlY76phvDz7Sj/8dKkIVPzsbGPDtrzMgi/VtcfdgbyhBNQJSJ9cmJM/FJD7o2RwJi/cMThdXOxlZHoupIKDstTmDBP1CBIn1HZ2wa+oTpL97abNtU0roribp0tVJq/gb0kZifHc8clHvXMAtqh9HaS6c/AYwLBW2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo/rvUmfwm6RfEiGNgslF0uRT5aybQfEK7dSIeDEcVk=;
 b=pi5fdpmdT85KEL4j2GdRC25G3XxMj2jvpjke563pd3idvrnEXi6Q9eWYVVGXdeg95nwtEcaYfQplKJm3jNrSz7EEsPgM/R3KQMPJEwgN88o5ehlq0cUu6gF8wZoZY1f68hC4fVl76j+OlpBUt+EHQDc9Z9Jb9q+rW3JLhWPRA7Ov8kf2wVN+0D8zpaZWQg2Yo0ZYlwmHQxxFYhXPuhq6AnHUlln4crWjUUzTzzSCwLlXui6T+MZoovyZqOSKPKJnXs55t5VFPqP2j28Tr8fxboTOeEHL7r/eWlaoJIrBeYkJqOSgd2j15k8ALcymud0jm6WoL2HiycUGHY0Pn26x5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo/rvUmfwm6RfEiGNgslF0uRT5aybQfEK7dSIeDEcVk=;
 b=dhjXlo8dpBdyPnRfjahyJ1fUXgv6LFW10cRvdEHqF7qaQkwEI9r4KAYGixQprwP5KpM3evb01cMLpQLnlJLScPR5juf/TA9UncIz7vdc6LrG/h2JtjKTxID316JWbTP0/dABdr5Db0UraS6wP81sj2UpfiLnG+GeY1RoFjNu8Sc=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:51 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::49) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 04:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:49 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:09 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:36:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:36:09 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1P3831572;
	Thu, 3 Sep 2026 23:35:55 -0500
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
Subject: [PATCH net-next 09/33] net: dsa: b53: srab: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:15 +0530
Message-ID: <20260904043724.2955444-10-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SN4PR10MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: f7063cde-b78c-4fd3-e9b3-08df0a3e2294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|921020|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6cmoRTtOfkXSA29uJxACyWPe7+qibQEO9zfpuo3UrSAVG0tD8FlA+7MZW+NO1IZ1i3GMTtb2CM0PTlN90Q8q6SHapdBpruwRiBKM6MOUq/FztwnaXuNPe2Wh5mvgKjDQy3oWqey9z1HUCYTAQFtpeQYiwS7a2fX7YS04mDYtU1xrIYpkzt/x3i3LgLleUE3TmTLSVx3kotJvLveXvmpokWJ07RKpdhh6lJ9TksxI3EFmO4flqt7O2qm/0DJFU08vo5i86daQ7ifC9Z6S+aLtETncyLtcOMkJDt56ZZ3bqWvcNzcNUwI0pDzNHWLe0WCh6HTR2OyrSf2w6Zgouj+ERGFXQsM5he4P2mHdBPc14Gk5djjTFUNdfdjGxpU+l7p+mtajAPyzPommwqP9Q7jteu2KjPjpUCrZSvbjDT/k5Flb9BobtGUbpIMzFogDN3ifNeKP75w4qyIUJAJcZH20O4Q9DYqPFPgt8GLb05n6UszcyNB5QfliGgVEspArFLpa5CnEK48bw/gtvKe1fK4q/ZwZiJ6sOEFQr0Hwc9ey4oT+iudsKd4KzK2Fnn88Y0DjtoZCFjm6F1AMOvN5O8SglWtyPthweARyuEK+wVAao6k6Dq8p/uo2bWe5eMf5fs8QDo6EbTupcJsaNctrLNVP7a9VA7a35GcNogAJpnqgw/tYWHMRtGYcK8JmRRXUEcI//1cNcFoTX3nu4Wy01KEiUcsNL53UDR10vost6o/yQ4pFAQJ9HyurtiAAKIyJZxdW
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W9Gpvm/PjExMWnU7ljzLrY7KFOQLLmYBTh41ZpdoxE4ykWcBHp4BPoQUGeRyY/tcD/OODsBguRE1cCITfa4cGuq9tZ4Q7YjFfpFmLWv5JEJXECnhwyaCVl+TctjrJbnU9lsU3aV1Dl31NwghFNTHveyAOudWhI1N2ROBHsUrOrqy+wG3PkXUjMr9GbGnACFvZgO8oy00wrlkfGx3aeFYXSbhmWTCa6PzCh6eASLaNxcbBii4ql2zcYEu54DxPp6lenRJbO58GJw8zletZpq8737TNdtKgqVPqRPx1VMD0jbVv0mngy/IVP6F6XD+81Le8T0jFkm5zV0VnpIvLg1yBtEcxqnmmYh6Y4R6piWSIia1VzGg4Tl5YrRtIlFAgQIekpodFvEzBzJ+SFpl1yybG37CGZ5kyQifCaJc86GT+RTFLSzDQjCZnmU1PlYgPTaV
X-Exchange-RoutingPolicyChecked:
	u5tCBJnPKoK1pEwEuNkPLRHoS5Gzzo6r5J4hEvaYl/pHMk5Zzq5ayoXd7LblsQe6jx7QskRjlnW4VEnRqnhyexWy3/ivlu/fBfmqjJ0c0x/L40mxi93laGrIXzsofeBCiBAZo7O6ddTsfcViKryPo+oz7FWHLDuWnJDuvzotj8aOd6ksuLbMTpyJG5wTpGNeNpVCie7sy/b8SIFYmFAATrMfci6N4NduZiNqQkYcRc2aXe4Tl+TFPaYaX95qH8JuzyrmUyhpW4K5ldwtuk8UNwzXlXlZfrcOJL+glk/lf8WJ4jWlCKgWvN6SPuJBrWNnQeBIMqKOGDzw71kC9pb5ew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:49.3408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7063cde-b78c-4fd3-e9b3-08df0a3e2294
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5590
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4ae6 cx=c_pps
 a=e4reWzpetjGbn3OykFohnA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: e_QmpQ7vs7WdZi1h-h3Oz_Jji6LW46T2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX12qVyT5zlxAc
 EE3JxHqqLF9T1q1527EQJhqcuTo01sigzj5GVYU1QF/wrMfeguhKu6P+sq/tkR0I32rwOfjSSkN
 rMWuQIkCyGxe22gZk13sjgGiY3CL0hi/ex+uGFn3oZwYjCmoqSAIZptsDPOAe6qU22DARJ/u70i
 FUW5MjW3rr7UhWFZ3bw6XHzCXVfI9rwf/1/uOmzO+ef4omzD3RPbHv2k6JGo+2GZN3pX6M7wOfD
 PDvgOnmMAQmqWdYUWacEkseIYsK5d9aOVipP7LO3JKdbioz6APqV9975xjtBEIaDMhTNNBy0pmx
 9fzVJVzogIrw+EwETcI17mqF7ORqf3QJnWIH7/mNJZVmD3WFkdL84LAE7Hg4lWGla1+XYvXp4wX
 Z1wVyqk1WTrwa9WUda9I7HedmQhaMi06yLPiNtX0nZ3Lj1y6lHv7vIdP6Wb6eCSNb2/0inmhui1
 2c5hr/90sGGy426Ry/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfXw2m98bEwrvLz
 XVUjlDgjhq+zekLXyTNvBHhnErpIbEL5+c8MOnCKQoYyhJfk97BZwzXpumIlgsL0IF9H6lxwZMg
 /v9QqRhOvoM2A/rj8dh7mjDoaWt+Ewk=
X-Proofpoint-GUID: e_QmpQ7vs7WdZi1h-h3Oz_Jji6LW46T2
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
 drivers/net/dsa/b53/b53_srab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b9939bbd2cd5..83a03fca142a 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -515,7 +515,7 @@ static const struct of_device_id b53_srab_of_match[] = {
 	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM583XX_DEVICE_ID },
 	{ .compatible = "brcm,nsp-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,omega-srab", .data = (void *)BCM583XX_DEVICE_ID },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, b53_srab_of_match);
 
-- 
2.51.1

