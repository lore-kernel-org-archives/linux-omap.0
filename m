Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793642590;
	b=HQzjeb4KLERrmI69dL+5haWL72Ft8X1+0/g7cChMR9oqFzfiQsPAw8l3L6937Z1U2hoE
	 Bo8zr2mG6/Poel0pxPdFYClUStZ1ykeIF2IeyBbOLEYNk7EqUW8Q2+BBbSYkSRDDoyF24
	 t9UCk+7RQlxbfG++GKug1cw+7gF7GbIFi5swyCvkGskEP4Vv+ATiV3doYLIjaTO1HwMoR
	 Q1xajLZ8xt3GgwkG/YuQxnD41i8diVBKsidNfJ7DK9AFignF0bkeRsY3xYOrUAk74nQ8N
	 EebIyUeJJ/qMSkclPX43VhizVIsV2BYpHbAEvYXjyK8rBAoi0XOdUN3p2NBe7LQ0Hzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642590;
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
	bh=CzUj5aF2f2D7cjbJ54zhjl5b2vPMfNVNDc2tEIYLkEI=;
	b=MRfI2lPuqufYzfSgNEFNyv5yyJNYMRqjiDlz/hOT3+UICka9XjMvJFLY/grdyuJJowPy
	 8XCFj9TsQm/E83mspykUmVkDdDPtLe/QnRdTMk/8ChRodt21Dj1CTzolWlsCgdLPTetPY
	 XK3KveKwbA7IxJzZuUyIIIGve6Gkz9R7ZZ5cXTuHA0Gpwf37HaAYkvWbyW5JEDrlbxHhu
	 cOykjHLsb9n9n0eBwNcLWivf68ljK7dQ2NFJJPj+IRyWCR4zPz6hvNyVFKLvPXm1hwT5j
	 8vEK3kmjkOQR+h+/KCZD/7yHtHWl6sdMY4fbRCRJgkHq9RF343SVL2bSTkTONaJ7hbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="jt1yP/Ih";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.62
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374E606A589;
	Mon,  2 Nov 2026 18:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3374E606A589
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jt1yP/Ih
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH7Be30bxMA/RXfcxV9Y/2sYvOH0tZPpDEZ2fTyT6nhJuT9Lnlp9dowdm9fAk7pMHZjEMlhVrREcBWQfWMy5zP+Z30nptDXTXWflersFSLxtrMS3wZDu4kBGzO/FTsoQZlArsy3ihLMFct0yRUQgPPWQvTR6ALY5+JZhvaCZrE1yY29u69qNIQoU0Vmp1TmU51PZomq/plF4WfTTB6lmpbUcJWxEDMYiOkq0QCL5Vey6clNN2SN3qrh0ukt37NZH1sdnNUgv2p7OLbpFh/BMaJ6lSRgd0fORPVCKPWDNX58VMQaX1Du4Wjl56UMXwlfhBA5fEyxPd1Po5DiiAvk1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzUj5aF2f2D7cjbJ54zhjl5b2vPMfNVNDc2tEIYLkEI=;
 b=M/V1qGrT1/IJt1FYuRVsQcspp+PumA2ya1Rvjc2Bfx/90LbpBKTkp+FIcNxR5Il5qMRiBcVR5y0Dfhnssobf0TZTZeAX5DUvXJba3TBeatw+vE3AYZHFdPpbd943F/oCH2MGT0bkN/RUcnTGl+2eeME2djPLXnxkHDu53wfT1L9UjqGWYrnQpQ6rA3q092WOicxvsI8UlUFiLhwNExDttCCyvFZPVaYlT1VRy+DTOJANyFb1BOsFFhpfnuUO4AoyNS1injjV3XUXAkDJ/pf1lkrc2hVAZ9bNRu+PWw8+y9yVrE+k/9qp4axak4mVN0TxX69K2XBSTOIB1U6EGpLXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzUj5aF2f2D7cjbJ54zhjl5b2vPMfNVNDc2tEIYLkEI=;
 b=jt1yP/IhyCu9xgZ57ge0qqpZx+K3nvbf7qhzRH6rulKCUg5bt+izrVvmLwjfHCEisiq3Y/jBprinqdcNXxJwZOWRXGhOkL28+N1g6WjOTKomj2JG5aGo/8f6yhAzcLLAbrzfOinsof1XlDkn1WUq+VSZh5U1JevVowQCkMlfSZjYDhNuk5zctlbnCAJbUPJ9QblDWwiBhXWTcZ3VDgPqKoIKiPPxyx69lW/BbYl57F0gnlhawmXL/8bVlMy/tp2XdooS31jDjT7hahc0Gq7RQ02GcfHbGulLKqM0DFz2AS/Zcq3Dz2VkFdDeX6LsJsPqf7HxyDb6Mj9onp/w0cS0og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM0PR04MB12073.eurprd04.prod.outlook.com (2603:10a6:20b:73f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:03:07 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:03:07 +0000
From: Frank.Li@oss.nxp.com
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER),
	linux-kernel@vger.kernel.org (open list),
	linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] usb: musb: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 13:02:56 -0500
