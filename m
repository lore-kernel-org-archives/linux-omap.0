Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E82493D2E;
	Fri, 11 Sep 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141654; cv=fail; b=W6jYNSlqomiNfw5QCMNH7S2Ezp5P5IMTKf/kTbHEdgRalc+1PFzsp2EyIMUU5/oRC/ZL1Ws7cax6NIm+M6XRDxgCErGDrChiju7ktzaecO0+CwPC2efa79h4WjvQPRS0O5lGZr5MfWshQYdrXwVvnswKycOQKKMycbDlXhTUdvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141654; c=relaxed/simple;
	bh=brdE7ZhsMWRD1TzB0eznvuTn1K2X5TaCXPkPX7akyMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VYeqlKMTkBZKMikJ9jbfKikE3zizitVzDZLmydXVlvoaSB3srKyPzKFW5UijR11680hp+M+FsDx8gI3X3nQFYAX8XGNAwO2c6DwVdf7i6pb5ZkX73BVHyBqKu/YUkEVFbcrAkQgrspjzaQhhNg+ZkipMxRJ5cyZ8t/v65Q28IYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Cjy8KZXl; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Cjy8KZXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvgHwMRAy+jT9+G/KXsq2toexNEE9onK4w1AiiH+6HtEyLP6luLeRLav9DslVFatWwvmhCxDilAAVCPI7Enrz/bEF+MfHvH7JFydM3ZyIvnMbzRSRpJCM7lKmxMG7jSF+YL6G2vaQ8XhyBnOwODEglu6VRt9vSzRcMYWNq73ClymelzOnkCoPmlQ1/e9VuoKjHfJsLuERV+C7pTwqC3TibjDz6YtNF6cIzMijVTWFqDUpaupjglGSFLd5dKEq5IzxQBgCdeQI0XfIvzJUozgpr8tCynroCk3HWOIhIG/QGGUjbNNcJaLFPMcZR8toyeL140gXlet6y+3AvzWY/CHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u9/ITUVxtMTvUDcBFfcR9iA3t9lqeXHZ3mC/OQF5NQ=;
 b=MuqTsdlKcvSWKIhAK4Z9YH28L57gN5IHKJE/qOVjPlgyJTujzevOAdYViwmwHOW8RUK17moniZ2blZy5KSGPDQnxKwqvGuqkf+0zymT03+p0qZ9EN8BT+nJUbtoCSdBvN2tAN1q9obdPDsB/7wOyN3dInbGCmqECZwlri3XDajBcCaqOGaS2oPbBR+uuNo4VibjXtEqQmvNBdh6m/OkYtQ1S1QSFeV+6BSNwOidgzjf4M5u92uDhrd47UU2ZabC+To9SQtSrybt16MkSvzSksb9/1U2VJqLJIP7VRbMGHbCb/nP5MBHV3QOMVSyof7CoMvuVRtwkENiEcyEE7y47Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u9/ITUVxtMTvUDcBFfcR9iA3t9lqeXHZ3mC/OQF5NQ=;
 b=Cjy8KZXlkXnCet05JnPsa+G5uXAtDBhShZTeDdmKsXsUiBHk1LjZmP9NuQx2p8BBe7K/gytBSTPZdnRkahK6/WRpjGnp4dY8+CAu0CJvWV/rl4DrYMyhE1kmW+aKIc1Q7UYocyo4PuITM/A0nPyiWycITT5XtK7I6R+9/R6jghnK0FFG6orX/nagYjTR1Sh7w4fGXyohqobosMayELT1jTe09uGMpYs9DMAQpuck03+FzMkBhObQpup+F9YIsPhqT4dSoNJMCm1akDvD8mLE3Mzrkwkc882Qvw85KRcVP+7OPWWfQVl2eNo5h/q/9gl2/+0RW+qmVtXd9QXYEEb7hA==
