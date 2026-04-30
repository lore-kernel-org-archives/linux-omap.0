Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4153BA252
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534275; cv=none; b=W8QFpqXkKKzOrBu/bdA920lU3RpTZ7fK+LVTFTAIGV6PoUi44vNvTCH2zpUaIhBgIKQtNBqEcOWlRtV97vF6+g01+Wavak0IdqwnNeM5/hosaYv3eBwJVkvDhNEKiMRplsvdNOZ9wAU/2I0I1/lrnLJYZBty3Dr27JtClqgjb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534275; c=relaxed/simple;
	bh=PHpDrTZXHmNwZUSRWJMw+i4wybcuMgJ3uN1C9wMAxi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrX/jKHPmg/tGYk9xASxGWhh5YoSM8Aeexc9f/5CMSpsKV1H0DwiihI9aUx9l2cpBb2C+JcSVCzVORJri3rdiRWB0S335TCIzWG6NqX6bj1b0yydEXmVrdWWUkOP+UPYCiBB3SIyJ3C3CMf51pLf1ER1n3OYiah6gg/hFbLkLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8ZEcTAZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UsfqAM3+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8ZEcTAZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UsfqAM3+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U5w4XQ2533912
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=; b=e8ZEcTAZndD7gvDd
	xk7RR6Poc+Z3TLgW4S1as3l4G182g+5Y+a3wT7kEvQnteuRD6Lt3D4dLtI3Yl689
	Wmd48IfyZq28fVE7l3CO9vC1azul95ORfkpoEDWmTigo3EZRBrDmV5+dj3NmJ/xZ
	+Hbk61dmTcH4LE+m6IU25Cr6PekHMJpOqrLi4axzUhLUmfLyYhdsnoyeYBhGl9O+
	bjq9/V1c4zJhCBmbQIvjmAVmAiqoE0D6wAa6LaajksvVufwg5UCq3sCsmXeR1056
	M4FbAgvnZev88GbC2MV04CcYUtTyh7gznGtH5869RkHah4HnddTrI2YIOq8xsbkk
	x36O1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe92h3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fbc49bef6so10342581cf.0
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534272; x=1778139072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=;
        b=UsfqAM3+T672P06jkMZzBiPiycGbLr8yyObnTRy09vkyB/E03OeQUJLTbmAbOvtRaX
         FudJhkdaD6rreWiUutD+NcYaoRi47VzsHoPjOKdENCN/Z1kqtEzdMrXNmMf4zSJ395mG
         DFugObCPsUvaMAuL6SxBb5Gg7Zc7eU4P8YcWWe7emMSNTRq4wz687MVfTrzbR14Q/FOr
         CSTI47cdcIZnogydesF1dQpLoql2Rx8gp3suMCyBIMyGEEtaOUrVUlCjtFQw6r6Vz7Bn
         TJHjuH0/O9HG8RsNUKil+yg9xfsG6E54z+Ey05llrD5OvVd9bv/HWfK7YW7ya+mRo8j7
         46mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534272; x=1778139072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/b/CPdx/UP9zJB8T5L7o6k+fxq4JskuiICzDFnr9ggs=;
        b=M2EAB4b4afNyEhZms6KWLT/YUgosDP5zj39vPEVpsb1jt2MhNnwbcqYNwT2FL/ShEP
         jfru8yCEKET/R0Z8Wh5kR6zL9Nu6ot6QsmHomE0w9HC357UDtMp6i1Z5jHnnNpE4faP3
         019l5AzX3siQIt5aPDWQKWlelHCjpDGkH/6JeZ9gJolmhXoC/m/ZyPdFBQ51x5OpPIau
         sqVLu/94sT2QXWurl2gh+rW1rlspVbn09KCw+or0BhTNYelwGDpwant0Ts/FC5diuVqQ
         jzru+Z6BAerIfGFT4F7mP7t80cIeQzbrluYikSU1hAAstCiDIZmOSj/e268TFH4C3t2X
         WehA==
X-Forwarded-Encrypted: i=1; AFNElJ8Wlwh/x2i1nQ3kUZ+0hddbuNMr5DZO+Dapqo5NApEbuzqZcfRoPUE51ad6vA59uHDjqFwo1tNwPPaP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tcoUldnR5Ag6qWf+QB52A697zygFPeZlOAw873V50BLA0In7
	keGrH6ldBHF9XV4aDzfTTiTsd+ID9jEdfoOWwR6rEJ2CgbTfa4/G+hmhxUdxzRgxCAAXCbiAvrA
	K4dSNeazbo7Rfic2Q+WEHR//rF+9NSGYJ8MgYtnHJHuGHdm0pxOSxbjjRPA5wjCfl
