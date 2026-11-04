Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792239;
	b=cwBepiy6qxdMK7FTvQ+GKG1Bz8zTG+Pz2Ssp4lX+L6C/X298yRBkwM98bkocThKWTKFx
	 PSB/ejJDG2xM7fJCGuirEVUJ0OsVwS4bXk4hnPM9PtiW4i0NcpqdN7UCDnOnst45TbVat
	 sr7gJCMn0VuNKal4e3Q90mTq7iSfL7t6DMMdP3aC7ZFgXxHpIl0iFU2G9krogss3Q08He
	 blt0t6Vcqc0+XFZXsP3402xPRvgl96NMMDURYCPKT6Xp/o9nMBR9VDkRIvN2BpmcpJUML
	 WDATcsAeRpoYSxObdz/EvE5N61G/0GTmVrb9+Pp9s0lpiawIVHz5LVUlpdmadP2hnvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792239;
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
	bh=sx6IFfQ95Vbqyb2CJl+oO9A50rlnJR1W46+8bQ0kTbQ=;
	b=jOhae9UOA1aSJoTOEBkyO5YK8V0kwFBp+9N0QBNpZMdzsYXaYr7Al5nnI+QXrvXP2uHZ
	 NShsUjIfOFDETeLZprSP/6JKHEF44PGuXPScj4AXXfQUchBVzYB9On9IuzO8Gob/scuc7
	 xd3PYfyTaulslFI+hXLq7zrXqz1W4Gaak6aNGoOnJNH6WI50j+JD+po+E3HkibX+ivNGC
	 0Fw4M8cA5cpM49wu/uOP3adu+bLZnkQgYnR0mvUl6VQki1PXDKxtK8n2nrkR9PI9nxuik
	 sb7XJAod8j1ahhoEevMWYTIoUBQw5WgBMMEYA0JMlPSwDDshmF/4dNnG2O2RuLH2s6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vwvAe3DT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.55
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9310606D808;
	Wed,  4 Nov 2026 11:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9310606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vwvAe3DT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGjwwflgqTW2gbGUg5t3NrE98Zzjaz7kmmlKaxgyzd8mqsM0SaHPAu9bvJGX2uiNIKbRF2c8BaVAdavn0MdYahgrMLLT58+oPWuTk0qYle7vGPJTyR9Ekmjv27jR2qb3xs9PxJUvCfueWuZZpkR6845ML/fsJwu+Aa8mZkPgO+r3nn7/4Mujb2z9OQdjiOQOtiHDF9J9+2L5m5oIQ74AeFxaFmnC0gSJ/jqlAfuf4LIFJQHpDGHr4/2MdVfOC9uqralmTDDNcKUqEYL6uSv6I62qGBxtKGtYTpQuLJjvvIn9CgUJ/H3tSbAAT4J4923irlX/WVeXSzMQ0fkyoBTQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx6IFfQ95Vbqyb2CJl+oO9A50rlnJR1W46+8bQ0kTbQ=;
 b=VBBrm8D017rQtKO0nj4noC2yO1elN/FZZj9f71j/h/l7hRPWdQiEZdYT6lQwSR1sOGkjcqWcI0Q5Qc13OFWeWU0vTJHd5GEegc7fMwx71e/Eg5N2WMK174PKXbVTHhT1oIT5LJ1StA4Re+L9Iq7k7sPOPF0Wbt/gnqKXXOiqatYfkEZ1taUMmOHl3hFswSdrd/fNbB7sLAijggKxMDgkQhUDsVw+UoH/4Y/JV0oNIa1vWpeHZsCMCMEmUS62hbQXkNmBeu9KgDnrFQ/V2xKTquaFUVr+enRWHVE3KzEKxx8TcEg8MUFD3neyC7GVzC8aYoRf6+Kw3HpDpuGtPl98Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx6IFfQ95Vbqyb2CJl+oO9A50rlnJR1W46+8bQ0kTbQ=;
 b=vwvAe3DThZaRIqFhqUHfKmXH/56KSLIuzNlWgEFQLSCnjrRQcBWth3wMa8O0fc4qbuDatm1tfzEmf1m0JKaVSJ8Zi0Z7FHhctM7qF+0jHebWufrxadygUtjBP9DOBNwW/E0dNKe+q7iq1ArnKVb860ayTFRE3hWf+7x3TJyVzRHWCVO+jWmC8YeLYkYIdAwAZ4AvRvQDf1S3dPBqgF/hB8psVDAo3rfBw+VqMQy47paKIVQB6APhK+SUl6AMvhBIP/v3Y7eRZ+F70uHkCEqfjVccQB/orYNul/CYAKW4l9bxOQRlxwpLtZwreVsG1WbmQFzx7vRlP/cNCPbezcyWfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:37:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:37:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH] regulator: Convert to subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:33:52 +0800
