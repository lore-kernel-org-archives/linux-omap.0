Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792238;
	b=aOdN48xcUyD8YAhFuXsvVKSC51WeR+C8hcJRj+sXb0frY4rALFLxW97ClxKNRQWsAYy5
	 1U1RAaSlLXSlUtuhJu3tvfzgHY1V1rDbXRB6M7fjLJ45affjBWzijTptdVq7lNSOVSJDL
	 e8ItrefA7DGZttmkXeTkto5+W0Ogn+1b0bjADZ0AFDcRWIp4sD4DTKYFMhspILuxvSZzF
	 2CSIgYHBJWH7kHE9M87gDZtYLI8FLToXz1BZeY0GEHlQfsxgjIQ6A32AcHg4hZi6/Z0S/
	 vBUaPURaDd1/O7UU5nohifztWprG5HvxNOCASt+jWIEHssrJEtr2lyiLllSJR8zuzPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792238;
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
	bh=LFH7gsM6hB49EpgMrwzu6ChfzNsOO+s+lYp+Wy8rFEQ=;
	b=yt+C0V+LwDmndL2tayVU3LhWIBjuWxDqRnzRXLLhbgmVf8C5cE/IhzdXT4E1Cwpf13FA
	 9fIM+pPvqGDAZ/leFVJqDk+GUWV98e/LowqaYzIX/aUKiGS4usRFDhGUa+EzDpAdLnAp7
	 pCX4C5fx9if5ZDVIbQ9zWUMxfgWrviBLF0N/l0ez73jdCJN1E4SwGPhRgueMH/PoYPD9x
	 T7MTqmm4gXANI0c9KERIs4cQ5675HetLnjg8QOvpmQ0n3ezJQNkfrIIfhjq2e434iGvMv
	 Xanr/Mj88L5aAXbSiX4zUrrFdSbXrmJnhbhzZ2XmEyeWjJrxOE7iGOgIoboOryk3cQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SZHJFGhP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.55
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC7606D818;
	Wed,  4 Nov 2026 11:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEFC7606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SZHJFGhP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVgQlB7HrMsQVoocw7vax7Hnm9y8JvWRT4nTl5K5C37CDuPkssBbIg55ukktvw+J6R4kbcAuN5j78PkUm6rSrUT9a1yubAVtkAldi6zvT2Ka7oW5WHQEQBL3gLDC+z/CGjPpkZzhKaA2zXpr7rr09j4w+EFJECKwSKl/hd07j8ewkRY79PEbB+09z0WC+TF4dSJoCZ09+oDcwhb1tVe1ZIBfBDyRMJBs4xbm7Pu2ECMovoWsxSG0rW/0IK+3XEjmvAR1Q52MXll205b4yLMTWY1KUfzDhmrYe/ZMMvQGGiNC9JYHkJqshhoHR4W8Bc08abXxCjv9rfgWd1GK2i8/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFH7gsM6hB49EpgMrwzu6ChfzNsOO+s+lYp+Wy8rFEQ=;
 b=wakb6kT52//pLlXiStmOTNtkXiFQCJjuax8E9fpX8OCtShxVvc3tJrRSgadcU9fUTWpMQnitxfWC77H+xMkbmLJxhk24mkcIzSl2/wZUKpzwWPaVIu39HsY/+qU41Ke1VW62VZVYpfZeVS0UMEd+GtkMAEdr4Es1UdySk8MLlXOOs9f7l+SUTKi9gFongyXENrj5ZfTpqHMkjH4QeIhcD95Ss2wLu+nL02+ygO3uH6OfREMly7xf9CHHTMQcT4p8/LtsVdI0rnxToOYj1fl+O/rZ+2sfKe1gvMz/vZKeSDJBMehxhDyBU/pls43Lt8GvWRNW3uriiKP/zBvP+V4/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFH7gsM6hB49EpgMrwzu6ChfzNsOO+s+lYp+Wy8rFEQ=;
 b=SZHJFGhPpX3CE97i9+yPy1DkQAyBQFJjJRVstTvheMPaDQsAnAGxu8l1QCWmLjgyyO9AAncK7sAarpAONaWaAWfqplZuu3NED4kRh/rDg7b9GWW+lBgrcBMRhCZ+B6u/CYHQIFv+QKwVeU8N52J2nQogdAZPdruAAfmHSPrgaNu9qRByMgw6bMgF2SSAYY3IuXwordNQtTpi6A7nb/uTqSOQq6t2Yr4EYc1kU8bv4d3wV1JrcUbD60codgBM7X+0Eq98pwlK6NSrShwbrBm/SD1YSZdGJYxTyhV1GWKgggUWwisl3+PN0D9TJF/qBFjlZdzNTH7Pm2cU3E3CtxuRBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:36:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:36:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vignesh R <vigneshr@ti.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] i2c: Convert to subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:33:16 +0800
