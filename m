Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A102E414
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815649; cv=none; b=cYlkB6g9Yi14O9CNfN/7fgNgFdY2cbrxsFrbWejdjymdiQOQoOGp1s4iBRbBWAJwHEaX2eb1DT8TKZkFPKHqoWrREZMXdyuyrZaSxtQ6eRWjbaADmBvrNXjIlCb8CTFpypHdbFDUooXXJuMm4ceKUmw2qlyjb6QDkwAxHzU2Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815649; c=relaxed/simple;
	bh=hzVR8c6cWUaHpcizU/8kAOOUgo6JfMrtGaBgM81xH20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGKJncshDrJhJIcguWmQA21XQX2o14MytFLP8gr8HB8myTtIzgd/bhlTHsqc5PxnraUDFuW4YqisvgWFeclrmqIbeetedL29iREmatsaK9LaMrNv7+4INxKX4Rrj4k2/MuvF3c/bXsopDx0wCfFGpN5AOLJCzHA5AGK+qJlfb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TjHMslnw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i9K4CK9R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TjHMslnw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i9K4CK9R"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BC6uZt4014119
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oc7w6KRnWeD4Y91Cp46b21ZXPP82c/8BhiJ
	cCxFw6OQ=; b=TjHMslnwA1GShAvUkxVOTp4sdahdvLXPXLm1K24argbpNcTvfM0
	n926lNCZdyfhS66+BlWmtiRkeaOc9oPm8GGHQB49ec4z7PcaK6LP8+9aCfGY07dL
	ibTcd3Ae7v4fb57mqqOxs5KLH+UPfcksDWrHyaV6BFnB6JQ76TsrStCQTPCYGX/O
	dNXHrj8JWbk5LMwgRjTb6LiNSc0lDBb3pRU4iqzd9p/cSJ/U78cI2H/ltFW7UBYo
	MB65RIWT+F/4C2HJejuetC0o8KMAPknSPs+tSUjNf+9IU2rPZOj6+1jgxekbjDLx
	ak8t2QkF0okg39GaAoQo7ODMqUobd3nWs7w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8aadb3y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 13:14:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a2ef071dso2146178785a.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770815643; x=1771420443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oc7w6KRnWeD4Y91Cp46b21ZXPP82c/8BhiJcCxFw6OQ=;
        b=i9K4CK9RbsGtWihpJ5oD9ZFaSpqFxXMowjeO8NMX526dpOdvFNkBMZtibyWatYGiD4
         lZTh3uPK7r32jIh6g1ssKc2QqCsTUBtY1vZ0lHEkmFj1d1Ckn01QYBxILve0lu85QiE+
         cGh0KnpY/pnyb0VzryZThGVo7krtQmU1eg+e3joezrLm3y3GLEY+MR4fyMmGrMhlhkjy
         JwheIlusjmIkqsTxmGEADQUudTnEwJ5wxZYNfSJWZKB/+b0EPVPRmL6eF/WySz0O+eg/
         kYtDyY3reYiSyQBEOvKju4LcYTd4296QjoReqYrV3BXG5fROHP+fhek4Ujr6z7HrXc1Y
         JFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770815643; x=1771420443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc7w6KRnWeD4Y91Cp46b21ZXPP82c/8BhiJcCxFw6OQ=;
        b=nBgPn3DV+jyqB+kP/SqcizYVYUs0WtLNfo/iCCMqaEaPgX+DpGCWUjOqMKRt3FQTK3
         wWI4B1NBeopgSX3ngU24PzzAT85+2DSxf9z0mcDNOk/XFmsY0WrudjWWd2pWxxY455HM
         jtBJy1L9SJMcz6SjFly/OPXJJ6AyGlyef1kxYGdxY7ZYv2riA7powYC35Rr+tt3d02tu
         5tKEluwZnwRNevhs/0u8j6vJ4ffgpiweAxs/1cRvS2U5xm6B/DNVzQWEdei75jGSw5hw
         c0COLtDFCs7NKCRM0iMoy2H+z/yt1c9GZ3rSrcNgpKpd4zqG0pni89fARcsXxJgx+QyR
         uQ0g==
X-Gm-Message-State: AOJu0Yx/kS0yYvbLT8pA/m4w9c6jiasNGDs2vSjFVhtR0dNwbORbg/C2
	IuxXshft6fCuwGc94p1WeXZPloiDivOmC5Lqf9hYqdaaAS69V06BM76yWOY461AMC6Z9h30ICAQ
	sVohsBUJxWrlvWL/hA1+9H2EtDuMnF1xTns8+MR5ZIz491ki1nKxr74giy6JimquT3+7CyJgJ
