Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A833372A;
	Fri,  4 Sep 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527639; cv=fail; b=Gz2GSBRKZHo9bYGikafjyRaDn/kEkzdDGY+PaBD7Z9sghvnl3Q5KZ9053XBwsVZqNfuJBk5Fgy7HLvZOSf0YMuxuhjePObdQxPCvPdYP9LqKDkReqPrTP/+pAYgI6QHZLDF4t88TA5sJlExODP3vZGDvdM9zCl5kgWdJXeYMtPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527639; c=relaxed/simple;
	bh=p2e0L6BJd3eYaXNKxlq07c/fzPpFlLTGlrZWwVdbo1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXz25BH9fHPqEkqIm5g9f7Em+3N55FMwa3UW7id3+plKX6DEDNc/JJw2D9ub5lloXyXIJtnEwiAQ/zfYID2Lxs0YUtRrArxG2GW8uOijvxjM/+/CTiwxWXvNzjzQ5gJkYURJZ8eHI5JHgEbxtWARhG46WarqL96ulGDYxqfnJaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=akTu72ih; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ngc0YhP4; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="akTu72ih";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ngc0YhP4"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHBNj3456727;
	Fri, 4 Sep 2026 08:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm
	30=; b=akTu72ihFfWZqi8JwxAgCh7NSp4JEgMXO3B0lLUk0fPUp8pJU0B2UmQrF
	vPozZlzuJN1XDffBm2399U5XLxYM6sq4zDCt80j6pTU3I1lbMZJk716k8RXyr5oY
	Tx78dkXomQ5zPSrycz5XX/R1kXbtKvzLzyMD3AW137I43jT7aVp6Sm2mE60iyAqv
	9JGoa0ovipJ9enGz3b5vpt3uF+CPEMmyXKHJ/t7Bi1b3h8vJLoelYICPZHO1qtME
	ps02ZEjYwE5mH4cnRRQSeYWzkqYqUbI3+gCbvWRkKmfWLYZJPkjNB8cKiXWKukT1
	LFCR0V4cy+p/kdTpK0srdEo1l+XrQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xv3hw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtzhRAa6EU81EAF6SrdfK3oauEh+mGtlSN0yPpxng93Ivf/K/JCCV6PBz0oUmT4Hpfa/R8P+giDr/CVn6EEnVuUOYdqNzDQtrnyOOf2fCHzg3ENt39H7zJ+RfzY+v18hpbExWhamfYdrJ4gJ4UhvtpRv7djLh29XYEBW6+28ElQijmbmWYcX/kbuHPDDyCb6umeVcmBURmkbUbUGyZcJaw3p3H6QsSM5LS/rqeUcPEXY2Rli53ZrnXI293dyU/iJyb/d4HAOeW371A4cJKBwFD48dsn8zWK5D5w5f71f+GxSNyyUhak0gfSAJwNfQ8lrmj0Fn0mvBVWB4kRt3oIWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm30=;
 b=yo4PLpF9a3LZEnN509hMU1STdrALi3drizmiUDrMbJnmCdszhaKE0wVE+lupy8Uimo4zhMlcmq3I4ITdG2bWQ8X0MoN1/w0mjM2v1L/hluXn6XNZl8dKHcqTM5JR/ZC5lX7PaMX0Tpb/OO6ei68FHXC74lMRps4yVKXaqGLOlzsCFUFCAWfYcA7Y7+0pdWcC/9njVuauM++VDhHHqg2WhDh4QshXJDm+5RlDUDOAD8xNC4AwZt6YqLOIqoOg0xTYA8fDSDgncSSTL2E1ZByTN8/n31IxJEjKC+pYUnMGmG0yc/YsahvAd1UUrEw0M9LN2umnIJPo/bsWj1ApigBVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VEJ9S51As+8i4RFTYMsWN+iJA9+Vwrcx8aSerRNm30=;
 b=ngc0YhP4UUZrlhfuSjfenaedG+NbM8wzbhuq2r7iRvRZ/aEeIbN8JDky9rlNwtlCd89ZvlE7ovnNhwnzz3SLuuf6PVDySM8Hgf5wOG9UgDp1QgJoGIVWuSuh4fOwqEwMID9LZcs/BzGAXLkQ1t2Lmey2Ca3JUIwHrHOmcODRfWM=