Message-ID: <20261104113316.1634141-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 194a3014-1696-4f15-cbf0-08df3a67e1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|1800799024|23010399003|376014|10067099003|18002099003|3023799007|921020|56012099006|11063799006|261009223027099003|261022075727099003|261026121527099003|261021123027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|261022115727099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	CLspK8VdkUqX5sqrTkjQm5v3VZBEvmzn554GNHp10p+EmWKWjVr6bQGsIP/lCLAuYGEtaR06iVY+XHS7q2cIl7S8O0IveRQFyzNqKzk2zLhPixLQAv81UTnHvTSphyqL9UUTrxm7HgjgC+RMnDDyH8MtdZxuoTIyuVcp5DGmMIVX4luj1A+gHKGzXwJzskoBzCmyarA1NDQZzIwKGXzzkj3o3EJOKUjQvC4zX5Z0i9ijGF8IRVN/OsHMYaANK3dGKecx2wGRSdrQLsvTB1jNNJqkO5uardSMc/us5iQAP/9unNzCvIX8pJZcbEIkzOkxxLv54WbgZJZypmltc8F6C6Pd18IPV8zho2JjekqBJrW5zpTo/YASwWlYZROLCi9jplEnZqwfHm78Y5jRF+K400ozY4uuGKnfsy9JXtu4LQvYrWOiNeBg8XE0Q81tFncrQw8pcqOfdJLljAhTdDrtwYzqWO9q1o3+GMcSKTzhmAaADZD7zqffp2VLQ8IEHFbj4HsMMbe65mg16nF3pDYoYGcWSPKi59T+Gc55sSS0zI+4nBd8RiVUQJXbRoAG1pA77Jfsb+NIMxa0LHNrzy4dr8OwefBUhcuozyjtH4c27jfonVslnaeZBNsmJk8/zp5WQXU+TB9ou2FB1gSDsCBuc4aqueXFdJ5Uh5zaqzNqhkPwkE4iC65bTg8PylUWHPqnEc7XGs+QyBrzfLHn9dCmfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(3023799007)(921020)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(261022115727099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxEbBunRf8DEdivPMlhQwic6OE0eWR+OB5TZx00aMsuL6adbgpqRBsTRASC3?=
 =?us-ascii?Q?UiBqd6TygLmiTeyfm3vN5fShkqhBK/hr8QKXL3gj7ClE1aW194mU4LqVwvbL?=
 =?us-ascii?Q?9SR//n7G6mvFuqG/oDwVjNNv3jTFYOE1fQKU4QKGYYU+0ZMuu3A6PQgxDtlG?=
 =?us-ascii?Q?6qstF206JnZuwyW3Ggg/WxAvYGXTX7cWRlImM03oQWnaSiCWbUGrjF+qzfU5?=
 =?us-ascii?Q?zgaQ45LIkADzcPYrrUVfQ9Y0cM/7dRK+tdHxrxZdJLiJWE62r8ii9zy4pzQA?=
 =?us-ascii?Q?W/rfn/SloOTB56m1XOsng/mwgWOr50xcozkh0/tSoimwL1mjx/IDvmejKxWD?=
 =?us-ascii?Q?BgXackvCLTy4cZvap5KBaROIKY2Jg3CCwkC/f3niH+6DvA87+p+miGSbbRs7?=
 =?us-ascii?Q?G+pdlPQQfhzgKZb0u3ftsLjjaQ/VEAQtA5cEqLAkJuB9HerpdM2dFqy/ZSF3?=
 =?us-ascii?Q?K65VYjc6aOWHTw9cbqjH7TrfU763U5Q9lXzlhuU8rywkBGSDCG6nKErH435i?=
 =?us-ascii?Q?4d1tCiUcO0qanqThySyFCIcaAib579qQfMKKoSRV+dEaY0MXqlXpafR+yULg?=
 =?us-ascii?Q?t4lSbA4Ui5UemhOMZhylePRlloDWtxTusv12LKyfDjym4Rw7wRPFPu6KJoE+?=
 =?us-ascii?Q?GbqQxAhX4T8HDkRqCvTHllY8AUJ1gNK/nlpDVfnaA+AMtWMp6flXuHg3SOP9?=
 =?us-ascii?Q?b/iNLZAFYKdlJmCfUasQAiqWc4fk4OGgtv0FsxvCrRO0e4hlNGhQ3zLSl1LT?=
 =?us-ascii?Q?OcogKJXl02IxGFMibuVyntZsiI5N1UZNR48ljWH3DzFg8cZ42W5XcXuWESSZ?=
 =?us-ascii?Q?GrCA0waq87ZuAxLa1kxaUjvSwSZeidMCZhH154kPc8SAc4MttbPilE7dB0Co?=
 =?us-ascii?Q?D4mjMtdovKGjDG4zboDxFRFFVOIpxI6J/O5didMzkHBw77DpV+Br/WkBPASt?=
 =?us-ascii?Q?um2KuEn5kNWi/D0rfLpMIYq+UHUjcZC60rIYHxVo5hRjLfmoRpXY5bxQo42c?=
 =?us-ascii?Q?BBNY9JToDPDV88Y/Fnrfyb+zkRKjSl35/rYvcn0eYkUWFXH3erc6Ft7kM3yu?=
 =?us-ascii?Q?Zs3dzZtZ/uQUnt+Cjk7/7O+lqd4IuXeJWVKkweqddE1jaiHwNEuhNUlCwZjS?=
 =?us-ascii?Q?cCVHgpDwg1yf+rVwir8EccfyqPQw2KgieB2DOq4K/exp0tigBnefxlpTkybY?=
 =?us-ascii?Q?FKWjb6YpsbzU02hmyUEigd7Zl/FZO0tq8wsV4KPUPTiVsIAGSU8NK0DRt4sE?=
 =?us-ascii?Q?5VISOWY04LiAqYm0RBzRes8HpvPlZXxeaKyJxOy1UMrcGKlqMmHHPeO8dNve?=
 =?us-ascii?Q?XUqTHJD6NVYduINRARkXDTgnjvchTk5gKBZFBqfgJBWYanSYbq9cIBNA7M0A?=
 =?us-ascii?Q?SS4k8zPHD/cTEdikl0UMhAmpfafnTG2750HSSs5poURRfnsw93vTTCrTksKB?=
 =?us-ascii?Q?MpPHM+Akp3Sx3w3/idRPaU3JgR5O50B2a2dsKsF9hVZV4Qq/CAV9DObxEV93?=
 =?us-ascii?Q?Pm7hY38ZkCeLfCVi2LijsxXnSD5vI9pmtLbqMaC7eMOWbwIemSfj6T5+B8gF?=
 =?us-ascii?Q?TuE/dJVMwQR5/vsFkrB0EVzPgjztDJtB3HEMBMRvr812qXmfDAJ+Al3B8T8h?=
 =?us-ascii?Q?FJxxayL6X7wgb2pDmLY8evVnGLOUq2EhvDoITYR2llSo7MtF2rAkMX4KXgWb?=
 =?us-ascii?Q?vOeA0RnIN83OShMj50D0KML6MzvVxy0kzbNOa+lVR8TrpUmTXEknRbPZrvLJ?=
 =?us-ascii?Q?Aibw8tEUTyI1r9aHNrN+VUID3hTQlvPLU1BXbUzhCx/ksAtrbp2N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a3014-1696-4f15-cbf0-08df3a67e1af
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:36:35.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FY2sKxUwOT1r9EUEH8XF+LEW6tYEUpCrqt5osbF/tsmS/l5TuZONNCThLvKIj1Knne7KQYhNN8s+k12QjJ2NZQ5ef4egfX9CLmZ4hZ+HR69Q+m6cEOzZsNH2rZvaiOQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/i2c/busses/i2c-at91-core.c          | 13 +------------
 drivers/i2c/busses/i2c-davinci.c            | 14 +-------------
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 +------------
 drivers/i2c/busses/i2c-imx.c                | 13 +------------
 drivers/i2c/busses/i2c-mxs.c                | 13 +------------
 drivers/i2c/busses/i2c-omap.c               | 15 +--------------
 drivers/i2c/busses/i2c-pnx.c                | 13 +------------
 drivers/i2c/busses/i2c-pxa.c                | 13 +------------
 drivers/i2c/busses/i2c-s3c2410.c            | 13 +------------
 drivers/i2c/busses/i2c-sh_mobile.c          | 13 +------------
 drivers/i2c/busses/i2c-versatile.c          | 13 +------------
 11 files changed, 11 insertions(+), 135 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index 8ca4556d9664..67727e7287ae 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -341,18 +341,7 @@ static struct platform_driver at91_twi_driver = {
 	},
 };
 
