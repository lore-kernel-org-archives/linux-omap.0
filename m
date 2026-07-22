Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012033.outbound.protection.outlook.com [52.101.126.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A64473C9A;
	Wed, 22 Jul 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707110; cv=fail; b=JznqCTF3VypQlaAU+iYms7mFfdpvZ4+7mNpaU8vZ7qo/HDJ0ScZyowTUoovqlnDKee9ggtEY4tEXFVjHVSK71knK53ae3HaNBAr4G4Mq6l+a9C3NbctJJ3+/AOiSyvpVsyKBniij8q9p5NdyZo54eAM74GX6xer1ql+giNkv6vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707110; c=relaxed/simple;
	bh=bGCtAQ/Ba1Z+eGMkQimrUZZuiyc8/akmUqmBxjDEpDw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjsFQ5KVvjdNXn9vcf2fkt0rcxBL1XcmrS+Xu4D/4mwmRuzi7dtpt1Yo1G1Nr79/+jcUbwAkUFmVEQakDTiqRLt6Y9QXxxY4W37r7425n7uF3o/muJtLG0Te3R2RWF3xClF9ssZlfN+qKoDXWit6fT2Py8Dyg4yNWfqYpkevwRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cgkvTXcX; arc=fail smtp.client-ip=52.101.126.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cgkvTXcX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esqH4BH1pRN4eR+UYluZ9DMzJ/V9nJW4EnNuyF6Nb/r1yOMODWTo9obVV030OcwWG9OELXVS5uOciOQ0/nwO6Ez6yWEDHR3sA9FP8AAsMUSN+irUu6JvOT67ZKgOTGmjpzTyL+Gl6hVevzXHFsRbro5C4WFuUNCT4bSQ5d659crh/5nXuBY+2tLekmwwfMCoFMm3jXRQkSZzdnFznQjrmGUZngaayECDzU81fZ7muV44Ed/g3MLboQX4YPn0pvzspt76OecVniDWLyw/Szu7c21V/4jYB3fS/d9Wstd+nYxfH7WzAxokfyU1mgtAi/F9dGM+cJSc0u7lBKduCexnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jL/2G1R8mln/PUUjf2ckXxQj9auNGo0IxEhFGfN6Ak=;
 b=TCYQrbMQceecqm50HaI1t3yyxtxghJYuwi0HEewxVi5tD8l3xeawY4ttkD6kbTMAcCgCsiaZS+I15alHGWn0h3TA/6FK9EdfOv4vm/LtrYmBhQmum8h5tMlxWnZRc5vU0Y6adswYFkizI7EWmO7itcxuTIfJDb8Hu4+Z64CCvQWo/Ja5hd6VRC7Tkg8qIgwIkHiNoQHdQkMG7bMkPxEAZ2YifhZCGJdDi/jbVmmBfP+4Q5phKK55Qv5TINqbqSgQ/ziIaAd9cUJ+0vgMc6Y8sBJL/FPbIBcBpFzBfeEJJuFDkSrb1BAbIg/WHmFZb5MULVDxRDLQfrKIB8ggeflu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jL/2G1R8mln/PUUjf2ckXxQj9auNGo0IxEhFGfN6Ak=;
 b=cgkvTXcXJMotpa+Ux/bPxOKrt1RhfNdWgw0aH+/6eIw5Z+/dIayUCqhSq4KRnq2kvOC2Ne6+NpdTwmsZcVjD8eDE50/q1Osc8ffHF2uZG6qiI3dzcQwgtQ7Ko1N8xuTZ1xwKAUu08iKJuSSXe5UuPq0bRk7rKTom4lEHzGG5Lpaj79MXlnakco8hfk/S5iOfY+ABzY0Y3iObA+IeK4jAGvBfgj2GyzPsZ2cTdhc9iiA8ekQco4rL5MH6wg/Kd8h9c2s+I1crBORDg6x2SFTbcvze7wuPA64xq87um1FURGu07x6T5uLyr5YTXXg0fD9Zn5rzI632q0V6PcUL2jfdig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:25 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:25 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>,
	Pan Chuang <panchuang@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT...),
	linux-fbdev@vger.kernel.org (open list:OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT...),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] fbdev: omapfb/dsi-cm: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:42 +0800