X-Gm-Gg: AZuq6aLTC5+2ImCUmjZAvC+Nr71DlgQ7VjWBmj5vfc5+Sg8WysgIDXJCrMcku/nQA8X
	sSebftWWLhbZ29aEa55xbgIcCigi2bPWph9HuSBIfetsh+FB4dU8r70PR3WvEGEKeekkDisdKvH
	00PZn5vIcPTWlFicLEGU2JSSTt9sxRp1WbwqD2zk6em2Ws7v5HrFy4RoFd8yMoE9nF7wVZbCEpQ
	f/pgjzibYREjVlExOx4lpjmIKsvAtmKytsuai6Z8lln3y4nRT8mgfbG0dgrCjEPV3Nb+SfkWN2Y
	sciK5Akpel3DymZQiBarq47R45aMyKx+fmf3yaoscXyj5hEPKGlWMH4WtX1yGcy2ko3ONZavz3N
	fCugSQy+y23xmpcNFSDDazuIRV2A6kcoulyogZL/kfe5zOurnOZ0=
X-Received: by 2002:a05:620a:1a10:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cb27fb7e9dmr366247685a.28.1770815643192;
        Wed, 11 Feb 2026 05:14:03 -0800 (PST)
X-Received: by 2002:a05:620a:1a10:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cb27fb7e9dmr366243785a.28.1770815642713;
        Wed, 11 Feb 2026 05:14:02 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:5a57:1eea:fbcf:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm137651345e9.7.2026.02.11.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 05:14:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [RFT PATCH v2] ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
Date: Wed, 11 Feb 2026 14:13:50 +0100
Message-ID: <20260211131350.126966-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 15uykJMbercCUf_1mGCjbSiuYwSECR-X
X-Proofpoint-GUID: 15uykJMbercCUf_1mGCjbSiuYwSECR-X
X-Authority-Analysis: v=2.4 cv=OoVCCi/t c=1 sm=1 tr=0 ts=698c809b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mL5-Ybe71cLVbzrCEFIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEwMiBTYWx0ZWRfX5eQREUFbxZkp
 DGNOwVnvQyrnrq40bhcsrkXso0Py06Z473+x0ktm12855zjM//bd+sLbEBxpGY/g3dtmLguMrxD
 CQMWOtl+fzPHdKiLwQv+xXe0GZlBfSraNlyF7t2/SEIf+Ob8dhaOhr6CIVW7Klv4/jRsEtCUum8
 hfE0KbcnsE6oq9mP82/OW3PsFyB5Vf4wB4r9aZKgXkQLKY8zq8YNlLq2g8GMZ3ytrX/HIOMMK4U
 XuVS2G6ahxc6JtCzNmFBRwfLBl+/ADq65uyLtbeOYjCtjCfE4ZoC8RfhpVy3+k0R+f/bIsMDulB
 Tc9DOsMaRNoZGXckZwXhpAKLq1GEh9eP5oGThAoqWNMKtb5S3jXqDlGj5QQlo08WJppjDIvnRWD
 VAohxlvhhEUgTF4NNRGFH4aX/A2OXmmUrb0OlVSBVrPZBVnuxUrczcSGK451L3k43IXWRFrZQUZ
 H/ntDfClyTpvEVFr3cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110102

Currently the board file for Nokia 770 creates dummy software nodes not
attached in any way to the actual GPIO controller devices and uses the
fact that GPIOLIB matching swnode's name to the GPIO chip's label during
software node lookup. This behavior is wrong and we want to remove it.
To that end, we need to first convert all existing users to creating
actual fwnode links.

Create real software nodes for GPIO controllers on OMAP16xx and
reference them from the software nodes in the nokia board file.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- fix build with CONFIG_I2C_CBUS_GPIO
- only export the two symbols that are actually required by the nokia
  board file

This is a follow up to the following discussion[1]. I don't have the
hardware for testing so only build-tested it.

[1] https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/

 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-----------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 29 ++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a5bf5554800f..a840934d4d15 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -36,25 +36,6 @@
 #include "clock.h"
 #include "mmc.h"
 
