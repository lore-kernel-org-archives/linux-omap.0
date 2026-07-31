Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012030.outbound.protection.outlook.com [40.107.75.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454013469F6;
	Fri, 31 Jul 2026 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785470122; cv=fail; b=IaDvNw2Bp2ts4wbekprxEovrWaIXlaWplW5H4oxpPHQ+J4QnChfSN+wMMCBd4wNUad4dsYYaDr7YBXMieKOP3b15yAQrKBxEY5U6R+1pN1/re1asLaFjMc25O0h1vbsGOuTIa0BK+/ZBfaHwr3gSEXhoMMkdmZoOVVCeVqjmaVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785470122; c=relaxed/simple;
	bh=VHm30NMUy3go+vSssNC6I11AsYfkCO48z2BSWSFHBA4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BEnkzmjNEZxI1udxsUhH7FbE9+Ao3lbXfk1OePz8brA8e1vvqj7qleqYbH85PqrSeOjIG0Z2xsV22dNHeSgXXqfkPJ7/TLvi2NcvadyQFTmPybrN6Uud9XLJ5OV5eYOPl7T3XHP+0LvkRZ44cBG+1PlL6aaDDkS8NgkdV8PmsdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gFB31pgP; arc=fail smtp.client-ip=40.107.75.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gFB31pgP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAMORnA2H0uC84QbZSFSh7iyjcGfMf49U6ZjoFT8zPGTn4XvoohT/v9aV1Jbi8k0ZSvrl+u9s6+tUIYUzoymTNAdOGMRmponNVzlfUO7KbvqeL4khoE+IiiIHwJfO6viZ+VPhMRFF1WY+K1Gs5bjY6QvdDqDLXEDcoXxIW/caoKs74llqYcXoic5FhisUZhN2hNvkg9qtFST53n+TJCwjXABHLU6hSy7qxe9bvLOydQtNDgupjHeYGsIpHfbckpisDAsgd5j6aoNPjoCFIxswpO6IjDQ5FdWJjOZjiiMSAS/q3bHpbwA+K6vtwnR/4kG+gbXo/GiCV5NseXpZrnocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akuK2urvgXG9SCTQ0N5ym1OmK+N97P7BeMBdBXYrulE=;
 b=bYWt3L1XqU8ElvZYDZIFbswFKW9VWua3hXhVn8Us2Br7JxcP9PiCe3Nkgl7BmnvTw9ugtlAivjufkqSjQ8oclnmZ9r8gxZ5NZs3rJadyQ49EsFGhKryLcHkowYJ+rqXTUUSdA0dhD5yr649Yrf9tplngCZbtcitR9IUfmQ9nxY0HlNaFC6cws/mkje5vsek6Fmhgx2wvtEzlbBoV4LbMNtgFzid2mii5fu3PfE4wUuuBJB+odO5QAAyp7RGJVg4SXSuvE3jSKERjzthYRoRK/a4XvKjwtJFO087LwP2Gdld94CdePzBRVzEFS0yrfRo+D1gj83uyPpJGYmZEFAqTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akuK2urvgXG9SCTQ0N5ym1OmK+N97P7BeMBdBXYrulE=;
 b=gFB31pgP6x241qtNG7HJOZULb4W2vHASJXBFE6vVPuYoXSi8jG0EXQb04JetKBmLcbj/VInoBflYtFXo7Xh5005vVbCrEgnLYgKdWHftdbhWxUjmfHEIv9Hnui6gRsxqDHi+sJRWXEaqIBGtW80A+t7X4TC/DeW4mJRHgzLGwzL6Jw6aG+DSeMiP993bldMd3KpgV5ylasA3yMTZx1z0Yxtru17nX6C7pP24bz1GiJAhFcQAiSvx3RFhGD1KqcteKUiaRoA365ioYfrf9gahc9avx6sm86RoQ2RDWiZKEEwtfLxfRCT7oaoZEkX5lQFNU4sEVhivqPC1O7Ipx20cPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8722.apcprd06.prod.outlook.com (2603:1096:d10:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:55:16 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.012; Fri, 31 Jul 2026
 03:55:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Neal Liu <neal_liu@aspeedtech.com>,
	Cristian Birsan <cristian.birsan@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Herve Codina <herve.codina@bootlin.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:GOOGLE TENSOR SoC SUPPORT),
	linux-samsung-soc@vger.kernel.org (open list:GOOGLE TENSOR SoC SUPPORT),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT),
	linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS RZ/N1 USBF CONTROLLER DRIVER),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-mediatek@lists.infradead.org (moderated list:MEDIATEK USB3 DRD IP DRIVER)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 00/11] usb: Remove redundant error messages on IRQ request failure
