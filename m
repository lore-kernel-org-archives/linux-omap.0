Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AA3126D9;
	Wed,  8 Jul 2026 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548686; cv=fail; b=tD2UA1pBDN5+v6+caVH0rZyELshJifxwbg7pR/rL9UblfxP3XeA8KmDqQlxPupO3Sd+kRGDwwF1zrko/77xb0ag3Qj2ybeshqNGTR4taUvL0QXzhK7jVA37CfX4X6+VGn1x7VlPIMAsIDZaQvSCwRfQGXLzJ2Ox9zG5lGAm1gtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548686; c=relaxed/simple;
	bh=BBLMbr5Z08Vd4eLlbJt1avXRXsocPshbbQaoAStVaD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOrgw13IDUOt9arFvFRxYK1BjJViUWgLC5QuJHT0F0F8pDMK+23lpBHmACPOA3QJGdlduzLliei4MYVoWG+ShvWFi4FV7P03CiFLbJNZXdn08NFygB297o3qRaI+eqPiKx/CdGFE20fr27C3dcPMdH0fjl50u8W7DyGwAMioXuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=HzQwbM11; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EuD4tfcy; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="HzQwbM11";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EuD4tfcy"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 668K7SXN2288697;
	Wed, 8 Jul 2026 17:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=j5VFDg4cvcKUJ
	rZE224EJ+K9tYievBZCYkSkeyJJGu8=; b=HzQwbM11Wem4zIdhQwKWAIfy3yRVl
	h6JAqWqR1RUuiyP336iLjH6dnIN7X3wfeiFOi6DHzOsxE7VOmk8S3R31tbOdaiT5
	N7KvM7ybxKCmAs4L8Vd9BCeKJXxsyeApPkRY+EX4TYzSozahH4ORPDPhb+NPnh8e
	hgLwuih6zIjYSXgsPJLM0JAGH3tB+j3SNsYjgIFDO1zUcVBwp1JcsqKa71rZDRQL
	v7ZfNT8Z30rauB0pQJgiZ6Arv23/+Kqgedzw8C3aHGwJRzoYAd9BWwB/3L1e6C4D
	dTgGIIh8wods8KzrLh9fzvNfhHCUUirRaVtZGgz3YyMDW24F+Re+Y5IUA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by m0384305.ppops.net (PPS) with ESMTPS id 4f9nft48m2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 17:11:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqZeYq1rx0GPLDsnc+iWbMqxTa8jGkowGgk01MVjk8aR2FvcnAwsyBs/gA0laXRwz+tjJsnJv4nyrLgWaR8Rj5xV2Jo5gvMT7PuoqQ/xI2PxEu+6I5JbEKZp8PBLWZ5zgHFoj3ZYf2ZxZKoW6BH8bEuVYvOQFNuzmVnnqDdyd+tbQFpJukddQiB9bUDDVY4ttmrstQVyDIBLs9VNRkl5jH7P38BnWW6J3lM+Xjs9DY5nAvYmPCrYMYK+uhu8zfGVRrFahpn/ujLBF/TjiqyYb4lAeF2lBz2dzkn9Mh9WidLIhBTTSC1C9yW313IVpP/2FVoNvrnrRMmcmJEnpmEaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5VFDg4cvcKUJrZE224EJ+K9tYievBZCYkSkeyJJGu8=;
 b=BZs/zCmvk8aN+3QI24nNslXd3NtScGvKJ4LlijVaoCHiJQYc539x/Jeq86sMZAU/tqheS3A1QX2K0b1VwBdB1VWoUGd8+y2lzmPANFY1dZVG9VNidZbsyaSKJlu5O60K2riDS9iwJtCdNURcFamnCuRuFf3W7bHjj5YB8pUAM6hEx0x+lojrdB36wIfq6i/l5PXV1qwUWmkWfqo6SiZi9Zf1czFXXa6cwCMaZSXtxahCabu5CcG8MPXzLhE+ib77EI1NwWUBVk7heMPZr9IKp8JgRUWmS0dk1hE08tfKvdGY/mQLva0glYMaOeRc9enln0EbcOPYIY8O8BlT18Yzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5VFDg4cvcKUJrZE224EJ+K9tYievBZCYkSkeyJJGu8=;
 b=EuD4tfcyn4pBONFj0Be4JOynfqSmcSQNezUE/iAamQbsI5Faei+A1sQi67MgdLkfKxO8MbRD4c8qMKd0ziI/XehueohWeeweeVgaPEDN768W73Cuk7jitMNKDqfQkdk+c3SeJNZ5tWpqjoAuh97Y2vfb3IPAXYI/3MSmtScjo8Q=