Message-ID: <20261102180300.3966399-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM0PR04MB12073:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3dc099-be05-4d09-fb9a-08df390b8c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|261102123227099003|261021121427099003|11063799006|56012099006|261009223027099003|261021123027099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oOyuuMTJLxUV1lbfBSM2IL4+tIiZ04+z4Y8awfNlbDzMeYiz3Krhv4fiePJ3VFfkh4uswTze86Be3DT064SsR3osH8cMYgRpuMmmwVs7r7J9ejY8Ry2r/umn/10VU00UkcVltnTZdeVVM1s2doFlWFnI2Tiju39FikcWlZPF5LQuIc5z3i8m0WXJ1KEBWq13KoTzp5fepxUaNCtiNA/l9JjHOg7/HuW9vHLlaBlHpPZzUAj+Zpd8bgmvxG1q2QCm+zQAbpoHXaakhPGRthLXQYa7e1MXRseAdajKPHKnXScc8dL8cJvVYRMj5grt7XFkZFXSS/oN9jkyUS5bIPWUgGr+G/EZeH4CFxM2XVxmt7TZGtOAdFgJONNt9RV3zf9Mq3Bh6KpMsvkjnqwSK2B0ksp/JclLDQRKDUH3s3VxdytdXi1ubxJ1JVMRTYqnT6j5fNatbHAAlYL9pkMDgmvHBZ8TPeEW9ejBiqBJ9DW4dzgedLbO+5pwMwMf3lep9N2AXbJor6QXINRq7QVEub2rOTRkznSpe9kwNNW6oTKf7fryBqWdaC0X27Dtv85q4SF/XOrsMmh9JQUsgvaq2Eh3sWu9Ro0QOSV1Uh7gODB8gtR7yYIVZWHc5YteN7YIDA02jrMkE2MaFoxDa/MAWNN93QVY2cmEppFX0wTDLYf0AvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLN78iXfG3IzAdNu6I3kNtqCGsLqea+9Z1plcpFmu3tneYk+EhxNEQCPh9B1?=
 =?us-ascii?Q?rKnA8OTV3Z/fLg6ftFMLw01W45dNSKsmyZcMM4LC13fOlwaljXFKWgZhgkEY?=
 =?us-ascii?Q?YOMme0vwZZhA6wvfO+qdorUxb2OqjY+c6nUYUwuOLpklIHyMolGYaU3Ua1Oq?=
 =?us-ascii?Q?UU7aRqZ/p3FUzzfPR/VmQS6UN2/mfAsVAhjgX0lop6Yt99HPjnlAbkLInHVC?=
 =?us-ascii?Q?ZfDd6ZGDkgR65Eqzzyh1NJlqkIj9HFCYkOud85Dt9qayaW8Rrnl9pY56/IHc?=
 =?us-ascii?Q?A6Aor/aJLTPhqrZw6ONOATvXOtd203gLoKmYbavZLzlWeugeiPFPXV24uFl0?=
 =?us-ascii?Q?TxJZEniQYo168hH17KtC+DY1/aPj3pGfClrXlAP+gJlDfE6je/z6aMaJ2SkQ?=
 =?us-ascii?Q?sXEw/9fs+/CxyMor172OAx3XkpMn/IdR09x1mvIWYiY65qX+ufZGb+eC0hBO?=
 =?us-ascii?Q?OI5WnuPho4h9hNoE+4872WhXDjRO6107wXSUCgDKs61FyXKdaX2RJtl6M2tz?=
 =?us-ascii?Q?QNueI0A5uIZwR8LN9IYD53f3GzgMCuHoMRqCRvGZMUyJBxFdWfJxFzNygYJm?=
 =?us-ascii?Q?ycQoforW03kPj9nuhYPAMkHwL35BeLMQdqnw5z+HREV1jEpo8EY/IeHo8AJn?=
 =?us-ascii?Q?X5yXb8HewXAy1IHla1WedUHu3Rg+nhBHFI858vDSKUr9aR8HT/ZsNr2zUgIw?=
 =?us-ascii?Q?RT4udbWg/qTluI9wa8WaY9ZP37C/nBbGlAd/T/+1oQ6nJdx6HCsj2nBm+noo?=
 =?us-ascii?Q?sAjES8ry+a4jSLjgdX1DFZwLm+vG9LIfwWuJzCL39j4pmH8kdDvJ8WkoM4P1?=
 =?us-ascii?Q?ZbpGAjnt9Hi51f2mTZIo0jMLTGoBXS2VIHI/DrgBUZnlDrz3xw3hZCbwYGMK?=
 =?us-ascii?Q?PzFCMPQuOuAAgDlFL7DO0E1ZZNc1TYRvLFfMG5TvP6xIAjkCUZ8dLGaQxaus?=
 =?us-ascii?Q?rGeLdc9lQ+IXlpDqSsUAdi7FkF3/Dommvkx7IxebApBsshScL0XCWiOUpB28?=
 =?us-ascii?Q?kEj3RRJERVqHF/MtypcWhrfOxWxVt5quxPyQiCs27wiw3hBVz/l2GK4VX3QH?=
 =?us-ascii?Q?VJruDbQx99F/cIqJJtxuQVppPo64Y5TK+KqdnKvDzOcQjkgTHmM+TQq2lrgq?=
 =?us-ascii?Q?Immb9ReW0PsgUyiGyC585DP/xOJ7O0f1Ak+Kw65Y0MvjQJmHM4hP2PBiATEx?=
 =?us-ascii?Q?r61zl0AypQbUnKybATDkYTCWo2L9bs5+nCwaxjjvVphED0UBEhfFnele1aJk?=
 =?us-ascii?Q?uwbxAzGUfeSlRz81AXMfh6HpNDa1kqwEPZIUY9yFW9OcRWgYy9pnto308Kfj?=
 =?us-ascii?Q?9u6Q3T8zJRZGEJ39oqLjDd4OtCb8m85GeJRYxnVt2GIivZl6fowYiNF2LB1C?=
 =?us-ascii?Q?9zsgcfKlzRd6eQMFyZ4wTSajhcWW1YQ+CRWBiZIz11KfN2MX71fha/b7h/t6?=
 =?us-ascii?Q?fwvXX5VP3LXSsiLxapPQBSNDLpe5QKnAxR9dU0b+EU2d7kJtZz9WIDc4X+/f?=
 =?us-ascii?Q?8obTAmZXk7fIumAfe17mgFmp4wx+LQ6Xmrv54iBAaRP2TdqC3VMx8N/4NawJ?=
 =?us-ascii?Q?jXhAZY9/GJeNpzjWJNdGVVsy7r9yTbFvX+L81Ph3svqUoCjJLXFWRh5GUEM3?=
 =?us-ascii?Q?tWT0Jn3ublxZxSoEDHkR3MQU5OZxof2Qx2HfOVy0hIFFTeTE3wUXJOhh0UAl?=
 =?us-ascii?Q?wjZ2h9+ckL7jizYG0lPKhPBgkYddL8Vg+64rfWYmC5N1g6bxBETvFd3z1r3l?=
 =?us-ascii?Q?+aME9r4qj9hMqc3p4C58uPXj+jr3IZQHzfw+2shmlRbmQwpGZMvG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3dc099-be05-4d09-fb9a-08df390b8c62
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:03:07.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8Be/7CtGRYVyRB8sNjRyGG61yhH58iHcevKX+Z3EgFALKLD5ZNio/OkXZOynqMadWtU8oN5Y/8QegpnF+TbEWVjC9V4S7XPL8CL/lXfIxgvoQA5BQKkYOy6jLOhPOUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12073

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback, callback_result, and
callback_param fields of struct dma_async_tx_descriptor with calls
to the dmaengine_desc_set_callback() helper.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/musb/musb_cppi41.c   | 7 +++----
 drivers/usb/musb/tusb6010_omap.c | 3 +--
 drivers/usb/musb/ux500_dma.c     | 3 +--
 drivers/usb/renesas_usbhs/fifo.c | 3 +--
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 28e958fcc862c..dd77e7aba77ed 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -167,8 +167,8 @@ static void cppi41_trans_done(struct cppi41_dma_channel *cppi41_channel)
 		if (WARN_ON(!dma_desc))
 			return;
 
