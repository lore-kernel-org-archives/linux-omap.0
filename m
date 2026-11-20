Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795194265;
	b=z6VL5P/JyKwfMAT4XYU1DweCW3Quo91umpEGHr4Mi2CdfzQguhfaEVktNQud1j3fDbR9
	 xFvxpvzzckRllj51t3+C9XKLQAwalp4wQ795ooixhCds3PqrWO/68XPqGjC2hNHjKPoD2
	 HXDPx/jBKzF4UbnaM2gsG5xJYhag+Th9PRlCjZ3Uu1flLojjKBUxpLzY9yxf/g8q35Rao
	 uTxiWNt6lMShPeBCPOPFknI7h3j9Vf2Z4GIyvvB1kJhjS7lVDbrWh2eyp6AtErgae2lUa
	 ue+pTjNtIOQLR7PvWfUcJvw+gIzN53+vDADTGMMn8GT80NGzNMPWYWoKsP8vpgHHjDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194265;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XKqPIGb7HCurcluq873UmtbPmj4SG5D9nn0tJ+y7Rhc=;
	b=eNcZGxfPRwmmXcX3aNX6+YFQKxwmdMyJrx5O05Zgqg3ns+6ziJpxsmeXaGAecafKfpza
	 GF+BL0Z5FLDX9lySHkiAWnz9sM6ge+LYlyqGof+R67YftlFJWb0MJi714isDGqHGelTlk
	 qUF2Kth/8qMrtz02pcZVcCo474M1d2RbE7KBJ64U+8CCu89bcop4DjBUp65SLfGiUlNyj
	 Htf6WIld01CEP+OOlpsE2sLRLYt7O060ld/pJ1JeHQr1E2Vf9QHdRfRSOO50UD9iCwNCK
	 kXOBlPiNdV7nGCr95N9bsldjRSKWY5Hy4p/eS38AuBwVbh3V/40e+ixVL6ketJSZN4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DkY9ANhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.30
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351A606A325;
	Fri, 20 Nov 2026 17:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B351A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DkY9ANhB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT/DWguf0m/pWgobgzEMz0zwwfKm69vTt0MLHyS0pbR/OmE7/Hoa61w30KorUfv0JhXyt4+cq2bGvW/ZmzQOfJdLjHZghdAiczDluRd7pAzM9aTB/U+WH66MpO/A3J/08B1abz88k4/LP9nyBVBg3rbnf4+gQBzOV61pQIZ38C59kSoUkpuDJNlug3NX6cyZLTr9p9KRxc/2lI4OHYRhJmLOOecshtLiwvzRzj+j8YGG4MwC03XMO1M5Rc8zf7eCxZZlhUm+pUQSHYZZYWSkQ2qkUTiX5h32PPNYkZ1qiZofdP4rJebMA9kMkfy020hJy6RI+DiT+Cb9hgiR7xuwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKqPIGb7HCurcluq873UmtbPmj4SG5D9nn0tJ+y7Rhc=;
 b=RTLmZMA71teSOPGcRA5kD+nl/1D8wYfk2dU5Afec9+A4pGP4Ctx1vJIdhuOkRqe/gwJlBh2vBZJ15IsXR1wGIwrPNZMWmZe1OqNwvtH8ay6fYRbs/jLYwn3sg3fZUSy0I+ykvQITwBxRER9D8HzydkuwtrjgSybGRFDTYYKGIbqutdNuIf56J1T83vwoevXqbUMPi/yVO+kLOnwxs9U6Ua3dF5IzCpyWeMrA4XbL6vfiqCEOrIUZLBVRCx5dWCYc0B+tG/a86gW7oyHUeR0STOizHDdd+jl+Mj8hqc3nUoc3Ya6Rn2cfsuigvwoUF67kb3Dq63yqMrfD72Kki1Y9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKqPIGb7HCurcluq873UmtbPmj4SG5D9nn0tJ+y7Rhc=;
 b=DkY9ANhBdttsrXc2xvu7q/+ZWWeYt39sq3zo88qGwu7khsCYb5ihokYLfr0H4NnN4PaZ9YrV1WyZ46Yb+WCz6GFqzPeeAHrdB3b+Qfr8abXjEoyVDtZ2xGnBG1Rm/EOrxgiy5omhCkC8jcGJON/0s6zAJs82ojFwIMgojxWjJ4bXQLd/gHBf4HEfJul20++2c81YAS1YOcq7mVmbTi5LWmqD6Xy9NldXvJ+YJn11DVvVp883rAxLDQWZW35hXQvcWGQLjhQyyU08xWK+DeBUF3+lyVG/KzdAHHTVH19kcPPvLIdfBrS+UUF/jPePKM7bmJXnY0k3ecA4IIHfz15b0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 17:04:19 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 17:04:19 +0000