Received: from DU6P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::28)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:47:25 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::25) by DU6P191CA0029.outlook.office365.com
 (2603:10a6:10:53f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 11 Sep 2026 15:47:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:40 +0200
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:46:09 +0200
Message-ID: <cf9c29bd-7e44-445b-b493-fb120898e706@foss.st.com>
Date: Fri, 11 Sep 2026 17:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] ARM: stm32: remove stm32f4/f7/h7 MCU support
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij
	<linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liviu Dudau
	<liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
	"Stefan Agner" <stefan@agner.ch>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
	<gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo
	<shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-omap@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Christophe Parant <c.parant@phytec.fr>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-11-arnd@kernel.org>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20260908152808.3928630-11-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|PRAPR10MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 17775c1d-c7d6-4ec2-8441-08df101bfa07
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
 imajK4QF5klaq03WdR/S+NJ7NNvxoXUvkBY5RWAVJLylQplErPggEU0auLmsFr/C6RHythvTPwpK0e9UrcFIL7srCo7kzlGeVyR3esOabRGdjJNm9nJ3nQP0iSurYKV8H3VIp3tYWKv21ffzM+uCmWlZYnrE8zmfWUKUHoIB8RMYzreL4e6UdvgE0GmcDuPIVdJ9sg/Iet/U54ozMaEmAX7XNBqJ8ssmNqnjZCIA90x0tniVS8PFGhb6AHVtnXGIbDG5iEmaApWESFZJAW6OhfdhUNx6kzkMZAvLM5+Xgqj5F4k0W5ZNj7ZMi04o4vYVAXkMB4X/34MiQuVEdoRbO/8owL4J6y3791Fujkf3DBtF+h3OvpxPVyGWeHDhMG1So3UlceLFkwUgCNRkEqo6xwYEmwCH2Kzw0FqjsjqLK3odh42BhUIX0Ruwr3a0N1A88JMJpQVSsiZlVqX9k/dNOTJoGp4tGoiXamxdA4bZTDZCjOc8YPio/F1ZSToqtVstmd12FqhqGLflc5Liznwdxf3YacRbm4moOEESurtYzVgUDigNpxV8SROa4rFsPVjXi3QqZVuXxhMCJV5VaPLJ8IYX3RH1Gn7u3ka3ncSvfVLl8YZP63PQv+b+JLaqcpTmc4SfsAUCHNQ+Zn1S3e0oxhb+rlYoWvGLYmPDPB5SipSBbJ7d/oFmFqrXQb0261aazDJ2GG9GA0CO7C1fCt7Die+f406rNE+emouIlWugwMxpO01kjZsV7zxv6BEqKEefGl/GW3sv3nhQvPQ4G+3rYA==
X-Forefront-Antispam-Report:
 CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 //Efo6JpJHlKdtxE0rhW2Sn6nfy7+D1TLhVolKmg+cRE4F5KVMVVOJ/V5r4RZBGEglEj0iFK0paEqjljMYjZ28IPixRPNs3GRQ5daFrXFczvkAGZav1UjnhBSpiCC75vjzSdhpDfVAGqGZSphTtle6rR6JSP828qH+3JyGExejwnAjX237WGWy3qi4aG5jImgzg2NgYkspTCAqpaje/hB1ZXd21JdmNhm0GREEmMNvvlx1TJzpY+gVk917KzBC37PLagXX7vKFmDM5pgZClmM3ZGHegeyd0ftz/KMBcStk2LCsDbvo3v70owsYtkx+IjJVPfOPAcLa68ER2lcBRnwYukoK4sLKSUv59jd9TYKR7ULOLnDHnTILnKqAA4uDOhaeng0uYavScCsiMDf7UKq7ws5LKhKD6dOijjCTgl9QHU0oe8yOUg+LBQmkk+C3eT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:47:25.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17775c1d-c7d6-4ec2-8441-08df101bfa07
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251

Hi Arnd

