Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18023EBF1F
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895516; cv=none; b=hU7ArjMtpOTZ/XkNKvUMHDDohV08ssfr5Gp4z3hFhG9mW8n9ghKe0m8787/MAMQ1LcRZOQGdUkJnWDaAH1s0uaJ6o2ajWH8v7Q20uG1ciT7/WuTaFIJjmEhvt0l7y2pxnx5tgvV9rBoAc+zNyr5CGEedVChX2c1qcZNfU/RqhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895516; c=relaxed/simple;
	bh=VunR3z/+JocjgFhytk6SHVWzdSGGqNBZRnDdQx6yCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNcZniIhj0T+VgiGodnOeTN6qvzg5307LdpctZJDwKiQ+S1s9cND3WSd7j0QPENSm4HWrfKfOsB91JdGXrR0ARFE61EgjmsNoxVXpbwpKDlv1+xKbyAY36ZdyZlwL80EGzczBOXbLRSuDs8wQaplqE+ySnNDa5T1MyR0r2z1r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aguKT32Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hfL/fs0R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aguKT32Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hfL/fs0R"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAOq5e3963707
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5PDGpXXd+WYqIC3XZToRU9plHqBK8VSdCl2
	nLvQovpI=; b=aguKT32Zh9CL5EEIJgDfEwKangY/qi/i/qNExPwDzTEdND8YvHF
	uumIn88o7F0Vb63SG/gFMb1BrDyKFLkeMkqQ8BEwqVaQiuUg96yX9eGqmipxMIsy
	GWPMZBQSOgq91zggXN5nGBc9KXGOMdTmBt6MWBAMdB749bxWOEeQLLG34HTzfpd4
	ViTPh8OhQM2QoJIOOjU/3OMN2cTzjWETV3qk2VL9D0pdgjLQXiUbH13vGWiLynUq
	WeuJBzGRiY++Fuge3CGsecO9PXD0+ACT+0tCPXDNHyzxxu8f2k5tv+JWhrsduCBO
	XOukPyc2ehgUMoVvSpLP/tzk2F4zPag8ejw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y8ntsby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 11:25:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ca3ef536ddso2734768785a.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770895513; x=1771500313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PDGpXXd+WYqIC3XZToRU9plHqBK8VSdCl2nLvQovpI=;
        b=hfL/fs0RDsr7wGUkzngZFFEgjdpIlG/4f1d39ssJulF4dAbwprgFoEDoI7B+nLarZF
         7ApBTDH/Pwxs4zPUEyljB1tqN3uRDl9MRxJN2Wwe83XIgduQ6MKdZ5MA72E3+rjJ6k6b
         4cgX/3I1JFd0wiT3ZSjstUfJxWiKQPuiPaEtpgpVkW1DF05GQfPFlFFiLZjBWZMVfCL8
         ruxSiJLJRiEpqFYq8crzHM//PdLCMlBCKAxq/8QKkhyvKWAhmhhDyaWLxpjUdVwFXz3B
         yCxIWY6fl/Gn0SJamk6EW6gKRgKUsqMF+ds0mreRAw5yEwLIlzpuLUujs5ggbsFMDSIR
         MafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895513; x=1771500313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PDGpXXd+WYqIC3XZToRU9plHqBK8VSdCl2nLvQovpI=;
        b=UZ0gb337T5v18HS1eg4783NlGBfKi/M7PO9/5sUmAyffdGZu20YF8xD0SMHezeKDC9
         RDPzy0IuEkKENK6xi6blVHzMugpSrdME9rQueipBNk444pTPlO5PXJhEz7MORdyiN5UT
         KJwunPJdjQIr+byxhSWsDqki31osWUw0NZ5EaanEdU6cnrOBKtWz75e3dDtpolQT0Znk
         /lH2eOV9yPzT8+mZ60PYsAyrDZN1M/kUTB9XIcg0/EtIH8t5G8jPjOuR8Nmnr7jLnpuR
         2LuLK9HaQxmGa4yZ/wLG0Sf/1cCTEQzQwJhR4B+VI/a44E1O0w6AQi/qeaW/x34TTgHf
         O50Q==
X-Gm-Message-State: AOJu0Yzs/h3Goqcon1p46MyhUL0j+uokLOKuiPZuUHWfjWBiMB9LHQmz
	QctFDWIi3feVym2z9srJyddzmFj7iAQDrLsEljUUaffdk4xlg1VWKa1fD4UgPgn5HjwNW/IpeyJ
	dGp1XEfNh/a5P0MpA5iEO/bNoVQ/QFkJI7vdEqWkHj0ZzCwEoMdJjMLTR+ARlIPrS