From: Frank.Li@oss.nxp.com
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER),
	linux-kernel@vger.kernel.org (open list),
	linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH v2 1/1] usb: musb: use dmaengine_desc_set_callback()
Date: Fri, 20 Nov 2026 12:04:06 -0500
Message-ID: <20261120170412.3782562-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: feabc392-93c0-41c7-bfc3-08df47285129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|18002099003|261009223027099003|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006|261026121527099003|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	D+AGEXVoJzUYbpWJ29fhqudc9QwqXQjjFs2d6+5fnj4G5h7sp7uFqICZF8ZSRdGKFVYQ3j0aXIvRhQAkVKL5s7E5RrJMZu0HbE19sPvxiYnf3Usa5zXV/2kjPPVq6N5FGBdGqzaXc9Wn6HSjKqsiTFZDSXrEuQaMRu6ROaeKrVZeugz1oLNwi8+FzUO985fAR+dcNRagkOuxYXvJ9PIldtcV+qxir1ktfsz60i+k69KT2moGjNHvXd6yKIwRAezBrplOiTgYL3Zi/x/FlE1iCWNQ+AVE0AHd5X9SqTrUw1YBRttfAWLSaMyzFe6Nd++3YV5ogWMxzO3G7gv80hh7dIIfJKFB1uW/0dQyySmF59ODh/QlEoVHmBfHxF+EsC9AiBo5u2WHNPh/dP1Z2DbY+h2fLnrzsb/wbBXc2EMgoApCcK9S69FlEb5jJZ3eJoe2yHXOZmL1pa2x1SkymTBBgeJxnnGdRWR25ofq1ixVqmtGejhxj1jNGjkBNztaTrb22H6g7OkXLBFOuSBamzVRtiZ/8J27sH7+7d5Dbg+opuIzBhaGpv0hGsKJNYf9CopDy5ZxYC++HtCtOH/y7mAeYc70ukURpf5Q9Ihpwajjtbl6aCUmOpsVjiNK16jQDsaHbrZFp/HwTaGU4Om/t8LScCLd1BB7KHGXlNuKLEABVrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(18002099003)(261009223027099003)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TwV9+SRVzsUn8aAcF3cigD3ZxyYp3gEhFTr5aSGYJjCYvn0xqyfoQhM9kmEW?=
 =?us-ascii?Q?ka9YzLGKsjVadYaSIqew5ws0pfNBlxWObiUcwX7wRMCizoSQkz0naqrkrL8d?=
 =?us-ascii?Q?zWndrhOX/PdR1h+nMvRg3DoPsAT39rhb6fMqg4qBbcWJ/dssFhrK37R/5WsX?=
 =?us-ascii?Q?5cb/ZHz9xWgLudqEEFndk1MVP9+zxDDeORBsCMRcrTEGPNrYA+HtH9RJxkSe?=
 =?us-ascii?Q?4HxjVIp6KOSCCJGEQBMaww4/k5vCKCgTSrYJ3cD75NNc5mnU0Acu14K0u8ri?=
 =?us-ascii?Q?oYRZVO9531hv1t1i1w3KTFwm614g6fjcc5x4fdCrJqnUlUQhnzxAk7tfDrOa?=
 =?us-ascii?Q?2kgjfvvjR69srcYR0aoDcevd3LLm6+ZKqYKfaZ9228t3Wgksggt4ScZhusGk?=
 =?us-ascii?Q?2hjstArDz0w8TE3d917AKYQk9A25vD0FpEK4SGGjUMa6f+13oL8o5fvPQ6B7?=
 =?us-ascii?Q?Q1QZ7i41QFw9UHVYM1bHEF1KGk2P5m3rlnGNMDqNm/kapKfAVEkOQapJ+8V6?=
 =?us-ascii?Q?uJ9bja7i0mm7PW3OyqMoiUtcPmo8ekkLc0tjeUu7fXL7XNaQ4CsAe0fptEqw?=
 =?us-ascii?Q?FDx5UhLUhM4mIfQjgFJCUSjS0HmKuoX4Dg9DGftrScaIJCtduMKxGhqLinu3?=
 =?us-ascii?Q?hKo9gv+Y8yjxOv5c5E1Y+4yLH4MCSdx7dCTbhe347AzFuhKb16gkrkl4IqG+?=
 =?us-ascii?Q?lmbKmfgMPm5uUXWELPuDo/RUYuDmiExCWdk+Elf0na0QsbRLG2Wrl0W6P6tV?=
 =?us-ascii?Q?sfm20cje/qqpTwIpKN5sPgO/zTt9JDx14hHl8MmgMYZeqScoovc1qpNTxvjY?=
 =?us-ascii?Q?e8BnjVShhBRvIGJ82voe2ctsga9wkSX4PyJ65ZHnXIxEGZ7WcUrSnM85qiUW?=
 =?us-ascii?Q?vzMhII/AE67r9qg4pfB9UZ3KMeQBDfAjG6xFNiFdn5NB9ZpJ8FXdCYlJ5ZIS?=
 =?us-ascii?Q?5hfU9mVg9vevd1qbNKBGvtAx6a/CfPEzjjj1aBXUdGCOBfjeenbgsxrcO65Y?=
 =?us-ascii?Q?V70AR/IXdKwgkKLJ3hCrPzj8QcftS4bPxMegB0JkZb5kj//hsc5Zg7XhW9B3?=
 =?us-ascii?Q?m0eMqSA0le3VUl09+KhPJLXpVNYqeJcdaaZoKkZV66rNsxgChMIkXgkiGwgx?=
 =?us-ascii?Q?Rsqs/x5dXPxB19D9jU6Cfk2l7QwcFaVeN1MkkRSSh6gpNkXoVeUgm9Ndqsko?=
 =?us-ascii?Q?qmLN7bv/c4yFC3JXPAC5F7/otFt1V+kY68i6B20Ob7RJ4T+fRI5mcebUbOxc?=
 =?us-ascii?Q?9ooBW4+WcY2k8E7v2Bsri7PU3r1JhY3UM2AqnI7x0/kMhgmglo8KGpUZ9gB5?=
 =?us-ascii?Q?DjxLLwlbngO5eB3eAFG+p6saCb+Ng7Y+7TVGE9fnXwzwdp9DFKA13dzdULOh?=
 =?us-ascii?Q?XYlZva8wOcdDyLgHTviLsW53dWbBhpcedspLMaykjhjmyrkvUFq9W6v6NTTK?=
 =?us-ascii?Q?Vlzm+bt4N+9a+iCiXUWzN5Ya+Q7yD6mggIOmxKcSgjtk+FVzf31V5F0tFtYk?=
 =?us-ascii?Q?CnqvNb9n2MF9qw8CoGIj3iBkoNi0iaftNKxb/ljeAHyaNrfTgioOBVd9ruL4?=
 =?us-ascii?Q?RuMGKFgcJYf7Y7/c+6p0bUV9aFkpc0gADy6bDsCvZqQLWUqhZQlw2Qc0FnFA?=
 =?us-ascii?Q?ltpTdvzKIhNw1F+c3wu6DWIv7y282VQoLVE7gZyyCA4IoZxuUST7N9v2bqgH?=
 =?us-ascii?Q?8YLGOrMUjHTSclXs3xM7rY8I1AbEz7m9h+eJbdrtY6yZtlqi58WRVS/khRjM?=
 =?us-ascii?Q?lZ58YFdjyPE6x3MD7qEPgAeAg5c2GqHHuBvYg/mXzVhXXodsa1ny?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feabc392-93c0-41c7-bfc3-08df47285129
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:04:19.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLc4znPzLQ3VZjdojfzdJFePkb/d0Z+d5D4mgzQNDI1zw6fUkn+Y4sUpduOckBSxFwsf2ibjLep4daQP1Wtqs8LrUbeweEioVN1ivULFzX0IUmp1EvDetYRq6iZ07lnv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback, callback_result, and
callback_param fields of struct dma_async_tx_descriptor with calls
to the dmaengine_desc_set_callback() helper.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- rebase to usb-testing branch
---
 drivers/usb/musb/musb_cppi41.c   | 7 +++----
 drivers/usb/musb/tusb6010_omap.c | 3 +--
 drivers/usb/musb/ux500_dma.c     | 3 +--
 drivers/usb/renesas_usbhs/fifo.c | 3 +--
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 37a009a4bd500..59f3664354294 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -167,8 +167,8 @@ static void cppi41_trans_done(struct cppi41_dma_channel *cppi41_channel)
 		if (WARN_ON(!dma_desc))
 			return;
 