On 9/8/26 17:28, Arnd Bergmann wrote:
 > From: Arnd Bergmann <arnd@arndb.de>
 >
 > The stm32 platform started out as a Cortex-M based microcontoller
 > platform in 2007, with a few of the older products gaining Linux kernel
 > support in 2016. These days, the only relevant chips for Linux are the
 > stm32mp1 (Cortex-A7) and stm32mp2 (Cortex-A35) product lines, with the
 > microcontrollers running smaller RTOSs on new products.
 >
 > The microcontrollers were marked as deprecated in the linux-7.3LTS
 > release, which will remain supported for a few more years and
 > is expected to be sufficient for any of the remaining original users.
 >
 > Remove the MCU support now, leaving only the stm32mp SoCs in the platform.
 >
 > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
 > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
 > Cc: Rob Herring <robh@kernel.org>
 > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
 > Cc: Conor Dooley <conor+dt@kernel.org>
 > Cc: Christophe Parant <c.parant@phytec.fr>
 > Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
 > Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
 > Cc: devicetree@vger.kernel.org
 > Cc: linux-stm32@st-md-mailman.stormreply.com
 > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 > ---
 >   Documentation/arch/arm/index.rst              |   5 -
 >   Documentation/arch/arm/stm32/overview.rst     |   8 +-
 >   .../arch/arm/stm32/stm32f429-overview.rst     |  25 -
 >   .../arch/arm/stm32/stm32f746-overview.rst     |  32 -
 >   .../arch/arm/stm32/stm32f769-overview.rst     |  34 -
 >   .../arch/arm/stm32/stm32h743-overview.rst     |  33 -
 >   .../arch/arm/stm32/stm32h750-overview.rst     |  34 -
 >   arch/arm/Kconfig.debug                        |  38 -
 >   arch/arm/boot/dts/st/Makefile                 |  11 -
 >   arch/arm/boot/dts/st/stm32429i-eval.dts       | 349 --------
 >   arch/arm/boot/dts/st/stm32746g-eval.dts       | 236 ------
 >   arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi     | 482 -----------
 >   arch/arm/boot/dts/st/stm32f429-disco.dts      | 243 ------
 >   arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi   |  91 --
 >   arch/arm/boot/dts/st/stm32f429.dtsi           | 800 ------------------
 >   arch/arm/boot/dts/st/stm32f469-disco.dts      | 260 ------
 >   arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi   |  92 --
 >   arch/arm/boot/dts/st/stm32f469.dtsi           |  18 -
 >   arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi     | 436 ----------
 >   arch/arm/boot/dts/st/stm32f746-disco.dts      | 234 -----
 >   arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi   |  55 --
 >   arch/arm/boot/dts/st/stm32f746.dtsi           | 727 ----------------
 >   .../dts/st/stm32f769-disco-mb1166-reva09.dts  |  13 -
 >   arch/arm/boot/dts/st/stm32f769-disco.dts      | 243 ------
 >   arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi   |  55 --
 >   arch/arm/boot/dts/st/stm32f769.dtsi           |  37 -
 >   arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi     | 301 -------
 >   arch/arm/boot/dts/st/stm32h743.dtsi           | 738 ----------------
 >   arch/arm/boot/dts/st/stm32h743i-disco.dts     | 145 ----
 >   arch/arm/boot/dts/st/stm32h743i-eval.dts      | 185 ----
 >   arch/arm/boot/dts/st/stm32h747i-disco.dts     | 149 ----
 >   arch/arm/boot/dts/st/stm32h750.dtsi           |   6 -
 >   arch/arm/boot/dts/st/stm32h750i-art-pi.dts    | 229 -----
 >   arch/arm/configs/stm32_defconfig              |  80 --
 >   arch/arm/mach-stm32/Kconfig                   |  38 +-
 >   arch/arm/mach-stm32/board-dt.c                |   7 -
 >   36 files changed, 7 insertions(+), 6462 deletions(-)
 >   delete mode 100644 Documentation/arch/arm/stm32/stm32f429-overview.rst
 >   delete mode 100644 Documentation/arch/arm/stm32/stm32f746-overview.rst
 >   delete mode 100644 Documentation/arch/arm/stm32/stm32f769-overview.rst
 >   delete mode 100644 Documentation/arch/arm/stm32/stm32h743-overview.rst
 >   delete mode 100644 Documentation/arch/arm/stm32/stm32h750-overview.rst
 >   delete mode 100644 arch/arm/boot/dts/st/stm32429i-eval.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32746g-eval.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f429-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f429.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f469-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f469.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f746-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f746.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f769-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h743.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h743i-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h743i-eval.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h747i-disco.dts
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h750.dtsi
 >   delete mode 100644 arch/arm/boot/dts/st/stm32h750i-art-pi.dts

Acked-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

