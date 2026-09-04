Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BC345EDA;
	Fri,  4 Sep 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527600; cv=fail; b=hRTx9uHYLylzbmq9yWbR9HMBpoVBF5XYj003+v1l43He/B+5k9n80YEgRfcaQH1Z9HRP5HMiPPTpcG0bBkdJd6Pkctb3+4yudB5ikycNdA+lq/X65RL2MA1mIMuJR8BDf9ki3nYf0xMXWoKgdtZNJHAJbnoGObWHIe7YgSoxjG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527600; c=relaxed/simple;
	bh=ZrCc1gcWNacZb+POfeYK99JH79xugcmevydTqlbdg4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsW81dbcGqCPGkzN+e7j3K9y83FdBMg7qmTleQGj+PR6oN4y6X+b4pTF1pYjjVZaTK/4qXr353BcPizfDF+GMQb+YjHbpvUjcAuPkAWV+B0+ug+o2222kCsudKQmz+BTa8aGpMWQv19mTfeG0Im6fkZ5Yt6CbIQqq4TakP6yBRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=gkVzKUtG; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Od1OdKtr; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="gkVzKUtG";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Od1OdKtr"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHCDD3456746;
	Fri, 4 Sep 2026 08:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIc
	HA=; b=gkVzKUtGWI1Vh7zPrOutOZfIzyqKrZFoaSmQwJbM+jqOsXbzQVUMdTjfd
	whw4gxQcfft+YSEFixPxuNFB4e7bMUTu+sVBDYV+OIayKr+s5Fq6ctY7iQA5lx+7
	5ml6baxfbkGysk8/5AVOIdn6aJx0Xq32ZrbSZiLw8vwxAi/vYXIWXr/SD1wzPqBO
	MORgYVZKOeOe2UMLTm9NQjuxLwJDYRsM4NDsvwfotevMmWVZaPHLN2Uo6lYxNSeo
	2VNFW8sbjUbga3vyTwnRfV0rMUTKikQzETZOM68ydmDPXfBH9UeehMpI50vZ9Ili
	bluLaLTKltZTJvuPj9CeumC2UXJmQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gfk4xv3aj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 08:13:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY8J6MUxpe5YtcGmtEdahDd8oIknZYbS2K3m56J4VXsKTPr3f3njpRgK4Yx6+Pal+S+PqX+5kNFbXq8Bf1gfy4kCD84PL4hX0QPCsEygzo5UEX6yV1w4ublU8K9x0+/QjOqW9LFYzhcJe+xjtum+iXFd/M40b+KPDeEFU6gvJDfEoL43Sk0I49h/G/NI1BrBls9+IXDh6jKSIiGUz4xEUDWlK5MgKg+gIYxhXEjMXjQv1aaxFnvOOarTqfzGtw+ZEW9RncMmrcu1CmiqTCD9Or9ps7Dz+EFJiJjw/qsuPuYYzu1Xs4ArOSJA7sACm0xAYqit1/TvWcDMmGwLlVE54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIcHA=;
 b=pQiH4PAPQIC9o7E0cckxxBLonh5T1ynFLGRq8Id/TSk/IWU6Ge7lCTW1sSzT6plzc5A3UQiF1WsotcGxe1zoO5jiZmGmZBCUR69lbVi1B7v/HO60ZvDinvHnbNkjjMNtOKf3IYzSMxAvgSXee649CUVeWR5Af91uW1P0kXExHJ6DYZ5F4OmIGEEa7jFa7MVSDFsgkdOJwfy7tteFFfr0LDOkWlUu5r93ioi04o9VPJWI3x4fMdsthKLW378zH7pVre2IUdrmlFvLLSmoLLgZQBqdPinEvt+dNujAV8cDGG7+cQgzHZfm/rxvwX8YhmMA+lW/tjYaYYOTxs/HcRcjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPwoOeeVYXkOm95zJLw/3AUi6/evQS2lJN6KFGBIcHA=;
 b=Od1OdKtrVa8IviKwmX8a8cp1LaF8jjKCFqrF45ZRmEbdiYe2ymV42gkVAlQkudhJrlioJRSP2CZeb+O/G4ue0ZeAg9rl3Q8OcW3aqYwPgWFSirHPPsr/gqnTBOC9Ew3kge3PAWfk7Gwsu+UMF/cuBcwQQl2rxgfaKOBgZanWV9Q=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 13:13:05 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::67) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 13:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 13:13:05 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:55 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 08:12:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 08:12:55 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.126])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684DCq56371029;
	Fri, 4 Sep 2026 08:12:54 -0500
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
Subject: [PATCH 5/8] i2c: omap: Use bool for flag values
Date: Fri, 4 Sep 2026 08:12:49 -0500
Message-ID: <20260904131252.2126353-6-afd@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: fa94aa0c-8397-41f8-55d3-08df0a864202
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	X1uN3QABlWzE8sgt1M6onQZ1Rl3XE1+5wj/D1PS5RCDucCbqZQyn2/M/0EkQDp4xSgL6e23+9sTXyx2KmmyqZGy+WdO96MNG+HLGiAuB+zWlTx3u1E8ZCf7bDvqxpHIpYtVPLmjpkE54R2jb1gemkNWFPIPnRyVhTfhFfKS09jlXeeDeASRcMDk4pVHERFna5eX4IqVi8ClZhkxuQ5U0kNV2eGx1z0z4w8H+ODIJppVJNu74RvMnWLlDht1M/NHg+TnVOHDuUcWP7KDOe0s4jpzk1aRgfs6gBfa8Uu+FnXBkp/2rTisLiylnNer+Cp1+SyA1tFVVlysz+8fCb+RVpB/ppISB3Vq7lz+PFZvq8bc5CP1+I4L/k3t0gLoyMGkpf3YTGfaFDrdqDiDTfV/Fc30AdZB28yUYo4g9cwJGZxZ/cRhWj2myR8AObcYeIw42kpF77CHUc6i8bf1BiGRWuk54r2DAfrz9I9V+/hApXPToIqRq8gchQVtYButBW3QjXRNlpc1Dkub52wUaJ631hvnBK/TjWLtHp4vSh6VhkbqunTWGyMhj4CUVs8quZR5Vpm8nEXdM1f+kc8wY37ICVvKojKcd8TmuxIqyaLNqiJL0qToi7kqYBEX9d7Rom7XGankAcz55HbVOCgtMkSrjt3FpXpSprx45eNQ2V0qMHL8hcTTz1ztZo6WNxhaxAdU5C0D6LuD1omzsWwCjie7S4g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	11MrpNE7BbSDc8egSYLchZKfsMe4ZQHOdjH1q11KTRY491VLa7TMFyOdyc0tBXh1WSBoNLhQVivjnHasG+AX1l7Uypwd4/O+zDB97UrrVd7JFiN7eB72W2uMpn59VPlrn84RYOgwVx4A+dMZ9rIU8fB4IzsfG8svys9IIjrKHxj8r08cFNlJN/3D0L/XhqETWr6PLDFfyL/Vp+A7Qfn2SHNr7e+MtXStKVBrcOlysKwdxYYmi1g4gKKK2A1kKUDDyKy7+yb3F7DCtv+vlT6iaGQVswCuFGHFY33OxgFmr8BeVIcJlS3yLeUbRFivOGQxA7YBz7YY/HJnNTErcVxlJ1ynAdWQgf9sZ7OVBmXwHPq8sZl63XqCqBWwiuF6SY0CRU9cKrONeXGNeL+brc5h55RDya8n4obVq6BPjdtUayr925omHQAU3Lu/VncK71Kn
X-Exchange-RoutingPolicyChecked:
	0Vc1PgIL8ZP99e4jHKt1DA54HaFFj0K4DlUm//FERFduGre5RGC12d3FR9ZxEOLFe2rhQl/WsdjmeV0D5fp4HqMaXQoXoP43OjBJmCYqn94NlcyK/3KE4tYRyDtcjZzhLFM4P6lCLJEis+SD9Ie9ES2Lj7xnOWZrNZ91gzyVlekNKjsASRH3OpK4RGWcn5YYUGESndCuOkGenxHQvkNTC4gaP11HrA4B/NqxyWApFo+y85819q/NQEvfZGBhbF9xaQ24L9/v1/ZsrftDQtIG/P74HfY6YcgF0mXsyM0zOkuDjrILq+RigSBUz+g5dU5CVkamfEmOXn4DcC6k+IJo+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:13:05.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa94aa0c-8397-41f8-55d3-08df0a864202
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX1r/C3UR37Puv
 FZfpJYOlk5JAyg8PiL4U1QuSTR8iPmX1Az0AVx3hVE7D8F06lT7DZ4VdB+lZg0SsgtVUOZqwCPr
 QFtn0qa93fU5QnUWRg18hc5j2/Wy/jg=
