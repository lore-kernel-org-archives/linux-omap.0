Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013071.outbound.protection.outlook.com [40.107.44.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18067352018;
	Fri, 31 Jul 2026 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785470135; cv=fail; b=JlyaG75oangZgXWNrBeVl7jU3dzBd391xb936Jcy7ZEEBoR+7UbOXvCpf1QSkiJKZBxplgZrcD40B4AnWqXns/sPYL9KEOCjopaSK/UR1ffJr8RYdpP/mNxLH8srnstiON2PBVGlalzisCSSTABv0dQziscCwFG3yvbR5zdqwm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785470135; c=relaxed/simple;
	bh=sgV0ciM/K0/Zs3ywtaovaTMfvxZQ3o4rdnYS9RRTsTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2QwtB0YBAw3aKvt7loKl8xNpurHOr3pYoFT95bIcVBoqg3GJ1e5sIHGDS7rO5Ttd5J7Pv3LyJVaDPv1GAoBCLEkBrU4DOjW8BBz69A/EcysdK+MRFElU8EabfwojxNkUTTNKNKQJsVJLqwme3q6uWv4AkfVIE0w6tQr9Mj6ync=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q+zzyjD3; arc=fail smtp.client-ip=40.107.44.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q+zzyjD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjcdcCPErXrEtt8KJHnzUuBNTAxFNhprs0IniK//DWNGinumrRuPhDYUXk9hdvTmAfErwd7R4bLYJiGTvtpGOg+udNJ8fVTHCkTTU09S0UEof396vPlK7/MwSEn7fVvgg9Yb/Fyoc/9NU+zS+SeumZkHVVBkGsLNxQGm5J2kmGXZ9OWYrSaFrtxeJzr1n1/a6z5bnxqHUqvoEs88mqAns47q9xMPtuxF2TDDh17HlSFI7W92jZQ1b77KEdcBAVwyCCCW98QpEh5N+argKFgkQdJwfNzeHuWHZj31VrNh9m1kB6hbx9NAlB/dsx6TDQCxnVrpwIshdbMYysGLijXzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2w7jZ1KH1RvIYaYXMlMmItVP/gdyni9Fk6pSH/rnPk=;
 b=I3/JVwyuG5jBuEwagxYZKGMdBx9KQqPYuQaEZu96bct/E4JPGT+P3Ap36aZQmg2RwAcrE5OyLiOUlanNmVXv8aeO0Y5+T23C26eift2QEBqr634u9xfrJXfa1o1yulpG78Vt8tV7RhJCd+ZHO5whLA5h9yp5+qj/j/wHDNKcxbxm0PNz6shFwJ8DIdruPN5+J8ZY9+w4EnZRY5lDjNw1o/jsmZ0GpP1CKO+/6GK27cy9Gsu/Efn9jNo3AbQaOeP489SeVjxzszGdzFeD9N1A9DAer2TEzmdbIDvqLRP1cqCzKnglZQeTsU4ygZSSifa3m1/7B2Z7JtUzieFm32xqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2w7jZ1KH1RvIYaYXMlMmItVP/gdyni9Fk6pSH/rnPk=;
 b=Q+zzyjD3Uw8jz3hiAUb7aveEb50bESn7i4/1rkT+0FDK6a9blr721ukxyIixRYTZ4HrMbH8epakkRk6h8nziHq51pV6lHnyX6CeKcKBVqfG00ipwobUPh/f5zQz/Wt+KjlObY5qDeWT4P6OXgBHXQnNleY7NyOMXawqn3te0S4M/bwZj83Bm6Wd0nKLeltdI0sQ0UwUx9K1wUhZTl0tqqm0+6YgD7Ip1XIy9dTrh7GF71L2IFa+muJJICsW+a2Pi4Pkw61xJOq1LlvIbk6rKKd5jxG2H5M5n1aBzwP7g4nSadnLb4DCrGDHZVn/WnEPpi7sJKzKnssDSft0LIiQQeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8782.apcprd06.prod.outlook.com (2603:1096:405:3c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:55:21 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.012; Fri, 31 Jul 2026
 03:55:21 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:GOOGLE TENSOR SoC SUPPORT),
	linux-samsung-soc@vger.kernel.org (open list:GOOGLE TENSOR SoC SUPPORT),
	linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 04/11] usb: dwc3: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 31 Jul 2026 11:54:38 +0800