Received: from BLAPR03CA0044.namprd03.prod.outlook.com (2603:10b6:208:32d::19)
 by CH0PR10MB4971.namprd10.prod.outlook.com (2603:10b6:610:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 22:10:57 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::21) by BLAPR03CA0044.outlook.office365.com
 (2603:10b6:208:32d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 22:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 22:10:57 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 17:10:57 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 8 Jul
 2026 17:10:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 8 Jul 2026 17:10:57 -0500
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.81.246])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 668MAvZx3314376;
	Wed, 8 Jul 2026 17:10:57 -0500
From: Sen Wang <sen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade
	<andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>,
        Roger Quadros
	<rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sen Wang <sen@ti.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable SND_ALOOP
Date: Wed, 8 Jul 2026 17:10:31 -0500
Message-ID: <20260708221032.1600089-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH0PR10MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 114428bb-2afd-482b-1ef8-08dedd3dc99b
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tNmKCrO6QgKIvGCFV/nylryYy26j0E8lSqVh77ctrs9dMCOn8o94R9SOqpg2JX/9iRwTPEyeH44l/A+Bg49Lm2C+bE6TAHeRAnX++M2GrgELOZo/UwPiNdSBZkuffj7OhMl6RKtNoyts/RahtRTcNiWmD0xAenlnwiWjSPs0fP0hcumfbmiGUOgNHcCQrFlJm0jk23UC6wTXlTEOAQwhJtTxkcJf3YdfImsYMCaPgFIiYdVa0cww1ATvGcLEBlbGs8V41+0Y5oaZJvuuBN5PtFScL2MN2CDgWXZEwUa/pHO5h2ndPdcDUOJUdBcXnwj0Di6CBA8vWHDIpbxe84MAtoiNf8m0wAxHTcB5wlOCvKEYN9LOsq4sn/4NfWRpI5rAH0MlAzNdIHDWNfbsuxJvpyC20Wn5jaOK/cdOeid2MwO0rKMdbqIhmnPoDn4GAgYNE9N94H6jgNSW0+HQM82W8+QLQMQkisdBHHarxmz/p8cc9qdqsClIrH0kIoM643byAMIz786374IrTNFvec6l9EG4bBuTvfugRmO9sR6u9mtiqKb5yofY0Nz1TGo+iDCFoVPC4q1TnzW/D/fbaYD/D6nTIwZ4IHCYnSWsxTKt86tGedmVe7mzYQeG4uNXE+DiarKZwtAe25pb3V/zyAjU7bDHUZzCW8RFNPRHMBPJo4Gs5fWQyzS5nP7IfKtvrAe1GZ4pzDRFvdtfItWVbBPsCg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmJ8xI+j+MUEpMatzN/oKGLYuUCJ/ie9N27god3jQNGsCn3Zz4S1MkfoYeSRzvpfLoWVfPCReCUcDJT91nhv+G7eNlO9hYPiBLAl1E0MG2Tz/dKMLsIjAic2ZZPmVe7juIjQO9wso4E7T38TlDVXvLZ3dvWhXkZ9wr2BlNjsRACyI6vx7rrWENZ9M2sgq+UVvKOJDqS5tf3h2si5zHaS9cvi6SEv3yNltlLeIY16HOX6jQ2OfvIeA05VpeOc6wA9+WCWOs0hmicT5rivcXjLrJD8CDn3EvD6y7w3OHKR56NmjWFP/9ePKQfMS1BCx3Gk4o10RtGpoTd3gQM/xVTvMkZVeiEbComb0lZtC0ES6mcZjJd8f7O0RShoOE8RLntYzkAk+w6vnJOGmcykUoPp3q2w68V1ELEmsQpdz2vLBnmbgU23YGycRfTCNFnmMtoc
X-Exchange-RoutingPolicyChecked:
	pGat1wQtzXoN4br5UaxkmWiMgqpGCtp82TWxLWdOtp7XSgr41avZWoR7e3YPcPYOUAbQz3rGSNRILfQlKPms9KPWuXf9sbC5aNvZU4zk9xmNs4LP9nKGGyPcK+Md7yLwqMlbrDE2+GZvGNGCB/w11ibfuteNZd7bEHn9gPGifvz9YS+LGS+J2L5hFZdlRFqEs9PVP4xPw5T5gF6w8OsiPuyx6PUZt7SmqC/61Kpa1DKySbJodbCUOO3pOlAkbtZBVbp0c5OxzuGqIt3cWJLx5Qg9N0T6FLFe7AKga66u0FRvUEG/HFXmII1+jD3zu/BLOsLe0b8n++e+uvBILan6wQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 22:10:57.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114428bb-2afd-482b-1ef8-08dedd3dc99b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4971
