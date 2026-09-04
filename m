Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFD499F05;
	Fri,  4 Sep 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527641; cv=fail; b=iyhjdkBb3vH6yu5fKfHRf8YOv9L1JvklZ6ZXav2QaYmWWkUYeJwauj3V4E/vrG9egWOZFtBY1nAosiRoaVhq+3yXsSSjLhmIxVHlrt23qasJjS0H3GUAPd19Mn9+7RyHZqSH+eDq9R9Px2JDqbBLy+IcTApPKJe37/7Q3mR3XWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527641; c=relaxed/simple;
	bh=4TWV0hp5GelVWeGq/SU1s2vRX1iT5+aHZlIL4+XIm4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU9joO4hfr59bCQ/B0sGTJVt2zf8oxe9XBk7CAOBs9IZsV/A6BpzJUwDAEOR0LBzw+DK5uE/QeEH3/oFEtaT7Ro/WSW/n3vIZfpQUKx2gNLqQHnjYwAWd4dSOE9CuhduwMPSUoZOymxksHoI7W7OuegyP6oMU8Hj05xaRdx979g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FUJWx2Xv; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qCUMVkRk; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FUJWx2Xv";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qCUMVkRk"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHPLo1941922;
	Fri, 4 Sep 2026 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=kCaXQG8g+KbdKJZmHMWxziFfL4YtofrBzJF5rA5Nb
	wM=; b=FUJWx2XvSc4eAHaXV1C5fLRnN+Wc3ZcvH22wi0mHJEKwerjO0AdegzwVQ
	u4PzgEamCGN1qbqZGiz9pThLsBGZQngu6euUgSOhlvmopuIID9UuuRUV+ZtsKkz0
	UHWB+aOeVOpvmVIeVcHPAWVdzaj49AOVb2Uvsr7TQGIF3WpfnZaLbk+YrzemzbP2
	hdAb4hlx24PV2q++JfspQ4SmHQFJr+TS8heVhyAxbUdk4EY/JV/yTrtVm3XISBRz
	1IQMfo7JUQqoWRSsP/YhKRXe4qbrvpdZC+yaDdEc0tuNldzIFElV2otN0kmaSYFQ
	o9BCNot/Ulxy5Wwd3rabtfsOfhuWQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gfrs326eq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDWrmt0fXOuy08ZXbI57RZiqXn1jgEAJXjcLcgWswEP7FAIG4vR5LGKqOkNPGDujhpqh8YTjlTQcjYL8vqnkznAtSvmLouhtQctyP7MnCchOjIFI7kiIB1uhXmJ91w90p3V7tqQ99jIUSAoyR/cgRcWou1JR5clStt5SKvQQzXvyI+8d8gihFrPKoBfi9dLzJBjwQ7AMk2HRF6AkWRcuZfS7BMVwtOcMWpqIbhZSR/t21UU7Q5hHPPdY+V/60HnhZT9f7b8dNvwZhHEqh2KN1bwb0cF1/pb1cCAcLxi/ArAuFGTRePIvhobwQjmzsuVeg8lF3b23w0bark60qdv/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCaXQG8g+KbdKJZmHMWxziFfL4YtofrBzJF5rA5NbwM=;
 b=BuiLV7kctP3xb3fdLJx2cNAo511hF1KwfGktbaw/cnFwMk8bDUG7aC6MohtnN0nHIEsAb93tToSQtJn1uiW9zqLyRAcTpsLggoF4EbHJ4jVzsmknD+jfWG1zyLCsPB/L9cQp+UNla/zU/KYoTGYH4tqx2hvy3A5abdgkMUXhZj3MU0BBVboDN1fubOpbtzdOeV3L3e/b7z5WkeRm/VS6VTn5AZ0HBzjcLMKhCV4XbXCPhlikeryXNiDU2S7RueagLbXXToRYvR8UBhuFP5gJmoflRuqGYFqSNKVfNC64QBeREFdXDlTvOPbRqlouDKQHN+IL3emNyU0qcCyObJY6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCaXQG8g+KbdKJZmHMWxziFfL4YtofrBzJF5rA5NbwM=;
 b=qCUMVkRkrH31ufRGsWOksMUK1HkSbY9X5PWEeNRx0eHVJzdZmjrY1nwQywseppeGNk65WANpXFEh4teozL5i5UCe1nRbXFd0VXT414TsmLEXeawKF1HTlHiYCk+G+uC1MwYMI/ESRKaTwvJXHIYt5PGUaRjxe9u5pmW4GA7GcaU=
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 13:13:47 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::37) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 13:13:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 13:13:45 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:56 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:56 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq59371029;
	Fri, 4 Sep 2026 08:12:56 -0500
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
Subject: [PATCH 8/8] i2c: omap: Add OMAP_I2C_BUF_{TX,RX}TRSH definitions
Date: Fri, 4 Sep 2026 08:12:52 -0500
Message-ID: <20260904131252.2126353-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260904131252.2126353-1-afd@ti.com>
References: <20260904131252.2126353-1-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN2PR10MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: d40bbee4-f968-4cd8-dbbf-08df0a8659b5
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QRm/1Js9cx9hF9okz4X9qLY9LGWlfmkQtO89idP/NQieH9d4Blo/sKgymT8VfEiNzs2HsGqNgRKdS9kIWrhxw+w+4Zd3HCpdUPX7/CWNvtKCLtp/zbtvniDqtu7jKS1VJPnjfPS5PcD4IFY5aZZ4NCuSs60pAVBM7in1sLbGWDS/xmei+dm+qVbTylF/NCWepsRGhk5xidzZIdA1ueVWYRYsawR4kX7Peao9Tk2M41LylR9OKUCEqfuXaONv5uVGkZn3NaFApM/HlH+en4zWfIthegCOASinN2zyNDGzeKInW1YhCAzrGm38BlEDRMNcYnbJlqK5JAruBbAh0rrVHSTjl8KWCxF9mXCJuvNj0B6cmx+XaETljcIcwp+FqkB580A7zHVYeF2mjgkqAmGAYVmfVkHuNUqXzAfM7qywnKK94cB/Q/Z/4g7K/N5VfkOA4+g512OPo75bw1+hfOsThziIHKulwhFzG17UxYIyd4VuBxxjB/PntrcjSDEpeEba0D8zxBJJkvhZqYCeUUI+EEPmep5m5bmPIKqbbdvrJIEBVDFKkwPMR4JnMPW9eC6TPxpa8ff6cjQjnMYm2iA1jwaEjgNbFvfJTbvAi8AWLfYiw9b+6K9EzUOfWgltRjYQKp1EUOrmzPrYKVNBbyB6nBwNjq3YrqHJo7OKNPEkK94NH0Dxm/dUfoMwhCZg7XBAZqkzYd1fhX/SUHljidx8Yw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xsPIiWB6VJ2b9BjDzezisLIgbRNY2iZ50kuXrQsK6rrrcIBIDCWUBNO9t8XaEFJJ1pxzE43TBovYGK/Yk6LcVdAOc/AzzYjRhkEgv3q5nbtl/5haNrVXq6Z3HqMRV/SUz7lwvU4dq8zjtgtINEVqXE7GX0DmRYgnLzAS+l7GzoqHjPUy3CgUtCvHqJ9SYTUJh2WZ2hZmixnAvrYtnWR+/GlOx0m7o8RkCOhdcrGImeSQVO0AkOu6iEYol5OaWeDm7HK7ybB+dO/JZ6I0CKUrgWx2CGEMhYVfzmbIuyYcajZXK7OsQ/WcASYbgt+iGlcvd5Yo4pObXi1eNVEN8pzMuyqEWrjIB7TuvhUJVnbryPe0V5qQrVNi5JlegDm3ukgRueWqjfi7LJIINvWN1Hx1a+IHRMgXQ93mmG3o9fceWDp6MdDwCepZXIuMPEIipl7c
X-Exchange-RoutingPolicyChecked:
	wOFSlS66j829t39dyZCsI1k6tXp/u+roynTJJXKzHuovqUgRbuWy8Dh+GWdooSiHl/z5OROGR99dW+rlGDDSYIL/b2oNNvu38vH0gQ0iwqggPHLAKgCNfJbopeT/1c2GXZjwBHRZugVh4PevEMH9zF+t4Rqh5zC/e5VTx3ZdyELLIrxpSuAajCLRDLlXnTuYnvJNOyLKCgyXG/Fn0pijOlcSX2Ki8YPMAt8g2ow40qIxqmzkQI6EGlWPKctl+8ZaCEsq7hISZrfAq5c3C1gGTViOmJ5kbChO/iyk5/ibBIgwzSN0Sl7xk3taXv5ZRKxCDY/cu+zpJC470i3QQ7L8jA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:45.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40bbee4-f968-4cd8-dbbf-08df0a8659b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-GUID: Y3unDY_0_gGN_zWNXd5QOZ9cTrXpMwsd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX1Jf0xxGbd51C
 m8nER6IJBIfuGuqAiOSy67IyRFo5/yWhqSTO4aRE7l3+wS/h4n817YO2g/qpkC77isAimhhGQL3
 fgoZbGP8wmppjrO+c+Dn2X2vIMEfrGs=
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a9ac40e cx=c_pps
 a=037dmpTZGv+Xy+TtntRLUg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=9kDT9J43iM3-Rq2zlG0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX96/lVQgcDWAc
 iUukDza2NRLnbS5+GK0h3ip2c8lSG98pq0pn59cyRHSyhBdOMZtf8ns/pWCXPLbAubATxjN7E57
 KNbAHDq+cvh5S/2GXFuCP2O5IxbHZjjUvJUOzrQSYZ1AXyAwx4cQl5/nWnbYHzhvn1JFHHhz9GG
 TfQlsPy+8lVs2y6hXvOt7PjMzVKf9DoK6rBC7p/MZpQRf3kHbMZaM9EUXz91UC5iEDZYmYWEWf2
 shZK73QFjij9oCBarVI6318xDMpUQnOXAPz2KZ+a19E3Yo/5prz+t0QqfwDR0cEhIQw+VmXY9Tf
 lgboNw0P2IWod4OrpejxmHs6DFu6cIhuIQji0d5FMnXhOzsCgd7/aqUDmFG5xwrOEC3ZvjukW9c
 g9+rope1fL3G036t5xh82ILdyB4fBxdIOiZX+HhLREGe8TGW/s2HrSjf4gJ6GfYaDHs/bIckhMM
 S0xdG+6Od9lRp6HHQ8A==
