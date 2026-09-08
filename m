Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378053447E;
	Tue,  8 Sep 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882177; cv=fail; b=Ahs9TJJdXrqfaZJ0ASOnk4FT6VDuSl4fmohvd3ef1pAmSvJp5h38zctlOKw2thVPk5n2hjisXsypa6KEk/YPqUjU0vlNL7awmIxZOqEoi+zS3P64qVlWwQ/klU+AUAF7IuDFYPHvL8lyKgqXzSfDoDt3hdO6MfpcXUL6L5Jhhyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882177; c=relaxed/simple;
	bh=Vbn+XLMaFzBjz/uvtk95yaSvYtDRv5PeHaLFfCPIbjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKgKMAXSpUe9lmhx8U02DhVPLqm6AVy68IXcO1JJ07rt+DGnox6oiqjx/D5/Xmd4YdTLquA0/vtP1UE9/n73ZB3BtEHSy77XLKWAlxzx5cyMZM1T00NGIerp0ctaST9HzGZmYj8C1i7wNyo3cFOfEdmDe3aZQmQ9KlWAGfRbmqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NydjUmG1; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UiP63I7E; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NydjUmG1";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UiP63I7E"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 688EjrMb2032901;
	Tue, 8 Sep 2026 10:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jiss
	aY=; b=NydjUmG1PCdAJzDMgWrJ9WIqJRIF9IP10T/6Rc8Q2BF6v6TYd20SimAEp
	pqRVcQ43vOV3Dfa3lvXI8ltxnNTr7uEkRGcmXZ62m15SPCmTKapNMH99CAyhzXLB
	3jc0xWQ73G8fcycU4ctOc+KuViBeiLrvjWivsdiGIXouh8Obw6jnKUI62Zh5Nu+6
	+bRKPsLv0naF9OyKThw4VthHXmPvZlRc8fUWg6bc/ArOgMPU8usOCesEYlCJRnvQ
	6q/WS5gqoqAm1AerLhfqAVejW94KeMmIyHekOwkh3A5v0qP9aUhUyuwWlM49G8Fq
	e2Ec8uzwqHCTsKZQIDBnGToqkrSUA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gjffmtbdq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:42:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZOM4TX58qLnm39A1uq+L4qQoDPvxbf80dhMSw29HKX7AY12Vm0ZNq4N2j56r5KrYzI/6bLxfM9MwWe6Q7VAVcDCiFtjybq99kmBzuUXqvsjXJVoVTBE6x8A/OkWu0on77GbTzDTw8TPux9CQv29YD634HqasR3ALc+mgD+EhDWgMY2nZvB/bR75WGH2wKGWg7j8KpNq92SX3pSYvKut6pBmjyfM0LcTr1WJHvoG+BHMIUMWNiEvrfVcx2PD2l21n/W1gZAxtuk/8RqVHwzq+19QR5adpD2iElzsxwSNs8Cfvqp8qqPnKMDipDlfiGF+nT7bVDMSc1ZmwDgA7HSkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jissaY=;
 b=BW9smUtv3HNvSZ3gmkePPbLgsUTLW7mjxMGP2hA3FL8Pm2pop5BbK7ftJgPXoR6PfI4bkv2EZa4QtMkln7FL1agWqRBWvj8QQFu3nhsU3TBSGUbD07hzX7+tVqCZP3CMvsujxcLpRIp/eszQZJMh0QYIyMhsG2armSWHklmQ81HNtpMK1g86SJrNxEuN/MtC0WRbNJRwGmoOkFm9tFOEypGu7jDMss7HJk5uOvI8NF/QTukf750+u29u1Ic/zjkBQ/tyZT4pu++ZWqDfIOGS1LZwNMRZKCZK+u2X5PRd7nZQ7xEDcb+piypRrxnqgEjKYndWrJDc9TzstW8WgMkz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JwITzJS1HiqrdKiUyafv46BdgOOqAsiTlQP/jissaY=;
 b=UiP63I7E9palrhugd8gOY+CtUA3QDz/OF1y94FZiIs/Guo1iWew6YcYdGgjKqoF1SJnomCkuVrFvcP/K4dXjdm/5jPYUcqrfiE/ZBh4O3W6FuSocOlXZXLjcoQoUQtntL3tw2wNZGDtiwqZxdSAY0WoiUE0+MZM+sqDuxyRoKT4=
