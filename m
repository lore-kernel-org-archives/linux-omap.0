Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AB4A014B;
	Thu, 10 Sep 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053144; cv=fail; b=rTs+4oOQjtzhj30GzDOvcpXe0JDn5w8qFM6ZTdEuSfpBN7NdjN1nVmQ8Tq000OagCwBPW12tQCpKCL5lFzBri6l2Pei7s9Q05qBZTMY9kLd61SbpIxk/mIvGj/FhYRDFwSYduoH87+MoqzJbafDPLvj9cgVRfW188rBk1v04gBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053144; c=relaxed/simple;
	bh=6JqOsxzUQ8y/6s5xVseY/S4LLB3v2fNGtzXHNT6qCY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mcww63R1q+ChcDXyG6o5yvLXiMhMomj1KkMBL7a9zRyUY5tNiAJ4eJFLa252+piCcsaf5SxEFnTI3XpFdcHDMVTsKVFw5vffnF2FcmnoYlH7ZTiqh7qluoMpvW7WTx0TKGcIHgFo8WVYNKSxFfIzkI9gMIaL1IXaOwpxx026SOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I4HGYA/O; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I4HGYA/O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2MbLQwfnlP3zQCcj50E5+cLC4Jxs3OhIxl8vRl4j3eBYVWn0gplg/E5tLbcQed8hNBCB6DLUzZ6gYp6YCLdKkE/Ba3/caceouiKJIk8/TFtkDUoF08o5rIGYnOMtsrRAysjG8KZURbgutiLVOXEAkZziyQZEf0V7WfT9R0TRF2O326vTN0dMAJRpecSaDN9g8ci2k9YgK0wM0tBViSaU34Xvv/TPsOLpXf/wQS+XSdwlsWTZr8aPQOWpf2830OvWWZSoA2oSjmZkJB4acYpQuLU06miyuFw9ZK0eNrU0Qwk+7H6RIiNM9w/VTeiXZ36pIZRJ3v5lkJvyHRMPqfuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3KGXCnwyFU7uVDILK0w67eWYaEtipbcu6Enii2y9kw=;
 b=ROR11Z3Lic+gDb5PTAYHIaM61t3jFKnw9xarRO3ZZ8dfTH5JTHeAYAyo8w6N9dKNVm0wSWivympF9dBMJlbZQT7G5bxvYC6KcNe47kEAQvLFbHJ4QCXYD8IgWubDXMHmy2CQgRdSf/kJM8TAgWdZ+dF1ESipMdo4X7ViGYXMIf3mdrH4CC4WJWehq3nQ9qYSsf6HXPzZ5f/Gpgw6hEp5h0tV+KDwMVLXKegg4VB99nEaqZyz0P6O5k3h1tIja1Q/WsVI83rqSK9fXJbgEscr6147jNedNjRS915GvpvnQsMeApSiAO2xRNiLhNttXu7HcjnZAdWAXYkKGJSiWokEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3KGXCnwyFU7uVDILK0w67eWYaEtipbcu6Enii2y9kw=;
 b=I4HGYA/OOHEZ6674aqj9KbQHzLFWMwS8nbZy0lHIYqMRDisIk6uQRuPtXjIsRLhZWse6EoDzGNqTSeHz/q2TuYE1l4r/a/Kl3n14dE7kur7xKNX3Aw5fpI2sx6n4jl022PsjOdqrTaRmWWsaJAM+8A/riKSEs80k0fWA/7FsJG8N/xqIiKk/C2wjWi3tuSDUKmpb56ytGpveJZOqBXLvf4/QiiDxaZY13OXb/Oe28oRwUExucFRD+UUln63vNPk9rkNCK3INutu7kALnD0SjUrWbdsOlZDoYMhYd/8axnJ1pd4zGAP7HfqcYrtPSz2zifE+IweZvGPYxcE8MkkBQYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 15:12:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 15:12:08 +0000
