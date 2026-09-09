Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A539A056;
	Wed,  9 Sep 2026 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942179; cv=fail; b=n1GVnxBTThEE42IlKAegI5h8LKDJhBuRxihbzUfdqQ9Qwt+tuLVBLbiF+08f4AkdaAsdg8CSFcP+io5NFvP9bj875GV8d/3UfVcDnnxFMnhDCQUjeXNQkkRVNx8XIj+piJpMSV0Xmou92ekqv41kFEGnmdurj/6FH4B8jqy9R0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942179; c=relaxed/simple;
	bh=l0yfWBJLxkHln3eNttBV5PCLa3SfuSUT7St307djuO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioCqpqItWre6rzNLhF79yrY/QUau5PFEczpQmpCsnTNyTQfJyIzHmCV+trJr35DfoHvWewVJ/dAAWfcvRqkHF7r1Zv8d5olNAqffKaFjtIdHV/6mnphe3wGfvEpXxy5ITX2ano3zkzpb45vwzhaTZK/gmQrSNzb0b0mgymIXuEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mwheJTwb; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mwheJTwb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty7pzSOOSDJAcOSbgY5pV3Z1Of2UfzWzwov2ni66Y4oXE3CxvREilmj/C2gTW4v38OO9/3g0cgFUIziwqkuIUPbVEUEgMunffJZaPF5Sx3kzL7xGXeD6WqJXUhCMP3kVY1xFkgtYAXiUN54vUaVajAfwzbjjjZEAiiVAfdxMW4EByAVGdr3vdmborSkM3FjU4PpHbitT70yIhyNcQ75YlU5TzBeAxn62S/EawhG+gY5DNdBNWrC74UGwYJ7BXXQzciXwp38RSr2PFQuBVh3BNHJUDR5crLinfdv3h65h6PFYAqcI+f2k9ZRPowVnry13nSNRYS4fKv6oZMfTpZ+5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wuqjSQ8IHg8O4qvBTdi7emdsh0w0ToGNdKAuXjoMto=;
 b=gtZ0mXnc6W/5HvOjZP7dWSitSMUdoFqnaxQLa8ppOoJBMLklTaG+MLPqAhNDyPj8yfXF4aWCpT9/UbXTYF/+SRMzqw4MC02kC3QbQpLgu5JQxDsT2F8b1HAvNrOcaGVBYbY8Ugudf5BxR98V/c8WzXXCTV2XLOfy4YdZJN+aGEXoKYZULTrRdQtk5UmlCSz7fvjEIQe35VY8QzkeDCSEFDwK6dBiOLzSkzXDqGVA8rmB5lU1k8QSdrzDYDdkb60vEnGNs7u/gDOfM+rwQDsY9dSHPmAqnwBHFGBD87UjH1/NFFuZVnk/FLsaoHTh73MNG8nNJ3dmSQDATTdWC4zcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wuqjSQ8IHg8O4qvBTdi7emdsh0w0ToGNdKAuXjoMto=;
 b=mwheJTwbcuq7xTIYEGDxdBcjMy6JGcBzYF/sNfDQhQ+3FKRJaOT2kfCMSH1pz8fvGSYgwKzWWrPR+ArVU1yixDGWPRnQK2p2S8riR5gcWTPM6eMfA87/Y+7jWc9G6TxFzPZ4kIF7x6ZgIbmMlUdH7+QXfzMcdvwRX56EbLemRbnP0FmKG4cDj/1bQ7V4uKxrJKN/b4srzPs+tf9q2uQ8Qbe3N/9PIzXvHufrqZYXU6gw+3zsyles6rzwRaiaAzEO4CqfX8A55vs4dhFumR8BtqkkByhB5iEstoSxaiOgCkKPfyVWUvrRzGDtxo+S8XLHN5hX5t1ySVJvcBO6cvuIdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AM9PR04MB8098.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 08:22:53 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:22:53 +0000