X-Gm-Gg: AeBDietcCm4ettrOHqZu7zpXQWSRtxPsHRUMq1lWSGGHIgcRj1fb2GTupJ82MwRIr6z
	xF6OSQJ8a98I8irg0V5xTgd6YCHJ99KvVfYTksKP0WobHRyZIMn04a2RO3S7bstp3uZZbcMcKF8
	mqHXbY6iFz4K1iwiIPlnZMn6hndX36hxEHgcns+dxFxJVoWDNNuG9oHN51Q0IAQ5S1BSn3iBAa2
	W7C82jmLZXBfIo6kIGxASv5eMI/tKRyiSXPdtl3wb9itaCzhQjliQOu2JJKw6S/T/G6LPsdQaHl
	Q5CdBlYY/iejlJg/+YlPay6SJXdZkbdbWEfayV+e8dnTRoUJo/4YG80aTKGACAf2W2nFw3hgKpF
	eM2rG/rKvkw5sZdtuw2fzznItMI1OX0O0l9x/XxbY76R2GJw0DwUh1zwRbQnj
X-Received: by 2002:ac8:588f:0:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5102aac21fbmr23257281cf.9.1777534271683;
        Thu, 30 Apr 2026 00:31:11 -0700 (PDT)
X-Received: by 2002:ac8:588f:0:b0:50f:c26d:f309 with SMTP id d75a77b69052e-5102aac21fbmr23256831cf.9.1777534271174;
        Thu, 30 Apr 2026 00:31:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm59515035e9.3.2026.04.30.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:31:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:30:56 +0200
Subject: [PATCH v7 2/3] ARM: omap1: use platform_device_register_full() for
 GPIO devices on OMAP 16xx
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nokia770-gpio-swnodes-v7-2-c88f74c90dd6@oss.qualcomm.com>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
In-Reply-To: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5930;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PHpDrTZXHmNwZUSRWJMw+i4wybcuMgJ3uN1C9wMAxi4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wU4XukNO7TP55pg4f/67FONGRM2nuEafp/wT
 kRV24+CwxuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMFOAAKCRAFnS7L/zaE
 w3vwEACMegZhfLDIQ41bJnAVGxvOM+tx9kxXuv0GdzvafYaKXSUamw6nOax3IPck2um/WXiok80
 oijfD99qGVMuGCgXiAVeJB3cnUwFGmNSYZNgRdu8cDD0Tbfn5wu6qxzZEPzBWuQ3q3Beet58xiC
 zUZwCZ2hfdTKAQINwI0kxqXrwNX3fYejHuH2EGJGrdM9fC+SRJSWFS1wMg+ExyHbVrceqlUOYKf
 b0q6f9feaBt8wptE6WJJXcNUyanIGiQFLN5ityIWCB9RAzcd6tBLBOzo2FfpGaKaleIRwjjEKkJ
 xUy252eNIl2x6oZbdoTfZTYA1nL85UsSwYRgRDMCEfiwra4dEv1KSXyix6YmaYCeeIObTUSbaab
 0NYI0YxJmUceuT/wXMyRh6kS0bO9gGXOpdWGH/PFq0TloUloHJuA6ZAQYRhTVnwibXdvtWD8cwx
 ks0jKWqs/aO739f/hzvZiMHd2zp4sQrLJSJ7P2Y329iI6lFCfsLzBMNI8vAPm5kIOn/4rNAc4ay
 GOfHfl2szvcTi94YtgvkrercKXtfuXDREpvuRas1ivYiUcDFH+NyrLOcMiTv9rGIa1ZZ5ouQOFF
 8jME7Cd0uZceegeS+xby6ZOagF1EIr08e0lJlyA6SQz/bM1Oqj5uVMoJwau+4ZlBXBBF9WRbkLN
 EdqOak95M9yCBpw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: cNDvgjBEtlbt1CiBwj1v6tyb0ZJvORCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX6cv+hjtT8+F9
 2cAMdjHgnJ2V3pVqfszK9j+z4FHlbwcJSfDfi0Nkao7jExpn3Iy2HLvT55WLqJ3OY3WaWalgdh3
 PZY6PuWiZMAfMzsX8eyNk89bMFrzd/iiHDnujMCJ0grCToEx31iIJDCKjyHPg1+m6z1/Q/1xom8
 Wi87xcBqNVgsGsjth0TpRcyxf3MY+yvRR4OUehE/emhA0jarCidIlM1uceTmuR2ocZ30S2AAr2i
 I1Ck1ViyX8/Lw42Xi4Yn75Cvp+xf27TM/7qXvyZy0vuYLGLpZmVr34ox/TACcjv6yfYPg4dm4g9
 RAhz+nPQt3zUW0qwiM3DISN57qbWBzZjx3L25izgiTRYaJ9RTO6hWhxrSuLS/LZxbdiXXo4Y02z
 2sSIjtU5eekd6KyHvlTqb7SGIClkHgktxoV40kxZMCu2RKY6YBEaMgdVhjvk6D4444+A1iKWmkp
 oX1Hc2LRK9zll7OAzCQ==
X-Proofpoint-ORIG-GUID: cNDvgjBEtlbt1CiBwj1v6tyb0ZJvORCJ
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f30540 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=f8xzO-aaW-4QTlJhfLUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300072