X-Proofpoint-ORIG-GUID: Y3unDY_0_gGN_zWNXd5QOZ9cTrXpMwsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040119

These were just magic numbers before, give them proper definitions
and use those in code.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 41464f92da046..669d931928fb6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -97,8 +97,10 @@ enum {
 /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
 #define OMAP_I2C_BUF_RDMA_EN	BIT(15)	/* RX DMA channel enable */
 #define OMAP_I2C_BUF_RXFIF_CLR	BIT(14)	/* RX FIFO Clear */
+#define OMAP_I2C_BUF_RXTRSH	GENMASK(13, 8)	/* RX FIFO Threshold */
 #define OMAP_I2C_BUF_XDMA_EN	BIT(7)	/* TX DMA channel enable */
 #define OMAP_I2C_BUF_TXFIF_CLR	BIT(6)	/* TX FIFO Clear */
+#define OMAP_I2C_BUF_TXTRSH	GENMASK(5, 0)	/* TX FIFO Threshold */
 
 /* I2C Configuration Register (OMAP_I2C_CON): */
 #define OMAP_I2C_CON_EN		BIT(15)	/* I2C module enable */
@@ -602,12 +604,14 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 
 	if (is_rx) {
 		/* Clear RX Threshold */
-		buf &= ~(0x3f << 8);
-		buf |= ((omap->threshold - 1) << 8) | OMAP_I2C_BUF_RXFIF_CLR;
+		buf &= ~OMAP_I2C_BUF_RXTRSH;
+		buf |= FIELD_PREP(OMAP_I2C_BUF_RXTRSH, (omap->threshold - 1));
+		buf |= OMAP_I2C_BUF_RXFIF_CLR;
 	} else {
 		/* Clear TX Threshold */
-		buf &= ~0x3f;
-		buf |= (omap->threshold - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		buf &= ~OMAP_I2C_BUF_TXTRSH;
+		buf |= FIELD_PREP(OMAP_I2C_BUF_TXTRSH, (omap->threshold - 1));
+		buf |= OMAP_I2C_BUF_TXFIF_CLR;
 	}
 
 	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
-- 
2.39.2