Date: Fri, 31 Jul 2026 11:54:34 +0800
Message-Id: <20260731035448.252289-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:405:379::17) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c00f12-0737-4170-fcf8-08deeeb78740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|23010399003|1800799024|38350700014|921020|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yu+YOUNL8mq2pEY4pitonDc1SKtMtdyKG6qY/YM/7dq7T93U2NA2/CAF/sG3rIkbcCxinfu2uTbIvguyHxrYyqVe24rEtMdkBNVtxkARIYOmbiaFsyyrHfPZTxyMuYXv7K9c98+TvTnaBUSiBMflR6Q6QkI7k6R619vqHVEjuvV8f2jbD5U/EuXPqAPxONbdCOBm0rpvaxSNOLf94xoMTTOtkttghoEvqNsca4UAV3/mpYXngr0TbZGjih+O8snFuwItdmds1Q2irXUJVSW2M4tS+6DN1+ZmeZYFGZJX/13vlGEogt+44um5IIHF+4ldX1l+HVgwdNIFN8TRX7EfM+tmQ1Uk2dQMSXQMhaNlGguT/Lmr7g9cacK0ILaYsCsIYOIG95ZVxpo1sljHqCupD21VDsQSSe0MwYPJVRm0RVONLfWghWMWyA+K2yl74DJG+kXu571reXyf13/w0cyDFQ2k0EUNuxoKl3vAtY25KIhYvhue4ZFpYuDOBF1AvzsXHL5SQ7nIEZ25nr/Vx8K9OHeXzJs82rP6HOw0eJjsVPLtMEK4/v9dYdjkS6ICyKXlJ1bpCuhEu3L1IbAH87Weo9+IrFwNkNQd81oXQ20TdDtRI1YKL4TfRjSCnILMdBojGTcFL48qwCbGtYaBMVOZ3WKz6G0HJjagW3rHY0S23UMVI8qtlTyyxuToJ//0gWBQPTd2Tn1oEmIgdkt+mN4MHOF+4JSzPRuwG7SUO58PW6ByMS6sSpqYzhWD/691Ol8M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7ITm9pu8d4bHF8sGCZCarW3HIgVU8UeYwSu4V7Big5QwUyhdI4/Sy6M+vGR?=
 =?us-ascii?Q?3TU3WoH+ZumHuj9DPxfBInEB5EDQPNZjmkA5No4800J1B1oJ3D89Vds1s6f3?=
 =?us-ascii?Q?W/Ex14agWnJoypEv87JQTvd2gbGu1nN9b24/uaDuSYZ1dbJFuk2/JA6VvOOn?=
 =?us-ascii?Q?G2pq+esg/HAhMjNomvl5DpNiBvN5xdiClpqFEiC8LGNEjX/y0nIEYixbzPJz?=
 =?us-ascii?Q?9EM5v2kUhWxVHf1gwOaJH9Ii0b5ZRl74B30QhLD76y8BIOfgXsM9kaooXton?=
 =?us-ascii?Q?wCTXAIkOmzJt++7+OT3OkxaVXnj+udspeye9PGWVUpgcBE0huOw9NeBAnah/?=
 =?us-ascii?Q?tbW1LhdIsQNgyncQf+ge7CpucGFmz+Jtfdo7haKZm5BaT+tLj24OWzoVQT3M?=
 =?us-ascii?Q?LgyqB5C7L0ZhomgTG2X4RJYYL2rpn+C9nlfoSB4rurPZKCheJ1ai3zx70Key?=
 =?us-ascii?Q?7OI5h/p6ASXVzoMzsQmEFdL+JRgySXbgHZ/MtlP+JTuoSHpd23CD+Svya2NO?=
 =?us-ascii?Q?psaeDDCgmUyb/xZ/icBlqpvC2wCZW0v8QY9fHaBLVZmwskH8L3yAvR/I9TLG?=
 =?us-ascii?Q?oFKd1hzclrO+1lfq/AzPKfuEpvxcET59VDSxgCBRo1vYNPgnPADoVvCsHnkZ?=
 =?us-ascii?Q?gixHK6mP6KFK7oU8HUIjl90xKagNgASWSR969V+Wdm/AHrPQGWt7mGafKMyS?=
 =?us-ascii?Q?tCsHswok1LWVJEPD+31xgJFC5a5gdeNSQACJq2ehIJKouN3bMhblbdow2c/8?=
 =?us-ascii?Q?8iSkE1Dvb0ZnGIMEvUUpHlxLAneg3JqfOWvGANHT20XxQ+guuEXyAN7zcZUK?=
 =?us-ascii?Q?2tl6BYoxwZ9cjLB78g9FB4cZ5I7pXjSmUbhPNLzn/iwCNmuTrk/VP3KfLNoM?=
 =?us-ascii?Q?9hrXNEGacbgbCILfrpesdDrc//Jf2XzPLSMsHgcvUSGuQ1sMsIkoGEBcsOeb?=
 =?us-ascii?Q?zamJ7oVCI2H1dtxaRrCQsI6SEb/b/KjTNoCMESdESOfXwhaz+iipb1+XfRLK?=
 =?us-ascii?Q?vTkK4SX42gtvJV6mxU6Tf22HL0KSNkY2lJts9ddiTYYOm+LtzzReJh4GC0mz?=
 =?us-ascii?Q?OQW+dR4gaW3Y4dyPbKAwUaqIoYJ/BeS7sbqlaS7irwJRztsbZfXGJpp6+QPy?=
 =?us-ascii?Q?5ufxVDIY8YzHbjskqgR6B4TrL+A18H9BHD1HBviKsBPwWMv2xF4dRDNqoqz2?=
 =?us-ascii?Q?pk2ineXVyJDLtwinKnrWySwUEUZM9874Bp8oLuUhPXmHoKG5f5L5fpCuaqpc?=
 =?us-ascii?Q?+U38GlAY8n2rBb55s1Wbl+rilYi+spRoaD38UdosgKng5DqbaBI322ijiqyp?=
 =?us-ascii?Q?ChszxV6VBLrQukS3rdVDxdngN93Wldev4jK+Z9rzFaCbchH32zvnnme4K+yU?=
 =?us-ascii?Q?haqRtKLPEWxprFeEZAUIWqr2q3jYyikPAtxB7OVL+0s4O0ynsMEN7h/JujeQ?=
 =?us-ascii?Q?IWkDsWdggf9kbNGgXecDg4SIrzYvHZODGEWU70pgHf8D4u+121+cW6xNmZVH?=
 =?us-ascii?Q?r4ftl5HYXWqKvz3o7EKzs0ZfIaBiix0ctRWxHFU31Z3SBkpsEczBdTrq9gG/?=
 =?us-ascii?Q?l4ros6hRr5V8HM1YScaY145GbL5lQTCjxeUZ0VdcXz9y9H/s9Sdgnu3oIZyt?=
 =?us-ascii?Q?URhYTuymqLTierX643EtJhyeuTFKPPilu+dtsOCU8hLH32cTud6B+/vqbpf9?=
 =?us-ascii?Q?yoHLbuMSgE9etqskFuLsprZ59AL76hklZMahVTUqTSV2xbVhRblb/BFYwSUZ?=
 =?us-ascii?Q?OsihgDfbdQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c00f12-0737-4170-fcf8-08deeeb78740
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:55:15.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V68DrNJuPx29a2//JmkT4tnImIRBm+jym5L6U9OGosS5rbI88+6E0k5wGWrg1E92D4ZOdQU8+vHbwYz6sSPRIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8722

