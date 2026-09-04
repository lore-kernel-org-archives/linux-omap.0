Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721873EC801;
	Fri,  4 Sep 2026 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496568; cv=fail; b=tz3s20TD7u11XqxPv+JnCNcl5lzlgFx5Vqw3mWKL+MeXCD9BHkxZVjN5t0xKLJFOaQPGRZkt9Fdvo4AJ+5bNohUfusf+GniXmmq8T2I4XfSCnpxC1w0/+yaVnmRx+7jgRChF2x5cYpBuJfS0jDh1AZkCjTnMyhwvzsMcsobjDzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496568; c=relaxed/simple;
	bh=q3QTb75ZCK+PNJrXjEBm4x83aEafGkLLlIb158qwCjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvgWPG3wHYlmF3Aw/sjnmFHrRooDfDc5whgopxOJxCq514pH2Hz2LwtYLMLUuLjtbEUPb/7/MovK3FGAlygD1jPhYHCQBymATvpD5bXnmUt6SjyhXTv8H+H6f9zrTKWhs9N/ssN5rek4eQyCIwP8lOMQD1CShsACBRlOGA7E2Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jbijPiva; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xc4F6FdX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jbijPiva";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xc4F6FdX"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842sg1j2373996;
	Thu, 3 Sep 2026 23:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=PTx0Rq1AEiVZd1c1y2YyJkPOxLf3eFmbA+/Xj5qgi
	Uk=; b=jbijPivaqcsKX1br+yGPMFHSYz+7Cq6rd1W3/9hDW4rPNxzVacNpUHwlR
	QPaMdFGDAUvaQZQIFfvEsOE+Iy0ERRhj8ROuKp9z8MIkDdhtyPa6cWTDuky7cyKO
	2p7SGs3f8TVzKT7n+Au3ZHf2YNoqdm1eNIYPx9FzqJPrW7Od5X/Feu0FA5r2dtLp
	PymA3aQlme8FG75lHy5oxQYSakyuT06UtVQsAV6CwgZvRsuUoFo5TsMRtULOhPUi
	GbByTj11hWMjk+ydXCjZacUnbkErLETfiDiWcXoCQpLL2rmKn9LoXN0/txfzzSac
	kNyCvoOGJvHpY5EIgz8WbG9wJpZbQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gf68jexfk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:36:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9LAPlzM7Ax0822MYx0+ae6QJ4RP2/eYuN2Dcs7x1oCx931qtsymBGjjd5w4aKHIdqcp5rfCOcdlY/0Usj4XYjXZbJQUjy0XHT0oXz8eDqKEdF+mVnp2ocNBjGPLczyRPMtKOTSVfi4OzN+8oC8C65nntx0flh7RPhWEacS+S3qvGjXZlqltyZNFPG4dduQtOPD8xvedlooJPtjEateQnltK/wzOioLzfWEB8t+t/67cKrP3ItYeGvS2aR8nXfucbhZOD1CjfbgNA+mfSf/8HX8bDJpRPW8O0UWFE8GCeVH95YBz5uCtiLH3dfOQyO5Qg061tTsMzSHM1kMOiiBMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTx0Rq1AEiVZd1c1y2YyJkPOxLf3eFmbA+/Xj5qgiUk=;
 b=fl0n6THo8ZTiTMfMuAS3tzN2TFCyaF2HoBo2mvYapI8C/9laLNaxQ4hJP8+HsZSeQrEilOLjt6HxHtUKxge5Nu3Q2BeHaztjO/yJHbJxbyTzGn5nxBIlkEu6szWV5t/FBPrvyQbFP/+jRQrtDy5efD7art/tuhOKq8nXP9L8OqAJKi0f6q7rBYhc6aBs+g+4kHkLZYGqZoAih1u7VMDePf13OIiEBOhiYBIQiTouUNgF+TuWfagvVhjvaaQBca77fqPrA04PazIcOUNd9R7JllCuGZYkdd6BPpgBTFCZIIZ/+kF4YPz3GIELAnIKvpjciUDBVzYLCCOgSzew6OZMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTx0Rq1AEiVZd1c1y2YyJkPOxLf3eFmbA+/Xj5qgiUk=;
 b=Xc4F6FdXo21HOq94U1B1sf2tKA8RDNU+nmZOdUBH6BKqLWwa63oJQeDvap6bDIU29c7mocRxZHacuDyF8l6bMfkLg70M9xBKRMYoRkbq1M5hzqzmR1GScG8K4t0KGdXQ/aN9BxBbkUb8TCppwTD8dJDkKaN/tWG7afgHoc3jvZo=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by DS7PR10MB5198.namprd10.prod.outlook.com (2603:10b6:5:3a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 04:36:01 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::91) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 04:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 04:36:00 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:11 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 23:35:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 23:35:10 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6844Xh1L3831572;
	Thu, 3 Sep 2026 23:34:56 -0500
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
Subject: [PATCH net-next 05/33] can: m_can: Remove comma after sentinel-entry in match-table
Date: Fri, 4 Sep 2026 10:06:11 +0530
Message-ID: <20260904043724.2955444-6-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS7PR10MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 3714ccae-4d72-4ada-78b2-08df0a3e0573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TKfmX48No09SqF41u1kKghcRBM8D0rahaC3/srl+CWknmxxwzG0eIhBuNjM+2Hb1bwkjRPmb9n+3HA6KxCKN8PpkanDtCcDCXWzo/A55plclOQ6jCwCRrJm5kBGMLp7wSLdpWnAMBIkr7QHClBA6iuFL+nbHmnodBGB9zt6WDGx2CWO3zar1ai3lDXtnZgvIK84yc8vJRjCOCIDZK+b8NO1kafi/6YDZKJyX3oxh1abEJuCJJYNOS5w1m/66p57i86WvLcQw74pWFPuw7cRE1z7tepuFNXHKrCQ1T1DKAPal17QgtA21U8gaWtIfM6rR5TfJUEzr0qqs32GJjq6KLOZ3C+RdEH7oOWcj2b/66M+HMKgwEBMns3wZ/tzMkMho2Y3i92TbmkO1slPbIfrLtR6cWpy4eeBUMthFBO6jZMsGz7q6FYfr2KmZg7MMraLIMUtb9e5vFjwz0+Es8iHVLlTHeJRpCtdDAG4/Enw9cG117t3FvGdzBWgryczSBZvbQrWFQpiK0ua4QLRngdsGRX4LF4M53rcm9IzcuYETEM/J3N/ow9PZccLt4BJnRzfiFy3tDJYM0FbWfOydP1dB0fmMLenfV7tBsrWNuR+lDxsCUTWgmIQKV7+fsZUDLHyxOShIO2SGGsvir32eEnwO3eVrzjxmgGQGbe0RSy6ZwNls0Ros+VI+B/8Uam5oMYR8aYvdzIXQ4UXliR4GRsHz8dUtztGFP4FVHFy2gKKcAEU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TNTi1XUfPI76R4fXko7nGNesc913AyrY5OrZohM+CI57ivL3q9H1PqKh1yYQDxfMjxyuS8TT1sdYA6ApxfOqHxcapD0silUJ5JOPUK3rryeRYtMMj/MdiL07lu3B9yhw7/vVYYMmPODcgbuR8SqvndpHunN1CfsJ8qXY/cFFzBcInNrOmLEXFxruxU8yk5ULaQsEJFJSgUIVjiP5CTlyjq17MJul0imx2JoxuL/lShC+elr7HvtEMSC201xh2g+nvTNfZQ9txtqyTKhF/KWzVGeA2FurCTqOgr7Ods1Yy7L4gi5q3/up/7cN4+smu9HiW+TMn/elKmJ+rL/XFi8eeeRyPG5OnIUbMi+Q32oisEIWanKwXRul3g2UliCWHGuOp+U26lKKbiR6RSp+sIBZFSAf7vqL6vr6C+h1sgtR5mDCxUKB3kwiABRXIL+dYkF7
X-Exchange-RoutingPolicyChecked:
	GY69U9/5HCCqz4Okj1mwGPW3uvknTDOwutV6z0yWsu+sKrq3ioyEIL0D9gQzCuVxVZVW2Z9q6i6KLQ4rRVpBqPjBEsbQBioRzXCBtvp0moFvsUlTcv3eD3qo4F+S7Tf0H96wJakGHerAGlXDmsmhJ6s5cLOWjflDUOS6pCf9aBjKkMUqFD9VhmOuk12wbF16yh35YQusrDlXBZ9uTvixrDk+8OrbiJ3M2R8SDKwTc2P2CQRP4o5mlHuwK4e5lT66AYgFwvrd6NKSk75nik8BuFlbqjiFDTh9JVZGuWL0IkCCgX3YcO7JhOTBvKJXFFSAzoF56X09V36NEkScpVeT/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 04:36:00.4690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3714ccae-4d72-4ada-78b2-08df0a3e0573
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5198
X-Authority-Analysis: v=2.4 cv=MvBiLWae c=1 sm=1 tr=0 ts=6a9a4ab5 cx=c_pps
 a=vvCUPcqovLgrcFR9lHNvxw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=YpTJUd8zm14dbW4r80wA:9
