Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AA3B95E0
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060187; cv=none; b=MbobhEJd+cQvckXp+z/kJEJDHQJduorTtB48AJLE6X9rLr/AXU5Wk0IOqZOcWnr/nOddiy9bf3BaoNwlELAdrALiQsf4MV8bSfGIgAtVBhFoe2G9LmN52dH+YTyNNactrCEZLTBYfLpHUtad9arrcRTJm0eGq028SwWPkmqZUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060187; c=relaxed/simple;
	bh=OUFgb8Qz0GK1/gaXT/PVQevLnAPBCQbbPDyCF7sXUFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxoxpbHad9kt3gKdQx7Mmmnmqn7YxvzdSxZXOu17wNo1rnjBqg9LBAcrLMS9tefiTfdBNk0sa8ZRHks2b3y1Z/uBUzqUvWG9Tl8OM7LS9Mo/4XSV0eQFp/IiHNEvN90J2LuE6k7kWu08EAXhagFUmVHmU6DRnR9y6o1YKQjCTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDTyFeQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DtcfYXfd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDTyFeQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DtcfYXfd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A6d6n2195107
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2026 12:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXfMPd1XaYmr+m0Ul6mK7sQ3BrtNsGiWSmTvc1lddOY=; b=dDTyFeQe+yLivZB+
	oWYCktrl4Pg7N8S4oGzl4BGFM+dvOSA37OYEof0aGeXasiKo+GE8iTPJo44CB1EL
	ROYVPkt4czHhowA74QrVWKtMu+UVrBOHW1Eo5Fo9/T2YGJFJ9IM11sCiOzcZK+0Z
	o/yKgfc1Z9n7nsTLBgbtpsWiG5W2eCwwhWAYyTiicwf98THeev+6jGjUPuIGMaQv
	tf6iuXwW7+54NON/iCwyZVbTELXPEW9tGk8o214un8mDR+eTTPItvwIhxJzOaN2m
	wp+KOPiz4PmD6unN2tB/eVeLvby0kmSm7GTSfEVfiWZDvJXJLf0l1zg7PixB6DTA
	W8XL8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8g4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 12:43:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd773dd409so195013085a.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060182; x=1773664982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXfMPd1XaYmr+m0Ul6mK7sQ3BrtNsGiWSmTvc1lddOY=;
        b=DtcfYXfdeXBcuW/E0jHqVo5YKzjJOZwuivAwYZ/I4d8qBEhmZOSfABOheKe986vuDc
         TdeuIP7MVj53NSz2UF/1DHZQgvesullWhnPgbj2uV2u9O5LHaiDzT+vDYmSdkm+TfpQF
         n52pAIBT5l8ZIytjLBehvdUO/WjaevIGqDGpEbk1ndspxhkyprzTRXnZ4aYCJvc4airH
         ABSLNaatEJzKQaJH5z+rih9WVh7b1xAXzkKHnVjDfE7WItnncUXQcUcVt5ZW12o918ND
         LAkmCpMlysARIl6DKNmKiOCVtCKN46t7VNtbURupRFwtAnTcNik1wUFKApEuwJ+IGtrt
         mdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060182; x=1773664982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kXfMPd1XaYmr+m0Ul6mK7sQ3BrtNsGiWSmTvc1lddOY=;
        b=pVIzK23Ctia5dRnjaCWhlIgPW0JFq2MmKbveAkfCyu3xqHWwR2NVyChx2M4zULsoSr
         GW++feDF04jtxvM7K6brigpwF/Jfy2vAn3FIs+DBLngjtpiQFIHiwriIjg8v5wAiUYRj
         nkGRa7CPgmSB0YRNlWNQ7aGaIfZkgkHWOkCqlmnLKyjba053ct2tVe4JMUVvdL51akiZ
         aJHCmoW+45FxIWGy5YqxrzpNaEnXKTt+pTxLmqU1lWlRCL4+iu8hIrhBZ2RvmWLM02Gv
         9f13H9GWHxYJXcyjv6ARfRBjjG5YMPgpGPiIsRqavgPJaApwh7ihQ1GOaLyXfFhoclGK
         ydVw==