Message-ID: <20261104113352.1634237-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 48205b1f-3d02-482d-588e-08df3a67f603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|1800799024|23010399003|376014|10067099003|18002099003|3023799007|921020|56012099006|11063799006|261009223027099003|261102130727099003|261022075727099003|261026121527099003|261021123027099003|261021121427099003|260925022911599003|260925021311599003|260925021911599003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	0uPlnPoe0yIrSYhqSIHA+JDYLzmwTNPhfzjo08RpjVTDUNZviFtXROjYkJnWxGRtg2ZxeDnj24EFgTHfb71IZ7gqa21KiA8JkYLKWUPMB1yO7U7UXK830eIYgmg8wlMCHQN6qRX1qFOvisUEJ7VXSH/ahLQCBd+KbUs7li519DgJ23a/1ychXO+LfsjHA+x2XX0m/jtHEghC2fMdSZhwYGCvM2BbJEzfaHMz2JPd6mUjH0sDdDmr3BIWeAxwva78M7Dsm6175vOeQM+RzXWskmkhOvNRZaCdjtzGvJCa9LkLgqT/kgvRiaoMXT8pVqit6Ry8RCnT7TrZxPo7RdYMu4AWpyER7c4gSCfPBO0XGcKvKqYjKxcmsUbDJmzx0TJrgZhODMm041CJFAxgfr4we5JQ0f4gvUZDUgwGibLBs8eRTgmtmFqFC+f6OVmbkW9vjHUxq9/nxJSOFhfqxnfj97MTRuC+rkc1Z4ZazKm9Z4lcKb4xqxMYyUTsfy+UeSyRgsfati2sCEBaRcwjf1ayjMElNkoKJrz29fx3N0qAsqS8Mk5zoULqxfYz1/4HnJU8ouH0yB6BoBPoKnJ0coHvy+MedP1V5wgVTIYLt5c/UNmljERNF+7jgIOOPtdDp/Qt/oSZBY9nR1rG7j0ORUED+q+4W48o4pD8Kq9HTJHbf9vb7iJk3h6As8fqDx7xEG40HtCFbV8UfhzB5EuvKQClaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(3023799007)(921020)(56012099006)(11063799006)(261009223027099003)(261102130727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(260925022911599003)(260925021311599003)(260925021911599003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4UDmK8ZnSIdP/EqY8Wc0HMWIdF6h0BknzW9Me7Pd08haDBUSR7yg2qaF4VC?=
 =?us-ascii?Q?hkms2StvysjzKfEFll4p8UsGL9SPPa6MWuKKB3gHP8LZgAwG1ypy20isifBg?=
 =?us-ascii?Q?ZuaCcKhVGYQ+tXcsiIbkRLAF2n+Bqif0N4qULM6IzXsaIE7hLc0QMwMFFLgV?=
 =?us-ascii?Q?LpahktOHIi+8cuiFWY6znOhgkzadRTbJEOpxRKTfD1CkYUzCDdR8Ug2y2cTe?=
 =?us-ascii?Q?S5j3AHDg73jRJEkk9ZWGjJJHpkEdX+RojyarDIRG/4ZJPtAGdIUmqqf9eYOe?=
 =?us-ascii?Q?n4brhTHUrzL+yNJCDxdTCNT5bQerjsx4q++1TSf+OM6fvgenl0utW0u3qIAE?=
 =?us-ascii?Q?DHF3cWZIBIs3W82+WiRgcI6rULFOTH5if2hkIVPqcVukJkypFnmRBwAGX9Ln?=
 =?us-ascii?Q?k1IPY+6k6BYGM4w/uOC12t6FZXZPgFZBFrPGJmpJ6aaybriaKvykn3fqocah?=
 =?us-ascii?Q?71jOMP5wO+70SEz9CAVJlHC3WjhbL0oj29kFKxGfvkLQRZVpS9WjYNq08FT+?=
 =?us-ascii?Q?nnJ2XAaKOhCNRtHU3qQXcnj9yg+smCT0wqBaVKEG2IOdp2ZuUYiB8aIh46kx?=
 =?us-ascii?Q?zE2/8pie0Bf440tS0owDwn1FS6nNvLJmB4kzo2ykPlAYVST5mRV+vdXSEAdH?=
 =?us-ascii?Q?4nOa+O8S+2hQCs/zCuQc9dDkUYizgTwn+o+u3IOCUDksjpMR7n9JZyRyxtie?=
 =?us-ascii?Q?pNu+Zy818NXB3fMXqV8bpOWwRzi+dy3FMKVZrFwS2FN2dfXFTk7r+bsNT/mw?=
 =?us-ascii?Q?Qd+PTIUy83NAt2q24ICDxskvuFJ/2xKSeRxpwaamg6uz5sE0V4lAhAxR55jS?=
 =?us-ascii?Q?YCOQqfR+wD+iALgwIFRb9m/OxiW3PvF/8j+WLtuhmvtOeLakXGZ8vR+V/IKV?=
 =?us-ascii?Q?ncZvifHy2GeIDJR6pICSJy19lsmE1s/CvXkZltDEr/Hr2VkQ9HtLeWEeCauV?=
 =?us-ascii?Q?T0HwW2ehZ/u90DDwBtDz9000v1fz6gDnDI9NlP2P6I0A0+0H9PERnxAx659u?=
 =?us-ascii?Q?4Kr7w+s3346q6yb60e8su/g98bWkB0hrlbb1Yg3Ps3uD4cUxpGyMPl1muMKH?=
 =?us-ascii?Q?3/Zl8KzytdkhH0A7ZB/kQuGNutj64o/dEt4ttQMjO2nL1d8rU0aGQgAL2DUd?=
 =?us-ascii?Q?WdRj7weVIEszjxJMN9RYCmoyun951+8A37aXKK07CHUzvB0mlPsz1kgt8E29?=
 =?us-ascii?Q?zj12zeN9YRxWOW+kWLcEHBTJxZGUFf2VSQmJnXNAtoOoIh8+7GKFy+YO255e?=
 =?us-ascii?Q?tnbwAE4WQDQQScGikql32T9fFW+f6CpnXoYxUts+oIrd0Dqi3NScHq7UcoAS?=
 =?us-ascii?Q?0vj5u9C8WuO71GzE+boitNJdEOFo997eeCoTWyQM2TelEoGkU7Ghe93gFjrv?=
 =?us-ascii?Q?fNJ+jw5VAJS6XT+7uLnjKreLQFgkUe8FRgEcUQRs2zEtlRTmcl9btP4tdTHF?=
 =?us-ascii?Q?nj6Dm8SaiAyxZ4CWjjMrQREx1LZG7ck7vnd1DUaaILyYIqtpwVAr2/euSrBW?=
 =?us-ascii?Q?5hBr4P2qJF9gnB+BXKdenJjnU8DTqXulh0fUQtSY4tG/G+ytLMdlyNubTHjg?=
 =?us-ascii?Q?5I/ZwWPWAYYVxg5D18DAbvAoIJRCW/lcDDLo/F2xvYCSEKNUU6Kzuj4GdvDx?=
 =?us-ascii?Q?JbRzEhdc3Q1yTC6HMo82kbsCILhJG9ylf18udWb4brLvA6T2ncVb1lggH0pE?=
 =?us-ascii?Q?KwKkbbLnImsmb54w7VV3q7kI0szF6kGLpGLaDqDHrGJAVWD3OsC5ylHO06GY?=
 =?us-ascii?Q?Oh7JpaiojJQHrd+y1YyxPMEiAROivHIRXwAOkgkgh1EQSUc/W7dS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48205b1f-3d02-482d-588e-08df3a67f603
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:37:09.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ao+FZZRdVvBt7dQjfxDMpYgZwdu/VITmtXYSf29yIMFDM6Y5vjpkdKwaFuPwXw6DBRF3h3XKnx9A8o3fRLZYi2yWynyBQydLoyfDQwhNk2arpQSHxdx/4kDruWBoZ8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/regulator/88pm8607.c           | 13 +------------
 drivers/regulator/aat2870-regulator.c  | 13 +------------
 drivers/regulator/as3711-regulator.c   | 13 +------------
 drivers/regulator/da903x-regulator.c   | 13 +------------
 drivers/regulator/da9052-regulator.c   | 13 +------------
 drivers/regulator/da9055-regulator.c   | 13 +------------
 drivers/regulator/da9062-regulator.c   | 13 +------------
 drivers/regulator/da9063-regulator.c   | 13 +------------
 drivers/regulator/fixed.c              | 13 +------------
 drivers/regulator/gpio-regulator.c     | 13 +------------
 drivers/regulator/lp8788-buck.c        | 13 +------------
 drivers/regulator/max77693-regulator.c | 13 +------------
 drivers/regulator/max8907-regulator.c  | 14 +-------------
 drivers/regulator/max8925-regulator.c  | 13 +------------
 drivers/regulator/max8997-regulator.c  | 13 +------------
 drivers/regulator/max8998.c            | 13 +------------
 drivers/regulator/mc13783-regulator.c  | 13 +------------
 drivers/regulator/mc13892-regulator.c  | 13 +------------
 drivers/regulator/palmas-regulator.c   | 13 +------------
 drivers/regulator/rc5t583-regulator.c  | 13 +------------
 drivers/regulator/tps6105x-regulator.c | 13 +------------
 drivers/regulator/tps6507x-regulator.c | 13 +------------
 drivers/regulator/tps65090-regulator.c | 13 +------------
 drivers/regulator/tps65217-regulator.c | 13 +------------
 drivers/regulator/tps6586x-regulator.c | 13 +------------
 drivers/regulator/tps65910-regulator.c | 13 +------------
 drivers/regulator/tps68470-regulator.c | 12 +-----------
 drivers/regulator/wm8350-regulator.c   | 13 +------------
 drivers/regulator/wm8400-regulator.c   | 13 +------------
 29 files changed, 29 insertions(+), 348 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 969554725a67..b740b4883812 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -386,18 +386,7 @@ static struct platform_driver pm8607_regulator_driver = {
 	.probe		= pm8607_regulator_probe,
 	.id_table	= pm8607_regulator_driver_ids,
 };
-
-static int __init pm8607_regulator_init(void)
-{
-	return platform_driver_register(&pm8607_regulator_driver);
-}
-subsys_initcall(pm8607_regulator_init);
-
-static void __exit pm8607_regulator_exit(void)
-{
-	platform_driver_unregister(&pm8607_regulator_driver);
-}
-module_exit(pm8607_regulator_exit);
+subsys_platform_driver(pm8607_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 970d86f2bbb8..52c08e6c4803 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -182,18 +182,7 @@ static struct platform_driver aat2870_regulator_driver = {
 	},
 	.probe	= aat2870_regulator_probe,
 };
-
-static int __init aat2870_regulator_init(void)
-{
-	return platform_driver_register(&aat2870_regulator_driver);
-}
-subsys_initcall(aat2870_regulator_init);
-
-static void __exit aat2870_regulator_exit(void)
-{
-	platform_driver_unregister(&aat2870_regulator_driver);
-}
-module_exit(aat2870_regulator_exit);
+subsys_platform_driver(aat2870_regulator_driver);
 
 MODULE_DESCRIPTION("AnalogicTech AAT2870 Regulator");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index 0431a732cd78..22fa51ce22ee 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -247,18 +247,7 @@ static struct platform_driver as3711_regulator_driver = {
 	},
 	.probe		= as3711_regulator_probe,
 };
-
-static int __init as3711_regulator_init(void)
-{
-	return platform_driver_register(&as3711_regulator_driver);
-}
-subsys_initcall(as3711_regulator_init);
-
-static void __exit as3711_regulator_exit(void)
-{
-	platform_driver_unregister(&as3711_regulator_driver);
-}
-module_exit(as3711_regulator_exit);
+subsys_platform_driver(as3711_regulator_driver);
 
 MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
 MODULE_DESCRIPTION("AS3711 regulator driver");
diff --git a/drivers/regulator/da903x-regulator.c b/drivers/regulator/da903x-regulator.c
index 2f85897183b3..05629667dfc3 100644
--- a/drivers/regulator/da903x-regulator.c
+++ b/drivers/regulator/da903x-regulator.c
@@ -475,18 +475,7 @@ static struct platform_driver da903x_regulator_driver = {
 	},
 	.probe		= da903x_regulator_probe,
 };