Message-Id: <20260731035448.252289-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035448.252289-1-panchuang@vivo.com>
References: <20260731035448.252289-1-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 8968bc90-5e83-43fc-5920-08deeeb78b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H81BeyXTWTZYFXvu1saL3Lt8mbxFxLMywCSXdXe5IkHHVDZYJz9xeBFXY7/32DFNuhYweQcOEATuEco4BARLXvK+V4INP25RbmTNittItFaqs7u/erpAISociw3fcJR19ONU0EIVJT5dnF8/plUtgUB1tgLXrl8PLgwfHaDGx2OriKXr1gkCgTakEgJ+mZVVSToCVKYrew4SL2C9ppqZ0XayLFMH68vNwAaF1j5az1jb/Kw7FsJY5gz6NidcGgogxJ83YoUHoaN+ME0IMLlp3KiO2Gvry/y8pfMYILKLfVX535oyjZkIu7faG+qQrsmlIrli8Xn4jMvuIY+wnJHcukAUUu8NxPjOLGJfMAzg9UbR5tmg6h3CQni5omYQLbMOgwBH//tC8dDydN+U7Zx2vneHXpirA/4qIN/ebchIxB/rUICEJedcDqOyRB5evfy+Z3jr1lPhHbGP7BUKupzC8g7Me9UiIP8yEjXBJq9ggxMcIw0OuN6RdK4LwPfsjS4u9rcT5uWU9jPeZajdtHwHSXHI3P6C9zir2iBsPJ3RrXBXeb0wSy1juacA2DskfuACv70/Ar2N0gzQJtoUgs/OO/Ix10O4K+Id2p8nUnmCe4lZ7fjb+HeiV8D/6AD5EsekjJz88O1WG8ibzWSqM6LeezXBSodV6jHrws3Bq/qn6Gh9SDjfCI3xxyft/aDW/vsieAZCnKnk8ECDHCoIHxjLEVgvH3VVtHgILJ49XX7XqUBK7btA0Zka4smHU5iKX0cE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J5U1G/0akIAAT5qLyvcCqxGgqpZqfojh35KZJej57K67G9dFxtGoYhAAfS6Y?=
 =?us-ascii?Q?lweGZ72AV39y4zp2ejjsoFF5RLuJVWO1daSS6jBp/QVfoZDEdYGFanH2b2p7?=
 =?us-ascii?Q?7qJEiAqLksNft35x+G3tbiL1SvsXHRckkKvkucJfQ/PnuJ8IXIqVTdbweMm1?=
 =?us-ascii?Q?DC2cSHBm5EDelzF/T749qwme1vvMNlrt0Z+I+9fnKZiSk1Tqk6/Uvv2Jwna5?=
 =?us-ascii?Q?laUmVapsnUMoIsM5Px52nLA6o5Ey0HculTfxvF3KRljT09MLcdHBye3lw6z7?=
 =?us-ascii?Q?lmAWR+gVnpKjTdXEtrTHJbvkRMUUefvpdHKXcaLlWrSiKjO2D1C52LGUSoqw?=
 =?us-ascii?Q?2D4JbCmn0w5R20al0q0JGbJXYdn8460quDBbtmjNoL2iine2zDQrE5j9olJ4?=
 =?us-ascii?Q?TGwd67R7cljQA+t6O0jQQ9qBlgO2KHxZN0gc/jZdZOQWyk4sC/0MPvcVtIWF?=
 =?us-ascii?Q?A1BG8CBBRynW2gOmWO8uhXlfIV6geF4pCeV7CMTnv+YUWKTLHnOkIJJjalMT?=
 =?us-ascii?Q?GATQ0WpA5wTiu1QfYcYk4h25Tnz9P6JLemg/bLCQfYihoVDd1at5FTh4xjnH?=
 =?us-ascii?Q?/7Liar2Bp+EUGBffEpUBUR/w2O+dly82fB7edmFT10UUvhvZbmKenEqCiA7x?=
 =?us-ascii?Q?uUx63WP5gh29Z9BVkATEBmpqnLPU5tBg1dqEOBmnOn82mqLRET9EANlGfngl?=
 =?us-ascii?Q?R8Fq/7SpdkqTV1How3bxLEo8Z3BhgaQX9yQW1yeIWXdjUTPd2yo+mwtMDQyX?=
 =?us-ascii?Q?qZMWn6JJNUGqUVQ1+RoCCgiDVqs+DInu5bmAFMH1DSgzo0p46eDeAED4xujc?=
 =?us-ascii?Q?pbFc3Yc2ZSOSIUH2Eh4jLdDRn8VApo7ocAXCQ9YxOotRMmlQqyMtoprlyTgQ?=
 =?us-ascii?Q?Rah/+rNE8wyKFczg1zyMpF/bG6hZuX2cYnWHZ6FwlwNpih3bY+LidGMsZGUB?=
 =?us-ascii?Q?yKhgfmis8HvK6IVo1H2sp544tGIeYZ6QHBguyttQ6ubW7Qvjk4V6hSC3Zu+h?=
 =?us-ascii?Q?oFh8+BkvFWiuPMluXwy6q5CAk/GfMxG0nVaUqEatvem7HqYI1HXxL8EDrDQL?=
 =?us-ascii?Q?+U6z7E1XnekCOERze9j6qkA44YV31UyU561lkNR5UBeiaHoy4QDBenwuIO12?=
 =?us-ascii?Q?9PRzXk8dbdj7DVLCHDtZ1zrtp26iVI7By87kzOYi5JQKhYOJDeq7jan5yrh4?=
 =?us-ascii?Q?GelprjroR802z9ESSDoK2AnQKZ5Z1RSAEUHaWPwuBvZgKAy/qvgGWSbrduSr?=
 =?us-ascii?Q?VKoLXsOyjAQ+vgQBegXKGZCrmJ7XL+FBQVVnw64bn65V4Cwk3wPhR4ZU1onF?=
 =?us-ascii?Q?Hn3/PWyV0zEYNFEWCM4gD6Ag5Eje5I/o/iFbGpyppktVg3RczK0wvz9h6p2y?=
 =?us-ascii?Q?M/WzXGT7MKWWQEc/dpBe7vqJqJWRmiv2FKfmg8jXCeKcFeMj+tqA65LW098u?=
 =?us-ascii?Q?1UsSJkOfBOlTB0CKnK/3shi0zAAZ6ICsJmAEDV043s38mqIj1qRC8YbNSTVA?=
 =?us-ascii?Q?B4xW6p52i1X9jPBx2caNm1xBA0tawarlQjryqZ1XjxUi8JO8v3/l9U+VfOFk?=
 =?us-ascii?Q?XqtN2XhyGIq198kaVmShEnPzgVP+m1GuuvWAf/kyqCVDyHeTHvN/WzOz9fiA?=
 =?us-ascii?Q?J42Ko02FQpAevOGjMCHIbZa1NIdtQsjzNfM1SRILA6+CuKem1FKJ3YyYCHc5?=
 =?us-ascii?Q?37n/w/t3hn9uuV2AXc/p3KeOiYSgptItcPlqiICjTC2pzqY+UTy2iSAjxdof?=
 =?us-ascii?Q?eusRiaVyNA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8968bc90-5e83-43fc-5920-08deeeb78b1d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:55:21.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88uBg0oAT46aYtXEC9mqnOEuEtVihCVZc3+kAQ2SNed+9jnKFWl6QDyWKeoDYsOSxtkGaH+Hbq9KnOgzUxk1iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8782

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/usb/dwc3/dwc3-google.c   | 4 +---
 drivers/usb/dwc3/dwc3-imx.c      | 2 +-
 drivers/usb/dwc3/dwc3-imx8mp.c   | 4 +---
 drivers/usb/dwc3/dwc3-keystone.c | 5 +----
 drivers/usb/dwc3/dwc3-omap.c     | 5 +----
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-google.c b/drivers/usb/dwc3/dwc3-google.c
index 60ee4cc99b28..e581d407b872 100644
--- a/drivers/usb/dwc3/dwc3-google.c
+++ b/drivers/usb/dwc3/dwc3-google.c
@@ -235,10 +235,8 @@ static int dwc3_google_request_irq(struct dwc3_google *google, struct platform_d
 					dwc3_google_resume_irq,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					req_name, google);
