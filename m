Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.159.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793032754;
	b=tWWDcihVGJku5e/yIVfbw9102CLgkbPCDM71/uWUXQ5lytM3j94k+MIweThrdG6+wBrg
	 L8AdXA3yUhrsb/VAKSWH0TDCdD2+5y2uvzH6JIYMdqS7MEG8TLUV7o6SP1DWlSikxbtRf
	 Vjd/SXa2eW7ZeZj/BI+p2ZOoFbbxYtPcqLk+aXQKjFfN49we658S8lNDYev37v1K1tVW3
	 y9XsTYYcwEj2/+IpA5sCvAlA6bstdmhMuiB+3icCHlmklwiE9S7a5rOSl0EvYscb4wlK9
	 0OGZugg0ZENELVd77VPdV3chXh8AQsPvawyrJr4fq6ATvlpmtHEatXPW8tb7r3Nsgag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032754;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9PKdJ3OQLSbF2lvSnCOsCqkcmUMhO1Ixl9R/fYdUR4Q=;
	b=zXy8gpCE1aKaeE8p/lQ0677a/hh+0udCWEqQNq17hJg9k6WN8VVfgrZxDhO+HJ6qdrNp
	 5oeQ4ToJaSzLvsAe+Dblw0TqDkhM7jp7GGV2ae63y0PBKNWgAVGZN47JxMHusHNnYuy43
	 i/VLrlv4+Zhzm0UXw7URmmKO8W6cIgdhBCfSCc5JjLbykQsZ1zogrX7IId07Ka7eGCDMK
	 Mq5KouH4Bv9rNiOimP/mTW535vmdlzH3Xb+As3Mi97zFQu0T/piDv7xuoFk/ulMWq4QfK
	 MMWSpbuvjNjJ3xVhCPruAUQtjJxzusbBG5P9RLgrnu9gCvZFpYZoIPwGmoXDufW2ALw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=fail reason="signature verification failed" header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PhMPCZKC;
	arc=fail smtp.remote-ip=40.107.159.69
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C91606A31A;
	Mon, 26 Oct 2026 16:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PhMPCZKC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnC5XS55QxBVUtdyD1OT/KgJyw9TppX3QWL9Ftwlx/N1JAwFysbaebzNGZ9WdQ8R2mHgzk0UDO7U+L4AnqBVX8QVolfU72N+Q0ad1GDs5jOqiayuW/kjh1QOqStNFJfrYaM1ImIPLVH5nXB6m7l5Q2SNS9KJJhbhqKe9m82XxZ9rAaDjV5wY8mrvvNhHCM1FnfaHPmaroTpyeprbFa3qXOHgiJX6hiC0SHg1FPIK1MHW4mq4Tq09F5g7DBGnKw0TGjpOoONgNu9YOu1MEXxnag5bfQzuZkL3JPWNOUcN3s+otjkzhPMx5dJajw0OU44NQs6J++TG84CviuZzdIvK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxZSarhcF7uEiNtUsNT1QpnEdNvxeem7zxUA/WOdbWE=;
 b=rpc1nKvch8rcOjh1h2BcHMxJ4ZUcyu+k3kaMRb00VlhR3wL1URaQn+USzjkotm+9aI9A1Rp+JkkKjDckdox1GiV4IoRvbtSCvjVTbxXYOTtzRkWda7u0V7eihALDdNS33ldi+Rk0Io/oNKxVvEEdCL+ywESvZ5rjYCY5Q0fm50HV4HWd5iR0QFCOT1AhCrR4qoDaHA2zSBkZ2NTic8QFcGitNsRpJiuA6vdqW1lb8Kwkw8CdIxi997kKQS/uDY408OTUyjh7QO6aimCy68lVKkf6P1nQH0WqqqtCHYMV5yWlohPe3YDxWSSoyUHblTyDfQW9b2pGihHkew4YkyvIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxZSarhcF7uEiNtUsNT1QpnEdNvxeem7zxUA/WOdbWE=;
 b=PhMPCZKCP6PZrQ17OMhfDwq7/A7gcsAP9FRIOn9wgzSIXgOanVxtjukfYvA5QHYYFbee8W+yA7un5erkdcMMzU5QZxy4/8wkQZsX5cYalrwHeJvfgXbJ8GaKerWd8ibRPxHNz2YuT75w14v+coBm0SIz/JqoDKlqBv2jZ0aBgBmBkNona1wKvmf0Kr/pm4zSyXItmDT+aXC3QBW2KIgSS9YRnPZJemXobo788GO3k1f5qRG/fY/7WHvtmqChdslRDU0JMfwfmve1HGOAWu6+hWBmRDkmlqJc/IdN8RRRvkwcNILgHW6GeKWNFL4x6uaXNgoAxNgb15BtPv1nHAGhdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB10140.eurprd04.prod.outlook.com (2603:10a6:800:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:39:06 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:39:06 +0000
Date: Mon, 26 Oct 2026 11:38:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yang Shen <shenyang39@huawei.com>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 00/22] gpio: Improvements around device-id arrays
Message-ID: <at-CGVq5jVsMQief@SMW015318>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: DS1PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:8:233::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB10140:EE_
X-MS-Office365-Filtering-Correlation-Id: cc32ed66-1b3c-496b-47e1-08df337fa6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|19092799006|366016|261026140227099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|5023799004|261009223027099003|261022075727099003|261021121427099003|261022105027099003|10067099003|261026121527099003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	TzsjTWC9ZLj+LVZmfIQKqr/h8gO8GiStteVQR5dMSF572EQcie+0+dkxU84Myl8P2ZEOSvfzB905POP9L7qs6y42KOMKNp1xAvfqJScgIyDlLSr/EZpaa9oywDXf38LsLoX8XxBO5FQ5bdco1XrhnMNfODeAXzmUIxfoHcSieUlhg4DkifiD7RSfOl0N0LTFM4EFt/q/eVDw4OV02DqVo9YyuvKLfaTg5ZhodOCJiGut5zxJ3ioAkwc8+En6KRG1sHIf0cr7g5bz82TC9ZsaorqlvTTG4obVs0JXpVfDgiWkFNSS3ezjFb++WrI3n8T37V6UaZdBZFm0ZvvStM5RLmF1p/JRcr2mr8EbTf7GnAe7UfDijfB7o1iuawpPAxDwqB86TAjrTDiRo5Y6f++g38S6Y/2y6tDrPHyKKWJ7NLncNy+fbykywyufoSyibicOU5JyhLy1lRRR2B8/LHH5QKYLoU3r6ljllXBXa3+MpzKFFaycB9QFtcnGJZ3cSxkt8gDR7uoZwJQZZ5WfCnsbpsiP18WQp0wtWBnvKmAuFzp88NSFSv3fQoswfeJdegBljE6MfhBlDyYxFu4SSAAnKzdPa4KqfNk243Al89wFMwW+CG/alF3X0ZH3KxWEkhksuXkuoT2rkg5xs7JFbAxSKxkt8vTNhZd6uqJhijf/KFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(19092799006)(366016)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261022075727099003)(261021121427099003)(261022105027099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kOxvwXleufIgI4BGstiJTXJoW7NhnFnGxjKALhwVd5w8ceBRLFqiAyEfy4?=
 =?iso-8859-1?Q?ZXi5r/f+v1+d7+sQUlkQYraFq4zBBxLaYjwgV0e1S4QtdAls4SnsADGX81?=
 =?iso-8859-1?Q?FV8G7Ylu+ODVWbkCHflkS/i6LZ5IoNuY3SeF88uC3H5EdezkW36tBMgNF0?=
 =?iso-8859-1?Q?TzKtPwel++0KIdTzH4Yzcew0sTaq3DwWxfT7doua+nQyWZ4iJzZAZw0BDy?=
 =?iso-8859-1?Q?5cxdxeOBjmDaYIWKSiuancWxofOPuKnor4skwYjFcI/vQRR2nSGIomoiJt?=
 =?iso-8859-1?Q?8mlOEITVC9N9t2C1nR7iPLIHJEI12mtuveYg0OOsBNPYwCPdaOvmmh5TDh?=
 =?iso-8859-1?Q?zp1eNAfX88IySSQTSOQ3Tt8PhoWnZXdbjcBEUejQnN6WgFKbUss0NoGI73?=
 =?iso-8859-1?Q?33TcJaPjgPdia6eyEzjYlI/pzW+F0Yen8oNq1TnBCdJZIXkZyTjU+bt1CM?=
 =?iso-8859-1?Q?Q3igtlMgnrz6z8DZjOiXL08W+gYZGfQzkN8S8aCzxPKpJoTYnkxlugSALG?=
 =?iso-8859-1?Q?BGPYjcAkwHO/dJqaAb0pOwqJQhUerKnfzmIC086LNIkD7Rap1cfsk+R7R9?=
 =?iso-8859-1?Q?mZwo+9zjB7/lTRd4ePKduwevLJvCaIc43MthnZvsbjbboiQWqGTfklJ//I?=
 =?iso-8859-1?Q?wecdzNgLaU94daPwLWOTj01KDvtJ2mUunpBO2Md+ZtyuryMBPL6/KOXF1e?=
 =?iso-8859-1?Q?oF1nSsDkJsA3Fr4D6AK9gAo7A+2LVpyI9Fc2aPpqo0oorkTRmXUXkO3iwb?=
 =?iso-8859-1?Q?23X4LW8wtX8KjxVw7tgIJ8dEYzL+4mg5dD82cdUS5STCvqgFzmEPwAYBM/?=
 =?iso-8859-1?Q?S/C1uvZmn6XKNcdgQBeBQZEOT1bcabb9KpQzFkJQETZbfchrxlvm99X/cZ?=
 =?iso-8859-1?Q?wwSnUhRo1TvD3Jqds0HVqfm1sDqVIheorLBAy/CwqtAJUv11q3NR5ufFYi?=
 =?iso-8859-1?Q?AgTKPtL8fF+nf3x+cRnAM10Cgdy6vjhUxvwHmWVKdz3zgJZgGAJFDURCFX?=
 =?iso-8859-1?Q?pdH5NTh2dkn7ztqePhlEs56Rf4dnh9ppluxc9fDDXa9bwJhlPXNf8vg8dp?=
 =?iso-8859-1?Q?M5s2LjTZ/kU+etUNXcqSh2+LYkWKJWowREJhVnugq1ATreJIOrkNhyYvo7?=
 =?iso-8859-1?Q?gWEHpi0cEcZ2Vrh7Zqvl/fa/lXDAF5CQQps5EZNJWLuzcTKR6Z+eo4R1us?=
 =?iso-8859-1?Q?mUzK5kA1dkVRz29aihUjxNFqgCCHeP0t7Yu6VCLACZS8fyAVMwnSMg/eOk?=
 =?iso-8859-1?Q?p19Nvn3DuNZrxixBw3VNk4Hx9IUcI3YagaYGx2tXQbilhZgsyz7FLOEwls?=
 =?iso-8859-1?Q?7vCAzW/Mqt6+5a4tjCGF+3Gsfy3PROC5GQ2DRi4aRwOJGaiQbFsCOAmJY2?=
 =?iso-8859-1?Q?D8YdS28x5GQD6g7N/+SQNDJTgOiR8NYXh24r+QQYC2I66oOXaNuGQDsU61?=
 =?iso-8859-1?Q?V//UNVD/u926Kp1F0tiobI3sjdYVr3yh/CvtVq1qdSd5gkTiHTNjgcqe0B?=
 =?iso-8859-1?Q?jzsAed7oCQI7hPZYgsCJcj/mFFYpEonh62VDtwAK25uF6nvIBnimMQM1Ht?=
 =?iso-8859-1?Q?hFSJpsuv4T73CoCCHB518q5xfVoBQLF2JyjHKzdCgMTP+UR+A2VEHo1W94?=
 =?iso-8859-1?Q?ZbnMVGtgKUd0FapU49yylpY48gmK/VeymrJfSQt/9d+zDIp85EJo8Q77fS?=
 =?iso-8859-1?Q?Et05YtXGiRkJ4QYCBfZHPr+panf9jYjJYht7lImY16F7nBEOYSz8/LNf4K?=
 =?iso-8859-1?Q?xcPRuuxNrHMXEtKg9DW+W+ys/NkiF56KezHwzM9CZm1MQbQYc+thlZGFme?=
 =?iso-8859-1?Q?0X3muI+J5uzt9XSVh6ZaRkekYLTGDgc7v07wSjKhFPZJi/TOwsn8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc32ed66-1b3c-496b-47e1-08df337fa6df
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:39:06.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sZRTz0pVhFlSF7EBVyQ+dtCHOlp//kUVETNITxzHc+vCv1CCg0ehPm3leCM5D+UYUddqkWOot6igMD9LV/kAZaFgwYP/nx3hhdmAbPYpJniEz6DJle+GpjlcQoTee3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10140

On Mon, Oct 26, 2026 at 05:28:11PM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
>
> as with v1 and v2 the original motivation for this series are the
> patches that convert the arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Then by not closing the eyes for small issues
> spotted while working on that, this series grew a bit.
>
> Changes since v2 (available at
> https://lore.kernel.org/all/cover.1784133987.git.u.kleine-koenig@baylibre.com/)
>
>  - Rebase to current next/master (new changes to
>    drivers/gpio/gpio-mlxbf.c, drivers/gpio/gpio-mlxbf2.c,
>    drivers/gpio/gpio-74x164.c)
>  - Fix a few commit logs to reference the right *_device_id names
>  - Drop all tags for Andy
>  - Drop a questionable MODULE_DEVICE_TABLE(acpi, ...) for drivers/gpio/gpio-usbio.c
>
> Checkpatch only reports two undocumented device-tree compatibles:
>
> 	WARNING: DT compatible string "apm,xgene-gpio-v2" appears un-documented -- check ./Documentation/devicetree/bindings/
> 	WARNING: DT compatible string "marvell,pxa1928-gpio" appears un-documented -- check ./Documentation/devicetree/bindings/
>
> I felt free to ignore these as this is a pre-existing issue and
> out-of-context for this series.
>
> Andy didn't like how this series is split into patches before, I do. I
> think it's not possible to please everyone's opinion regarding minimal
> changes per patch vs grouping similar changes in patches and about what
> is considered churn. I'm happy about every patch in this series that
> goes in, so feel free to apply patches that you like and that don't get
> resistance even if other's do. If patches don't apply, just drop them,
> I'll catch up on them eventually.
>
> Best regards
> Uwe
>
> Uwe Kleine-König (The Capable Hub) (22):
>   gpio: Remove __maybe_unused annotations from acpi_device_id arrays
>   gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
>     array
>   gpio: Drop unused assignment of acpi_device_id driver data
>   gpio: max7301: Drop unused assignment of spi_device_id driver data
>   gpio: mmio: Drop unused assignment of platform_device_id driver data
>   gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
>   gpio: xgene: Add missing ACPI module annotation
>   gpio: sodaville: Add missing PCI module annotations
>   gpio: Add missing OF module annotations
>   gpio: pxa: Add missing platform module annotations
>   gpio: pl061: Use empty initializer for amba_id terminator
>   gpio: Use named initializers for acpi_device_id array
>   gpio: pcf857x: Use named initializers for of_device_id array
>   gpio: bd73800: Use named initializers for platform_device_id array
>   gpio: Use named initializers for spi_device_id array
>   gpio: virtio: Use a named initializer for virtio_device_id array
>   gpio: Unify style of acpi_device_id arrays
>   gpio: Unify style of of_device_id arrays
>   gpio: max77620: Unify style of platform_device_id array
>   gpio: Unify style of spi_device_id arrays
>   gpio: Unify style of pci_device_id arrays
>   gpio: Unify style of various *_device_id arrays
>
>  drivers/gpio/gpio-74x164.c          |  4 ++--
>  drivers/gpio/gpio-adnp.c            |  4 ++--
>  drivers/gpio/gpio-aggregator.c      |  2 +-
>  drivers/gpio/gpio-altera-a10sr.c    |  2 +-
>  drivers/gpio/gpio-altera.c          |  4 ++--
>  drivers/gpio/gpio-amd8111.c         |  2 +-
>  drivers/gpio/gpio-amdpt.c           |  8 ++++----
>  drivers/gpio/gpio-aspeed-sgpio.c    | 10 ++++-----
>  drivers/gpio/gpio-aspeed.c          | 10 ++++-----
>  drivers/gpio/gpio-ath79.c           |  2 +-
>  drivers/gpio/gpio-bcm-kona.c        |  1 +
>  drivers/gpio/gpio-bd73800.c         |  4 ++--
>  drivers/gpio/gpio-blzp1600.c        |  4 ++--
>  drivers/gpio/gpio-brcmstb.c         |  2 +-
>  drivers/gpio/gpio-bt8xx.c           |  2 +-
>  drivers/gpio/gpio-cadence.c         |  6 +++---
>  drivers/gpio/gpio-creg-snps.c       |  5 +++--
>  drivers/gpio/gpio-davinci.c         |  8 ++++----
>  drivers/gpio/gpio-dwapb.c           | 14 ++++++-------
>  drivers/gpio/gpio-em.c              |  4 ++--
>  drivers/gpio/gpio-ep93xx.c          |  1 +
>  drivers/gpio/gpio-ftgpio010.c       |  3 ++-
>  drivers/gpio/gpio-fxl6408.c         |  2 +-
>  drivers/gpio/gpio-graniterapids.c   |  4 ++--
>  drivers/gpio/gpio-grgpio.c          |  2 +-
>  drivers/gpio/gpio-gw-pld.c          |  4 ++--
>  drivers/gpio/gpio-hisi.c            |  6 +++---
>  drivers/gpio/gpio-hlwd.c            |  4 ++--
>  drivers/gpio/gpio-imx-scu.c         |  1 +
>  drivers/gpio/gpio-ixp4xx.c          |  4 ++--
>  drivers/gpio/gpio-ljca.c            |  4 ++--
>  drivers/gpio/gpio-loongson-64bit.c  |  4 ++--
>  drivers/gpio/gpio-lp3943.c          |  2 +-
>  drivers/gpio/gpio-lpc32xx.c         |  4 ++--
>  drivers/gpio/gpio-macsmc.c          |  4 ++--
>  drivers/gpio/gpio-max3191x.c        | 12 +++++------
>  drivers/gpio/gpio-max7301.c         |  2 +-
>  drivers/gpio/gpio-max7360.c         |  8 ++++----
>  drivers/gpio/gpio-max77620.c        |  4 ++--
>  drivers/gpio/gpio-max77759.c        |  2 +-
>  drivers/gpio/gpio-mb86s7x.c         |  2 +-
>  drivers/gpio/gpio-ml-ioh.c          |  2 +-
>  drivers/gpio/gpio-mlxbf.c           |  6 +++---
>  drivers/gpio/gpio-mlxbf2.c          |  6 +++---
>  drivers/gpio/gpio-mlxbf3.c          |  4 ++--
>  drivers/gpio/gpio-mm-lantiq.c       |  2 +-
>  drivers/gpio/gpio-mmio.c            |  3 +--
>  drivers/gpio/gpio-mockup.c          |  4 ++--
>  drivers/gpio/gpio-moxtet.c          |  4 ++--
>  drivers/gpio/gpio-mpc5200.c         |  9 ++++----
>  drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++-----------
>  drivers/gpio/gpio-mpfs.c            |  1 +
>  drivers/gpio/gpio-mpsse.c           |  3 +--
>  drivers/gpio/gpio-msc313.c          |  1 +
>  drivers/gpio/gpio-mt7621.c          |  2 +-
>  drivers/gpio/gpio-mvebu.c           | 13 ++++++------
>  drivers/gpio/gpio-mxc.c             |  2 +-
>  drivers/gpio/gpio-mxs.c             |  4 ++--

For all imx part:

Acked-by: Frank Li <Frank.Li@nxp.com>