-static int __init at91_twi_init(void)
-{
-	return platform_driver_register(&at91_twi_driver);
-}
-
-static void __exit at91_twi_exit(void)
-{
-	platform_driver_unregister(&at91_twi_driver);
-}
-
-subsys_initcall(at91_twi_init);
-module_exit(at91_twi_exit);
+subsys_platform_driver(at91_twi_driver);
 
 MODULE_AUTHOR("Nikolaus Voss <n.voss@weinmann.de>");
 MODULE_DESCRIPTION("I2C (TWI) driver for Atmel AT91");
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index e15eef163a8f..b7afdf22fad5 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -896,19 +896,7 @@ static struct platform_driver davinci_i2c_driver = {
 		.of_match_table = davinci_i2c_of_match,
 	},
 };
-
-/* I2C may be needed to bring up other drivers */
-static int __init davinci_i2c_init_driver(void)
-{
-	return platform_driver_register(&davinci_i2c_driver);
-}
-subsys_initcall(davinci_i2c_init_driver);
-
-static void __exit davinci_i2c_exit_driver(void)
-{
-	platform_driver_unregister(&davinci_i2c_driver);
-}
-module_exit(davinci_i2c_exit_driver);
+subsys_platform_driver(davinci_i2c_driver);
 
 MODULE_AUTHOR("Texas Instruments India");
 MODULE_DESCRIPTION("TI DaVinci I2C bus adapter");
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 1da6b0314b6a..0f7d564bd187 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -315,18 +315,7 @@ static struct platform_driver dw_i2c_driver = {
 	},
 	.id_table = dw_i2c_platform_ids,
 };