-	if (ret < 0) {
-		dev_err(google->dev, "failed to request irq %s\n", req_name);
+	if (ret < 0)
 		return ret;
-	}
 
 	return irq;
 }
diff --git a/drivers/usb/dwc3/dwc3-imx.c b/drivers/usb/dwc3/dwc3-imx.c
index 973a486b544d..d967acd43d44 100644
--- a/drivers/usb/dwc3/dwc3-imx.c
+++ b/drivers/usb/dwc3/dwc3-imx.c
@@ -250,7 +250,7 @@ static int dwc3_imx_probe(struct platform_device *pdev)
 					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					irq_name, dwc_imx);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request IRQ #%d\n", irq);
+		return ret;
 
 	ret = device_add_software_node(dev, &dwc3_imx_swnode);
 	if (ret)
diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 1cf96540b66e..ee92a5efaa6e 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -273,10 +273,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
-	if (err) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
+	if (err)
 		goto put_dwc3;
-	}
 
 	device_set_wakeup_capable(dev, true);
 	pm_runtime_put(dev);
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 7ee1610162b9..8ad302abe883 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -144,11 +144,8 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	error = devm_request_irq(dev, irq, dwc3_keystone_interrupt, IRQF_SHARED,
 			dev_name(dev), kdwc);
-	if (error) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n",
-				irq, error);
+	if (error)
 		goto err_irq;
-	}
 
 	kdwc3_enable_irqs(kdwc);
 
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index fe74d11bb629..3bff775fbe4e 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -518,11 +518,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
 					dwc3_omap_interrupt_thread, IRQF_SHARED,
 					"dwc3-omap", omap);
-	if (ret) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n",
-			omap->irq, ret);
+	if (ret)
 		goto err2;
-	}
 	dwc3_omap_enable_irqs(omap);
 	return 0;
 
-- 
2.34.1