Message-ID: <57c51083-f0ae-4b4e-a8f8-a44c73be1b18@oss.nxp.com>
Date: Wed, 9 Sep 2026 11:26:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ARM: imx: remove i.MX31 SoC support
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-8-arnd@kernel.org>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260908152808.3928630-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0019.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::8) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AM9PR04MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3e3560-7fd1-4b20-7919-08df0e4b8b08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|7416014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	4hGSUw9FOYULwKxIcR2y2vjgWtB+xvZMFYQQPQ8KLfAB6KwGYjltOO2r0tj9roYayCqaCLFDmiBBXYETIbErk49jWHBNvzEYWsItzNOZHH0vilnHu/XpUkbjmVO/Blg70uExvQj6lzcDR/IQeV+h6H1GbRTAxtzGxxnb7Yxt1VRCsMxYNFJdjnHg0x7Grt4apA/AYRWycpY3Qoq2IMVayhlGP+1L3F0pdrFl+69YvrpfmqRzTpA+3kt5IZRXLq1he2kp+ejrfYW4O3TWZd0u860wEJP6b/ahfNhwtBXEKVz12MNIDDkDH+9rjnKMP3nWocgrgNf49arh4Wm4CmTnWrl5HQVhvFvp1AYx4ur7e3/Q6B0bEhQpSsVf1S86J75nEfB+eNCc4V0MPFXDl4gggTEa8ffKoZ2QTbXmku2iaZWiKaQapxP9qwrOPL8kB0OVxCpz/KbRGS235/VmnpIyiSY8eUVKNDGWR1RI/sNVBC6rrsr6vA1Ez8AMAbnVTPAKvh1eFzWvapVyi1TDYZ2BaeybAfM9+rBG9bAOuoiUVfU8Gwh7rXUXHqDDSwMNvd4ykekxAh64m+PvyhIk7V6jUCQnLnAAZXyIhlpS7pIU85oqt1DV7pCUQmOMmgr0GloCuqYvy2TADre4SLdyTp1gNrGInWpRx5eAYIWDKCcTXX98VfWEUjeoUBO+oF9vzbZuEoKaU2U0NnotChTkdTXXLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDdDUUtjM09QSWZ1SVo3aU5ZV1JuakcrMXJhYk9sc2ZBczR4Z1FZb0dneEdj?=
 =?utf-8?B?Mk5xZUhqVC9vdHVQSHVoOU5relV4UGNhSzQ1Q3FiVWJDTnBCOG9sMVJiMHJz?=
 =?utf-8?B?Zm9NQ1F0OW9lYXpzajBXRUZHQTVKSHpUMHJZcnI0Z0ZkM0VibjUvaDZJUkpZ?=
 =?utf-8?B?aEM3SFFjTFhhNzg3VHU1K2ZMbnViYTZnK3ROSlJLcm1OVzByMFJsVStHL29E?=
 =?utf-8?B?SlYxM3hvOUxUZXZZVjV6QlB1a0ZoelpuRHhHZnJJaGgwRVFhc1lqaGxmWDN5?=
 =?utf-8?B?VCtGUmhRMGtuNnp3Y0VZc1U4NGprSnFFNzY4YzVpdXF6dloySytiRkZZd3JB?=
 =?utf-8?B?b2ZWZHlXVVE2QzRTZEJRU1JUdGV6YldPdG1FRi83SnNtWmxhWk9QZ1JMTUUy?=
 =?utf-8?B?c0k0dG9paEhsU081K21IWEgzQldzbGJhTlFySFRwZGpPM3FWMVUzKzRQWktV?=
 =?utf-8?B?Q21ib1ViaHpBRmJWTGFCenpPZHFLYlAvUmE0U2xWT2lZN3RlV0E5eFIwL1RX?=
 =?utf-8?B?Q1ZSSDBlbUhMZGdXYWZ2dmtJbzZiNFcvWktGUWpSTnZVME9Rd2ZCaEx1Y1Mx?=
 =?utf-8?B?azhNbHhDYkxTZjl4VTQrdmozQW5NRk9sVjA5ZFUwMndpZzRxN09BYXFGcnFk?=
 =?utf-8?B?dklZZnhmUzIvd1FwTDA2dnRKY2RrODNOdXJiY1lKWTFoQmJQZGlZUjM4a28x?=
 =?utf-8?B?Q3pyZUU2QiswTjFwSFNUUkdFV3lGNzVZRnR6QlVld2pmYkt0YUpkZUhoNDV2?=
 =?utf-8?B?M25JUDdnanI2WXFxbkxmTVFqejB5REtQS25YQm5HZnBIUzJXMjJjdmkrZDNt?=
 =?utf-8?B?dUlPSkV1akwrcThoSkZRdG9iTG94UXc1NzdXdGRLZmpPWFpLOHNqWXIwN1hG?=
 =?utf-8?B?NnZuMjVFWU9IY0hOYStaNkJreXhiY2RWQXduUWJFQW4xRmcyZUp3VFhpbFo0?=
 =?utf-8?B?T211aW5oSnpIZkphajkwNEl5Mk04K3hyZHplRnJXdW1jZW56ek10RmsrbU84?=
 =?utf-8?B?eWxlWkJ6NUpaSTUvM2N5QjhBempGVEJtTEdSVWdaZlB6QUpzY1liM0hRUXg2?=
 =?utf-8?B?d29BNU91SHRLL1VYZjl2YU52U3kxaFRYV3JSS3NWVTFLSGV2UG1DYmpaTHV5?=
 =?utf-8?B?ekRqdE9PbEFVVzJWQ0lReFh0QkRWSXlqa1FwM21mR0kvV3krTFZ5TmlWL2tS?=
 =?utf-8?B?UTgxeW5sNE5zR2ZkNkYrbEtVYTJPb0FDUVphTEt1dnphT2JrczV0NzdqN285?=
 =?utf-8?B?WkpHYmVlOEJvRmhRQjc4dFlJQzlJVXJFclNYS04wV3laS3AxYlFIVEsvcHBR?=
 =?utf-8?B?WVNmc3RWU281Q2wxaThuNWZNTHhFZGdNeVZWSjBhVFUwdllqTlFtUzlFQmVi?=
 =?utf-8?B?aHIxaGtKR29xcEtVTkZRMEdaVTI0TGFNOE8xOExhYTUrNEEvVDh2akhqWjM5?=
 =?utf-8?B?YkF3VnhQcGtSTG1INVlUUVVUa0p2UjluRmVKSTYzVnBlSkpQT096MkgyMXh6?=
 =?utf-8?B?UERCSTRTSm5WeFJUL1A5cmUwenhQbFMzVXY2TllTV09RN2ZxNHkrRWwzZzNG?=
 =?utf-8?B?UzBoNEcxcm9aSUc3UFhMQmM0V0RxS3FEbjlGemR3T1Z4dUJlRFUxMTJLME9t?=
 =?utf-8?B?UlQzYngzNXNLQ1ZEY1ZTQkV3RFlGSFJTYkh4L1RpbEdhVHRXblJvdTZPOXF6?=
 =?utf-8?B?ZUtzS01HdkRkQXhNd2RSYkE1bkxteVpvQjEwcmpXQ1djbDM2K3E5NnhvRXZn?=
 =?utf-8?B?dnhPdzI5OVZKMUN0aGIyOTl1d3ViSmRSei9yWmRSMzRERlhZc1NrcUpERm9U?=
 =?utf-8?B?K0hNVHZPVTkwQ3hwQnFuVWRBTHYwVzhMMVR4SXRrdU5UUmpLOXh3QlE5ZUts?=
 =?utf-8?B?U29rTHluNVppY0xFYTNuTXdaSE9RQTVmNXBqYmJIbU9UWVZ2WWgyd2FHSWRS?=
 =?utf-8?B?MkdRb1V0K052TjJwcVR5TEJrTmthNFg2dy9XNHA2VmV1cXJlbnY1aEI5ckFk?=
 =?utf-8?B?Q21vbDlBbzUyN25meFdxRnNpQmZCM1VPQko0SXU0YTMrakE1K2xMb3BCc2lv?=
 =?utf-8?B?dThhb3E3MFlRK2g3OEdDMUl6OFptNVBqR0FaVzRSMjZYNS95ek1HcHlEQU4x?=
 =?utf-8?B?RmRHNFZhcTVrdmNEOENsQ2FLVkZyU3ROcXYvRVNlRUV5N2l5QlhySnlYd1ZB?=
 =?utf-8?B?R1BSTTRFRlFmRXlKVFJqVWtISkRmbWJpZGFia0pybHcrRzFZaVpYdXFsWlYx?=
 =?utf-8?B?NFUzSm1WK2RxOHJwUHNpTkdJRzgvdGZhVEhMS3lEcnYwT2xrUUVTRzNEWlJ2?=
 =?utf-8?B?YlZLcHFMR1Q1MWRWSU14NWFWU2xkdlZyYlAvVGJqVnpLMkZIcE56QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3e3560-7fd1-4b20-7919-08df0e4b8b08
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 08:22:53.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LBg1RmP/QwGm3rODyDqVqdqSIadUkrAAlT3FU0jxu+wbpz8AEpnUsos6Ovg6O8WJrezdzamRZcn4alM+pAH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8098

On 9/8/26 18:27, Arnd Bergmann wrote:
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

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