-		dma_desc->callback_result = cppi41_dma_callback;
-		dma_desc->callback_param = &cppi41_channel->channel;
+		dmaengine_desc_set_callback(dma_desc, NULL, cppi41_dma_callback,
+					    &cppi41_channel->channel);
 		cppi41_channel->cookie = dma_desc->tx_submit(dma_desc);
 		trace_musb_cppi41_cont(cppi41_channel);
 		dma_async_issue_pending(dc);
@@ -467,8 +467,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 	if (!dma_desc)
 		return false;
 
-	dma_desc->callback_result = cppi41_dma_callback;
-	dma_desc->callback_param = channel;
+	dmaengine_desc_set_callback(dma_desc, NULL, cppi41_dma_callback, channel);
 	cppi41_channel->cookie = dma_desc->tx_submit(dma_desc);
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
index bbb4978c0cd5f..378fb57358b58 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -116,8 +116,7 @@ static bool ux500_configure_channel(struct dma_channel *channel,
 	if (!dma_desc)
 		return false;
 
-	dma_desc->callback = ux500_dma_callback;
-	dma_desc->callback_param = channel;
+	dmaengine_desc_set_callback(dma_desc, ux500_dma_callback, NULL, channel);
 	ux500_channel->cookie = dma_desc->tx_submit(dma_desc);
 
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