X-Authority-Analysis: v=2.4 cv=TKd1jVla c=1 sm=1 tr=0 ts=6a9ac3e6 cx=c_pps
 a=lgH93Z6fMBj3OFKE3BLqTA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=vVWVvIjhg91t4kWa_skA:9
X-Proofpoint-GUID: 6eojDAFfG8lh-Mr1emy5Mn6VTHw0mjEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX5NCqUZS2Vfv9
 3aQcZZNvyCzlQUTKeBiOymnT0BAU2AqIj+vYFf3A2QWYr+tVnNsjioiyRTp04bJ83go0ROaQQfl
 nMqxiaTdE5FI4XBXnq26H0zmkGvas7dQFHguuq7ywguhEQBQpdnRAPm6oqPEFawdlJXGvSOFUFh
 X0zybMUlS2G8+3LbB+LZkCWX7c+pWsojqRhl34Z0/efSkSEgk59A8Lu//kJgb75an28o4N0VH7X
 XrMtm555tbijQYVMGnlfRROviagbYd49qXSp16RYeayWf3ljzxdpYgOJuic01fh/U8yMRNQ3fq1
 VpN+Qtg+oVi+2FLEu88/p8NIaPJBcxhUcvWR7g4WDJM7GM81jttIZ7BnPGCbXizVE3dSG0MER7l
 HNhnCt5hMsMX7xzFWJ1QpPUNI1Am41Nv4EQHwDDbusHXfYr0ibqpwhVBaQ/XVcdGmHtraYEnqNq
 rztyKdCYPDCoeLWErbg==
