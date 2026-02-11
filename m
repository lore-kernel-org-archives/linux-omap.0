Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1936A018
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808506; cv=none; b=UUAhRjvYR+LKFOymTsung2fM8k7yxV1MoFD/Gly3HPBRD723ndOjQ/mGNR6yQSc7dNj3OhfH1mLFoswcEvc3h28WwvBMu6b7I/7EeQuWzHP9IdRn0SnUI2PifOg95MHn6Q2hbncaf9LdTY9m1APL2s40Z1PBKCBB5zg3DsQWamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808506; c=relaxed/simple;
	bh=qpVi0pOotkDTglEnkOeHaSMSTqV1ATNS3Kxf5dzY/TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjfi8NK1p/o+LgeMAhJgQxSSnF0W2HxZwUTYdQefgwIdkCHnZZGKJ/hysV0i/gyaZjmt6EhqaRSkcayBDIizhmDgWL6dwP82li7Z2KDOHA4bBbB4IImlC9DHY8EABeQWelIs5FPmC5JSGCy3TPlmDhXqYRbVfiIgbwQkem7pboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K92mR5gp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/11YVM6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K92mR5gp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/11YVM6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BAHuxP2298192
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 11:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GFOHX3QhsTEHsBp+8Bj8FeFIaQREW/GahrF
	WdSGC1Ac=; b=K92mR5gpg72mdc2VdRGSEfvnFJN35ZqDrumWFgvOFeVgj9+eLkl
	ynLTVJ15ndzNJPLcfC9J/pp5XWwA5U7lkz6XaIUhbW5J/+tfE0KRaQZiKpsrARFB
	QqnsCZ29joa/z/3ZD9abwJ2w7hBLps2cOZLDjlFFOdbr91ve0uaXMSUtAqB8mN41
	ZAJs+l/8wH7C3i2XTsARgHZXbQswEx5B+e8dTF3B+xP5upFC7E5UGePjyVqmSkze
	xqFZ6GjfEAe7UotYkqLGG+ylyOBV5spPI7LBMoa+zpdh9delr1121uXH2jhKlhNU
	dwmIKpnS9/7VFB9q+P9zpBqXBiChbukP4oQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8qvq85av-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 11:15:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ef98116so1664039285a.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2026 03:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770808503; x=1771413303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFOHX3QhsTEHsBp+8Bj8FeFIaQREW/GahrFWdSGC1Ac=;
        b=N/11YVM6YblRrU8vHx5UOxN3F+A/w2ZEanaeXcNi4JwtwuJaYHLK4ZDidZJ4vBZolc
         SjInMZifUD5mViWYG6coK3sNsxKo3DCDHn3/Y+UWsI0uyVzFwhotYO5krVKdMXQbnRhR
         nKiPE3P1WhI0wgtPuIeXX/YS+ond3a9DSJOlvdNu18KArpeqsImx0EX5wshW2RPbCUfS
         EQh3U9tsZyBzg8vaXLlPk+4ff8EGIsCq4zROX8xqAumcz2jadqFTwCxXfa94aG5REGvQ
         3b6tCT26zyHpq8+SRHt0/0TNh52HhA45L72ehEqLJPZb8GCzzyhkse3M+5xFAX0bZQI9
         B3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770808503; x=1771413303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFOHX3QhsTEHsBp+8Bj8FeFIaQREW/GahrFWdSGC1Ac=;
        b=YG6TjlixJadRhy8jzN8N74vCH0I4ibyuMl9YrTFifqvO2Y17PJS9UPuzL8u0tmFZfV
         L5zJCmYzg2eLgD9rdWPEJbP5wuGuC3l7vWrbRvGeoarYCKUd8t8tAafHaWyn/Hw+BdHy
         XNAwRAo3sUfk1ob+FuA0wPr74gO3jTUGdblH0jH3d9gfX6I+ZdvzRP8q2p6i1uCaBWMk
         Wa93ON9URXPwnunjSrzu3NFqBxqNwXoLlxUle9MoUn7+ZuAn3rkeLqcpwUGLRVhEnyYn
         mwNJEy5lJaIWobmWTqL/8MmE3qcc242R8qIj7Kw0ir4PnQN5CN4zuFfWbsrVj7BRAzm3
         O+hQ==
X-Gm-Message-State: AOJu0Yzkb17MZYjt8rOhrlgev/ea1uf4id+Sr1Awkq0mXGwir02o3p03
	b78GcNJ1poJhihYW9hQI8Zaxl6A/J6o+wqaNdw+XTNy/aP6aSleGHLAG76JCSAgYure/Q62Jj44
	symHG0hi17RIjOHuZYKicqTYFO6UnScGLfCik8Kq1c+CaMX6aHo+qSDyQoGsKjGyZhHpxZ/jF
