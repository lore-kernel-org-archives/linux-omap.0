Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B450565108;
	Tue,  8 Sep 2026 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882240; cv=fail; b=S0nqpg05otvRuogTXvL0Ac6ougfkjuRqAqRStmIUdODLmcRS+WcV623l0TUsaGoc+/RmKmel1SpZ90H9txKpm/SdRe1Mw+lWQU4w0Orr4gb/ix2Ot7mGJvOjVyDFu2gaQfIDmODZzZp21FMl0fMVLFoyTs6IcJkauOmS4Sn9ASA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882240; c=relaxed/simple;
	bh=EL5ceNUk6yokUkG2f9NSDJIsi36IwdqmxO9GP0JXNsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsRzwCeEjmZHLJJfRpPEbQ0cetHGAeGEaL1BsPuymPgnZPoaPg5lXNO6buFBvo1VLj/Pt8pUT0VQ6HwFlo7YNSAYoVW+1/SPxdhSH1aAM7nHKcFHwzmH0kyhbzBK2XCdYyelgJaIKh6cV7TTczNTdE8DbpRn0avK6HdFnHebe+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VprLOEMM; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cxcdom4P; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VprLOEMM";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cxcdom4P"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Elooq1845540;
	Tue, 8 Sep 2026 10:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+mtFK3uMBh+95DlhbAWd1LHsJX/Cb+oUhkeRK6PqU
	iw=; b=VprLOEMMHgkNUcKm7bpe27/AvEeVASDl9Q0oF7FNCy4WV7ADFpn/j0GsY
	hRgXaHd10idBvUJrLSCouU28NfZiopHoOZtmHi9y149RTwG1qJ1bHN1DGwMliClU
	cK1NdUWRzpO6u/NTO9Zw0+bUvVYlT1+jnHzGCJUSp7E/1+XgkvP8NKo8QOY2xycV
	fj56YPgJO6xlhZecHwMCLNN0y12zp9vG3Nzpf2PAzyDtBqNAxRWzH7v8KZgLOGzf
	BZx+Hg2iX4io8B3Rvd3yax4bHLUJ/uYSayldzINS8Nk5q/ZUJmRQFM+ZP1DKsPAQ
	d1vOAvVm3/O/9bwK+rY1LWEGtbibw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940mybs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:43:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGSrA2aCoot0Ik6IjYjyoWUGbGvAjH1HHuchtJVCvAUdXMo8HWTb7mnVZxmMCBoAZ4+KNlNZ81vCzquHdOihD+U3mfPMxcQgC7LX7yorpTPWJCi/N09wNCgH8jgrFW4RLfkMAsRstJv8bhI+6MsYKEiA1QH8ShopcCVer/V6FDxxZLx+LpSrcbCSTY78VzRmEl219lFnLVYXSbUuHT7CoUbl56vQfnP2k5nlZVgRKLYbpaqzC/WgTyO3awrR07qBBBthoPDkqdNp60JnXCnGTdVE6WeDpwdIV8dP396yNhGRJBkgZtA4UISJJ9DNcfmF1AHiwhvTXlYDa/mwfZBOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mtFK3uMBh+95DlhbAWd1LHsJX/Cb+oUhkeRK6PqUiw=;
 b=ICbOplfqhuu7A2KCyhTvB95Bxpw4jwQrslAkCVDWmhH4vmLnx03p8LtIuPDIkQXGt+ce6qZMsIh2KcpBj6qWwaSPY691gRWX22DRK6m4tB8zar3PjRaxgOleeZukDANeSqLcfW42LRad1dTBQ+i7AZ9Jk+WLaBwhECen0eFjdEbGLS/+/L/32HSlCXVHBLrgS6Dlq02ZFqWIOKcCPXPFH4oOKZn5NO1O4b5vioTEcZh5H78FXdabXMsliRQTZ3rCaGPgi/P5G/qyYnw4poXtRu2zSWial8I0ixC9WlR3DaND0fArmz4vTpK9i+miEJ4uj3XLbd4R6heDcBDZkNB0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mtFK3uMBh+95DlhbAWd1LHsJX/Cb+oUhkeRK6PqUiw=;
 b=cxcdom4PqbcL/A2kq6lozUUXQgA0E4u8ftZKqfnkOnuW2TJZ5ZiWvRCvllrYMs7Aof+JgtKVE4qffMH8Edf2wM8vszSGvi4KKqat4kYEx56lD+DCflL4rXQzNa6eTyzw74FIvO+VlPfa9l6wBOxyhHyEtk5jbaws6M+ckIiY2FA=