-		dma_desc->callback_result = cppi41_dma_callback;
-		dma_desc->callback_param = &cppi41_channel->channel;
+		dmaengine_desc_set_callback(dma_desc, NULL, cppi41_dma_callback,
+					    &cppi41_channel->channel);
 		cppi41_channel->cookie = dmaengine_submit(dma_desc);
 		trace_musb_cppi41_cont(cppi41_channel);
 		dma_async_issue_pending(dc);
@@ -467,8 +467,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 	if (!dma_desc)
 		return false;
 
-	dma_desc->callback_result = cppi41_dma_callback;
-	dma_desc->callback_param = channel;
+	dmaengine_desc_set_callback(dma_desc, NULL, cppi41_dma_callback, channel);
 	cppi41_channel->cookie = dmaengine_submit(dma_desc);
 	cppi41_channel->channel.rx_packet_done = false;
 
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 36ee61a52e7e6..eba54d1a5931b 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -308,8 +308,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		return false;
 	}
 
-	dma_desc->callback = tusb_omap_dma_cb;
-	dma_desc->callback_param = channel;
+	dmaengine_desc_set_callback(dma_desc, tusb_omap_dma_cb, NULL, channel);
 	dmaengine_submit(dma_desc);
 
 	dev_dbg(musb->controller,
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index 7b62527ea3f74..c9c62d4ee6207 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -116,8 +116,7 @@ static bool ux500_configure_channel(struct dma_channel *channel,
 	if (!dma_desc)
 		return false;
 
-	dma_desc->callback = ux500_dma_callback;
-	dma_desc->callback_param = channel;
+	dmaengine_desc_set_callback(dma_desc, ux500_dma_callback, NULL, channel);
 	ux500_channel->cookie = dmaengine_submit(dma_desc);
 
 	dma_async_issue_pending(dma_chan);
diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index bac6f8fd0055e..8111d9b02c7ba 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -839,8 +839,7 @@ static void usbhsf_dma_xfer_preparing(struct usbhs_pkt *pkt)
 	if (!desc)
 		return;
 
-	desc->callback_result	= usbhsf_dma_complete;
-	desc->callback_param	= pkt;
+	dmaengine_desc_set_callback(desc, NULL, usbhsf_dma_complete, pkt);
 
 	cookie = dmaengine_submit(desc);
 	if (cookie < 0) {
-- 
2.43.0

