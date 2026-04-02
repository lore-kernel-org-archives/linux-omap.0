Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602663EBF0C
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139330; cv=none; b=UMckOv/5E0dj/BODLrv/4Y37ci+mv8n2TMETc0c+MMUUjYoxDxLZtjg/WNMryWCpKBrUkzttnbxqHBIrL/fClcAGyQVm4rPuZb/CuO28tUGB0MBkX4G6DNaivcqUrlk9yuSkuA1NHewmT9oUlMacMN5Yi3sXd7inU7y4mxSWcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139330; c=relaxed/simple;
	bh=84lA+sQad0KFCHbORyyoFKtDWqR/112mWPWVfk7uVlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ol57UFR6he2VBmU6/sKbpsuFi3CfPyZvpU/Dk1YT4R+Rw8g3YjE7fKqF0lF5pX0iAJ7UwJQ32GVBdsNVAHwN5xoJiGCYxGZRM3X3iOurYbBznFJ9B7uS4bMqodDYDTszX8E2NVxJ9frsWN6NCnQw7ivalh4sVW3J3l+ZoZjgKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCRWECBd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HOpNNqJv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCRWECBd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HOpNNqJv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BLKH6091382
	for <linux-omap@vger.kernel.org>; Thu, 2 Apr 2026 14:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ko1IaIbS30UK07529xORwTESC79YHbPzcSNYySWBN3s=; b=BCRWECBdceo8emiX
	zVu1XemBIxDnAfpAVprpPRAtAlqgL/yPKHibQWKIS3zbIOD01OFtUiWDAS3pX6Fn
	ucFB4kUiij61guxsMtPANwSlFiRlxBcTqjkm/jybIlqHtlUUaSzprNzh9eUZjlhO
	4SY3Qxd3PEsLR/MdCYJkvauFJGNyoXqrSuxHJI26weardUyj6KzMZgZd0klhoQFy
	0OWz113/0NiJGgwFWJ3SzZVjjjWotAojZrdACM8sI4q5TeA419H56AmYkcgMH7me
	yLWG2u17rfXBltd9QIdNHGVvJfaGXuY9RqSvobF3/XoDleHUGKPlwYOox0/0jbeJ
	NWr7Qw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcua4dt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 14:15:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509044f54aaso25834551cf.1
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139327; x=1775744127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ko1IaIbS30UK07529xORwTESC79YHbPzcSNYySWBN3s=;
        b=HOpNNqJv6o1+z+CCM0u7Yr74wkVcTtCMgXku/RAko/mbYKwm0E0USTzzz+hNYQX9J3
         sHVeqc9Cdg+w2Ku5XbB5+vg+8NbHdqAjmOdhcxjJ8tthVjbkUso79NobjW3slLw4tFfX
         i3na5JdYKL2QpcttpDQSCjXb7fsJVUKo9KdU+xmqpFVi33SSZoTthSeLbpqcS5YDaP3p
         VAQJ+6m3IztiYccsNT8EzMPeu5W0IUMZXjR/vTGdbwFU5dniZOduzFneCPZddVSF9PeO
         oq/J+yAR+Sycx5Q/+3lnCSNOWlCZWr+pRRX3qA7Oqo7skCWRwOcSI2trBDmlDr5ETVEk
         Cicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139327; x=1775744127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ko1IaIbS30UK07529xORwTESC79YHbPzcSNYySWBN3s=;
        b=jycbk/V0bRfAYw80yN7QON48JMhGzvjTKewM1sZINZRJcxosCvgLBCDGbIl4RW+z1U
         Ve9z2ENYvleYtn2X//bV0DXi9AfMuzHfcvnwd3snFhqaOPHI55Mpqv8xLO4YqDI05UIc
         I13D8jYhyyk3SQQxNwzbJ6U23vJCPn80HghBVMMjP9T8nQUyTTsLO1gSSB5oKytMygCB
         4qILftR2YlSB3gN3SCalr5PIQgnCYhKUzIogeKWym9uyJUlbAAg6v/FJFrc5IFDURyHp
         KG0fO5Nx5VSvGrdZr6XGCxhQ1FQr9/L6oRmx2r55BZ1956duJczwGb7CCHGo0dcbADes
         X/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXB1dCoV4ZoMPH8wvWqhLDZpRS4BlHDIUEc6VPKA6B1bU44ibLPeb1EKf3xV0MVjur0kur1iC+MRD3l@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDyJlUYwKdaHzLaqQq3zaIEsLxpWO2XG6CEwJbpUCKEwUnDK4
	qr0UCuVxpmdu7GniSg9A+yiiHR4RsghhWcE9FVmRECE61IHlqiTOsvH5AJKuPmEmPn9N/cHUrGD
	DkSwfNgcDJk9yfPrXhkUG5u2frRTBWfnxvRP36mBtPwJ4TAttqQOZKjoghzMF4LEg
X-Gm-Gg: ATEYQzy5hOFGAlC57/iR32bK1zHj2odmRVLg0XfYj87Pq576figok0K7SRSbRiuclUR
	aZwblZ+4eI5iMHJQ1TPjSasWSiZMwApQ6NLkWY6QLyHQrZo1LD0gyrD8OokW7Ij11LuGPcXbACI
	C5lGMyqeUyPSAF+Wetmh4JO1ye71B181d8aTY26F4BxjUg5gCepjn75JlaMaDxMKAml3+5BaQE4
	TkmnP4be1wtPYryUtou2IUncvb0eLYq7uFDnOVwPJew6JMWZ9/yC4eTfqjsci99wzSqrOXu5Lh7
	Cz3wyxYxeS8bUZRk0XmK9hvPd/88iDSMEQd4RDzo4hNWl2ns4ekG8qHLddMRg+KmDCdXrqf82kC
	GuETCWxifAIquTPlGZ8ZkTu/PBFyl3kV/nvNgHn4CVhCBnnuOaRqD