Received: from SN7PR04CA0163.namprd04.prod.outlook.com (2603:10b6:806:125::18)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:42:38 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::35) by SN7PR04CA0163.outlook.office365.com
 (2603:10b6:806:125::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:42:37 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:25 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:42:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:42:25 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.33.213])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688FgNWc3725209;
	Tue, 8 Sep 2026 10:42:24 -0500
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
Subject: [PATCH v2 2/8] i2c: omap: Remove unused is_rdr and is_xdr variables
Date: Tue, 8 Sep 2026 10:42:17 -0500
Message-ID: <20260908154223.116074-3-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f64f9c-ac2e-4dc0-fc1c-08df0dbfcf4f
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RI7H2THDQVTKCjZC9+ccSPBcqMcEpXGNeNvAlUfEfnmgsRvEzC8NnftpBF1YO/ahVjI/mbPrE07jrxVIxtpz8SGGMSUxaTDQYHjkKLCgOHxtULLa19E46musa8C73XIAhH90EnU8bs/X3nFORmOsm1cH2Pk4GR17GdCI7kuZ4+Ygn0PH8TXmR7cqrEG9HkNkkZrX4Aokm6qfe7bwsu2zMvvCYkpmlZuy/VD/Rl6MsKqLDR3vjO+N/28mJKwtfn0FtGWnWHOPORuGteatjIK16+8oO27UsL8CDSJ1C9WkGOlHRQENYu1Pf8Qb+SW8cScAtf0XewWGwpJM5ltidPIODhT7DT5ksFTxSivjoEklax1JdLlrl5OxFXnqApXLGWcjbAsPaB34Ji2blK3jeZOxThy3QkhKLlvFGFbU4qpTTc7A+SeULuW/p2X+Yyi+8pUoXDkW6/8wl8aBWR7CC52S7gkUb8+Gu+WAiw1/N6IbfCQMVzbUWsAv8TShWzxAneO5RQBLz5QbzsBx5y+xLW+2YF97kgyrjAFVVAqeXJxZ66zCbevzJf1hXjy0j5hB//2HXBjPD4whM8kyixTGG9ZWeWAjWIPrYpbsfDz2x2vErFE/rcGaKFcoJ6mPIvXvMw3iMFbVS1+XBwksOd3ZmdQyz9CgbbPxb3ynKSA9trfTTx/2b/Cr1dfalnCZOhKDy74g1CoK0Ewt0PGOGIbm1OiwSw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ODkialvv8c6ErOXpCIl4quwrsLKSzCfw52thVo7tGG+NmzZZ/FMaY0idCerIHJWnX60gliFiNgSDRvR6Yoh+g442I1OlGvQqhMYNXKrq3NqffTObbkVxKtT+gjk9MOJCSvlcwM4ivtj8+ISAejr3flQYazVjwwXpPb2uUTt5nNcoRWNH/NbrQvoQeLL6PQBP3dMJTA6mNBTdqYyvlxx5I0hQNzNmo9B2SV7NveHibSNu75XW7PhOWK6hTk4ygA75f5kkFqHPCFL+P71WAB4cVIJ5gyIBLc9af/9b6jOyg74i1k3LIW70r04wbziqi+SHAenbXJog0IA7Dt10onFAxVNzVRdb6uDPp7KcFzlbEWioloNk2ioyViwU6kSduUQAuPYg2sQc47tW2uHs2U/eypbWgBvLM75OIzRphAMtBtfs4PZZ2JVcSW49ZF3i6u6o
X-Exchange-RoutingPolicyChecked:
	r+2H+Hnz+fHtL0aXW0aHB8U8mq7MYrxqwwkI452aMbJ1U6QEtn8yDH951RfejGJl27euwOqxI1M6R/D4QhKJTNln3Cejkc7azM3npnXE4quJaoGD1pqg3F4uxFNToEB9dOAwZ3+z+2+Kgxd3tESfNLD/06XshdiIHFsL/tnmP4561+Z5DH1lIvTtlSZaiQdh36653j+NAho6xlr+TNNwurb+Eik4lSt+2z2UBri0Jp7EN7sbg1Sfl4isiD9E4nsrUKDZ9Mex75HkzR23pOyaEyY+WbDeA+sBgAXwDAp6mPPFoRd448NFMqJjJAJ2UZGGne9c0yv+Ecs3NwZ6JfFwYQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:42:37.7234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f64f9c-ac2e-4dc0-fc1c-08df0dbfcf4f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-ORIG-GUID: ts_RIpyo0eK8uDm7ewzoqxiDfZXVJu7H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfX20cQfjGRUMI1
 wGzXxX39Ik/CLk/EXGoprknc+HFJ6jzznFX0aiV+Z/PyqMamCCIeea9yNR7s4OMa1+FofDsetrn
 Y/kAGFjs3q+p9NL6EiD+SaGBuKcat3cCgodhTqHadlqq4h/ChYOJlaXdl53iaMGbJpJ6P8eXNWQ
 o433PwjUSVwwdyi/d44C7VcYeb4gTy5U8w3cbRYju8aAvxpQeSQ5PX3IYGv9WrIL9/BW6EmUFie
 KjQUNQ6+r9BKhvCxti+LkevrjjCQaivzVb+1zFdk+S1EbLYlQ3iYoa+0zZdBQUPoDhq67F5a7qH
 e1WcbFTM8nod0128GZkwRY8xD2KK2MJ3JUAXPECBqJ44APBYTthnuhcCEBnzlLRqJ3GCBAgzChB
 /+m0HKxPaIqCXEDmdzoOJjzkktg51hKRirPBq/4avM3K7TwZXzrpVMy1ptM+VobiGNfutt+24jI
 /svArhl9qw3emp8AF5A==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa02d30 cx=c_pps
 a=V+mzYH1ZSfwt9Wwm8MCB5w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=50gAi1W1AAAA:8
 a=eUdvuMK_en-A6lLaKTEA:9 a=bIAsa0K8HJLRn3BBPJ--:22
X-Proofpoint-GUID: ts_RIpyo0eK8uDm7ewzoqxiDfZXVJu7H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2OSBTYWx0ZWRfXzaBuRxAfivPC
 ynNGnXVVC94n0Z97x8KeAPlXwSk78iUdJCWsMx4ewmsKSf2Ce4isKBpQ4wBruIrJ0tK0s32wJ2l
 NCNY9ayyydhsuOpCr2HGbi2QG8HQxWc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080169

These are passed into omap_i2c_{receive,transmit}_data() but are never
used, remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 72f979eec7311..68b0a043f1e51 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,8 +993,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1014,8 +1013,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1119,7 +1117,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1130,7 +1128,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1142,7 +1140,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1157,7 +1155,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.39.2