-
-static int __init da903x_regulator_init(void)
-{
-	return platform_driver_register(&da903x_regulator_driver);
-}
-subsys_initcall(da903x_regulator_init);
-
-static void __exit da903x_regulator_exit(void)
-{
-	platform_driver_unregister(&da903x_regulator_driver);
-}
-module_exit(da903x_regulator_exit);
+subsys_platform_driver(da903x_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>"
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index fbebe538a648..412eb27c1067 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -441,18 +441,7 @@ static struct platform_driver da9052_regulator_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-
-static int __init da9052_regulator_init(void)
-{
-	return platform_driver_register(&da9052_regulator_driver);
-}
-subsys_initcall(da9052_regulator_init);
-
-static void __exit da9052_regulator_exit(void)
-{
-	platform_driver_unregister(&da9052_regulator_driver);
-}
-module_exit(da9052_regulator_exit);
+subsys_platform_driver(da9052_regulator_driver);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("Power Regulator driver for Dialog DA9052 PMIC");
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index a0d3414aa79e..29756eec6502 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -579,18 +579,7 @@ static struct platform_driver da9055_regulator_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-
-static int __init da9055_regulator_init(void)
-{
-	return platform_driver_register(&da9055_regulator_driver);
-}
-subsys_initcall(da9055_regulator_init);
-
-static void __exit da9055_regulator_exit(void)
-{
-	platform_driver_unregister(&da9055_regulator_driver);
-}
-module_exit(da9055_regulator_exit);
+subsys_platform_driver(da9055_regulator_driver);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("Power Regulator driver for Dialog DA9055 PMIC");
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index e0c96f10e570..7f0604327358 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1036,18 +1036,7 @@ static struct platform_driver da9062_regulator_driver = {
 	},
 	.probe = da9062_regulator_probe,
 };
