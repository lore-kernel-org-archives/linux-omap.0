Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013017.outbound.protection.outlook.com [52.101.127.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87B31A575;
	Wed, 15 Jul 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123454; cv=fail; b=t/QTbYMDvrccBiG0CrTCk+cknfDJ+Lr+QUr1fxvUMpTNMieBEq6H+A0pd1KSZapoQUOns/mF5LpfQx2OuBbwEz+BAptS3xoV3xbSurEMqUlMz9BhUtFB+veiHC0KyVcDoxy687VKEd32q5tguvg185ERyHUAMkWNkT5J3+01yfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123454; c=relaxed/simple;
	bh=JLwjPykJV+AyRbZwcxkOIQ3voFzEqpPFB8YZJ6gZ2y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anKUfiBKrNQN8Ug7kALgpBXMh0HdYUOdoB222H6PD2LQoytCfVPcAmkjnxcnDwXjtF8f68QM7me6BslT8HosqdssizRreBXsp6Mn2jeo8lQgivrsEecp7kUTuU9OC3KzP+WAAbLbLd04Q41n7RKiBBBFKO1JanCsVTrDz2tnSjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Pp/GBD6S; arc=fail smtp.client-ip=52.101.127.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Pp/GBD6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO/C+0x/npVj8lT+FVL37tjisn3y0uRoRYtKUzwyzElFnHJi+HFQXlXIrtPFkMo9l698f8wQkwrot6DAUnClBUgo2ox1a7+7B17MugUAjCcykfwsxp2O0kE8Ammxl5GfmeVGL1WC96BExgdtWhcY0TTC1eRiQXdKmIBXo/WEBYiCL2TzkRSDEbDwazM2obanMvb0m0NZUzPe31yD1/E/8MemaaLM6pBfiP8A3G49aQOGqxo/mlcSOXl6p8OUqOiexl7lwcZxfLs/iXqqOwIIokZErAXH0VC363HS9U5H4vb8eU5P2Zixm5NS82Com5Y+cCQI/nUASqc3qEbSVwXzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba0gaU5QGk10jENTTqgFAaHF8XRZHYAUaMbTIgrgOVs=;
 b=e3/F4T5d6zIkPPL7Q6qHEQ5fYsntcMj6Y90j8UFMyGIj8vc+ER4pRJt1O+JIR2VQGGDl0n+yXYGrRrs89cWJq9Qt9e7hpPjCu7TfvpRfRPvvlPEduOZu5FpVRwr4hstB+cdN121a2JQxJjZzeKu9qd1KrM/uiDkvXfgqcST36DmauDv3rhVT982E5ZxhBQn3gWufc82AF5xeMwN3OhR71tEi2PuhxgF773oz0VY1iydkGyEVEyFiAADnyogrUEOYHIsEavFNuKy9KoJUunsCdBZDKMHTGOgQ+Urmv+PDRJmGzyHHpIw/ZiiCqzXflQfe4uLHGFpM3PmstOBWdu74oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba0gaU5QGk10jENTTqgFAaHF8XRZHYAUaMbTIgrgOVs=;
 b=Pp/GBD6SjZaHioeHamAUajAgR29dDNH9RqdBr96VDRki+cC09f03OOQy6ga9t0YzqyeTBpIlLTBAAuvTVKzee9GSof2HsAXtjnSk3Vzb9lczlKnPBUpX18ZcV5gU4jyVqZvqhQGGp/s1gDBTakF31lZQcW59k/VbbbqNA2Lq7YiouzcFPWLeO9bZ6WXNCivVuWeze56b/PY+qcUVu7HVkGHhwdONfxaUgey/q2Fd7H79879hrshGnfo+mqp2ilMqxLGRfcVrF5Mz1w/2nUTZTJRTSJAhKkwx9Y09zHsK5rp3Gp7O7hxYkCSHUelnQJhNKbA+7wTIbdtHJBoYHuB3cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8658.apcprd06.prod.outlook.com (2603:1096:4:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:50:48 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 13:50:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP) DRIVER),
	linux-omap@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP) DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 2/3] counter: ti-ecap-capture: Remove redundant dev_err_probe()