X-Gm-Gg: AZuq6aI/QmsJw93FKSp0I30z2Y3eHL/XensNz/4RxKWczqF+0vA6YeagHmsFa1p1NL+
	E9pg3eqTYpMmHRV2RIS8CU5u0aF/0Tira3SZAZR4jKDoJHMnOTylxJBq5bYPnyZ5FuXmLf1h/eH
	wUmJCp4gWR+L5HAdNXNoZRshJGbSe+2aBB7EtjRH61cg71TB79ZRZ/9JRMCRwKTudTPu+elqoqi
	Oet9ONz5tqry5mbkSb3gVgmO/3sHAnbLsqhIuWXG3jBY7SpqXJ9KQzLmvNekEKhB854muI4mxh8
	wwmfaUe0Izx4FbIYuzn1PalHDfojhjisH6Elnt5WUrPsF26/cjaKjXNDIdAXxhL4xfhCN8NUE6X
	rGg7EP27Q9zf/v8ly1pR9BmTn2civP7ca2jmkE4oH+9cUn5auZoc=
X-Received: by 2002:a05:620a:4112:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8cb330fd638mr288562885a.51.1770895513072;
        Thu, 12 Feb 2026 03:25:13 -0800 (PST)
X-Received: by 2002:a05:620a:4112:b0:8c7:fdc:e87c with SMTP id af79cd13be357-8cb330fd638mr288559985a.51.1770895512532;
        Thu, 12 Feb 2026 03:25:12 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:afaf:b495:9036:167a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d4785fsm11453572f8f.11.2026.02.12.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:25:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [RFT PATCH v3] ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
Date: Thu, 12 Feb 2026 12:25:08 +0100
Message-ID: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4NSBTYWx0ZWRfX4n7IQUksZjDB
 DwvZ3DDATSvjKdFoyEu25es2SAHtRs5c+5TJSr3fuZUVighK3wmaMo4Cs6N7L7G4WD4sgrC2l4+
 FBabQRAJaBO4F6jWQDb9DDgUU49OTgEcpB077CtSNhMpTwXEs2Qb1u6Hkisd+qbyPk+j7FdyhSX
 oYP7VzfAGAaC19kBtieeec9fcZD7ZFBypbcG3Ook+QbAX6stXUWDCAbSi0L0cUNJmnfRJcdmu4v
 4cXP2Ka0kd4FmExdWiQNFKZ2eTxkjdOdnj/0m1yDniVG2Eh/2o45efwdef43FUt+ksDJe+0ePXo
 6lWBK2zVQbmMqm3NmyGAieZm0ytq2CZYTLfB1IHeHpJGThxANiLfPx8IWmEU2MIeka0DFfAtvwM
 A+G3qUkCXT5v7TDoelFhfKd570kDfCmy774+R9MYilyh389BtsO/FNoE10t2gC1SWH0BgkXVqxF
 kgoThnNlQ/PRXsN2vyA==
X-Authority-Analysis: v=2.4 cv=VNvQXtPX c=1 sm=1 tr=0 ts=698db899 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AKYXJijLabmKD37pI5EA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: cbMdkp9bd0g5laDf9W41mq-2lpBEfruK
X-Proofpoint-ORIG-GUID: cbMdkp9bd0g5laDf9W41mq-2lpBEfruK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120085

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
Changes in v3:
- fix references to the MPU node

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
index a5bf5554800fe..46f817f6316b7 100644
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
+	SOFTWARE_NODE_REFERENCE(&omap16xx_mpu_gpio_swnode, 9, 0),
+	SOFTWARE_NODE_REFERENCE(&omap16xx_mpu_gpio_swnode, 10, 0),
+	SOFTWARE_NODE_REFERENCE(&omap16xx_mpu_gpio_swnode, 11, 0),
 };
 
 static const struct property_entry nokia770_cbus_props[] = {
@@ -318,7 +299,6 @@ static void __init omap_nokia770_init(void)
 	/* Unmask SleepX signal */
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
-	software_node_register_node_group(nokia770_gpiochip_nodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 
 	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 7a7c3d9eb84a0..c0f6e231fdb44 100644
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
index 55acec22fef4e..177621cb47844 100644
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