X-Proofpoint-ORIG-GUID: Tu0C2J9yAKaLq9qKUmg-O9ZDRH04qQat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX/mi4jYAgvGRb
 WtCiUtVKuNX5wKokdfq2Uz+wqEMR8y884Rwen98jEF5s1FpK3K/PEPFvMSfKq2TX8HNu9CBMhHr
 tz7yFxLGFOQPhJC3Ls+u+FSEU5bPIrUqmsn0qgEFjD/htTLaUGd1UNPEmCoRQjScZwtKAAWun6R
 gLySn4jmt+2SPUMdcWdcQXnW+CbebnyNX68jsQOlhCis2eIRVjsLruyQLv90ewYTpePXqVJgLs2
 jeGREic+fajl5ngQFL11TW964g4DYLXfC496S3J6B7N6Qd7qlMGAwqlGbpKmZ9Qq1E9HdspfvQY
 sBfJ9F4eRvXYxk7ABZ6BqiFNI0dt1XZRDK/kUC5LipZE7cHH0xiyv2ndfBHoTDh7N5hjUiGpTe3
 diK6H5CPx9ztNRmNxIVD9tFm+YX2qWDxTyM/a9wL9ZtftWDYueu2VEQwjNIz5JN9dOznvXsCKyI
 qMWkefMNaAxBSreNN5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA0MCBTYWx0ZWRfX1Af7EQ5I67K6
 CCTmM4+HCdLKeHDDI3dhFzM3ikH7UdwX7jAyThVP5dY3M6stT5nsSNPNmVjCZn+68qIBGVbYjsE
 WvBHRsKVm8Hq1QwPEy4ziqwi+RgUAiI=
X-Proofpoint-GUID: Tu0C2J9yAKaLq9qKUmg-O9ZDRH04qQat
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
 drivers/net/can/m_can/m_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af..51dd41dbf2c9 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -220,7 +220,7 @@ static const struct dev_pm_ops m_can_pmops = {
 
 static const struct of_device_id m_can_of_table[] = {
 	{ .compatible = "bosch,m_can", .data = NULL },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, m_can_of_table);
 
-- 
2.51.1