Ahead of changes attaching GPIO controller's software nodes referenced
from the Nokia 770 board files to their target devices, switch the
method for registering the platform devices to the
platform_device_register_full() variant. This is done to leverage the
new swnode field of struct platform_device_info which automate the
software node's registration and assignment.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 71 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index e8dbe173bd33fae72c7c884f930a530f78096839..9cca29f860544ddbec3734cec9b3246ce468543c 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -55,14 +55,13 @@ static struct omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.regs                   = &omap16xx_mpuio_regs,
 };
 
-static struct platform_device omap16xx_mpu_gpio = {
+static const struct platform_device_info omap16xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
-	.dev            = {
-		.platform_data = &omap16xx_mpu_gpio_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
-	.resource = omap16xx_mpu_gpio_resources,
+	.data           = &omap16xx_mpu_gpio_config,
+	.size_data      = sizeof(omap16xx_mpu_gpio_config),
+	.num_res        = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
+	.res            = omap16xx_mpu_gpio_resources,
 };
 
 /* gpio1 */
@@ -99,14 +98,13 @@ static struct omap_gpio_platform_data omap16xx_gpio1_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio1 = {
+static const struct platform_device_info omap16xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
-	.dev            = {
-		.platform_data = &omap16xx_gpio1_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio1_resources),
-	.resource = omap16xx_gpio1_resources,
+	.data           = &omap16xx_gpio1_config,
+	.size_data      = sizeof(omap16xx_gpio1_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio1_resources),
+	.res            = omap16xx_gpio1_resources,
 };
 
 /* gpio2 */
@@ -127,14 +125,13 @@ static struct omap_gpio_platform_data omap16xx_gpio2_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio2 = {
+static const struct platform_device_info omap16xx_gpio2 = {
 	.name           = "omap_gpio",
 	.id             = 2,
-	.dev            = {
-		.platform_data = &omap16xx_gpio2_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio2_resources),
-	.resource = omap16xx_gpio2_resources,
+	.data           = &omap16xx_gpio2_config,
+	.size_data      = sizeof(omap16xx_gpio2_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio2_resources),
+	.res            = omap16xx_gpio2_resources,
 };
 
 /* gpio3 */
@@ -155,14 +152,13 @@ static struct omap_gpio_platform_data omap16xx_gpio3_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio3 = {
+static const struct platform_device_info omap16xx_gpio3 = {
 	.name           = "omap_gpio",
 	.id             = 3,
-	.dev            = {
-		.platform_data = &omap16xx_gpio3_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio3_resources),
-	.resource = omap16xx_gpio3_resources,
+	.data           = &omap16xx_gpio3_config,
+	.size_data      = sizeof(omap16xx_gpio3_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio3_resources),
+	.res            = omap16xx_gpio3_resources,
 };
 
 /* gpio4 */
@@ -183,17 +179,16 @@ static struct omap_gpio_platform_data omap16xx_gpio4_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
-static struct platform_device omap16xx_gpio4 = {
+static const struct platform_device_info omap16xx_gpio4 = {
 	.name           = "omap_gpio",
 	.id             = 4,
-	.dev            = {
-		.platform_data = &omap16xx_gpio4_config,
-	},
-	.num_resources = ARRAY_SIZE(omap16xx_gpio4_resources),
-	.resource = omap16xx_gpio4_resources,
+	.data           = &omap16xx_gpio4_config,
+	.size_data      = sizeof(omap16xx_gpio4_config),
+	.num_res        = ARRAY_SIZE(omap16xx_gpio4_resources),
+	.res            = omap16xx_gpio4_resources,
 };
 
-static struct platform_device *omap16xx_gpio_dev[] __initdata = {
+static const struct platform_device_info *omap16xx_gpio_dev[] __initconst = {
 	&omap16xx_mpu_gpio,
 	&omap16xx_gpio1,
 	&omap16xx_gpio2,
@@ -210,8 +205,8 @@ static int __init omap16xx_gpio_init(void)
 {
 	int i;
 	void __iomem *base;
-	struct resource *res;
-	struct platform_device *pdev;
+	const struct resource *res;
+	const struct platform_device_info *pdevinfo;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -224,24 +219,24 @@ static int __init omap16xx_gpio_init(void)
 					ULPD_CAM_CLK_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
-		pdev = omap16xx_gpio_dev[i];
+		pdevinfo = omap16xx_gpio_dev[i];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		res = &pdevinfo->res[0];
 		if (unlikely(!res)) {
-			dev_err(&pdev->dev, "Invalid mem resource.\n");
+			pr_err("%s.%d: Invalid mem resource.\n", pdevinfo->name, pdevinfo->id);
 			return -ENODEV;
 		}
 
 		base = ioremap(res->start, resource_size(res));
 		if (unlikely(!base)) {
-			dev_err(&pdev->dev, "ioremap failed.\n");
+			pr_err("%s.%d: ioremap failed.\n", pdevinfo->name, pdevinfo->id);
 			return -ENOMEM;
 		}
 
 		__raw_writel(SYSCONFIG_WORD, base + OMAP1610_GPIO_SYSCONFIG);
 		iounmap(base);
 
-		platform_device_register(omap16xx_gpio_dev[i]);
+		platform_device_register_full(omap16xx_gpio_dev[i]);
 	}
 
 	return 0;

-- 
2.47.3