X-Authority-Analysis: v=2.4 cv=AaOB2XXG c=1 sm=1 tr=0 ts=6a4ecaf4 cx=c_pps
 a=bt8r0o3PvT4lvF5YbTRm1A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=oFaIfZNELmqWH1DmM9cA:9
X-Proofpoint-GUID: gw1QPFfirBhn-TgWZ2_Iag1oxW_TsMez
X-Proofpoint-ORIG-GUID: gw1QPFfirBhn-TgWZ2_Iag1oxW_TsMez
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIxOCBTYWx0ZWRfXyCHOacc4wnnP
 iR5w2QeHDBKpoGOVZX5cVrEh9Kv1bFSVkfMJr+Fu6rrYxJ190JkMqnX6Ro3X5F0Gw6YMkTTvb5J
 eoANqJheKk84a1p/wgBshFNYS42QO8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIxOCBTYWx0ZWRfX6je3UP4/B88z
 m6BSqH3a8g7abVQnZbFStwJXiETk5sZNpjQPJ7Yr2C2iQLAa/+ep8sxzHWZQKH6mUhVNODLd6dM
 G/FeihIytvucNh1XS9hem5z5yWI5cYamoByJXzLYETZ8FV5b47tvhoERkaX2qCQ4NbLqURMBzTe
 RJluB4SKpI2H4W5eE8ye1V5H2hFhJLMSqST+5lRv26bcCvC9ACs4vH6PIvwpiOEu9Wxr6TzS74j
 vNIG2GwLU39fm4mDsHtbNLAIe03p5RD1mwLw1BXfpgnz3itZ0dsDHgLp1GsC/dXQqd//ea5ul43
 tikmTt/aR0+Nm2AFHKEwyORS9gRkIDfkR0J/DhY5cbS+wTXCVvECgToMZkH2sj3N8RsBOLEC4gC
 TAgJtDr0JzBhWJOlWIK1dZ+ejbY0Q5JEsxutPCmkJ8KFDWW4KnIKXdgp9MW/PSA72jPlTXojwtq
 j0yUj4q691LzrneqvFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080218

Enable the generic PCM loopback driver on AM335x, AM437x, and AM57x
platforms, matching arm64 defconfig (commit 7235cdd9cc52 ("arm64:
defconfig: Enable SND_ALOOP")).

snd-aloop lets a test setup loop audio between capture and playback
without external hardware, which is useful for automated audio path
validation on these boards.

Signed-off-by: Sen Wang <sen@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 0464f6552169..f488a2f66d7e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -520,6 +520,7 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
+CONFIG_SND_ALOOP=m
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
-- 
2.43.0