-
-static int __init da9062_regulator_init(void)
-{
-	return platform_driver_register(&da9062_regulator_driver);
-}
-subsys_initcall(da9062_regulator_init);
-
-static void __exit da9062_regulator_cleanup(void)
-{
-	platform_driver_unregister(&da9062_regulator_driver);
-}
-module_exit(da9062_regulator_cleanup);
+subsys_platform_driver(da9062_regulator_driver);
 
 /* Module information */
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index bf34ea440d77..b4680f335961 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1064,18 +1064,7 @@ static struct platform_driver da9063_regulator_driver = {
 	},
 	.probe = da9063_regulator_probe,
 };
-
-static int __init da9063_regulator_init(void)
-{
-	return platform_driver_register(&da9063_regulator_driver);
-}
-subsys_initcall(da9063_regulator_init);
-
-static void __exit da9063_regulator_cleanup(void)
-{
-	platform_driver_unregister(&da9063_regulator_driver);
-}
-module_exit(da9063_regulator_cleanup);
+subsys_platform_driver(da9063_regulator_driver);
 
 
 /* Module information */
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index f797cb504b9a..3f95ac2b0d29 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -388,18 +388,7 @@ static struct platform_driver regulator_fixed_voltage_driver = {
 		.of_match_table = of_match_ptr(fixed_of_match),
 	},
 };
