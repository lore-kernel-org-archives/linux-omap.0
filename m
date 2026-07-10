Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A8416132;
	Fri, 10 Jul 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681813; cv=fail; b=cZXPanI0pEKYiQPx67o4RYTkSXKvsrsQ+0B3je2X+Qf7WJz8GzGbEM1LGsxTZGd9J1fc4IcREuSRwiYU4SmEmnxZr8Esn0KL2XRA+4r6HzfJGYAIcx7XP3+Wy9nrk23BVf1fT1Axj5XS1W3n9GzBe4Uq97MCuyoRRRYf4KhTbPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681813; c=relaxed/simple;
	bh=Ncnu1/diBTLO4XzZYNd3A60lp64auzefVrFCS2v0Hv0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDZKU1rU4Kj0ocNWRxtAO/qGwYXdg8Gzbw10F/tou/FhtnxgIOxd5tvkP2/fRmurbyhB8SeUYGTRHJc8vhNGJ8+qMopgTmmFclpWTgGCtMbA3IEQmMqOwMu+tvg2ITEuKLAuxov/j1oB1NlGY4XA6fb4lP0L7aCDDMaSUeE+hM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mieZCpLB; arc=fail smtp.client-ip=40.107.44.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mieZCpLB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAIjKZa7Cck45DZym827vBlDxIMR0QFcK/rJV8H0cHyd98iwhRSg+hxlYz7h6iYOSU2NtUXX/yWSCjdeShpfeYNxsE006yUpd9i/UOvlWe9ihVT3yd4zQvIfUf7aS+l9J7TxvmWSmqifnIy+H20Af1MaQTF97lQ8cCU1xuHvpD+rQK/WMglEYGTnZmqDukikp1BEwbW+IfaUkO+iFAnzs4wmO9vQ+TC7abO+RagN080sDLbsAsS/068XlhcVdevyk3TJRzVTAXgTq7/E2+4p2q5YBRxnUybz+EIbAJPHHTXM3etwA4hEJzNeIaJwbGXP53U1omBcxJ5cFI1nT7gOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ZNrYoBpp6PqzGGZMPCTkRg5ncfDmHXtOe1BAsDtp8=;
 b=PeZ82r05LShH+odVrtfUkYIc8v/pUvpc7REz9PxRxLU9IpTglKUhUa4nt84s0WbhOl3rgMHdMZZ8GmrsstkvKr7N5fTg/nYe/hew8yyWRLSQyHwEPiWm/2soY1siJLZIN1AIkZ9YC8eL0MgTFrlTkhQg1xdG7LnAY9csIrLLLxizGcochL0x+ukecKv4dR37gWKy4yz4j5ENFQpi5lGbhFpQefQsb9CR6mmD9Hwhl7Xgu2nIxeJTFnyhdMNPgJ4QajLGVPZzERz4REO2Q86l0eln0Aho2Np9wbmcr3d1HS8ibkLO+wPb09ANNtqHQvM6ZrwPcx429uS/76sOxlRENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZNrYoBpp6PqzGGZMPCTkRg5ncfDmHXtOe1BAsDtp8=;
 b=mieZCpLB3xb2kUzDvyqjcmQO5djo3pJowYawH4FmFvfQVNpyFDa8sPe+PJ2/dt5V2Qp+76mr/hBcEw3hIEbEj87+unxt83oIx+hnunyN+hq61OM5BL6I3CxSln2WIp3aBVgkAp515qe1Z2YwILn9AOiiGAapI8yENZAWU6/vFNmJwdePtTWaWBBjkqDOgasOYF+wcYJlebdv1g1yN4NbW7p+SJTWkLd9k6KtMnFlLR5pNVkxFRcJPZBl4s5StDEHz0MAmZqp7ljbqJJy3A+V6hE0xTzkrm8hjhgdca8AjV0RHrwsLdgRX2901I4Ymahf5F3loDbpBbvfqQSYkS5L4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9021.apcprd06.prod.outlook.com (2603:1096:101:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:10:09 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:10:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	linux-omap@vger.kernel.org (open list:OMAP2+ SUPPORT),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH 2/2] bus: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 10 Jul 2026 19:09:27 +0800