-
-static int __init dw_i2c_init_driver(void)
-{
-	return platform_driver_register(&dw_i2c_driver);
-}
-subsys_initcall(dw_i2c_init_driver);
-
-static void __exit dw_i2c_exit_driver(void)
-{
-	platform_driver_unregister(&dw_i2c_driver);
-}
-module_exit(dw_i2c_exit_driver);
+subsys_platform_driver(dw_i2c_driver);
 
 MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..fff31638cb8e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -2126,18 +2126,7 @@ static struct platform_driver i2c_imx_driver = {
 	},
 	.id_table = imx_i2c_devtype,
 };
-
-static int __init i2c_adap_imx_init(void)
-{
-	return platform_driver_register(&i2c_imx_driver);
-}
-subsys_initcall(i2c_adap_imx_init);
-
-static void __exit i2c_adap_imx_exit(void)
-{
-	platform_driver_unregister(&i2c_imx_driver);
-}
-module_exit(i2c_adap_imx_exit);
+subsys_platform_driver(i2c_imx_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Darius Augulis");
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index eee4fdcd9df3..ad0b1e911dfe 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -888,18 +888,7 @@ static struct platform_driver mxs_i2c_driver = {
 	.probe = mxs_i2c_probe,
 	.remove = mxs_i2c_remove,
 };
-
-static int __init mxs_i2c_init(void)
-{
-	return platform_driver_register(&mxs_i2c_driver);
-}
-subsys_initcall(mxs_i2c_init);
-
-static void __exit mxs_i2c_exit(void)
-{
-	platform_driver_unregister(&mxs_i2c_driver);
-}
-module_exit(mxs_i2c_exit);
+subsys_platform_driver(mxs_i2c_driver);
 
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
 MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bd659dfa702f..cd4d6d6b32c6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1611,20 +1611,7 @@ static struct platform_driver omap_i2c_driver = {
 		.of_match_table = of_match_ptr(omap_i2c_of_match),
 	},
 };