-static const struct software_node nokia770_mpuio_gpiochip_node = {
-	.name = "mpuio",
-};
-
-static const struct software_node nokia770_gpiochip1_node = {
-	.name = "gpio-0-15",
-};
-
-static const struct software_node nokia770_gpiochip2_node = {
-	.name = "gpio-16-31",
-};
-
-static const struct software_node *nokia770_gpiochip_nodes[] = {
-	&nokia770_mpuio_gpiochip_node,
-	&nokia770_gpiochip1_node,
-	&nokia770_gpiochip2_node,
-	NULL
-};
-
 #define ADS7846_PENDOWN_GPIO	15
 
 static const unsigned int nokia770_keymap[] = {
@@ -112,7 +93,7 @@ static const struct omap_lcd_config nokia770_lcd_config __initconst = {
 };
 
 static const struct property_entry nokia770_mipid_props[] = {
-	PROPERTY_ENTRY_GPIO("reset-gpios", &nokia770_gpiochip1_node,
+	PROPERTY_ENTRY_GPIO("reset-gpios", &omap16xx_gpio1_swnode,
 			    13, GPIO_ACTIVE_LOW),
 	{ }
 };
@@ -138,7 +119,7 @@ static const struct property_entry nokia770_ads7846_props[] = {
 	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 180),
 	PROPERTY_ENTRY_U16("ti,debounce-tol", 3),
 	PROPERTY_ENTRY_U16("ti,debounce-rep", 1),
-	PROPERTY_ENTRY_GPIO("pendown-gpios", &nokia770_gpiochip1_node,
+	PROPERTY_ENTRY_GPIO("pendown-gpios", &omap16xx_gpio1_swnode,
 			    ADS7846_PENDOWN_GPIO, GPIO_ACTIVE_LOW),
 	{ }
 };
@@ -225,9 +206,9 @@ static inline void nokia770_mmc_init(void)
 #if IS_ENABLED(CONFIG_I2C_CBUS_GPIO)
 
 static const struct software_node_ref_args nokia770_cbus_gpio_refs[] = {
-	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 9, 0),
-	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 10, 0),
-	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_node, 11, 0),
+	SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 9, 0),
+	SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 10, 0),
+	SOFTWARE_NODE_REFERENCE(omap16xx_mpu_gpio_swnode, 11, 0),
 };
 
 static const struct property_entry nokia770_cbus_props[] = {
@@ -318,7 +299,6 @@ static void __init omap_nokia770_init(void)
 	/* Unmask SleepX signal */
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
-	software_node_register_node_group(nokia770_gpiochip_nodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 
 	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 7a7c3d9eb84a..c0f6e231fdb4 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -35,6 +35,9 @@
 #include "soc.h"
 #include "i2c.h"
 
+extern const struct software_node omap16xx_mpu_gpio_swnode;
+extern const struct software_node omap16xx_gpio1_swnode;
+
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 int omap_serial_wakeup_init(void);
 #else
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 55acec22fef4..177621cb4784 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/property.h>
 #include <linux/soc/ti/omap1-io.h>
 
 #include "hardware.h"
@@ -55,6 +56,8 @@ static struct omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.regs                   = &omap16xx_mpuio_regs,
 };
 
+const struct software_node omap16xx_mpu_gpio_swnode = { };
+
 static struct platform_device omap16xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
@@ -99,6 +102,8 @@ static struct omap_gpio_platform_data omap16xx_gpio1_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+const struct software_node omap16xx_gpio1_swnode = { };
+
 static struct platform_device omap16xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
@@ -122,6 +127,8 @@ static struct resource omap16xx_gpio2_resources[] = {
 	},
 };
 
+static const struct software_node omap16xx_gpio2_swnode = { };
+
 static struct omap_gpio_platform_data omap16xx_gpio2_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
@@ -155,6 +162,8 @@ static struct omap_gpio_platform_data omap16xx_gpio3_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+static const struct software_node omap16xx_gpio3_swnode = { };
+
 static struct platform_device omap16xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
@@ -183,6 +192,8 @@ static struct omap_gpio_platform_data omap16xx_gpio4_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+static const struct software_node omap16xx_gpio4_swnode = { };
+
 static struct platform_device omap16xx_gpio4 = {
 	.name           = "omap_gpio",
 	.id             = 4,
@@ -201,6 +212,14 @@ static struct platform_device *omap16xx_gpio_dev[] __initdata = {
 	&omap16xx_gpio4,
 };
 
+static const struct software_node *omap16xx_gpio_swnodes[] __initconst = {
+	&omap16xx_mpu_gpio_swnode,
+	&omap16xx_gpio1_swnode,
+	&omap16xx_gpio2_swnode,
+	&omap16xx_gpio3_swnode,
+	&omap16xx_gpio4_swnode,
+};
+
 /*
  * omap16xx_gpio_init needs to be done before
  * machine_init functions access gpio APIs.
@@ -208,7 +227,7 @@ static struct platform_device *omap16xx_gpio_dev[] __initdata = {
  */
 static int __init omap16xx_gpio_init(void)
 {
-	int i;
+	int i, ret;
 	void __iomem *base;
 	struct resource *res;
 	struct platform_device *pdev;
@@ -244,6 +263,14 @@ static int __init omap16xx_gpio_init(void)
 		iounmap(base);
 
 		platform_device_register(omap16xx_gpio_dev[i]);
+
+		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
+					       omap16xx_gpio_swnodes[i]);
+
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add software node.\n");
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.47.3