Message-Id: <20260710110930.462109-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710110930.462109-1-panchuang@vivo.com>
References: <20260710110930.462109-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 063516a6-7924-4705-789d-08dede73cdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	YJq6E7BMR3QzF0wE2XD23KWRJMxw7b326h4DYbcIfQ7W7d5N5cAPNNmewLoAMqXdAHA4FUeFJjGzPXBKyFVAbRLSp9tOQqflGuPkPmyfzp8RFZFrVJ/rJzBdWrgWUEMXxNg29tXF0xeBvpxp4BPdrVmVXIajXdlzXjoNBxK3L3odRuXHCMXwqOE6RCWJEeXBAwXK3nJ4bizG+QRyQWR262RESfiHnPvui79MGC18tiUmnnMNGqQ1NLvX0pmJtxgPJnxVI6Wtn74ZNfuxkImMCoG9WxxfCyATBzqcGMHpg8LBxB6LIH5ryL6Y+PLTM6IQ52Gc9jG6dPDeCTNmc2xlt5SXnwrMVLpfIfRZLA4gkTKZp2bvYBe3s+w1VzHR7GJI+YwIcsJWjzRFZBWnccA38A7U7p/BftTnyS1gXoU41nf4ri4C/BJr7AIIUsVdU1iSUKMBhy1iIqpKw1+JBuuwYR0itZRnPDJZWoNFFp3sVdm99MNl9wU332GitUTvgbREh9r4JFIz4Q2C8S6Q9wJGjuxPcFk/f/iL57FF16GTQi2Vv3t/yeMFszucdxHejLfT/PgrAY/dLOuTSadqOyNmi3j0sa6ak3OU0fBF241JIMXonAsR68KcmghEW5hj7Dzt7/dnapEx+8PdNJ2lcZPpiC2xUnK0jNZNkdBEcDjnR03IZIKAUlYX8bG3Tz5YIOSX7NPYDBhylyCVbxd28g31OPdftYYk9wTxvUF4U7g/llV8XEm8fryTIejP4xjsphug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0od0GsgaYS1WavGJNnl16aOp3zoyDBXX6TXQy2eDsbxHxJw4/H9eDzZjFzH?=
 =?us-ascii?Q?J3Yoi5kUv8HtcWYLqhDxdEFIVypZXlgNiAusBVx89QnXu3cKhV/0xAs5vQh0?=
 =?us-ascii?Q?XtlyJgRMPyDp2uhVaNFLyKlK2Q49QJCDrNjIIEmngTzpeFXl64FgpzsYc5sk?=
 =?us-ascii?Q?adokWh+2nRhIHRBmRqcf9bU6Vl2Kah0CQfZiBraP+01UrcSBmLBjn1G9fhL0?=
 =?us-ascii?Q?eWuZ4vLCTk7BPe3zzIwCGe2M6QGuq+yEE9xMfDLjygAGMBiFIU0+lgqsKEyW?=
 =?us-ascii?Q?mgB0yBUfu8RWFb/raBHaUMz1rpedYYzuq8jwign7WBXBSYEIWT+N+BMvEMMp?=
 =?us-ascii?Q?n0IZV1eZCfNaZybQxT9sR9v90EYRAnSQPkQfxCbFZwR60k/JlSXPhMWTfk9M?=
 =?us-ascii?Q?3hKhGzPBGdTaDeCk2oo+Ca0Szc82YC/y3UHHdLnLMU4D2IbSskfp4ZwqRNJB?=
 =?us-ascii?Q?uOTrh6ZY6eJ51VrOusyR21FuhQKi8dFbE9FUeYIHGXA1qYUYagzLsep36ciI?=
 =?us-ascii?Q?ewjxq3hl9/8bfUYKpTlxXlqHinGZc6UN53/gIhGc7dTWkCbz644plCclwJFQ?=
 =?us-ascii?Q?7zyG1rp2suwURYcBGfevK6Kt5oMHZQdv6xx35j7Nz1E4G9LGGu2mcju2WiKl?=
 =?us-ascii?Q?dKsKxSkIgaNRZs7hVCYIVNYISloA2Y5sYilBXsOSmd40jTsruTc1guE3KI5A?=
 =?us-ascii?Q?qyDp/s4DHr9DPk9tHWnQgcb5HoyuK26FWHQOPvmhhHUEL5iy8uZziX56585A?=
 =?us-ascii?Q?N/+054oBvktbvlJRD/rnLTlthJMUYSlyRZPLxJgxkl0pmnWzwC7AgCJItga+?=
 =?us-ascii?Q?UgS2eQ0doaLfbVP1VM05N6E6gAqe5vd+YpiEKy63zS6vu9Sa9tjMkj0QxXIl?=
 =?us-ascii?Q?iR9NqvvOXGtaj1YAOd4l0ozzytz7/DdwUg5AbpuXg7GlMBbQxfiCvDIBx4oI?=
 =?us-ascii?Q?OXUYongbeMBQ0D70JrCF0w/wfs4sduGOOxpvM3y7BGrbVon3SoEgb4JExtoA?=
 =?us-ascii?Q?EL1rY5T6BDGxgyxt3/ZOxTAYAYyrAuhQo1kAnHk7bzUiAKq58/0YDUPK2tBJ?=
 =?us-ascii?Q?blR72+YRY1VDfFW16u0en2Sxm22r1ZyisgnC9AYhUCCn2iaXkA0bzg00wa+C?=
 =?us-ascii?Q?tv9Bn3o6ojT+Sf5XVk4wURO0exntAOl09LLIdElGkqoQBYi7wveBK+HROtGy?=
 =?us-ascii?Q?VJqDxkl2QZCUPnvM+PmSf4juO6pNfjWEVUQ0tToDa0Y1+v/ZKuEnJXX+KtQM?=
 =?us-ascii?Q?AsMDrrddM9i3UNIZzOWgEo6uuqkRLeZr2fUQy4hl+PVlYqGuwb3yW8MFTxje?=
 =?us-ascii?Q?3NJRZbF+Ygp0Z9NEEmOn/Zqnp2+7r+U5VmmQNvsa/iL+dO6HQTswBM/5/b5C?=
 =?us-ascii?Q?DXBBlnmoweSteqhZel0fD+/oLe1xh8PYr1MpXDNuWkp7nTQN74PkPZAJnYh/?=
 =?us-ascii?Q?5b84sK+suFVxKSSJUlsYoWCzq5dRA8RJHyuxw3cZPpK72H1MALQRh3nR4A2P?=
 =?us-ascii?Q?C2FNTXq3RnnKCt7bfLNiOShNjWaIhYJbkKN7UY3bPO2oHg7TIC7OyjD4s3/P?=
 =?us-ascii?Q?kD4lkS5Z8fywtOwvkYtZJncD5OFmmXQjYpVRzy2vScejLRxwGSuqz3wNt6y+?=
 =?us-ascii?Q?G3sNDTCZYFiXJYkAQvRtKKswABPIb2Ti7LcHzcsmPvjDApDLV+XFJ906sJ/q?=
 =?us-ascii?Q?/BwWbslhCoLDzxkZxBhI7D6iNcoKLEXk5dpXbxvEMcrAcrt6bXvMIINbssXk?=
 =?us-ascii?Q?pZbWSgNspA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063516a6-7924-4705-789d-08dede73cdb3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:10:08.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MRQm/DdpGmPHT28IAxwyawJgKaE4pV9egcjX55zCbzwIFXhpNijqrckKhx3IYchHx2qlZXV6PlNz7OMG/fD+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9021

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/bus/omap_l3_noc.c | 7 +------
 drivers/bus/sunxi-rsb.c   | 3 +--
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index eb1ba6319fda..45f3f793976c 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -278,17 +278,12 @@ static int omap_l3_probe(struct platform_device *pdev)
 	l3->debug_irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(l3->dev, l3->debug_irq, l3_interrupt_handler,
 			       IRQF_NO_THREAD, "l3-dbg-irq", l3);
-	if (ret) {
-		dev_err(l3->dev, "request_irq failed for %d\n",
-			l3->debug_irq);
+	if (ret)
 		return ret;
-	}
 
 	l3->app_irq = platform_get_irq(pdev, 1);
 	ret = devm_request_irq(l3->dev, l3->app_irq, l3_interrupt_handler,
 			       IRQF_NO_THREAD, "l3-app-irq", l3);
-	if (ret)
-		dev_err(l3->dev, "request_irq failed for %d\n", l3->app_irq);
 
 	return ret;
 }
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index daf0ea563e47..671c9b33e783 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -787,8 +787,7 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, sunxi_rsb_irq, 0, RSB_CTRL_NAME, rsb);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "can't register interrupt handler irq %d\n", irq);
+		return ret;
 
 	ret = sunxi_rsb_hw_init(rsb);
 	if (ret)
-- 
2.34.1