Message-Id: <20260722075803.570532-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 326d0e2d-6530-49cc-35b4-08dee7c701d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|52116014|366016|921020|38350700014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oOy22dL0IjhSHanHicNv1WuOu/We5xDs0U4tpfqyyoQr7TqLEQW2fjyzAgRMUvGwPz5mnYGfryOhZT0yH05tzNw0nh9sj85trEh3Z1WfLpkwVx1IS1AqzuA9xEp3VVkmbRAKEX38BRwekuTQ6s4436+Ts0YVbnRgrjb79Cmu4XN+8bpekyh/Ynf8sDTzMDXsTTv6wRHOK6dZe9S9q6NSU2aF3dPocDf6JV20czsjCaZx12zYgv/2bN66jaDF0gCbA2ArkWHR332o+eWZVhcBnAZqF6CFE/Mcx4Q3JpBSssh3r3jO3vFGBXp/IMA1bAKs2ck8xX1qjESr5jMg4/h6Kv44Il3EAu9SKvThZr7AyrvvouvheXu45lxXMNWG+/HfL5U4KAV8OhxKosiHjAiA3aT/7fPmmhyhOXIXd2BvB90c214s5DIgXb3Zl/92qksZUAuDsxMjgJYXYd0AUCxsMgvfAsnMu2DwuBZaAaf+OVX32hwmdUAQu1Puuv+yhaurl4nm0i7jv3BTBIbCpg60v57tu1t5Gf9wWENX/gXtpIX6Rti+5bCutVHuSD6vHUWohDeNh3EtX4VrUOB0a/MXSm+VAE6MRw1L8mgbZ3wXLg+2TKekeQejCbcJtVr4vTAAvM0kEm7kiWTXs1KqSIHr33p+bCI/I0DRDb87VcqKRRKS0OGe8UieQpJkJGzJfCLFDuNoAkUUJ6xzJcqec4LClpkEHlPyIGYNwrt8Yp1ZMKIiSnM7tj5Qid74sfNXXm8G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/LwnMlnX/3WHcOuyB617Q8j1nLotfog5pdYQVBqZa9wex0psC3PmYcrnHB4?=
 =?us-ascii?Q?Y2ks3aov8b/sWywt9mhHl+Ktomv8jsQ2o8Q0DRNEy+TZ2Zp592zeICLK+lvt?=
 =?us-ascii?Q?JG1HZmI5X4KJ7buG1KsvWvYD4oMLSH6E0eb1p3Zw6rVptBA2JP9ZmubXj2t3?=
 =?us-ascii?Q?YYdFEN+GPaNCuZblzetaxh5G1PykoRKshnztFoMa7LIDHDYn8qWhFwFFcYTh?=
 =?us-ascii?Q?DxQaCltvdcpCUDAhWF2Z8v2FhrM9omURoCcWTZYalNLB5QPAA5WmdOQLeQ5w?=
 =?us-ascii?Q?uNI5vLgGMaDFjKKL4fEMkcQewMBd0Cic7AcrDMKJJHt8GH12PuewFLzvBdp4?=
 =?us-ascii?Q?l+FxYNYxdvuegNyXigspPEDebkhY+fHEvzizpEwwXN0FHzXMcpu7wCmzvtSK?=
 =?us-ascii?Q?btBVN3w6oOkE9v9ArZQQu8iburoshTOZhFURqedKBSC0Bj0tcRL0d+42EQkB?=
 =?us-ascii?Q?WK6poBflJVM4/qJ1fnRfUitdp9Nz6B0jm46tbS3yZit2Vh/xoOhPzej7RnS9?=
 =?us-ascii?Q?E2mVucliP78LITviq6RTYQHJxw51U0CZqOmzdAEQ5yindCzwYYMfV2Czw7ID?=
 =?us-ascii?Q?2fCKoHhq2vT9gRdKq3wr0SUIaALh6haB3vartwvjaW1YuuBotaKIwc69Acjr?=
 =?us-ascii?Q?fgqoy8z16PRtGaysibhZFxbbCO/OfhvQPy9TDHcz2wAbQwt7SqdF50nUAMlC?=
 =?us-ascii?Q?sQd4wGM8GI/RP2DR+i1MRjAYWoAHZL7qNSNOjGLDaPXEglVK1CyvIPZg8JmA?=
 =?us-ascii?Q?cay+hx+Uyv0lSaOrNkyq0fTVKZQxHndQk+zjkwxaQwxQbcLIA6C5kcsdly2e?=
 =?us-ascii?Q?1yvUb+jVIIYN85ZbEir+i6/TUxiQn43mNkSFkryPTLte0EJek6YOVczGYfyg?=
 =?us-ascii?Q?iJrD0n9ew3BqZi2e3jURuoI8ks2t65c8NShUYW65bgZ928UyDCbOBuzbu8BM?=
 =?us-ascii?Q?O0GxOdNb6rPab/XsAQ/jHfuPqs/zCVa/ArNuqCUqxuIViOx1y3qnnp1MyQex?=
 =?us-ascii?Q?C47N77xHn+II0UBmXOvL26B0QHmDWIQwTTODfYvDGI7RafP8vWooLiFA9yf1?=
 =?us-ascii?Q?nTXYDW24zH+JVnyley59QfdIIszPeXS5PYVrPQJMVSQAt06dzDPYJeMsMZuJ?=
 =?us-ascii?Q?g/Yi1YSx8Eo9/mF5AYFwoszdbj2WOKvXzW0V2kpLW361kCKHeqhUcGwNflWL?=
 =?us-ascii?Q?JK6lfwPHfnejCAs99idwzjo6Mv7g4TJj/E4FB4vWYxt0YOTVUPkLmowdlMkG?=
 =?us-ascii?Q?xNLQVD5qrsbOsueTvrHGcCuPxkXMVe2LzFQ/V4HqzUSoYgpiqvhOG08AR9J3?=
 =?us-ascii?Q?+c1A4Vgnw0InzWKoKQ0FQD8Ec3kin+j7sSYaeNuBZgiFtbYqD1aKWcgkScup?=
 =?us-ascii?Q?IvfQjfA+Og6r1NPkCtBlCyfFiSAzh7qaFJdvTcfdF7NBTbyJ/3QJJgyh9Qyg?=
 =?us-ascii?Q?ZHTdBM9pQUblbkW0g5mW4VW6DmF1ZJ9vKZzuuCUkhLf14lvyiV3PX00WIc57?=
 =?us-ascii?Q?BdAPj9lzGmRxucjWabRCBAUtkU699/jtmOsXukTs9FvrnsPSJFfA59EFXQAZ?=
 =?us-ascii?Q?lq1gC4Fsdwmbo9SBKtEF1KiAIRPTVcj8CGQdi4Itpaiabp7tdvpNvPfrtEt+?=
 =?us-ascii?Q?wpUsUDDR9a+Bg6L3qtiU3xnuEv6u1GczLbriPewFfl3vIVWqk9sZ243b4g8U?=
 =?us-ascii?Q?s+RsniqVxNjGlpPrO3JfPJ9bpJAuX+DgacVBAptrsYaxBZ7+boBULbbZ2UUU?=
 =?us-ascii?Q?4mU8KhVMbQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326d0e2d-6530-49cc-35b4-08dee7c701d4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:25.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sozxBQU7qvJGVFF9Iat+Swh/NgUt7Q/noq/1Ca5/0czy6R8jQbfU3EYrezdihUHvnFrhbnksQSF1yqEgsc2H7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8492

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index 5e7963b4aa93..7c3463ee02ef 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -1185,10 +1185,8 @@ static int dsicm_probe(struct platform_device *pdev)
 				IRQF_TRIGGER_RISING,
 				"taal vsync", ddata);
 
-		if (r) {
-			dev_err(dev, "IRQ request failed\n");
+		if (r)
 			return r;
-		}
 
 		INIT_DEFERRABLE_WORK(&ddata->te_timeout_work,
 					dsicm_te_timeout_work_callback);
-- 
2.34.1