X-Forwarded-Encrypted: i=1; AJvYcCXg+yvr2TtkRwhmdPr1CBMjmGibeQPc8qPOaOStBNNhbuUSfaPHLHbNq+GY0SbgDbJ+EvIzsE8xOHxM@vger.kernel.org
X-Gm-Message-State: AOJu0YyAr04vnr79spH3XBHH3os1xqJBnfh2vV6em0Y0PVsD/ZelmAzS
	pTNSZREU84IlH1dfgzk+kQZzM9BEQHrnFSSXQiTo2kelLkuM4vSilJx0tgCcsvkxhidXuI6OQeG
	EljAGivL8/TXpu9N/TQqxgga/W3A+hy4q0dXVkQPlpP0Z5zxBjYBFuVHMevJpurix
X-Gm-Gg: ATEYQzxCvc1muSoxnOeEVnWnUXIZKiJRjc/tTRJdn5HXq4atWjqWMPzcrV6WtnH+tlk
	JjWBkoNRYAwIT5L7XsguGTWj4j18Kat1oDIt1YPpT4sQ0xR9TQOzANeHPKYGqPBCzHDrKB/idat
	xYtTHv4wq1IjzFInY64p4phTQGVkcy/K5s0jz2fdjcvNp8wqysn8OASFsnMFkv88HO36GVniSYd
	bt7o30aWPeUf1wC1ZPimECGIL4NfAPyljpboOa0i3nQPp4dsU8hdr8Q5aFtwj1YQqbT2F9c2ECP
	zX8tCiNU8+f6J2TT/n62rbsr6JfXAHcF+JjPvrgQJmSA/YOsuE23F96NULm8ingv7rkHokVcdYV
	0MYNPI/zhp94ngjPVZMtXLsQg64hiXyD3Nyq9ypZcBh9uXlFTtiFT
X-Received: by 2002:a05:620a:bd5:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cd6d36d2c8mr1380872785a.21.1773060181876;
        Mon, 09 Mar 2026 05:43:01 -0700 (PDT)
X-Received: by 2002:a05:620a:bd5:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cd6d36d2c8mr1380867385a.21.1773060181326;
        Mon, 09 Mar 2026 05:43:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:38 +0100
Subject: [PATCH v2 2/6] gpio: move hogs into GPIO core
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-2-4e61f3dbf06a@oss.qualcomm.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
In-Reply-To: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14044;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OUFgb8Qz0GK1/gaXT/PVQevLnAPBCQbbPDyCF7sXUFQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBId9xcXzbOth7Gymbfaqjt9FRe/KfnJPjDp
 N79jEB98kuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ASAAKCRAFnS7L/zaE
 w32CEAC8sYufJWmJsDubtmeQtDqgG+SKFTxD8RZzD13supY6t4IIE/KWCXM0gTcC3W6PjEDHNfP
 KNCQIiRTOdAomxOA6EqCH+yCZ11JB4IGziV2yWdLndApXo1Ed8xDy7SWPZ8G0/vHSBs/boYUoPK
 nQPUEsPZ0ISPv6tgv55CH18vSkiefuBCcr5bJg4s8JdwyVqkB83541iB/8Jvi+yT6JtbV5EVqv8
 aHAJcuvw2BbG9Rcf6UypwtNZbY1gycDWmzEAIb4tKn0qLkRKUH+RhCNGR2YGBNUXrLJeSq3QTxy
 l2nlWHBIb+k/tK1Clv9x9MBRLOZeBHxjOZ9oSh+wnsOe4086HiPRXsHagBoIFYyYjvK9dXWHw+E
 RLl3I1yrTBvSg60lM7nACrMZn+tgg771KEvO2zzT9Q2fUjLdLBQy5WD+rPoxYAbaYY8a4ul5ziK
 lVHD/sNM7IAO35s62jap6cE2dnEQ/wQPCK10EeQOd/WiLvaWOjPUjfRbZU6+Qkw814I2DAdVzn/
 E8S09juG5h310jQhecvQJj/ExFwi68IOn8bb53jxUemooNiCRPwnQPubxPjtVb5Zw4eV50R5WJ+
 fkjRDsxOe9e0HJGFpNedW4poL828rzAEOPZF/t7FS1rgdZwSeFLrm2Dw/Fo/f/qLR+M90pwf7pF
 6NdvOsvUttOfNNA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: m4sW3ajv0qt_AA_p-uTEMvtkIoJPFH3C