-
-/* I2C may be needed to bring up other drivers */
-static int __init
-omap_i2c_init_driver(void)
-{
-	return platform_driver_register(&omap_i2c_driver);
-}
-subsys_initcall(omap_i2c_init_driver);
-
-static void __exit omap_i2c_exit_driver(void)
-{
-	platform_driver_unregister(&omap_i2c_driver);
-}
-module_exit(omap_i2c_exit_driver);
+subsys_platform_driver(omap_i2c_driver);
 
 MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
 MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index e1cc2b2bd628..9a9a12b7e981 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -735,16 +735,6 @@ static struct platform_driver i2c_pnx_driver = {
 	.remove = i2c_pnx_remove,
 };
 
-static int __init i2c_adap_pnx_init(void)
-{
-	return platform_driver_register(&i2c_pnx_driver);
-}
-
-static void __exit i2c_adap_pnx_exit(void)
-{
-	platform_driver_unregister(&i2c_pnx_driver);
-}
-
 MODULE_AUTHOR("Vitaly Wool");
 MODULE_AUTHOR("Dennis Kovalev <source@mvista.com>");
 MODULE_DESCRIPTION("I2C driver for Philips IP3204-based I2C busses");
@@ -752,5 +742,4 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pnx-i2c");
 
 /* We need to make sure I2C is initialized before USB */
-subsys_initcall(i2c_adap_pnx_init);
-module_exit(i2c_adap_pnx_exit);
+subsys_platform_driver(i2c_pnx_driver);
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index c9927a389aaf..f045d0c2c54b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1607,18 +1607,7 @@ static struct platform_driver i2c_pxa_driver = {
 	.id_table	= i2c_pxa_id_table,
 };
 
-static int __init i2c_adap_pxa_init(void)
-{
-	return platform_driver_register(&i2c_pxa_driver);
-}
-
-static void __exit i2c_adap_pxa_exit(void)
-{
-	platform_driver_unregister(&i2c_pxa_driver);
-}
-
 MODULE_DESCRIPTION("Intel PXA2XX I2C adapter");
 MODULE_LICENSE("GPL");
 
-subsys_initcall(i2c_adap_pxa_init);
-module_exit(i2c_adap_pxa_exit);
+subsys_platform_driver(i2c_pxa_driver);
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 15e14a6fe6dc..dd1f6f854a32 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1188,18 +1188,7 @@ static struct platform_driver s3c24xx_i2c_driver = {
 		.of_match_table = of_match_ptr(s3c24xx_i2c_match),
 	},
 };
-
-static int __init i2c_adap_s3c_init(void)
-{
-	return platform_driver_register(&s3c24xx_i2c_driver);
-}
-subsys_initcall(i2c_adap_s3c_init);
-
-static void __exit i2c_adap_s3c_exit(void)
-{
-	platform_driver_unregister(&s3c24xx_i2c_driver);
-}
-module_exit(i2c_adap_s3c_exit);
+subsys_platform_driver(s3c24xx_i2c_driver);
 
 MODULE_DESCRIPTION("S3C24XX I2C Bus driver");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3a55f803e4f1..1ecf14890209 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -986,18 +986,7 @@ static struct platform_driver sh_mobile_i2c_driver = {
 	.probe		= sh_mobile_i2c_probe,
 	.remove		= sh_mobile_i2c_remove,
 };
-
-static int __init sh_mobile_i2c_adap_init(void)
-{
-	return platform_driver_register(&sh_mobile_i2c_driver);
-}
-subsys_initcall(sh_mobile_i2c_adap_init);
-
-static void __exit sh_mobile_i2c_adap_exit(void)
-{
-	platform_driver_unregister(&sh_mobile_i2c_driver);
-}
-module_exit(sh_mobile_i2c_adap_exit);
+subsys_platform_driver(sh_mobile_i2c_driver);
 
 MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
 MODULE_AUTHOR("Magnus Damm");
diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
index a1ab6ef6f071..152ab19f272a 100644
--- a/drivers/i2c/busses/i2c-versatile.c
+++ b/drivers/i2c/busses/i2c-versatile.c
@@ -116,18 +116,7 @@ static struct platform_driver i2c_versatile_driver = {
 	},
 };
 
-static int __init i2c_versatile_init(void)
-{
-	return platform_driver_register(&i2c_versatile_driver);
-}
-
-static void __exit i2c_versatile_exit(void)
-{
-	platform_driver_unregister(&i2c_versatile_driver);
-}
-
-subsys_initcall(i2c_versatile_init);
-module_exit(i2c_versatile_exit);
+subsys_platform_driver(i2c_versatile_driver);
 
 MODULE_DESCRIPTION("ARM Versatile I2C bus driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0