Date: Wed, 15 Jul 2026 21:50:29 +0800
Message-Id: <20260715135030.326290-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715135030.326290-1-panchuang@vivo.com>
References: <20260715135030.326290-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 30574bc3-e269-4d30-e524-08dee2781334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|52116014|366016|56012099006|11063799006|38350700014|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2eljeclGOV2z1OPlHMsLi6erEPynoY99MYow0+kEcbtNtpOXOHo3b3kWjW6tH6JX+EODyiBoNIzY3VrgoOBI09QwWvorF+rQvMp1MvBhyKvdr1wSjDVOG2m+K/9QLwdglcNxVKlrZwk6nNu7QO2MEPHGG2vH7cJgNcpiSbQZ5p1cAnAv6c9eDqfK4bVoBNT4ciD+TJX+VxUSjAyJ8JsMlDHAjHNi2WTD2ZUYrfZnkd74jquSct/ElMKnihNAB0kZs9FQhURU7dOTFN9+OPiAzM27nJm2AkOf0ZMXhmjPAhBlsR5hq3BRQbDf32ZcbE096z4n8/uN5ouFeA4NDiTKl2EFTZgJBzO82QTM+JwWLSRk6S0VRtfWLLxXEW17EK227HMDT38cd088Ax2YJWfJf/DhmzYFHvCKvK7/aHpMbcWC7kV51y8d0UKSCd9+X7iebgHCD1HgiOhULVEFo250CJ21Fd2gUJpHpeI2Iw2R80IBy5C3SLqCs52DQkYC5n6hHtcR36/XkMFDO6KSV9/MTnZp09+eyvKd3OxtCzu8BQl2TFfC+s61f0Ac/PipwdV4Chb6J55p4ZhQtTsWg075cNvgFR/PtxnQ9tEvIxJKsEzlDGLSks3qr7qNMCgBYQIQb+hkdRshi8Qp1YCiJXFK3RgjAXJyIP5SCeEZGRg2pK7OkGo8hZNAVi26J9oarLCpL219RyOsf3RshumXNRvxo2DvOIudpeq0Ysx6iOHzD8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(52116014)(366016)(56012099006)(11063799006)(38350700014)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbAUjfr28q3NG08uCI8xMxPx0pINeugNQ3P28fcyxp5hOWVqiWzBO5v2WA2s?=
 =?us-ascii?Q?9sJfWXWjoMlAhfdPXQZrfYO0Wj5+K1kwgsLrYtkLdDIGPFjkdOOLzxSPre4P?=
 =?us-ascii?Q?O2AZxME1z44bZhhZ5ySJc0T0dK2JNzSgvo97nrVYK3DF1YiazM8JSc3pTuPz?=
 =?us-ascii?Q?BQUzhSL2NDIPQKDRIeJ97beJqEi9e7QPSmvnb+W5uq+daI2+qcaDbjiXEp7J?=
 =?us-ascii?Q?0aKSwaiYvXVKUGlddRkSDYkWYtRIEUSQfWB2s2n2/3EUGu4GaUSrCWKJG8kg?=
 =?us-ascii?Q?CTypLKl0OeNrJTdtVP2xUO39Lexz/W/8HScuLt5VZ3FJ+KJBoGSl4+0zSAg+?=
 =?us-ascii?Q?Q45/htOySsB958g3VMPRiX2y/K1WkqVZ41U0gwhspKo+CSWTCRUp1Xno9FB3?=
 =?us-ascii?Q?NIsmKu7W5MNkblf+T6nVcT4IDnT+VXTS8QA7TMTYuKlhs+u10rHyPHT8JZPn?=
 =?us-ascii?Q?lslmYLqhD7V0XHDMh2MCYFcyyM/fflgZDlBxBydpF4n9n5Vnn+eAAYeW4TbD?=
 =?us-ascii?Q?HNDeJeS2GsKpI1+gupVmAYoDm4LVKUAJLohoIL7aaNlJ7dOn/yg6uUelP0Da?=
 =?us-ascii?Q?jZd32+wmfCtn3C/vI4a5qw0RUj6XnAs6zrXzJKldFVsMGAsWybStZQH1+Xkv?=
 =?us-ascii?Q?lpBFsMuxaoqEpaA0xlZ2OabzuuL2kfA0kfpBTA0Px3dPB4U1fHeUMi3Knaph?=
 =?us-ascii?Q?XLiP9ICQ5ZX+qeEXgvl7Do+zl9pST5qZX2dfFDdds52eRNaXFzKXNWoHerx4?=
 =?us-ascii?Q?tdyrzNivAQHl0ELHrwN4ReVgW9b8VTV+MCyVUhBW2PhIVhlnk6dn287kd78F?=
 =?us-ascii?Q?1sCeMWJkOZCxRmIKDIv2SzMAElxeZu14V31rs+XLfyQgfL8llVTVbrPEKY+O?=
 =?us-ascii?Q?KC6GEZbeDVg1E1qRZLhjBO8b0YYRw7IQ0kvdtS1Cn2E4rVP5xDxkvEdcmb05?=
 =?us-ascii?Q?3MuuSyWG5wpuFr/Sj8mUY5eou6+Cc0gLR7XiC/3kOqZfbvrwnohxb27QsDpY?=
 =?us-ascii?Q?pNJhJCpOu7C08smRg8cITGAJRUjlus17S6Q03YZ9yK/+LOtiLqv1Q96gGSMl?=
 =?us-ascii?Q?VB4UZENyHc/SkB2fQm852ogof+pvmHl6kRnxHqAa+EwdDdOYuPS6mGvcJCOw?=
 =?us-ascii?Q?EQuhJFH/CExe+LAodTekT4TsYxzDi1w0V5KXjRycBYj0Z8h0hC779Pu9hOMH?=
 =?us-ascii?Q?8Dle0ex5fBGXQTSRGjSlOK5wRLly5j1SAeMaeg+gL9fz0PjwUz5MdqBYHX5W?=
 =?us-ascii?Q?td7r9g4dKci+Le4T6qW1Mlfy9+sFPjpGO7XCev0Ksxy7K3dJOeCG7Wr6CvN9?=
 =?us-ascii?Q?BneYzh75PSP1byP57Nszuh+Zd5/qtdFdwAgAsD4sNY2Z8siN8uV7fID20ehM?=
 =?us-ascii?Q?vkGmo7DtWuqRQ5sVnRFs/0WQscnaVI4FqkCtZbTgiRfALTnAhuFLvOJUKpvS?=
 =?us-ascii?Q?zHDFT5fUbEprSt+y41d9zvFMQ0DLdYQa0ZZwNF3swInufuB3UKYdsB6tzSBm?=
 =?us-ascii?Q?TQ6J5rdq7KgYheASgZF37JuX62cgB2xURZ6lTPxY52IepDrXv370x53/3xhV?=
 =?us-ascii?Q?nWN0jE3haZNmkgn9Gemlr3I+UvkqBHJKYddBbJdlU1h31wKmC1PZt7iHYE+G?=
 =?us-ascii?Q?77PB8RnP33Vi8yWOrNX52hmXJhZsvQ4SBkoWYReAvRXKOP5c7SlLzIYpqJeP?=
 =?us-ascii?Q?oK3qwFEFPVaPlzB2R1eps0ClETXOPZFtIk2X+YDQrNdjyUZ/0UDtlfRIcuh1?=
 =?us-ascii?Q?PhfvAgUMSw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30574bc3-e269-4d30-e524-08dee2781334
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:50:48.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZe0Wp6odjrauwJeHBZbDX18AcICffCgOqp8QcvN28traUnynpJsQgoD3GxIoKgQxv5nAPYou3i9vYmeVOgWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8658

devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/counter/ti-ecap-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index f69b6920463f..d77a256f0ed3 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -513,7 +513,7 @@ static int ecap_cnt_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq\n");
+		return ret;
 
 	platform_set_drvdata(pdev, counter_dev);
 
-- 
2.34.1