-
-static int __init regulator_fixed_voltage_init(void)
-{
-	return platform_driver_register(&regulator_fixed_voltage_driver);
-}
-subsys_initcall(regulator_fixed_voltage_init);
-
-static void __exit regulator_fixed_voltage_exit(void)
-{
-	platform_driver_unregister(&regulator_fixed_voltage_driver);
-}
-module_exit(regulator_fixed_voltage_exit);
+subsys_platform_driver(regulator_fixed_voltage_driver);
 
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Fixed voltage regulator");
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 6351ceefdb3e..e16eedb27b1c 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -370,18 +370,7 @@ static struct platform_driver gpio_regulator_driver = {
 		.of_match_table = of_match_ptr(regulator_gpio_of_match),
 	},
 };
-
-static int __init gpio_regulator_init(void)
-{
-	return platform_driver_register(&gpio_regulator_driver);
-}
-subsys_initcall(gpio_regulator_init);
-
-static void __exit gpio_regulator_exit(void)
-{
-	platform_driver_unregister(&gpio_regulator_driver);
-}
-module_exit(gpio_regulator_exit);
+subsys_platform_driver(gpio_regulator_driver);
 
 MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
 MODULE_DESCRIPTION("gpio voltage regulator");
diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 2ade249ab6df..6028c2ac11ec 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -522,18 +522,7 @@ static struct platform_driver lp8788_buck_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-
-static int __init lp8788_buck_init(void)
-{
-	return platform_driver_register(&lp8788_buck_driver);
-}
-subsys_initcall(lp8788_buck_init);
-
-static void __exit lp8788_buck_exit(void)
-{
-	platform_driver_unregister(&lp8788_buck_driver);
-}
-module_exit(lp8788_buck_exit);
+subsys_platform_driver(lp8788_buck_driver);
 
 MODULE_DESCRIPTION("TI LP8788 BUCK Driver");
 MODULE_AUTHOR("Milo Kim");
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index a8b3a2058d34..cfadf33574c3 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -286,18 +286,7 @@ static struct platform_driver max77693_pmic_driver = {
 	.probe = max77693_pmic_probe,
 	.id_table = max77693_pmic_id,
 };