X-Gm-Gg: AZuq6aK9G2rfiL/6r5R9H01+dxrZ3oRMTuSUMr8uITg/UkMJw2auJaSTIAfRBt4CDhG
	USawCACIVksHg2apzSmkq5SGJcsInNcw44l0dyGHu/Lz3DgdA/9RtpVbVJtXPYE+CEq8JZ4QdGP
	ysgyShvrrDp0l4b1ebX3W7DJTzzW3NHry4c7hQH35ry7m4Z4mpm6dwfVbRF+VQIy8bLi8Wyj6yI
	GflhT2cIwlKBzhrOYQH0l6dHkDkYs0gNRfVQrz7bOA9FD5T/p/ZhUKJmDjcgXlV4/ZkDGIuwu45
	abJPlDp9pqcOiZmiO0gTwXtxsmXrM4kZb10GcO36wKFVIhO4+aOeV0JTaivwp/Z8Fiu10uk/QhE
	jbUeQnUw/pzjeK+HNZGludjyZrhBZN+yzrn74iXVGcwe8YtPSjQ==
X-Received: by 2002:a05:620a:29d4:b0:891:bde8:56d7 with SMTP id af79cd13be357-8cb2acfd5f2mr126693585a.50.1770808503193;
        Wed, 11 Feb 2026 03:15:03 -0800 (PST)
X-Received: by 2002:a05:620a:29d4:b0:891:bde8:56d7 with SMTP id af79cd13be357-8cb2acfd5f2mr126691085a.50.1770808502721;
        Wed, 11 Feb 2026 03:15:02 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d772:ba4c:782c:2fd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba69115sm15647725e9.11.2026.02.11.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 03:15:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [RFT PATCH] ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
Date: Wed, 11 Feb 2026 12:14:49 +0100
Message-ID: <20260211111449.122593-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rSEnSBbGGa1i7rynvs5QsWMH6ceBaobl
X-Authority-Analysis: v=2.4 cv=Q77fIo2a c=1 sm=1 tr=0 ts=698c64b7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mL5-Ybe71cLVbzrCEFIA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: rSEnSBbGGa1i7rynvs5QsWMH6ceBaobl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4OCBTYWx0ZWRfXyZxAf3lawyLa
 B7416ymCk1yZXBKMWP1cYPHlrBFFJYqqRUMs+BRs7bH5UHsH6/zX1yBEB/Ks+njSk2rO8+Tbcsa
 V6GqjCdYusZMvaau1NO2IpbjQVpdbp6xofdGSff48tR6tgtciXZdaGcbUDUyc2h2ZH22N+4yXm/
 96mvyaQG+EaskCmLVO+yVYF6O7fl74mYzT4aVKKDCl6YdV7TQ8o5WIP7aBAC+MJuU1dWt7VwOqb
 4PBGRdUYOMjh+j8W6rr2AK1k6tU6R8ZjQe9/F68wbKcLtOVvC1mIs4BuBZrl1P75tWldduSIk+T
 5jjNI6uKCpKVf2H+g1o40zyQuCypjibzQUatDihadVc389oda0Bw1EGVGpQDfKCZ2/VjHW2KPT5
 XrKfNdkFQQv3wKzNnDffU2n2FySfxAaUj/MXb3U7BTeEr5NAAjKKKU7CVOCHAlf1o8cNJGaq4SB
 o3tfzm2ihtwf7Ty22RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110088

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
This is a follow up to the following discussion[1]. I don't have the
hardware for testing so only build-tested it.

[1] https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/

 arch/arm/mach-omap1/board-nokia770.c | 24 ++---------------------
 arch/arm/mach-omap1/common.h         |  4 ++++
 arch/arm/mach-omap1/gpio16xx.c       | 29 +++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a5bf5554800f..a81514c6f92c 100644
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
@@ -318,7 +299,6 @@ static void __init omap_nokia770_init(void)
 	/* Unmask SleepX signal */
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
-	software_node_register_node_group(nokia770_gpiochip_nodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 
 	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 7a7c3d9eb84a..34659b5fc6f0 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -35,6 +35,10 @@
 #include "soc.h"
 #include "i2c.h"
 
+extern const struct software_node omap16xx_mpu_gpio_swnode;
+extern const struct software_node omap16xx_gpio1_swnode;
+extern const struct software_node omap16xx_gpio2_swnode;
+
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 int omap_serial_wakeup_init(void);
 #else
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 55acec22fef4..6eedb87cbf6b 100644
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
 
+const struct software_node omap16xx_gpio2_swnode = { };
+
 static struct omap_gpio_platform_data omap16xx_gpio2_config = {
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
@@ -155,6 +162,8 @@ static struct omap_gpio_platform_data omap16xx_gpio3_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+const struct software_node omap16xx_gpio3_swnode = { };
+
 static struct platform_device omap16xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
@@ -183,6 +192,8 @@ static struct omap_gpio_platform_data omap16xx_gpio4_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+const struct software_node omap16xx_gpio4_swnode = { };
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