Date: Thu, 10 Sep 2026 10:11:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 07/13] ARM: imx: remove i.MX31 SoC support
Message-ID: <aqLIuIwpToxyehkv@SMW015318>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-8-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-8-arnd@kernel.org>
X-ClientProxiedBy: CYZPR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:930:8f::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: fc009761-23b3-4d75-4566-08df0f4de18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	+nmpR7ulSd7bSvLgRdzz+zBHI+q720n5dv8ZqHsszhN3vLQ96VeH52isC/1MwGV/At7h/9/V0hXlLW35v0P7gNKmb7KMA23HG8zNfKtQe4TN6AZnRaJhbxM9oOJ8OGsmbAA0xeNsvp2A6Xv84imFY/+xg4e3xfYCBjxjY6DO9n0CSwZ7Sx1Bi5VH8878VA9HvQwbMKkfdEiPkGToKFy/RJq6z0rGkKByn/ny3MneVXhLu51XBJe+Jm5RLPhdonuqWyV9Ts0fMuA0bm9y6WfGotT9s7s1DveWtOtQDNL91YDsHWdCuiACDonEr7+hYAkcqHH0G/sROBp5qrkBkNAnQTtZP6frJ2Yg529kHfhKU7mSrllH+BlcWp2CzM2a2yRti6pNkNIGqAGY+AZ5HLkfhvgOKYvY8c3P9JcgcOoQENZiEdlugmesAiCAaSIeD2O94TtUeEcyw0+3YsCRaNrk5zga0ju+xdK10fkOClJliWfPYD1PpOYjzIyqD5uKplzIMKCEMysuE+ne/zbgJNy8gFrcDjJFgCfKed9rnQJbEtmTlpZbxXACYmRZ739NQF+al+E13UI/kGimyK0v+UgFooS0vvVCDFfXi7rAo8aq6s1urQBIaz2eVOtCTXgite7n+eRIRgQyN4LqR04qVLhKB7j/8EW/QGr3F2hhZI9oZyvnM8wKaGJnrdNBMCSDrftYinPGSVAlzHLdq4vba0pT0V3SmYttY5RW9C2lqoglwcA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OZs0ZkcZJFsFHKeE7XBu6mSTSjpQ6uNj2b1i/vrJ3STqRdhKPtTevrl6BT4h?=
 =?us-ascii?Q?NkYtCcHJeJhMECB/JrjK+hPWPhbvoNDU9znDgYbTNAvqY4ZgMX3ZtcBfY2z+?=
 =?us-ascii?Q?ASKjknidDVK8rPogWQzvLxrOErse2cxKki3cyxYu2P2vmHxdaJa7h8P33CX5?=
 =?us-ascii?Q?Z9Y14DXKlp7taDt0+rtSrCbaREyug49jPOUH07ekjfaPDfPlJrsjxUuHWr1P?=
 =?us-ascii?Q?1+pRHdnIQUT1GKUfh0wVw1vbl8AL5cE/16gzFOkRW6Icuzybkw5dJp7RUb7G?=
 =?us-ascii?Q?TElUXkX2DEzSwgoWv4ydUa4Zk6E/Ue3qayqhHGY6+41cpSIZVeGuMc1B/Hcq?=
 =?us-ascii?Q?hhyDAx/UdalRc5l/jBHEdiMgpVxNBONPPQY6qeBBkvRTnfaZ8ICOpmmUbB+4?=
 =?us-ascii?Q?sWh4pQTlaZaST8t7GKdaknDGBw6G9rIyafLy+JW/gehP5XbOdYjpTC3dWfq9?=
 =?us-ascii?Q?nn/MGPoGPmlLIixsHRxAvdC3gsDudcZvjjrtYocrZn5I+TqV8mACoc1XZn/7?=
 =?us-ascii?Q?z1W+cgZT07dF4idgZJ5E6xCfAGULzPXHLdicpuWcwqlV0CgpjlWRrnsINZBe?=
 =?us-ascii?Q?Yd/Q/bxnDjK3OUa74rWhvq1MW9dLQbTkWYjiutEmzutF8IX7jHp5phLQqHol?=
 =?us-ascii?Q?V1Jiq89cw53/SPQC/REIQkGgU8B9mAY8kru+jtX9lfNHwZ4afmrmEmEgLguA?=
 =?us-ascii?Q?UWAnmjsgvXE1OQVE+CpNUNJOclJqbfqjMmTlzNTOu2dDQ89lBqzuEgNIWLf6?=
 =?us-ascii?Q?BmVUgCFJxMbQv6uTbRa1HFUBty461xwPoYf/PmEGhitNiFx1/Eq3b7NYVaxC?=
 =?us-ascii?Q?c4FzMGAdBCOUfljtytyXFYvZphIWvpZVJZsajZmudLk0av4rhfD3MG02c7KJ?=
 =?us-ascii?Q?TWlB3uT1wMlAYjVYoTwzL4V7zkV/9t9sKPQ9drIIsuw7uPr5Z7PaF9hGPGqx?=
 =?us-ascii?Q?/0zPjQ4dnTl3NoLG8SfvxUHgVDaajUp581WN+mrfckl/pcDlYy4cQ6o2U1GC?=
 =?us-ascii?Q?Da2figekRD4DLcWNWJTSCKQfJlC5xJ4zG7uboqgC9E3Q1VqocYg7Pq3d0c2Y?=
 =?us-ascii?Q?nA/c53RT6dmOcZMcco5MVEmTqzfgNYWmLaC+tpxZcN3OAb2xmoOHCKYo5OZ6?=
 =?us-ascii?Q?dp4ZJQtm5q4rN7UtpMEZcETWF0ai0xXjiN/31/gVp1VSQ5sdl6NeijJ+YOD8?=
 =?us-ascii?Q?jh2ekJXAKkgKdly38RjtqZWMtflBBWbSV0Tw8cKHOIujoLuR2UvyS4ObD/1Y?=
 =?us-ascii?Q?AccagiaUcUlSgNPsvPDRkZe2hqp0KuEqswx4F/QrbANEpQ0BeYKneWeeodkv?=
 =?us-ascii?Q?cOosEtDWd8QIWVNs2aMxWv7zx7C7O4+x6CVnAos8tGGYmjoQMPgODm0i6Y1O?=
 =?us-ascii?Q?yexkahG5XSg3HNrPqYpbNBEG6rOuvapKRVIB9yFMM0qtV8UTka4Fgq1vReue?=
 =?us-ascii?Q?NauSzEu/RUIYcv/o4EBzUy0mCxsW8iqLzTpJJac6MUB/Opi/KoZf5C/tcWUS?=
 =?us-ascii?Q?zgiug/u5WwAvlxIJJDZGuoNW1/0JrQvFFlyMDkao6ENRC4Ps8XEZszo7qqFx?=
 =?us-ascii?Q?m+wNObeLnGnxici3xwFBtydc8LPrbNLrKMZM2PwoFe1zbqC7zGoLTDCWQyu7?=
 =?us-ascii?Q?U4mGV8t3oCn0x/pOYzi+tK719LOelnGzCmXMmnNtijhyq4tlWQzO7ezQ3hUd?=
 =?us-ascii?Q?JOFPCtCNTzwLBiR+D0QCogWsFNLiIwD9oFwDSabfjbUr/mE26ovOZ4iRqnAo?=
 =?us-ascii?Q?PiWzOHutt7aja9u0zQyXl4slujb6Kbzxy9bPC+AQfllrrK8wvMc6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc009761-23b3-4d75-4566-08df0f4de18e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 15:12:08.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQT7mpww3iMmaz/oGkaxxljv+oOMpjMJVthqWjUP7ZSP7EQMnuDo6nTiERH4PYhabCPCaEK+4L/TyFHhpwvliH0WJkJA4XOeIIgf8Ta58wn0N+0+JrMq08ziQZEy72KP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