-
-static int __init max77693_pmic_init(void)
-{
-	return platform_driver_register(&max77693_pmic_driver);
-}
-subsys_initcall(max77693_pmic_init);
-
-static void __exit max77693_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max77693_pmic_driver);
-}
-module_exit(max77693_pmic_cleanup);
+subsys_platform_driver(max77693_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 77693/77843 regulator driver");
 MODULE_AUTHOR("Jonghwa Lee <jonghwa3.lee@samsung.com>");
diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index e59aa7a3ee54..f8f0a50161c6 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -377,19 +377,7 @@ static struct platform_driver max8907_regulator_driver = {
 	.probe = max8907_regulator_probe,
 };
 
-static int __init max8907_regulator_init(void)
-{
-	return platform_driver_register(&max8907_regulator_driver);
-}
-
-subsys_initcall(max8907_regulator_init);
-
-static void __exit max8907_reg_exit(void)
-{
-	platform_driver_unregister(&max8907_regulator_driver);
-}
-
-module_exit(max8907_reg_exit);
+subsys_platform_driver(max8907_regulator_driver);
 
 MODULE_DESCRIPTION("MAX8907 regulator driver");
 MODULE_AUTHOR("Gyungoh Yoo <jack.yoo@maxim-ic.com>");
diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index c1532db0a4ee..bdcbc457766c 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -267,18 +267,7 @@ static struct platform_driver max8925_regulator_driver = {
 	},
 	.probe		= max8925_regulator_probe,
 };
-
-static int __init max8925_regulator_init(void)
-{
-	return platform_driver_register(&max8925_regulator_driver);
-}
-subsys_initcall(max8925_regulator_init);
-
-static void __exit max8925_regulator_exit(void)
-{
-	platform_driver_unregister(&max8925_regulator_driver);
-}
-module_exit(max8925_regulator_exit);
+subsys_platform_driver(max8925_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index e48ba694a906..25aac72b79e7 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -1165,18 +1165,7 @@ static struct platform_driver max8997_pmic_driver = {
 	.probe = max8997_pmic_probe,
 	.id_table = max8997_pmic_id,
 };
-
-static int __init max8997_pmic_init(void)
-{
-	return platform_driver_register(&max8997_pmic_driver);
-}
-subsys_initcall(max8997_pmic_init);
-
-static void __exit max8997_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max8997_pmic_driver);
-}
-module_exit(max8997_pmic_cleanup);
+subsys_platform_driver(max8997_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 8997/8966 Regulator Driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 90651f4d1828..2eb16fa92b86 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -765,18 +765,7 @@ static struct platform_driver max8998_pmic_driver = {
 	.probe = max8998_pmic_probe,
 	.id_table = max8998_pmic_id,
 };
-
-static int __init max8998_pmic_init(void)
-{
-	return platform_driver_register(&max8998_pmic_driver);
-}
-subsys_initcall(max8998_pmic_init);
-
-static void __exit max8998_pmic_cleanup(void)
-{
-	platform_driver_unregister(&max8998_pmic_driver);
-}
-module_exit(max8998_pmic_cleanup);
+subsys_platform_driver(max8998_pmic_driver);
 
 MODULE_DESCRIPTION("MAXIM 8998 voltage regulator driver");
 MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index fb3aa1cec1f2..449f4e3621c1 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -459,18 +459,7 @@ static struct platform_driver mc13783_regulator_driver = {
 	},
 	.probe		= mc13783_regulator_probe,
 };
-
-static int __init mc13783_regulator_init(void)
-{
-	return platform_driver_register(&mc13783_regulator_driver);
-}
-subsys_initcall(mc13783_regulator_init);
-
-static void __exit mc13783_regulator_exit(void)
-{
-	platform_driver_unregister(&mc13783_regulator_driver);
-}
-module_exit(mc13783_regulator_exit);
+subsys_platform_driver(mc13783_regulator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index b29cf6ba6f12..debec21aaf3c 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -633,18 +633,7 @@ static struct platform_driver mc13892_regulator_driver = {
 	},
 	.probe	= mc13892_regulator_probe,
 };