devm_request_threaded_irq() and devm_request_any_context_irq()
automatically log detailed error messages on failure via
the devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in usb drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (11):
  usb: cdns3: Remove redundant dev_err()
  usb: common: usb-conn-gpio: Remove redundant dev_err()
  usb: dwc2: gadget: Remove redundant dev_err()
  usb: dwc3: Remove redundant dev_err()/dev_err_probe()
  usb: gadget: Remove redundant dev_err()
  usb: host: xhci-tegra: Remove redundant dev_err()
  usb: misc: Remove redundant dev_err()/dev_err_probe()
  usb: mtu3: Remove redundant dev_err()
  usb: phy: Remove redundant dev_err()/dev_err_probe()
  usb: renesas_usbhs: Remove redundant dev_err()
  usb: typec: Remove redundant dev_err()/dev_err_probe()

 drivers/usb/cdns3/core.c                  |  4 +---
 drivers/usb/cdns3/drd.c                   |  4 +---
 drivers/usb/common/usb-conn-gpio.c        |  8 ++------
 drivers/usb/dwc2/gadget.c                 |  4 +---
 drivers/usb/dwc3/dwc3-google.c            |  4 +---
 drivers/usb/dwc3/dwc3-imx.c               |  2 +-
 drivers/usb/dwc3/dwc3-imx8mp.c            |  4 +---
 drivers/usb/dwc3/dwc3-keystone.c          |  5 +----
 drivers/usb/dwc3/dwc3-omap.c              |  5 +----
 drivers/usb/gadget/udc/aspeed-vhub/core.c |  4 +---
 drivers/usb/gadget/udc/aspeed_udc.c       |  4 +---
 drivers/usb/gadget/udc/atmel_usba_udc.c   |  5 +----
 drivers/usb/gadget/udc/r8a66597-udc.c     |  4 +---
 drivers/usb/gadget/udc/renesas_usbf.c     |  8 ++------
 drivers/usb/gadget/udc/snps_udc_plat.c    |  4 +---
 drivers/usb/gadget/udc/tegra-xudc.c       |  5 +----
 drivers/usb/host/xhci-tegra.c             |  8 ++------
 drivers/usb/misc/brcmstb-usb-pinmap.c     |  9 ++-------
 drivers/usb/misc/qcom_eud.c               |  2 +-
 drivers/usb/mtu3/mtu3_core.c              |  4 +---
 drivers/usb/phy/phy-ab8500-usb.c          | 12 +++---------
 drivers/usb/phy/phy-generic.c             |  3 +--
 drivers/usb/phy/phy-gpio-vbus-usb.c       |  5 +----
 drivers/usb/renesas_usbhs/mod.c           |  4 +---
 drivers/usb/typec/anx7411.c               |  4 +---
 drivers/usb/typec/hd3ss3220.c             |  4 +---
 drivers/usb/typec/mux/it5205.c            |  2 +-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c |  3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c     |  1 -
 drivers/usb/typec/tcpm/tcpci_mt6370.c     |  2 +-
 30 files changed, 35 insertions(+), 102 deletions(-)

-- 
2.34.1