On Tue, Sep 08, 2026 at 05:27:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The Freescale i.MX31 was an early SoC based on the ARM1136r0 CPU core. It
> was used in the Bug Labs modular computer but ultimately much less
> popular than most other i.MX SoCs.
>
> As the ARM1136r0 support is causing a lot of extra maintenance effort
> to keep alive and there are no known users, remove i.MX31 in order to
> allow removing support for that CPU core altogether.
>
> The related i.MX35 is based on a slightly newer ARM1136r1 CPU core that
> does not have this problem, so there is no reason to remove that.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: imx@lists.linux.dev
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Frank Li <Frank.Li@nxp.com>


>  arch/arm/Kconfig.debug                   |   9 -
>  arch/arm/boot/dts/nxp/imx/Makefile       |   3 -
>  arch/arm/boot/dts/nxp/imx/imx31-bug.dts  |  22 --
>  arch/arm/boot/dts/nxp/imx/imx31-lite.dts | 178 -----------
>  arch/arm/boot/dts/nxp/imx/imx31.dtsi     | 371 -----------------------
>  arch/arm/configs/imx_v6_v7_defconfig     |   1 -
>  arch/arm/mach-imx/Kconfig                |  11 -
>  arch/arm/mach-imx/Makefile               |   1 -
>  arch/arm/mach-imx/cpu-imx31.c            |  72 -----
>  arch/arm/mach-imx/mach-imx31.c           |  18 --
>  arch/arm/mach-imx/mm-imx3.c              |  44 ---
>  11 files changed, 730 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31-bug.dts
>  delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31-lite.dts
>  delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31.dtsi
>  delete mode 100644 arch/arm/mach-imx/cpu-imx31.c
>  delete mode 100644 arch/arm/mach-imx/mach-imx31.c
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e2fc89055463..52387fe2a057 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -424,13 +424,6 @@ choice
>  		  Say Y here if you want kernel low-level debugging support
>  		  on i.MX28.
>
> -	config DEBUG_IMX31_UART
> -		bool "i.MX31 Debug UART"
> -		depends on SOC_IMX31
> -		help
> -		  Say Y here if you want kernel low-level debugging support
> -		  on i.MX31.
> -
>  	config DEBUG_IMX35_UART
>  		bool "i.MX35 Debug UART"
>  		depends on SOC_IMX35
> @@ -1411,7 +1404,6 @@ config DEBUG_IMX_UART_PORT
>  	depends on DEBUG_IMX1_UART || \
>  		   DEBUG_IMX25_UART || \
>  		   DEBUG_IMX27_UART || \
> -		   DEBUG_IMX31_UART || \
>  		   DEBUG_IMX35_UART || \
>  		   DEBUG_IMX50_UART || \
>  		   DEBUG_IMX51_UART || \
> @@ -1468,7 +1460,6 @@ config DEBUG_LL_INCLUDE
>  	default "debug/imx.S" if DEBUG_IMX1_UART || \
>  				 DEBUG_IMX25_UART || \
>  				 DEBUG_IMX27_UART || \
> -				 DEBUG_IMX31_UART || \
>  				 DEBUG_IMX35_UART || \
>  				 DEBUG_IMX50_UART || \
>  				 DEBUG_IMX51_UART || \
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 1a2539fa19b4..e0747cb6e772 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -16,9 +16,6 @@ dtb-$(CONFIG_SOC_IMX27) += \
>  	imx27-pdk.dtb \
>  	imx27-phytec-phycore-rdk.dtb \
>  	imx27-phytec-phycard-s-rdk.dtb
> -dtb-$(CONFIG_SOC_IMX31) += \
> -	imx31-bug.dtb \
> -	imx31-lite.dtb
>  dtb-$(CONFIG_SOC_IMX35) += \
>  	imx35-eukrea-mbimxsd35-baseboard.dtb \
>  	imx35-pdk.dtb
> diff --git a/arch/arm/boot/dts/nxp/imx/imx31-bug.dts b/arch/arm/boot/dts/nxp/imx/imx31-bug.dts
> deleted file mode 100644
> index d87eee3f9b3c..000000000000
> --- a/arch/arm/boot/dts/nxp/imx/imx31-bug.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2012 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> - */
> -
> -/dts-v1/;
> -#include "imx31.dtsi"
> -
> -/ {
> -	model = "Buglabs i.MX31 Bug 1.x";
> -	compatible = "buglabs,imx31-bug", "fsl,imx31";
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0x80000000 0x8000000>; /* 128M */
> -	};
> -};
> -
> -&uart5 {
> -	uart-has-rtscts;
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx31-lite.dts b/arch/arm/boot/dts/nxp/imx/imx31-lite.dts
> deleted file mode 100644
> index 630f8fa69ba8..000000000000
> --- a/arch/arm/boot/dts/nxp/imx/imx31-lite.dts
> +++ /dev/null
> @@ -1,178 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -//
> -// Copyright (C) 2016-2018 Vladimir Zapolskiy <vz@mleia.com>
> -
> -/dts-v1/;
> -
> -#include "imx31.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -
> -/ {
> -	model = "LogicPD i.MX31 Lite";
> -	compatible = "logicpd,imx31-lite", "fsl,imx31";
> -
> -	chosen {
> -		stdout-path = &uart1;
> -	};
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		reg = <0x80000000 0x8000000>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		led0 {
> -			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> -		};
> -
> -		led1 {
> -			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> -		};
> -	};
> -};
> -
> -&ata {
> -	status = "okay";
> -};
> -
> -&nfc {
> -	nand-bus-width = <8>;
> -	nand-ecc-mode = "hw";
> -	nand-on-flash-bbt;
> -	status = "okay";
> -};
> -
> -&sdhci1 {
> -	bus-width = <4>;
> -	cd-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> -	wp-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "fsl,mc13783";
> -		reg = <0>;
> -		spi-cs-high;
> -		spi-max-frequency = <1000000>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
> -
> -		fsl,mc13xxx-uses-adc;
> -		fsl,mc13xxx-uses-rtc;
> -
> -		regulators {
> -			sw1a {		/* QVCC */
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			sw1b {		/* QVCC */
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			sw2a {		/* 1.8V_DDR, NVCC2, NVCC21 and NVCC22 */
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			sw2b {		/* NVCC10 */
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			violo {		/* NVCC1 and NVCC7 */
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			viohi {		/* VIOHI */
> -				regulator-min-microvolt = <2775000>;
> -				regulator-max-microvolt = <2775000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			vaudio {	/* VAUDIO */
> -				regulator-min-microvolt = <2775000>;
> -				regulator-max-microvolt = <2775000>;
> -			};
> -
> -			vcam {		/* NVCC4 */
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -			};
> -
> -			vgen {		/* NVCC5 / NVCC8 and NVCC6 / NVCC9 */
> -				regulator-min-microvolt = <2775000>;
> -				regulator-max-microvolt = <2775000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -
> -			vmmc2 {		/* NVCC3 */
> -				regulator-min-microvolt = <1600000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -		};
> -	};
> -};
> -
> -&uart1 {
> -	uart-has-rtscts;
> -	status = "okay";
> -};
> -
> -/* Routed to the extension board */
> -&uart2 {
> -	uart-has-rtscts;
> -	status = "okay";
> -};
> -
> -/* Routed to the extension board */
> -&uart3 {
> -	uart-has-rtscts;
> -	status = "okay";
> -};
> -
> -&weim {
> -	status = "okay";
> -
> -	flash@0,0 {
> -		compatible = "cfi-flash";
> -		reg = <0 0x0 0x200000>;
> -		bank-width = <2>;
> -		linux,mtd-name = "physmap-flash.0";
> -		fsl,weim-cs-timing = <0x0000cf03 0xa0330d01 0x00220800>;
> -	};
> -
> -	ethernet@4,0 {
> -		compatible = "smsc,lan9117", "smsc,lan9115";
> -		reg = <4 0x0 0x100>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> -		phy-mode = "mii";
> -		reg-io-width = <2>;
> -		smsc,irq-push-pull;
> -		fsl,weim-cs-timing = <0x00008701 0x04000541 0x00010000>;
> -	};
> -};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx31.dtsi b/arch/arm/boot/dts/nxp/imx/imx31.dtsi
> deleted file mode 100644
> index c58f855ea851..000000000000
> --- a/arch/arm/boot/dts/nxp/imx/imx31.dtsi
> +++ /dev/null
> @@ -1,371 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -//
> -// Copyright 2016-2018 Vladimir Zapolskiy <vz@mleia.com>
> -// Copyright 2012 Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	/*
> -	 * The decompressor and also some bootloaders rely on a
> -	 * pre-existing /chosen node to be available to insert the
> -	 * command line and merge other ATAGS info.
> -	 */
> -	chosen {};
> -
> -	aliases {
> -		gpio0 = &gpio1;
> -		gpio1 = &gpio2;
> -		gpio2 = &gpio3;
> -		i2c0 = &i2c1;
> -		i2c1 = &i2c2;
> -		i2c2 = &i2c3;
> -		serial0 = &uart1;
> -		serial1 = &uart2;
> -		serial2 = &uart3;
> -		serial3 = &uart4;
> -		serial4 = &uart5;
> -		spi0 = &spi1;
> -		spi1 = &spi2;
> -		spi2 = &spi3;
> -	};
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpu@0 {
> -			compatible = "arm,arm1136jf-s";
> -			device_type = "cpu";
> -			reg = <0>;
> -		};
> -	};
> -
> -	avic: interrupt-controller@68000000 {
> -		compatible = "fsl,imx31-avic", "fsl,avic";
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		reg = <0x68000000 0x100000>;
> -	};
> -
> -	soc: soc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "simple-bus";
> -		interrupt-parent = <&avic>;
> -		ranges;
> -
> -		iram: sram@1fffc000 {
> -			compatible = "mmio-sram";
> -			reg = <0x1fffc000 0x4000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0x1fffc000 0x4000>;
> -		};
> -
> -		aips1: bus@43f00000 { /* AIPS1 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x43f00000 0x100000>;
> -			ranges;
> -
> -			i2c1: i2c@43f80000 {
> -				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
> -				reg = <0x43f80000 0x4000>;
> -				interrupts = <10>;
> -				clocks = <&clks 33>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			i2c3: i2c@43f84000 {
> -				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
> -				reg = <0x43f84000 0x4000>;
> -				interrupts = <3>;
> -				clocks = <&clks 35>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			ata: ata@43f8c000 {
> -				compatible = "fsl,imx31-pata", "fsl,imx27-pata";
> -				reg = <0x43f8c000 0x4000>;
> -				interrupts = <15>;
> -				clocks = <&clks 26>;
> -				status = "disabled";
> -			};
> -
> -			uart1: serial@43f90000 {
> -				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
> -				reg = <0x43f90000 0x4000>;
> -				interrupts = <45>;
> -				clocks = <&clks 10>, <&clks 30>;
> -				clock-names = "ipg", "per";
> -				status = "disabled";
> -			};
> -
> -			uart2: serial@43f94000 {
> -				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
> -				reg = <0x43f94000 0x4000>;
> -				interrupts = <32>;
> -				clocks = <&clks 10>, <&clks 31>;
> -				clock-names = "ipg", "per";
> -				status = "disabled";
> -			};
> -
> -			i2c2: i2c@43f98000 {
> -				compatible = "fsl,imx31-i2c", "fsl,imx21-i2c";
> -				reg = <0x43f98000 0x4000>;
> -				interrupts = <4>;
> -				clocks = <&clks 34>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			spi1: spi@43fa4000 {
> -				compatible = "fsl,imx31-cspi";
> -				reg = <0x43fa4000 0x4000>;
> -				interrupts = <14>;
> -				clocks = <&clks 10>, <&clks 53>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma 8 8 0>, <&sdma 9 8 0>;
> -				dma-names = "rx", "tx";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			kpp: kpp@43fa8000 {
> -				compatible = "fsl,imx31-kpp", "fsl,imx21-kpp";
> -				reg = <0x43fa8000 0x4000>;
> -				interrupts = <24>;
> -				clocks = <&clks 46>;
> -				status = "disabled";
> -			};
> -
> -			uart4: serial@43fb0000 {
> -				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
> -				reg = <0x43fb0000 0x4000>;
> -				clocks = <&clks 10>, <&clks 49>;
> -				clock-names = "ipg", "per";
> -				interrupts = <46>;
> -				status = "disabled";
> -			};
> -
> -			uart5: serial@43fb4000 {
> -				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
> -				reg = <0x43fb4000 0x4000>;
> -				interrupts = <47>;
> -				clocks = <&clks 10>, <&clks 50>;
> -				clock-names = "ipg", "per";
> -				status = "disabled";
> -			};
> -		};
> -
> -		spba-bus@50000000 {
> -			compatible = "fsl,spba-bus", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x50000000 0x100000>;
> -			ranges;
> -
> -			sdhci1: mmc@50004000 {
> -				compatible = "fsl,imx31-mmc";
> -				reg = <0x50004000 0x4000>;
> -				interrupts = <9>;
> -				clocks = <&clks 10>, <&clks 20>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma 20 3 0>;
> -				dma-names = "rx-tx";
> -				status = "disabled";
> -			};
> -
> -			sdhci2: mmc@50008000 {
> -				compatible = "fsl,imx31-mmc";
> -				reg = <0x50008000 0x4000>;
> -				interrupts = <8>;
> -				clocks = <&clks 10>, <&clks 21>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma 21 3 0>;
> -				dma-names = "rx-tx";
> -				status = "disabled";
> -			};
> -
> -			uart3: serial@5000c000 {
> -				compatible = "fsl,imx31-uart", "fsl,imx21-uart";
> -				reg = <0x5000c000 0x4000>;
> -				interrupts = <18>;
> -				clocks = <&clks 10>, <&clks 48>;
> -				clock-names = "ipg", "per";
> -				status = "disabled";
> -			};
> -
> -			spi2: spi@50010000 {
> -				compatible = "fsl,imx31-cspi";
> -				reg = <0x50010000 0x4000>;
> -				interrupts = <13>;
> -				clocks = <&clks 10>, <&clks 54>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma 6 8 0>, <&sdma 7 8 0>;
> -				dma-names = "rx", "tx";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			iim: efuse@5001c000 {
> -				compatible = "fsl,imx31-iim";
> -				reg = <0x5001c000 0x1000>;
> -				interrupts = <19>;
> -				clocks = <&clks 25>;
> -			};
> -		};
> -
> -		bus@53f00000 { /* AIPS2 */
> -			compatible = "fsl,aips-bus", "simple-bus";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x53f00000 0x100000>;
> -			ranges;
> -
> -			clks: ccm@53f80000 {
> -				compatible = "fsl,imx31-ccm";
> -				reg = <0x53f80000 0x4000>;
> -				interrupts = <31>, <53>;
> -				#clock-cells = <1>;
> -			};
> -
> -			spi3: spi@53f84000 {
> -				compatible = "fsl,imx31-cspi";
> -				reg = <0x53f84000 0x4000>;
> -				interrupts = <17>;
> -				clocks = <&clks 10>, <&clks 28>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma 10 8 0>, <&sdma 11 8 0>;
> -				dma-names = "rx", "tx";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				status = "disabled";
> -			};
> -
> -			gpt: timer@53f90000 {
> -				compatible = "fsl,imx31-gpt";
> -				reg = <0x53f90000 0x4000>;
> -				interrupts = <29>;
> -				clocks = <&clks 10>, <&clks 22>;
> -				clock-names = "ipg", "per";
> -			};
> -
> -			gpio3: gpio@53fa4000 {
> -				compatible = "fsl,imx31-gpio";
> -				reg = <0x53fa4000 0x4000>;
> -				interrupts = <56>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			rng@53fb0000 {
> -				compatible = "fsl,imx31-rnga";
> -				reg = <0x53fb0000 0x4000>;
> -				interrupts = <22>;
> -				clocks = <&clks 29>;
> -			};
> -
> -			gpio1: gpio@53fcc000 {
> -				compatible = "fsl,imx31-gpio";
> -				reg = <0x53fcc000 0x4000>;
> -				interrupts = <52>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			gpio2: gpio@53fd0000 {
> -				compatible = "fsl,imx31-gpio";
> -				reg = <0x53fd0000 0x4000>;
> -				interrupts = <51>;
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -
> -			sdma: dma-controller@53fd4000 {
> -				compatible = "fsl,imx31-sdma";
> -				reg = <0x53fd4000 0x4000>;
> -				interrupts = <34>;
> -				clocks = <&clks 10>, <&clks 27>;
> -				clock-names = "ipg", "ahb";
> -				#dma-cells = <3>;
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx31.bin";
> -			};
> -
> -			rtc: rtc@53fd8000 {
> -				compatible = "fsl,imx31-rtc", "fsl,imx21-rtc";
> -				reg = <0x53fd8000 0x4000>;
> -				interrupts = <25>;
> -				clocks = <&clks 2>, <&clks 40>;
> -				clock-names = "ref", "ipg";
> -			};
> -
> -			wdog: watchdog@53fdc000 {
> -				compatible = "fsl,imx31-wdt", "fsl,imx21-wdt";
> -				reg = <0x53fdc000 0x4000>;
> -				clocks = <&clks 41>;
> -				interrupts = <55>;
> -			};
> -
> -			pwm: pwm@53fe0000 {
> -				compatible = "fsl,imx31-pwm", "fsl,imx27-pwm";
> -				reg = <0x53fe0000 0x4000>;
> -				interrupts = <26>;
> -				clocks = <&clks 10>, <&clks 42>;
> -				clock-names = "ipg", "per";
> -				#pwm-cells = <3>;
> -				status = "disabled";
> -			};
> -		};
> -
> -		emi-bus@b8000000 { /* External Memory Interface */
> -			compatible = "simple-bus";
> -			reg = <0xb8000000 0x5000>;
> -			ranges;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			nfc: nand-controller@b8000000 {
> -				compatible = "fsl,imx31-nand", "fsl,imx27-nand";
> -				reg = <0xb8000000 0x1000>;
> -				interrupts = <33>;
> -				clocks = <&clks 9>;
> -				dmas = <&sdma 30 17 0>;
> -				dma-names = "rx-tx";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				status = "disabled";
> -			};
> -
> -			weim: memory-controller@b8002000 {
> -				compatible = "fsl,imx31-weim", "fsl,imx27-weim";
> -				reg = <0xb8002000 0x1000>;
> -				clocks = <&clks 56>;
> -				#address-cells = <2>;
> -				#size-cells = <1>;
> -				ranges = <0 0 0xa0000000 0x08000000
> -					  1 0 0xa8000000 0x08000000
> -					  2 0 0xb0000000 0x02000000
> -					  3 0 0xb2000000 0x02000000
> -					  4 0 0xb4000000 0x02000000
> -					  5 0 0xb6000000 0x02000000>;
> -				status = "disabled";
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index ed588add8d31..6ac42c06c1e9 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -15,7 +15,6 @@ CONFIG_PERF_EVENTS=y
>  CONFIG_KEXEC=y
>  CONFIG_ARCH_MULTI_V6=y
>  CONFIG_ARCH_MXC=y
> -CONFIG_SOC_IMX31=y
>  CONFIG_SOC_IMX35=y
>  CONFIG_SOC_IMX50=y
>  CONFIG_SOC_IMX51=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3f0521c652cb..77704c6a70ba 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -39,17 +39,6 @@ if ARCH_MULTI_V6
>
>  comment "ARM1136 platforms"
>
> -config SOC_IMX31
> -	bool "i.MX31 support (DEPRECATED)"
> -	depends on !SMP
> -	select CPU_ARM1136R0
> -	select MXC_AVIC
> -	help
> -	  This enables support for Freescale i.MX31 processor
> -
> -	  This SoC is scheduled for removal in early 2027,
> -	  since it uses the ARM1136r0 CPU revision.
> -
>  config SOC_IMX35
>  	bool "i.MX35 support"
>  	select CPU_ARM1136R1
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 5c650bf40e02..fa0144f0882d 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -5,7 +5,6 @@ obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o pm-imx25.o
>
>  obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o mach-imx27.o
>
> -obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o mach-imx31.o
>  obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o mach-imx35.o
>
>  imx5-pm-$(CONFIG_PM) += pm-imx5.o
> diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
> deleted file mode 100644
> index e81ef9e36a1f..000000000000
> --- a/arch/arm/mach-imx/cpu-imx31.c
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * MX31 CPU type detection
> - *
> - * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
> - */
> -
> -#include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/io.h>
> -
> -#include "common.h"
> -#include "hardware.h"
> -#include "iim.h"
> -
> -static int mx31_cpu_rev = -1;
> -
> -static struct {
> -	u8 srev;
> -	const char *name;
> -	unsigned int rev;
> -} mx31_cpu_type[] = {
> -	{ .srev = 0x00, .name = "i.MX31(L)", .rev = IMX_CHIP_REVISION_1_0 },
> -	{ .srev = 0x10, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
> -	{ .srev = 0x11, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
> -	{ .srev = 0x12, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
> -	{ .srev = 0x13, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
> -	{ .srev = 0x14, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_2 },
> -	{ .srev = 0x15, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_2 },
> -	{ .srev = 0x28, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_2_0 },
> -	{ .srev = 0x29, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_2_0 },
> -};
> -
> -static int mx31_read_cpu_rev(void)
> -{
> -	void __iomem *iim_base;
> -	struct device_node *np;
> -	u32 i, srev;
> -	int rev = IMX_CHIP_REVISION_UNKNOWN;
> -
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-iim");
> -	iim_base = of_iomap(np, 0);
> -	of_node_put(np);
> -	BUG_ON(!iim_base);
> -
> -	/* read SREV register from IIM module */
> -	srev = imx_readl(iim_base + MXC_IIMSREV);
> -	srev &= 0xff;
> -
> -	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
> -		if (srev == mx31_cpu_type[i].srev) {
> -			rev = mx31_cpu_type[i].rev;
> -			imx_print_silicon_rev(mx31_cpu_type[i].name,
> -						mx31_cpu_type[i].rev);
> -			goto out;
> -		}
> -
> -	imx_print_silicon_rev("i.MX31", IMX_CHIP_REVISION_UNKNOWN);
> -
> -out:
> -	iounmap(iim_base);
> -	return rev;
> -}
> -
> -int mx31_revision(void)
> -{
> -	if (mx31_cpu_rev == -1)
> -		mx31_cpu_rev = mx31_read_cpu_rev();
> -
> -	return mx31_cpu_rev;
> -}
> -EXPORT_SYMBOL(mx31_revision);
> diff --git a/arch/arm/mach-imx/mach-imx31.c b/arch/arm/mach-imx/mach-imx31.c
> deleted file mode 100644
> index e9a1092b6093..000000000000
> --- a/arch/arm/mach-imx/mach-imx31.c
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright 2012 Sascha Hauer, Pengutronix
> - */
> -
> -#include <asm/mach/arch.h>
> -#include "common.h"
> -
> -static const char * const imx31_dt_board_compat[] __initconst = {
> -	"fsl,imx31",
> -	NULL
> -};
> -
> -DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
> -	.map_io		= mx31_map_io,
> -	.init_early	= imx31_init_early,
> -	.dt_compat	= imx31_dt_board_compat,
> -MACHINE_END
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index 9b0b014d7fe2..42e73518004a 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -69,49 +69,6 @@ static void __iomem *imx3_ioremap_caller(phys_addr_t phys_addr, size_t size,
>  	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
>  }
>
> -#ifdef CONFIG_SOC_IMX31
> -static struct map_desc mx31_io_desc[] __initdata = {
> -	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
> -	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
> -	imx_map_entry(MX31, AIPS1, MT_DEVICE_NONSHARED),
> -	imx_map_entry(MX31, AIPS2, MT_DEVICE_NONSHARED),
> -	imx_map_entry(MX31, SPBA0, MT_DEVICE_NONSHARED),
> -};
> -
> -/*
> - * This function initializes the memory map. It is called during the
> - * system startup to create static physical to virtual memory mappings
> - * for the IO modules.
> - */
> -void __init mx31_map_io(void)
> -{
> -	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
> -}
> -
> -static void imx31_idle(void)
> -{
> -	int reg = imx_readl(mx3_ccm_base + MXC_CCM_CCMR);
> -	reg &= ~MXC_CCM_CCMR_LPM_MASK;
> -	imx_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
> -
> -	imx3_idle();
> -}
> -
> -void __init imx31_init_early(void)
> -{
> -	struct device_node *np;
> -
> -	mxc_set_cpu_type(MXC_CPU_MX31);
> -	arch_ioremap_caller = imx3_ioremap_caller;
> -	arm_pm_idle = imx31_idle;
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-ccm");
> -	mx3_ccm_base = of_iomap(np, 0);
> -	of_node_put(np);
> -	BUG_ON(!mx3_ccm_base);
> -}
> -#endif /* ifdef CONFIG_SOC_IMX31 */
> -
> -#ifdef CONFIG_SOC_IMX35
>  static struct map_desc mx35_io_desc[] __initdata = {
>  	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
>  	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
> @@ -147,4 +104,3 @@ void __init imx35_init_early(void)
>  	of_node_put(np);
>  	BUG_ON(!mx3_ccm_base);
>  }
> -#endif /* ifdef CONFIG_SOC_IMX35 */
> --
> 2.53.0
>
>