-
-static int __init mc13892_regulator_init(void)
-{
-	return platform_driver_register(&mc13892_regulator_driver);
-}
-subsys_initcall(mc13892_regulator_init);
-
-static void __exit mc13892_regulator_exit(void)
-{
-	platform_driver_unregister(&mc13892_regulator_driver);
-}
-module_exit(mc13892_regulator_exit);
+subsys_platform_driver(mc13892_regulator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yong Shen <yong.shen@linaro.org>");
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index f82618a70106..bf66cfd11465 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1668,18 +1668,7 @@ static struct platform_driver palmas_driver = {
 	},
 	.probe = palmas_regulators_probe,
 };
-
-static int __init palmas_init(void)
-{
-	return platform_driver_register(&palmas_driver);
-}
-subsys_initcall(palmas_init);
-
-static void __exit palmas_exit(void)
-{
-	platform_driver_unregister(&palmas_driver);
-}
-module_exit(palmas_exit);
+subsys_platform_driver(palmas_driver);
 
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_DESCRIPTION("Palmas voltage regulator driver");
diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index a25a141e86c4..fff2b5be5cc1 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -152,18 +152,7 @@ static struct platform_driver rc5t583_regulator_driver = {
 	},
 	.probe		= rc5t583_regulator_probe,
 };
-
-static int __init rc5t583_regulator_init(void)
-{
-	return platform_driver_register(&rc5t583_regulator_driver);
-}
-subsys_initcall(rc5t583_regulator_init);
-
-static void __exit rc5t583_regulator_exit(void)
-{
-	platform_driver_unregister(&rc5t583_regulator_driver);
-}
-module_exit(rc5t583_regulator_exit);
+subsys_platform_driver(rc5t583_regulator_driver);
 
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_DESCRIPTION("RC5T583 regulator driver");
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index 7f99f3e90bec..d5a6d3554631 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -97,18 +97,7 @@ static struct platform_driver tps6105x_regulator_driver = {
 	},
 	.probe = tps6105x_regulator_probe,
 };
-
-static __init int tps6105x_regulator_init(void)
-{
-	return platform_driver_register(&tps6105x_regulator_driver);
-}
-subsys_initcall(tps6105x_regulator_init);
-
-static __exit void tps6105x_regulator_exit(void)
-{
-	platform_driver_unregister(&tps6105x_regulator_driver);
-}
-module_exit(tps6105x_regulator_exit);
+subsys_platform_driver(tps6105x_regulator_driver);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("TPS6105x regulator driver");
diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index 6655d9c31187..bcfa418a503d 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -442,18 +442,7 @@ static struct platform_driver tps6507x_pmic_driver = {
 	},
 	.probe = tps6507x_pmic_probe,
 };
-
-static int __init tps6507x_pmic_init(void)
-{
-	return platform_driver_register(&tps6507x_pmic_driver);
-}
-subsys_initcall(tps6507x_pmic_init);
-
-static void __exit tps6507x_pmic_cleanup(void)
-{
-	platform_driver_unregister(&tps6507x_pmic_driver);
-}
-module_exit(tps6507x_pmic_cleanup);
+subsys_platform_driver(tps6507x_pmic_driver);
 
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("TPS6507x voltage regulator driver");
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 8f916ee366e5..8a5e0889551c 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -515,18 +515,7 @@ static struct platform_driver tps65090_regulator_driver = {
 	},
 	.probe		= tps65090_regulator_probe,
 };
-
-static int __init tps65090_regulator_init(void)
-{
-	return platform_driver_register(&tps65090_regulator_driver);
-}
-subsys_initcall(tps65090_regulator_init);
-
-static void __exit tps65090_regulator_exit(void)
-{
-	platform_driver_unregister(&tps65090_regulator_driver);
-}
-module_exit(tps65090_regulator_exit);
+subsys_platform_driver(tps65090_regulator_driver);
 
 MODULE_DESCRIPTION("tps65090 regulator driver");
 MODULE_AUTHOR("Venu Byravarasu <vbyravarasu@nvidia.com>");
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index b167ba22fe16..f55cc1a8079d 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -262,18 +262,7 @@ static struct platform_driver tps65217_regulator_driver = {
 	},
 	.probe = tps65217_regulator_probe,
 };