X-Received: by 2002:a05:622a:207:b0:50b:465f:706c with SMTP id d75a77b69052e-50d3bdace4fmr105254821cf.60.1775139326265;
        Thu, 02 Apr 2026 07:15:26 -0700 (PDT)
X-Received: by 2002:a05:622a:207:b0:50b:465f:706c with SMTP id d75a77b69052e-50d3bdace4fmr105251081cf.60.1775139323963;
        Thu, 02 Apr 2026 07:15:23 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:15:05 +0200
Subject: [PATCH v5 4/4] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7115;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=84lA+sQad0KFCHbORyyoFKtDWqR/112mWPWVfk7uVlo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnyrQduqYRzaSGCrj/a3Z+EMcoLtnR8gXIhB
 rRkqv36XQ6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac558gAKCRAFnS7L/zaE
 w051D/9/iGB6iVqBzF719/2yLqnIAn9kqb0163tgxIPoz8kXX/FI5zf+t6Q3zmC9Cygm5OUsqgK
 3n9fI+svI8LS2chxUKP7kCbHvxH3MlHHM300iW3hkLUyP9lkdwOHFQ3vvgA4djp78E1MeB+GKsW
 /GMMtvgntw0YwmWqQqY9WFPagO8FSHAncV3ui9H6PZf9TIeQIHwDQVDjqlLZHCeUZ7BxSbwup/R
 +YHFwpxiLdoFtdOX90NVHPpM3Yff462amLZatiXPrHWLaJblB7ZCjKZN+C1n0Gzrz+dDtXDM8sr
 cPfaXSnQjZz68q0P7NWLbFGNqRJAsS58iBbcFWCg5b5gVQMw1LMdMzBHiCz9jTTrDdpG3/MbfS8
 fEgjfM6Lxkd1oaH61wlXPx0Y6lmzjIvoGZb0kshhiQrymMOrMgvWjPuVX56IWKkRpW0GNXUJ0iA
 vLIMOuaxk43lNIX8tl/QmEeYrpw2KFAi8MR/l1JFlADn3xEr+3imTlmUsdyUthTNmqsd+Ot6YIp
 3SLge6ThitT8CX8lKjNM44ZjsAijL3cRu8XH8lDcBwz7pd2Px87aAvJKBoBbwBGG1RtRhMM6pj/
 7bJLVfMTbgMApzwv+lIh6glmEODbiutZfQR3jm5iJfk8OUtD5eXjBLIgH1CiDIkXbpjcfpW0yLk
 W1Ge0RJ1TNMYuwA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOCBTYWx0ZWRfX8PMyWhri5S5U
 E0V8m5vXRj/jrJnmgh/jDT3W+W2i6c5I2IWBkvva4eteBBqUQXB/S6YVWgPMyY1+cfuCfCYZf7d
 oH3Ed+L4ZlSgt2eeAtzAQEaftzJJgqcz8d/NXee0ODhngTUQ4/ucebOiQWQvBXpoUhPMVSuB/6Z
 wKW1M6qoEPzRLwnWRgHlTxU8heDFI3Yf/TLHoAvcqJPqxo4tHmoZmB3q6ArdEPf5y1GdSkmHLNH
 402GJ/m3m57HjSgzpJ18vT0JwDzNV8W9cRFLQ9OJDiWQiB4e1y/yiVQuK6mCBFyoD763L17WEt+
 udKuFPfZwBWeX7ZS9/SR0/5Ee3L1k1Dxjnl+E3kELr6mob3ryj/jcKhoyY5wUUIiOlswLd+U5z5
 kChlMt79wcbd7OSH7C9+wlesRn4Faj88AEB8Hqbv9lA/vKhb7kstudb2SD8e0uYqqT6aCYiy8iH
 SDB5hoNuo743o1usc8Q==
X-Proofpoint-GUID: xL1fJaEXV3DO7UMnM328YxcW99pPPQLM
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce7a00 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=mL5-Ybe71cLVbzrCEFIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: xL1fJaEXV3DO7UMnM328YxcW99pPPQLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020128

Currently the board file for Nokia 770 creates dummy software nodes not
attached in any way to the actual GPIO controller devices and uses the
fact that GPIOLIB matching swnode's name to the GPIO chip's label during
software node lookup. This behavior is wrong and we want to remove it.
To that end, we need to first convert all existing users to creating
actual fwnode links.

Create real software nodes for GPIO controllers on OMAP16xx and
reference them from the software nodes in the nokia board file.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-------------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 28 +++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a5bf5554800fe17b430e84ae421ffa8da2bb11a0..46f817f6316b70ff37bb9dfde86c675fd692999b 100644
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
index 7a7c3d9eb84a06c18fbc70e7c94a161b487cd002..c0f6e231fdb4422c5d2c1aa3e33dd6dd99d2710e 100644
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
index 55acec22fef4e73f20935473602ef6cb2f4f379c..e371183e0213912ebfa7edd34ca7e7683869ab12 100644
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
@@ -244,6 +263,13 @@ static int __init omap16xx_gpio_init(void)
 		iounmap(base);
 
 		platform_device_register(omap16xx_gpio_dev[i]);
+
+		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
+					       omap16xx_gpio_swnodes[i]);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add software node.\n");
+			return ret;
+		}
 	}
 
 	return 0;

-- 
2.47.3