X-Proofpoint-ORIG-GUID: m4sW3ajv0qt_AA_p-uTEMvtkIoJPFH3C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfXzIDuRN15aT6k
 ZklhvMvZZXzsgTqejm7y+R2JIvuTuPnU8YWNb+qSzAa8Z9h/NffK1u/JFOG1tnpwfu0QJYdBLSh
 IuuPhKRher6G1zEpFr9jfJl7i+aWiGNGwu2+8E7OJMEGXUxXD/NVt5FOhfOtILODAkgWkN/JB9a
 VKfRds/ePKS97az31fRhh3h1somPbbw/hD0ETMaRNyxVmx2JHe9vAfayBMTCcABptxjSbCTdFMu
 aDm2HQ2w3m/LtWTZzCRNRGb69+KcaEYy0zaiGMxZEAidQpToNNKOMIb2F3+tLKaqWPCFOHeHmJ1
 aIb9uEWdWe4QhvAOvzAgpY1k7au8SYJnQ1wu45IwhKKteOzA2mOf8kQNx1VoPiIuXg3wxBD0q/2
 a6fRuWQhNaXeVit/oNXVJ6e6p3NZwa033Aliq9a9not/IVWjx5YmhPEB/t5TIAVty0+XEcUIF41
 /Uyrz7XgiFLc3O2oo7A==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aec056 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WIzJRdd3zNLVKdG7TxsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116

Refactor line hogging code by moving the parts duplicated in
gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
OF-specific bits in the latter.

This makes fwnode the primary API for setting up hogs and allows to use
software nodes in addition to ACPI and OF nodes.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-acpi-core.c |  70 -------------------
 drivers/gpio/gpiolib-of.c        | 143 +++++----------------------------------
 drivers/gpio/gpiolib-of.h        |  10 +++
 drivers/gpio/gpiolib.c           |  98 ++++++++++++++++++++++++++-
 drivers/gpio/gpiolib.h           |   3 +
 5 files changed, 125 insertions(+), 199 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index ced6375d1badf9e113e708ce4bc9f83071f9acca..09f860200a059b1d17c652b9aa66a49abea3cb4f 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1220,75 +1220,6 @@ static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
 	}
 }
 
-static struct gpio_desc *
-acpi_gpiochip_parse_own_gpio(struct acpi_gpio_chip *achip,
-			     struct fwnode_handle *fwnode,
-			     const char **name,
-			     unsigned long *lflags,
-			     enum gpiod_flags *dflags)
-{
-	struct gpio_chip *chip = achip->chip;
-	struct gpio_desc *desc;
-	u32 gpios[2];
-	int ret;
-
-	*lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	*dflags = GPIOD_ASIS;
-	*name = NULL;
-
-	ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios,
-					     ARRAY_SIZE(gpios));
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	desc = gpiochip_get_desc(chip, gpios[0]);
-	if (IS_ERR(desc))
-		return desc;
-
-	if (gpios[1])
-		*lflags |= GPIO_ACTIVE_LOW;
-
-	if (fwnode_property_present(fwnode, "input"))
-		*dflags |= GPIOD_IN;
-	else if (fwnode_property_present(fwnode, "output-low"))
-		*dflags |= GPIOD_OUT_LOW;
-	else if (fwnode_property_present(fwnode, "output-high"))
-		*dflags |= GPIOD_OUT_HIGH;
-	else
-		return ERR_PTR(-EINVAL);
-
-	fwnode_property_read_string(fwnode, "line-name", name);
-
-	return desc;
-}
-
-static void acpi_gpiochip_scan_gpios(struct acpi_gpio_chip *achip)
-{
-	struct gpio_chip *chip = achip->chip;
-
-	device_for_each_child_node_scoped(chip->parent, fwnode) {
-		unsigned long lflags;
-		enum gpiod_flags dflags;
-		struct gpio_desc *desc;
-		const char *name;
-		int ret;
-
-		if (!fwnode_property_present(fwnode, "gpio-hog"))
-			continue;
-
-		desc = acpi_gpiochip_parse_own_gpio(achip, fwnode, &name,
-						    &lflags, &dflags);
-		if (IS_ERR(desc))
-			continue;
-
-		ret = gpiod_hog(desc, name, lflags, dflags);
-		if (ret) {
-			dev_err(chip->parent, "Failed to hog GPIO\n");
-			return;
-		}
-	}
-}
-
 void acpi_gpiochip_add(struct gpio_chip *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
@@ -1321,7 +1252,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 	}
 
 	acpi_gpiochip_request_regions(acpi_gpio);