-
-static int __init tps65217_regulator_init(void)
-{
-	return platform_driver_register(&tps65217_regulator_driver);
-}
-subsys_initcall(tps65217_regulator_init);
-
-static void __exit tps65217_regulator_exit(void)
-{
-	platform_driver_unregister(&tps65217_regulator_driver);
-}
-module_exit(tps65217_regulator_exit);
+subsys_platform_driver(tps65217_regulator_driver);
 
 MODULE_AUTHOR("AnilKumar Ch <anilkumar@ti.com>");
 MODULE_DESCRIPTION("TPS65217 voltage regulator driver");
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 1ab5767590f3..a144b4c5ed20 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -524,18 +524,7 @@ static struct platform_driver tps6586x_regulator_driver = {
 	},
 	.probe		= tps6586x_regulator_probe,
 };
-
-static int __init tps6586x_regulator_init(void)
-{
-	return platform_driver_register(&tps6586x_regulator_driver);
-}
-subsys_initcall(tps6586x_regulator_init);
-
-static void __exit tps6586x_regulator_exit(void)
-{
-	platform_driver_unregister(&tps6586x_regulator_driver);
-}
-module_exit(tps6586x_regulator_exit);
+subsys_platform_driver(tps6586x_regulator_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 3a3027e0b94e..61bb269fc7c6 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1259,18 +1259,7 @@ static struct platform_driver tps65910_driver = {
 	.probe = tps65910_probe,
 	.shutdown = tps65910_shutdown,
 };
-
-static int __init tps65910_init(void)
-{
-	return platform_driver_register(&tps65910_driver);
-}
-subsys_initcall(tps65910_init);
-
-static void __exit tps65910_cleanup(void)
-{
-	platform_driver_unregister(&tps65910_driver);
-}
-module_exit(tps65910_cleanup);
+subsys_platform_driver(tps65910_driver);
 
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
 MODULE_DESCRIPTION("TPS65910/TPS65911 voltage regulator driver");
diff --git a/drivers/regulator/tps68470-regulator.c b/drivers/regulator/tps68470-regulator.c
index de7db7690f6b..7aef0c12fbcc 100644
--- a/drivers/regulator/tps68470-regulator.c
+++ b/drivers/regulator/tps68470-regulator.c
@@ -185,17 +185,7 @@ static struct platform_driver tps68470_regulator_driver = {
  * registering before the drivers for the camera-sensors which use them bind.
  * subsys_initcall() ensures this when the drivers are builtin.
  */
-static int __init tps68470_regulator_init(void)
-{
-	return platform_driver_register(&tps68470_regulator_driver);
-}
-subsys_initcall(tps68470_regulator_init);
-
-static void __exit tps68470_regulator_exit(void)
-{
-	platform_driver_unregister(&tps68470_regulator_driver);
-}
-module_exit(tps68470_regulator_exit);
+subsys_platform_driver(tps68470_regulator_driver);
 
 MODULE_ALIAS("platform:tps68470-regulator");
 MODULE_DESCRIPTION("TPS68470 voltage regulator driver");
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index d09864bae5ef..8dfc24a74765 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1310,18 +1310,7 @@ static struct platform_driver wm8350_regulator_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-
-static int __init wm8350_regulator_init(void)
-{
-	return platform_driver_register(&wm8350_regulator_driver);
-}
-subsys_initcall(wm8350_regulator_init);
-
-static void __exit wm8350_regulator_exit(void)
-{
-	platform_driver_unregister(&wm8350_regulator_driver);
-}
-module_exit(wm8350_regulator_exit);
+subsys_platform_driver(wm8350_regulator_driver);
 
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index fb3ca7956d00..f9b9973b70e5 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -257,18 +257,7 @@ int wm8400_register_regulator(struct device *dev, int reg,
 	return platform_device_register(&wm8400->regulators[reg]);
 }
 EXPORT_SYMBOL_GPL(wm8400_register_regulator);
-
-static int __init wm8400_regulator_init(void)
-{
-	return platform_driver_register(&wm8400_regulator_driver);
-}
-subsys_initcall(wm8400_regulator_init);
-
-static void __exit wm8400_regulator_exit(void)
-{
-	platform_driver_unregister(&wm8400_regulator_driver);
-}
-module_exit(wm8400_regulator_exit);
+subsys_platform_driver(wm8400_regulator_driver);
 
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("WM8400 regulator driver");
-- 
2.51.0