Received: from BN9PR03CA0516.namprd03.prod.outlook.com (2603:10b6:408:131::11)
 by CY5PR10MB6046.namprd10.prod.outlook.com (2603:10b6:930:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 13:13:45 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::a7) by BN9PR03CA0516.outlook.office365.com
 (2603:10b6:408:131::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 13:13:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 13:13:44 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:55 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:55 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq57371029;
	Fri, 4 Sep 2026 08:12:55 -0500
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
Subject: [PATCH 6/8] i2c: omap: Make reset bit name match register name
Date: Fri, 4 Sep 2026 08:12:50 -0500
Message-ID: <20260904131252.2126353-7-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CY5PR10MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc3437f-ce0e-4d6d-e89f-08df0a8658e0
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	lMhnGkOV1WuzHwAIRdXufDFnInpTE14wzfdcv0BVXGaUVYzsofnoamSf4jafIMT1hOxxeul99UHvtTsM1RXDsnlEB522YsFCCPy7b4avba3qQUpkLgNFSQtV0VhKvfj6enLP0164WP/E3yyKbHrdpFzBWBjBPIvE8H+OO4DXnsupKaUsZLPyz7Rp41DgMiNwF95uUt592OYlaT6O5JsAbYYrtvuGT/2NoMoZw84/OQmLG5y9cBDvgSz4U6zCQQRNYpvb6cwJTP2KAYXyuvJa6bH8dthFa4giOCsQPZbGLkLR5kQO61a0imWy3a3r7RlRpU84CbJVqbd2B1vnUPbGhQxbneGrDETZSq2hFl+qPVTfn4IWfvoORe9XY3r3is7SZhXsc5PazXc1uwSV0vNkij+QwPVEN6VaCdcJ3QFvaTcS9tUYeGAUniAADHFn/crxHScIGgtGCVobeSKH1jTR9NJNYxiGi/LZOu/Lorv+NPIzmpaOJit2PAq/D4sl5wbZ3dqiZrCTmUbViGZtrApZm8KpFs3C328JPxbzYOXwnxT9SBIZO3bPNJGAwVqkaQ5d6ztpenM6xzcxzqQclttq7lOH441Er7BxOkij0OHx+btIRRn1prBrU60noa5Q1e8Uqtimp4UYD3/3N8NX0mYYSswAgyUioFLVO4bGzObckqqPWs9GN3Re/WNGqcIhH9XRuWlW5EqS0rcrYkz+gAOEBw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wbh/6nlswSWgYCzMLnoL+57MmeizsIOrNafWHnofOwuaj9A12z+O6CqaknYRmWEBmZLGRI0CEyC4SVbIRWAyNMmsNXPLHy1SAtuDp8/CB+nVKK7Tn4Y0U3dWC9kvlzxo6yYzaU93K3blu+aU6m6u6bdbwpLxgrsxceCRdpS90in50IO3YVvFPEzsm6CVInuNsAckjuk0EreXgRlRbA82JzqodNV2GxoC9tnGPiX+oaInNKW62XeLjr+444qxxQ1sQtnCsBR5Fys2uUCNPbBg5iD13mbVq0DnTLdd+FCl3fX8GyLiaE20fmb+ws8j23t1lAe4bs+ALJ8mntiQPZUtIM6xeIo52xnUYcNf4W7KOInr3Q6A3nDf0g2/KCZlAAfDDdUPl9Huib1Jr6B76qh5ny8SrYFoDnnruaYNlpul78kcPUvPJuAFlPe0GO8Jrnig
X-Exchange-RoutingPolicyChecked:
	bkmXDD3nyokybGup44XGuPvjYQdr0qfyi/pHNPYvwLFpj9M7coP7i0QoUvQ3toq7EEDpwwas7DvwCD+cHqspH2fWHZp1Q0LBnCMn5JDgbDQ0xsjAnv049XpKQ1es+EHw2FyWxA4Agg6y0Q3VtCvd5b3VDs2mrzfmtEcuJxmTgvecJIrdmQNTocFHOx5RDcOzS9lrNfurlMrqdi1e/pjeIJ1wnZ0y8U2yrs67NrLOUAgDz1VAJuPv7GbTRwb4mCgce5G8ox4NpkLARHRUxlh7ht749e+2879/HN/w0N9ajUX7rTjmhsMtRIBe2V2ruHMZpzPV3o1BTAcN243hlURH7Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:44.1670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc3437f-ce0e-4d6d-e89f-08df0a8658e0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6046
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX8kWMoJFrcALy
 tklS8N1jQEQVP0IDwhNTRuxnx5nck8VZfDa83/hdFJbXXq3rZfczhuToo+faYwHJ7Ela30rC2rb
 O37ZAB//Xy/A0dkW/qFfLZ16e8/Cii4=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ac40d cx=c_pps
 a=jKN40M1qUjEArv1iOeQWeA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=jiVZLek5lCiKkj7Mo_QA:9
X-Proofpoint-GUID: gglpqda7xj8iSuEVCA_rNBg4JkIusllx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX/K2OnsTuGFVI
 uToDTQFJBULB0Ux3sOBumCmwjWja1kBrit42RNYLWPa/PCaQlq7KEVADo+ptyz4HXoTmic7ehtg
 lcZs/0AOvWxeSyHEwQwzY3xMhpFldZ+ZmTUOtwFqTMpK55i3EvSzglPWo0KppbGgVmbVhMOdhy1
 moud5TIiCc9vYverd0mAq70+9gx4RaVNN2V2080HdmUHSB2pq2MTp8i4TKvB2dGN0MHi57aYdWR
 uFoy/4kteHiPlceMnzScyVm2cMhdMcB43jKAZAYQIL/RA71lSaZd8bYCfbjzeeqnBQLA8Q6UamB
 8afbcUabaGPW5LdYdvfUdpaSsIhmdFrcT6DBhfD2SipmCKPI7UDaWHISa7B3KPWIH1STYUyU8mx
 SyjCmFdLMpiRX6pX30z2B9AeXG/GUG8dSGcC0rEuhwqDjrnEjPWQdvXjyXwQGyU/0jb+L0GaiPW
 0NgJ/0vfbz4CfWNPmLg==
X-Proofpoint-ORIG-GUID: gglpqda7xj8iSuEVCA_rNBg4JkIusllx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040119

The bit definitions usually match the register name definition to make
matching bits to registers more clear. Do this for the bits inside
OMAP_I2C_SYSS_REG and OMAP_I2C_SYSC_REG registers. Remove unused bits.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index dc75780f76c96..a50cf195c28cf 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -133,17 +133,10 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 
 /* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
+#define OMAP_I2C_SYSS_RESETDONE		(1 << 0)
 
 /* OCP_SYSCONFIG bit definitions */
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
-#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-#define SYSC_ENAWAKEUP_MASK		(1 << 2)
-#define SYSC_SOFTRESET_MASK		(1 << 1)
-#define SYSC_AUTOIDLE_MASK		(1 << 0)
-
-#define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
+#define OMAP_I2C_SYSC_SOFTRESET		(1 << 1)
 
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
@@ -293,13 +286,13 @@ static int omap_i2c_reset(struct omap_i2c_dev *omap)
 			omap_i2c_read_reg(omap, OMAP_I2C_CON_REG) &
 				~(OMAP_I2C_CON_EN));
 
-		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
+		omap_i2c_write_reg(omap, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SOFTRESET);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
 		timeout = jiffies + OMAP_I2C_TIMEOUT;
 		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(omap, OMAP_I2C_SYSS_REG) &
-			 SYSS_RESETDONE_MASK)) {
+			 OMAP_I2C_SYSS_RESETDONE)) {
 			if (time_after(jiffies, timeout)) {
 				dev_warn(omap->dev, "timeout waiting "
 						"for controller reset\n");
-- 
2.39.2