-	acpi_gpiochip_scan_gpios(acpi_gpio);
 	acpi_dev_clear_dependencies(adev);
 }
 
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 08b7b662512b825086cd70440be98b59befc3ffe..bc56003025258eba29c0897c43b29101fd490b17 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -735,139 +736,26 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 	return desc;
 }
 
-/**
- * of_parse_own_gpio() - Get a GPIO hog descriptor, names and flags for GPIO API
- * @np:		device node to get GPIO from
- * @chip:	GPIO chip whose hog is parsed
- * @idx:	Index of the GPIO to parse
- * @name:	GPIO line name
- * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
- *		of_find_gpio() or of_parse_own_gpio()
- * @dflags:	gpiod_flags - optional GPIO initialization flags
- *
- * Returns:
- * GPIO descriptor to use with Linux GPIO API, or one of the errno
- * value on the error condition.
- */
-static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
-					   struct gpio_chip *chip,
-					   unsigned int idx, const char **name,
-					   unsigned long *lflags,
-					   enum gpiod_flags *dflags)
+int of_gpiochip_get_lflags(struct gpio_chip *chip,
+			   struct fwnode_reference_args *gpiospec,
+			   unsigned long *lflags)
 {
-	struct device_node *chip_np;
 	enum of_gpio_flags xlate_flags;
-	struct of_phandle_args gpiospec;
+	struct of_phandle_args args;
 	struct gpio_desc *desc;
-	unsigned int i;
-	u32 tmp;
-	int ret;
-
-	chip_np = dev_of_node(&chip->gpiodev->dev);
-	if (!chip_np)
-		return ERR_PTR(-EINVAL);
-
-	xlate_flags = 0;
-	*lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	*dflags = GPIOD_ASIS;
 
-	ret = of_property_read_u32(chip_np, "#gpio-cells", &tmp);
-	if (ret)
-		return ERR_PTR(ret);
+	args.np = to_of_node(gpiospec->fwnode);
+	args.args_count = gpiospec->nargs;
 
-	gpiospec.np = chip_np;
-	gpiospec.args_count = tmp;
+	for (int i = 0; i < args.args_count; i++)
+		args.args[i] = gpiospec->args[i];
 
-	for (i = 0; i < tmp; i++) {
-		ret = of_property_read_u32_index(np, "gpios", idx * tmp + i,
-						 &gpiospec.args[i]);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	desc = of_xlate_and_get_gpiod_flags(chip, &gpiospec, &xlate_flags);
+	desc = of_xlate_and_get_gpiod_flags(chip, &args, &xlate_flags);
 	if (IS_ERR(desc))
-		return desc;
+		return PTR_ERR(desc);
 
 	*lflags = of_convert_gpio_flags(xlate_flags);
 
-	if (of_property_read_bool(np, "input"))
-		*dflags |= GPIOD_IN;
-	else if (of_property_read_bool(np, "output-low"))
-		*dflags |= GPIOD_OUT_LOW;
-	else if (of_property_read_bool(np, "output-high"))
-		*dflags |= GPIOD_OUT_HIGH;
-	else {
-		pr_warn("GPIO line %d (%pOFn): no hogging state specified, bailing out\n",
-			desc_to_gpio(desc), np);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (name && of_property_read_string(np, "line-name", name))
-		*name = np->name;
-
-	return desc;
-}
-
-/**
- * of_gpiochip_add_hog - Add all hogs in a hog device node
- * @chip:	gpio chip to act on
- * @hog:	device node describing the hogs
- *
- * Returns:
- * 0 on success, or negative errno on failure.
- */
-static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
-{
-	enum gpiod_flags dflags;
-	struct gpio_desc *desc;
-	unsigned long lflags;
-	const char *name;
-	unsigned int i;
-	int ret;
-
-	for (i = 0;; i++) {
-		desc = of_parse_own_gpio(hog, chip, i, &name, &lflags, &dflags);
-		if (IS_ERR(desc))
-			break;
-
-		ret = gpiod_hog(desc, name, lflags, dflags);
-		if (ret < 0)
-			return ret;
-
-#ifdef CONFIG_OF_DYNAMIC
-		WRITE_ONCE(desc->hog, hog);
-#endif
-	}
-
-	return 0;
-}
-
-/**
- * of_gpiochip_scan_gpios - Scan gpio-controller for gpio definitions
- * @chip:	gpio chip to act on
- *
- * This is only used by of_gpiochip_add to request/set GPIO initial
- * configuration.
- *
- * Returns:
- * 0 on success, or negative errno on failure.
- */
-static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
-{
-	int ret;
-
-	for_each_available_child_of_node_scoped(dev_of_node(&chip->gpiodev->dev), np) {
-		if (!of_property_read_bool(np, "gpio-hog"))
-			continue;
-
-		ret = of_gpiochip_add_hog(chip, np);
-		if (ret < 0)
-			return ret;
-
-		of_node_set_flag(np, OF_POPULATED);
-	}
-
 	return 0;
 }
 
@@ -922,7 +810,7 @@ static int of_gpio_notify(struct notifier_block *nb, unsigned long action,
 		if (!gdev)
 			return NOTIFY_DONE;	/* not for us */
 
-		ret = of_gpiochip_add_hog(gpio_device_get_chip(gdev), rd->dn);
+		ret = gpiochip_add_hog(gpio_device_get_chip(gdev), of_fwnode_handle(rd->dn));
 		if (ret < 0) {
 			pr_err("%s: failed to add hogs for %pOF\n", __func__,
 			       rd->dn);
@@ -1201,9 +1089,10 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 	of_node_get(np);
 
-	ret = of_gpiochip_scan_gpios(chip);
-	if (ret)
-		of_node_put(np);
+	for_each_available_child_of_node_scoped(np, child) {
+		if (of_property_read_bool(child, "gpio-hog"))
+			of_node_set_flag(child, OF_POPULATED);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 2257f7a498a10d69980f0c8afd48d5b661632d87..218cfe5bc4ac31a7c48306a08b4feafc06c0ad55 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -10,6 +10,7 @@
 
 struct device_node;
 struct fwnode_handle;
+struct fwnode_reference_args;
 
 struct gpio_chip;
 struct gpio_desc;
@@ -24,6 +25,9 @@ int of_gpiochip_add(struct gpio_chip *gc);
 void of_gpiochip_remove(struct gpio_chip *gc);
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index);
 int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
+int of_gpiochip_get_lflags(struct gpio_chip *chip,
+			   struct fwnode_reference_args *gpiospec,
+			   unsigned long *lflags);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device_node *np,
 					     const char *con_id,
@@ -44,6 +48,12 @@ static inline int of_gpio_count(const struct fwnode_handle *fwnode,
 {
 	return 0;
 }
+static inline int of_gpiochip_get_lflags(struct gpio_chip *chip,
+					 struct fwnode_reference_args *gpiospec,
+					 unsigned long *lflags)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_OF_GPIO */
 
 extern struct notifier_block gpio_of_notifier;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 581d00c128b608c30f45c12e968c15628e205870..b993cdae79e6dc389ca42ed079b3e39d1f9fed5a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -948,7 +948,7 @@ static void gpiochip_machine_hog(struct gpio_chip *gc, struct gpiod_hog *hog)
 			  __func__, gc->label, hog->chip_hwnum, rv);
 }
 
-static void machine_gpiochip_add(struct gpio_chip *gc)
+static void gpiochip_machine_hog_lines(struct gpio_chip *gc)
 {
 	struct gpiod_hog *hog;
 
@@ -960,6 +960,98 @@ static void machine_gpiochip_add(struct gpio_chip *gc)
 	}
 }
 
+int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
+	struct fwnode_reference_args gpiospec;
+	enum gpiod_flags dflags;
+	struct gpio_desc *desc;
+	unsigned long lflags;
+	const char *name;
+	int ret, argc;
+	u32 gpios[3]; /* We support up to three-cell bindings. */
+	u32 cells;
+
+	lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	dflags = GPIOD_ASIS;
+	name = NULL;
+
+	argc = fwnode_property_count_u32(fwnode, "gpios");
+	if (argc < 0)
+		return argc;
+	if (argc > 3)
+		return -EINVAL;
+
+	ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios, argc);
+	if (ret < 0)
+		return ret;
+
+	if (is_of_node(fwnode)) {
+		/*
+		 * OF-nodes need some additional special handling for
+		 * translating of devicetree flags.
+		 */
+		ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
+		if (ret)
+			return ret;
+		if (!ret && argc != cells)
+			return -EINVAL;
+
+		memset(&gpiospec, 0, sizeof(gpiospec));
+		gpiospec.fwnode = fwnode;
+		gpiospec.nargs = argc;
+
+		for (int i = 0; i < argc; i++)
+			gpiospec.args[i] = gpios[i];
+
+		ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * GPIO_ACTIVE_LOW is currently the only lookup flag
+		 * supported for non-OF firmware nodes.
+		 */
+		if (gpios[1])
+			lflags |= GPIO_ACTIVE_LOW;
+	}
+
+	if (fwnode_property_present(fwnode, "input"))
+		dflags |= GPIOD_IN;
+	else if (fwnode_property_present(fwnode, "output-low"))
+		dflags |= GPIOD_OUT_LOW;
+	else if (fwnode_property_present(fwnode, "output-high"))
+		dflags |= GPIOD_OUT_HIGH;
+	else
+		return -EINVAL;
+
+	fwnode_property_read_string(fwnode, "line-name", &name);
+
+	desc = gpiochip_get_desc(gc, gpios[0]);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	return gpiod_hog(desc, name, lflags, dflags);
+}
+
+static int gpiochip_hog_lines(struct gpio_chip *gc)
+{
+	int ret;
+
+	device_for_each_child_node_scoped(&gc->gpiodev->dev, fwnode) {
+		if (!fwnode_property_present(fwnode, "gpio-hog"))
+			continue;
+
+		ret = gpiochip_add_hog(gc, fwnode);
+		if (ret)
+			return ret;
+	}
+
+	gpiochip_machine_hog_lines(gc);
+
+	return 0;
+}
+
 static void gpiochip_setup_devs(void)
 {
 	struct gpio_device *gdev;
@@ -1209,7 +1301,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	acpi_gpiochip_add(gc);
 
-	machine_gpiochip_add(gc);
+	ret = gpiochip_hog_lines(gc);
+	if (ret)
+		goto err_remove_of_chip;
 
 	ret = gpiochip_irqchip_init_valid_mask(gc);
 	if (ret)
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 8d1a762f9d11bfc29c9102be02d7b640aa7daad3..dc4cb61a93187659d943f4ce3622bc1755e9fd42 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -23,6 +23,8 @@
 
 #define GPIOCHIP_NAME	"gpiochip"
 
+struct fwnode_handle;
+
 /**
  * struct gpio_device - internal state container for GPIO devices
  * @dev: the GPIO device struct
@@ -274,6 +276,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
+int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode);
 int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 const char *gpiod_get_label(struct gpio_desc *desc);

-- 
2.47.3