X-Proofpoint-ORIG-GUID: 6eojDAFfG8lh-Mr1emy5Mn6VTHw0mjEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040119

C bit fields are weird, use bool for single bit flags. The compiler will
set these to an aligned size in the structs in either case.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cc65dc90770d1..dc75780f76c96 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -174,11 +174,11 @@ struct omap_i2c_dev {
 						 * if set, should be trsh+1
 						 */
 	u32			rev;
-	unsigned		b_hw:1;		/* bad h/w fixes */
-	unsigned		bb_valid:1;	/* true when BB-bit reflects
+	bool			b_hw;		/* bad h/w fixes */
+	bool			bb_valid;	/* true when BB-bit reflects
 						 * the I2C bus state
 						 */
-	unsigned		receiver:1;	/* true when we're in receiver mode */
+	bool			receiver;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
 	u16			scllstate;
@@ -313,7 +313,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *omap)
 
 		if (omap->rev > OMAP_I2C_REV_ON_3430_3530) {
 			/* Schedule I2C-bus monitoring on the next transfer */
-			omap->bb_valid = 0;
+			omap->bb_valid = false;
 		}
 	}
 
@@ -458,7 +458,7 @@ static int omap_i2c_init(struct omap_i2c_dev *omap)
 
 	if (omap->rev <= OMAP_I2C_REV_ON_3430_3530) {
 		/* Not implemented */
-		omap->bb_valid = 1;
+		omap->bb_valid = true;
 	}
 
 	__omap_i2c_init(omap);
@@ -531,7 +531,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 {
 	unsigned long bus_free_timeout = 0;
 	unsigned long timeout;
-	int bus_free = 0;
+	bool bus_free = false;
 	u16 stat, systest;
 
 	if (omap->bb_valid)
@@ -558,7 +558,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 			if (!bus_free) {
 				bus_free_timeout = jiffies +
 					OMAP_I2C_BUS_FREE_TIMEOUT;
-				bus_free = 1;
+				bus_free = true;
 			}
 
 			/*
@@ -569,7 +569,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 			if (time_after(jiffies, bus_free_timeout))
 				break;
 		} else {
-			bus_free = 0;
+			bus_free = false;
 		}
 
 		if (time_after(jiffies, timeout)) {
@@ -585,7 +585,7 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 		msleep(1);
 	}
 
-	omap->bb_valid = 1;
+	omap->bb_valid = true;
 	return 0;
 }
 
@@ -620,7 +620,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, buf);
 
 	if (omap->rev < OMAP_I2C_REV_ON_3630)
-		omap->b_hw = 1; /* Enable hardware fixes */
+		omap->b_hw = true; /* Enable hardware fixes */
 
 	/* calculate wakeup latency constraint for MPU */
 	if (omap->set_mpu_wkup_lat != NULL)
@@ -644,7 +644,7 @@ static void omap_i2c_wait(struct omap_i2c_dev *omap)
  * Low level master read/write transaction.
  */
 static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
-			     struct i2c_msg *msg, int stop, bool polling)
+			     struct i2c_msg *msg, bool stop, bool polling)
 {
 	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	unsigned long time_left;
@@ -684,7 +684,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_OPMODE_HS;
 
 	if (msg->flags & I2C_M_STOP)
-		stop = 1;
+		stop = true;
 	if (msg->flags & I2C_M_TEN)
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -1423,7 +1423,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		omap->fifo_size = (omap->fifo_size / 2);
 
 		if (omap->rev < OMAP_I2C_REV_ON_3630)
-			omap->b_hw = 1; /* Enable hardware fixes */
+			omap->b_hw = true; /* Enable hardware fixes */
 
 		/* calculate wakeup latency constraint for MPU */
 		if (omap->set_mpu_wkup_lat != NULL)
-- 
2.39.2