Received: from CH0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:610:74::14)
 by IA4PR10MB8658.namprd10.prod.outlook.com (2603:10b6:208:562::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 15:42:37 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::27) by CH0PR04CA0069.outlook.office365.com
 (2603:10b6:610:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:37 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:27 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:27 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWh3725209;
	Tue, 8 Sep 2026 10:42:27 -0500
From: Andrew Davis <afd@ti.com>
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        "Andreas
 Kemnade" <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 7/8] i2c: omap: Switch to using BIT and GENMASK
Date: Tue, 8 Sep 2026 10:42:22 -0500
Message-ID: <20260908154223.116074-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260908154223.116074-1-afd@ti.com>
References: <20260908154223.116074-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA4PR10MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 7362eca2-9498-4f98-7684-08df0dbfcf5e
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|10086099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rHztN18NRBSaOcizK+ZZsVvW5ZUqgTNwftP62Bzh7IrxkKUisXykUmrB3Ggu1+plE4NhAUrDICVhA3eHIZ23Pal6hMH9D+MtR4nfuH/z0RJsm5zlIRpupmrgl3fhnNq45YHzK9vDo/KSdV6KmYS/3NlTy0ZemjtOwrAzIH/qvh77+jk7kSRPS4bCudCrUxqoptY+aO9Du5JUQBs2q26Gk2QSL2XZgAzqe6Vur3NGBfTQCXJMXNAtYtCs8AlzpgGfIBTzWTyviheKqe1uNFhIypjvlsSIl508+fIQDmk2n7OG0VkCBaxeCaz5ktuOR5kJDbi7IkIObwnXHE3G0jvDphVS4bUXloLECRHS3gGf67borb4gfaIWVqBNfxJ/5VmndHmOKK0TG/lDyvwiazYMeQF4nkKbvvDvpuvwfwFl9bEWo90hVjjhEpJmjyrSgiOSwLWeafROVHoZaU2nvWqSonx08QH236eaLKMia8oj77Z2Lnw1efL68sS4fuWn/xE+k8Xe934w+l5dq0UwA1gOdzSGmYDrO3vpRABsP7vtoEMSvaF6LLqgvoUX9aIBreykx7D1LCNIgMPU7G04P7HSvqcUWEAZrYIfb/pia0jBo+Axrjvlj/fcULIbFZF5sh+q454bgCXYKJC9Pfww60a+h7kae8NhfRYRiqKyoBxYz5YBtWLam1fGe2/vTorvievPZXmcjDftCc2eshCR1CyX/w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(10086099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kLOPGVP3JvQaNw7dStbZnKwD5Qf1YAP+AmdCn8t5kQAGHO5HaiLwQWmCScXB6V4aGLh8mR6PMtGeqgBc4Z9YwRWdYD5/1iDHH+wzH6LPZcl9ujddAplWkCBpSYZpshXnsuLkzUsATpqlhJzRgbsxhQzdDTxbw5LWLFoRGj6PzMY0Mjq7qGzMXJfR4Jvc4BIW1fy9bVItIsWBnBuOpIMgzgDb4c2ChPZ7XCezjyX0X1SvfvBPfYk5LzDSoyyKTh0qCsfgRpFBS8LsYtToV/blEba5WxH9d13GeKUV8FUz9X0Yc05Y5AXX++ANXyuLTTsj+lpgfHmk9lJR+OpTR3W4r2tiziOJ0bljoFnJBj1Qynwl0qrQehyz/ri4OEU6aFeOMhg0d1PuTopyPm1k2qgkxY89nlqNT+6AelXHMSXOlIo/xFPAOrAitkn0qftN2HJc
X-Exchange-RoutingPolicyChecked:
	JEgLWUltK3QDoliZG7n+XLxEQIZOx16S5kTcRJJLr4QYcKgey1qjxA0vnTK4NreY0sLDoksqxJGWXgHVCMmMfIGebXxPMM4pvOwZhUbv/oCvaveYIbJtIRlBBNRz2U4PKppdomy/T5WI7OkUdW146/EisDbyQH7QZ9a1jPJiZHTCDmnzXIozyCxlXM2sQIcfwNoxDH18xI4tM7csS2L12j6WAcUnvO/MHzZDvGHALMTkArpbON3sL5p1bqic/u8OXrjnSgLIt0jx9wrf5O3hk56SEg19sWzCsjESij/oTdFFFxscMg23iYQlxZXUpmlsZ5GIx9BDW1J2jb/qAerImg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:37.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7362eca2-9498-4f98-7684-08df0dbfcf5e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8658
X-Authority-Analysis: v=2.4 cv=FewHAp+6 c=1 sm=1 tr=0 ts=6aa02cf3 cx=c_pps
 a=zLftBE+EtYxwi/BgDV84wA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=nc86A_OknvlbK2ZPRX4A:9
X-Proofpoint-ORIG-GUID: d8WDDo4hof3LFI6oMVBb9BwR-8xKLP0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX7DynwT/P1rnu
 MMV7sZKo+1BEphDEXAmCU1S09m5xesXK4yNxTOYfEfGmDv2Rzol1j5eDF1jofSmK1qi1duL06UH
 97nw6+wuoAi/xpoOmTICifWVnrd31FlF1uhe4Eq0XK6oyIzgazm01hZkWpEGAH7hZfFJOCnLEIf
 KFXU7nbr7gtJ+d2fGjQ2xJkm41iKCCNl6KSt94X1oZVTfcaUrZQe9mfmyabSpxjG7I6dSwXUkwh
 xl9w14XLzHQU01hNdzeBxrjl6YEO1WEdf1A/Iqk9gnqEMlvEDYCQDgRsjZgQs+D4V2mXs3CGpOZ
 hLtGT5Z9IN8eIiPQmy2IDkwEFq9AclkQqohe6LqkaqfyfLOYtY9EaVQ4x97u3awY/D2mkakRNzR
 CodtSVcBCGACemCjTutIQsYX3CpjBCd9/l32B+YvWA/YnW4I5ZRnqcMozI2yaUDGbRte+dxGZie
 jkVyv61cK1gjxYIVCIw==
X-Proofpoint-GUID: d8WDDo4hof3LFI6oMVBb9BwR-8xKLP0r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX8a2JC8JiEzRz
 zMUD5uoqYpIo7rQWo7cDNXSPhCDLYWl7dVoYh7rEJQ9M7JjJhrQlf8V4n5VyRdl2zXpadD6jwLm
 7m6SN8w34jH7reEVP7/CPw5b7UbJy+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

We have helpers for setting bit values and masks. Use them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a50cf195c28cf..41464f92da046 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -79,64 +79,64 @@ enum {
 };
 
 /* I2C Status bits (OMAP_I2C_IE, OMAP_I2C_STAT, OMAP_I2C_WE) */
-#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
-#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
-#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
-#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
-#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
-#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
-#define OMAP_I2C_STAT_BF	(1 << 8)	/* Bus Free */
-#define OMAP_I2C_STAT_STC	(1 << 6)	/* Start condition */
-#define OMAP_I2C_STAT_GC	(1 << 5)	/* General call */
-#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
-#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
-#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost */
+#define OMAP_I2C_STAT_XDR	BIT(14)	/* TX Buffer draining */
+#define OMAP_I2C_STAT_RDR	BIT(13)	/* RX Buffer draining */
+#define OMAP_I2C_STAT_BB	BIT(12)	/* Bus busy */
+#define OMAP_I2C_STAT_ROVR	BIT(11)	/* Receive overrun */
+#define OMAP_I2C_STAT_XUDF	BIT(10)	/* Transmit underflow */
+#define OMAP_I2C_STAT_AAS	BIT(9)	/* Address as slave */
+#define OMAP_I2C_STAT_BF	BIT(8)	/* Bus Free */
+#define OMAP_I2C_STAT_STC	BIT(6)	/* Start condition */
+#define OMAP_I2C_STAT_GC	BIT(5)	/* General call */
+#define OMAP_I2C_STAT_XRDY	BIT(4)	/* Transmit data ready */
+#define OMAP_I2C_STAT_RRDY	BIT(3)	/* Receive data ready */
+#define OMAP_I2C_STAT_ARDY	BIT(2)	/* Register access ready */
+#define OMAP_I2C_STAT_NACK	BIT(1)	/* No ack */
+#define OMAP_I2C_STAT_AL	BIT(0)	/* Arbitration lost */
 
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
-#define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
-#define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
-#define OMAP_I2C_BUF_XDMA_EN	(1 << 7)	/* TX DMA channel enable */
-#define OMAP_I2C_BUF_TXFIF_CLR	(1 << 6)	/* TX FIFO Clear */
+#define OMAP_I2C_BUF_RDMA_EN	BIT(15)	/* RX DMA channel enable */
+#define OMAP_I2C_BUF_RXFIF_CLR	BIT(14)	/* RX FIFO Clear */
+#define OMAP_I2C_BUF_XDMA_EN	BIT(7)	/* TX DMA channel enable */
+#define OMAP_I2C_BUF_TXFIF_CLR	BIT(6)	/* TX FIFO Clear */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
-#define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
-#define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
-#define OMAP_I2C_CON_OPMODE_HS	(1 << 12)	/* High Speed support */
-#define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
-#define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
-#define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
-#define OMAP_I2C_CON_XA		(1 << 8)	/* Expand address */
-#define OMAP_I2C_CON_RM		(1 << 2)	/* Repeat mode (master only) */
-#define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
-#define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
+#define OMAP_I2C_CON_EN		BIT(15)	/* I2C module enable */
+#define OMAP_I2C_CON_BE		BIT(14)	/* Big endian mode */
+#define OMAP_I2C_CON_OPMODE_HS	BIT(12)	/* High Speed support */
+#define OMAP_I2C_CON_STB	BIT(11)	/* Start byte mode (master) */
+#define OMAP_I2C_CON_MST	BIT(10)	/* Master/slave mode */
+#define OMAP_I2C_CON_TRX	BIT(9)	/* TX/RX mode (master only) */
+#define OMAP_I2C_CON_XA		BIT(8)	/* Expand address */
+#define OMAP_I2C_CON_RM		BIT(2)	/* Repeat mode (master only) */
+#define OMAP_I2C_CON_STP	BIT(1)	/* Stop cond (master only) */
+#define OMAP_I2C_CON_STT	BIT(0)	/* Start condition (master) */
 
 /* I2C SCL time value when Master */
 #define OMAP_I2C_SCLL_HSSCLL	8
 #define OMAP_I2C_SCLH_HSSCLH	8
 
 /* I2C System Test Register (OMAP_I2C_SYSTEST): */
-#define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
-#define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
-#define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_ST_EN		BIT(15)	/* System test enable */
+#define OMAP_I2C_SYSTEST_FREE		BIT(14)	/* Free running mode */
+#define OMAP_I2C_SYSTEST_TMODE_MASK	GENMASK(13, 12)	/* Test mode select */
 #define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
 /* Functional mode */
-#define OMAP_I2C_SYSTEST_SCL_I_FUNC	(1 << 8)	/* SCL line input value */
-#define OMAP_I2C_SYSTEST_SCL_O_FUNC	(1 << 7)	/* SCL line output value */
-#define OMAP_I2C_SYSTEST_SDA_I_FUNC	(1 << 6)	/* SDA line input value */
-#define OMAP_I2C_SYSTEST_SDA_O_FUNC	(1 << 5)	/* SDA line output value */
+#define OMAP_I2C_SYSTEST_SCL_I_FUNC	BIT(8)	/* SCL line input value */
+#define OMAP_I2C_SYSTEST_SCL_O_FUNC	BIT(7)	/* SCL line output value */
+#define OMAP_I2C_SYSTEST_SDA_I_FUNC	BIT(6)	/* SDA line input value */
+#define OMAP_I2C_SYSTEST_SDA_O_FUNC	BIT(5)	/* SDA line output value */
 /* SDA/SCL IO mode */
-#define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
-#define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
-#define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
-#define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
+#define OMAP_I2C_SYSTEST_SCL_I		BIT(3)	/* SCL line sense in */
+#define OMAP_I2C_SYSTEST_SCL_O		BIT(2)	/* SCL line drive out */
+#define OMAP_I2C_SYSTEST_SDA_I		BIT(1)	/* SDA line sense in */
+#define OMAP_I2C_SYSTEST_SDA_O		BIT(0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		BIT(0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
+#define OMAP_I2C_SYSC_SOFTRESET		BIT(1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
-- 
2.39.2

