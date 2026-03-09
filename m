Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1853BD635
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060197; cv=none; b=LZEN4emQzBETH43PpddVxFmVzm3cbuwNI+6YJJVtB2y7pP87RhcDkH5gSVJzej1LIHfmt2tJq7Utfw/PfWbEjLrgw/FwcQzoixHy+dhFXs+qXpWBI/Y/PiZxeEVXttGvBY0V7k9PPzOUXMcsmn5YRg9xhWI2MguASX4tEexdw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060197; c=relaxed/simple;
	bh=R4Ywu/pAKIvIVEZDR6pAqvPYf0v/XCn2dkIco/jqnjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHOq6Kb+HA/uokKKPpwNw3v2Mkdxx4xSnECjHnmHSwCkUd9YYCnKaq+MgSTHNNQySrGyGlbpHpV8j54YXPca06HpuR7LAk0d5elK4RRDlpAr0+KuorJIj4/IVpDLNM0hUBqdH0pXPIriQLcM5lsl72suAlNB3uVThW61Zvtbyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=keI0l7AZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbTNz15L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="keI0l7AZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbTNz15L"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298A4Lk2661676
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2026 12:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=; b=keI0l7AZufa5NJR9
	FxGOQJ82CTfr4mFRHFugkpK3cXX+IIsYH5lra08dS+9AK9XSvgBD5JKR2q6iWWuZ
	G8MRhRAlcnvmPlUbQKn47suu4v6aPEvDVZv8G8kqBAA05GiP/GR3mwa/R6A0hBk8
	DvgFbcQbQ/V/rgisY+O9yAaHxvTChxp8wpZ8PVrlzO1OPGydIInKtfEhGUhftXU6
	eUiH8X4FzkJMa/99XU6OgK67g3k5UqBsez9pUt6e04/tmfM0KdwodjRo3xWzoqs+
	lgk29vdKF1kcH+bRQQBndZoexA0ScP6R/hBdKJRSK5k1SzCBs9R9qf94OesuLpDa
	1EIqxw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr9cpnq0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 12:43:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd900cd3a7so160058285a.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060190; x=1773664990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=;
        b=YbTNz15LnNMMkisg21hFJps1dDul6em0VMvPTSben8utXN3ZBrmZKR/KyizmTEB2zE
         FP4ULGR+UGmgV9+56Axwee5F+B5O4b0Pg/VBAVIPCFiHQKsV9K0mI8SGidkn2WWGJ+Oi
         9d8Elw2oTxjzQJXRp63ymzXr7TTjv5KtJY35OZPGFD41T2MXy4XYjHwrkCMbylQTimV2
         p0XG80Cjq1PFBumXp603kCWt0IoJAYXBYmCoBn/s7eyGQi/leNiAZzkBoQpQeRtbyECO
         gxPqg+NMnWSV1O+75+EJmn/MutUUSIynm4SvSLkob+3w/PlGM2QIWEFvLRgvA9MT073L
         R/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060190; x=1773664990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+44pNLvKD6wmlyUHopw7JCev4MUbKdOMecmtcoK78I=;
        b=Zqjj7eom41xsrvuVlv7u/NXdKJeCnHPPt7sE9FGCQeP0cwUBNCx6BWhXnsO4ubBZl0
         8NH6CPKRxBiJDDPadSBwOjcy6YqVkfPUWwYRYhkK9sOQFLQRQ+tpbAmG7mophrVREYzN
         Q/Q3mvgZ+C9FNwgAiYCmPElmIF/oxpM2TZd0rpFIgWHa/D8gLrulYEouKZH5AyujlD0K
         rV1du1yW1LKzgBe+DS2R0iYznjcUjA/9OsCv2E1qkfzMjF+WEG0byuKKn3sc9YdWy+r7
         hB/owuAAjpBOFXrNxljQGc2SClAHQ8coFfBIG8wXJy6mAek9NHltyLsQVgUM3pZX0FTg
         K1cg==
X-Forwarded-Encrypted: i=1; AJvYcCXY+jSGqji7oHqblXe5l5hwwpuhIBOv/PJckgW2IgOc0tDLx4wYijgut7wsGxX1Ep51u+8Hr0HvkJMt@vger.kernel.org
X-Gm-Message-State: AOJu0YyOiHCu/Ufcd5Df7o9fG44oXSMtJHOPzQvNCe/DPX04Z5Z2/wtA
	P24LzRiMdJo+XF9k1/V9j4HFRmTfVetMKRcWIkFK60fbFSWJGY/Hf4NhdiA0Iu6uBcTPhEGPQX2
	zen9gzkUSj6iW3PGi9XxciKXgzudg5kA40fnvoHNi4nWSK8aS8OCXhWilX5kNsCb9
X-Gm-Gg: ATEYQzwgMY3EjGnUcZkUI3mnVQJu3VhqtSART7PGQbaSkZ19EZhl69ox0ZU/HJL6kiK
	LJUDYIANdo2YHTAcQ8cMLs/brlZJUhmAMAoBkIS87C57xE9YeQQo/auVVunVGcNR9wF2YnzqZ67
	9SqCAINN8yAWlV36a0kfHD5Bj1C4SMnmE9UQQzw8fMdlpUZxwI9E1b33cOJ0Q7eTnazahfQ1MFl
	357KesLK87YkZiu0kzlOpo/XO0e1SeUuWqykZy6KKrCtwLALb9pm0gHGNg7kUiCNQqG59g/FpCW
	Pbj0Ka9g80TwNwmtPoBfvTCf1lax17gFYHqzd/vz18WYj+7hWF/ruQ1XYbD4CDERLciSVtVm4nI
	vJmMuZYb/Yab+Liwddx7wFCbJf8AOjkqnEfddGQdBtVmz2GZkUDSP
X-Received: by 2002:a05:620a:400b:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-8cd8efbbe47mr163770285a.28.1773060190443;
        Mon, 09 Mar 2026 05:43:10 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:8cd:8efb:b7d9 with SMTP id af79cd13be357-8cd8efbbe47mr163765685a.28.1773060189835;
        Mon, 09 Mar 2026 05:43:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:42 +0100
Subject: [PATCH v2 6/6] gpio: sim: allow to define the active-low setting
 of a simulated hog
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-6-4e61f3dbf06a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=R4Ywu/pAKIvIVEZDR6pAqvPYf0v/XCn2dkIco/jqnjY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBNxYsA8Q1LF5HZoRzIH4kwEDuPpcFPljJRv
 aDgYFtdqiKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ATQAKCRAFnS7L/zaE
 wzp8D/sFgjA+zH/WzHB4KtIHoXip9zBsEn/LDT+Fc0zQjsN9Pq30alODEdm8KQ+4kbj30kiNHoX
 dstNie7A4CFOFdJPwCFC30iLABL/O3LGw0GcuGqDLpQyrQzw4wvdqKrSTu4mtdwyiivYzCRq8os
 u0H8OQF4+84yB9DQkNLZeGhmzmvXwz6+k/kpqHKJOzFIV5SHNHdwPV4n0+GKX0dM1YnGl9ggY7y
 isMrdgdf2mRdxkcuoHIq5Rj6e0TbaRn0noJig2+VwRyCSYbvQBCj88TIvDvzed0M+mp9Gwp2EnP
 x3fzOCgD8Gsava3M/x+mNa8MI3AGFCYHBrEGa3ST13BvF5u1P7NyvfgbHLY3qhafqoSd6Wk7WHw
 HUxKt/9nSykSy5BiCq8bbEr/Regwj3eWvVt0kOmfUNkz7oN5aFhS30szutYVtyIv+pyz//vvlvf
 PIVRWLbKRPH+narFofUFn7ynAgZf5cS/RKt89sbbM7qbCPisCZRLuX/kHvgtAujYbJy8N4cM0U+
 mrzJYamb4ipvmCxMdOG+2WG+3LqW/9omjYlWFhOzZ2v6+VJa+yxmVSfptO5zH1GoTfymaly/vir
 6u5EXCUzF9qDtPLwu6tfIR25m1CcmZU5WRnXPt9lPRFZ8NNZmctQoaUAdle8rpzM7F7e/dp0JPJ
 Mt+lWwKr5E+YH+Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfXzsEurSXqyu+C
 3pxJYqbgRklQH6uff0/+n2MVmXcC9TW+Z2w/aH35s+mIySpCkvfmSlJYHg2rZlblTPbJSEB43A8
 owmJKZypurLCK4vpINtoRvqjwUYfrHy+HvGbTskCijOLaDEw7W9ujK4THGQA+H/AGQLV3WH/6fr
 rfqM4h2s9p05fC0v2eepE2QuAsnQiujMIerY5yYi3thnu7GOkXDJYl1TS6Ez0++g2Wfcc3Hfev1
 u2s/PYOF+yvHAPENeUpmQLyiNvB1Upto67trRyKWLyQa48ZyqWrkea+yuL9BJU+Xw+jRxUhyQNq
 hG3No6i/BF8ZBJ9yewDZbffRGAGT9VoB3R9mrBicaR4POLWD5dMrmKNZmV5MH+H38R0cIgiEaDi
 zblQa8hTvkF8wM/S5T3QFL1kVfejW2LwJyOMa371KXyllaV37Zry/u2AHjHf5lc7jSg4O0syx7a
 3Np3ws0v9OSspmk5LmA==
X-Proofpoint-ORIG-GUID: R2DqQLYfFvoyQyhwqYPxq7_20d-zkEgG
X-Proofpoint-GUID: R2DqQLYfFvoyQyhwqYPxq7_20d-zkEgG
X-Authority-Analysis: v=2.4 cv=e7sLiKp/ c=1 sm=1 tr=0 ts=69aec05f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Z_vE--IGminT9Q5MwdQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090116

Add a new configfs attribute to the hog group allowing to configure the
active-low lookup flag for hogged lines. This will allow us to extend
tests to also cover the line config of hogs set up using software nodes.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-sim.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 51bcbdd91b4b027b7a340971a11cce5280ca1295..f32674230237eb08bbf8dd1337a79b5d0aa13259 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -654,6 +654,7 @@ struct gpio_sim_hog {
 
 	char *name;
 	int dir;
+	bool active_low;
 };
 
 static struct gpio_sim_hog *to_gpio_sim_hog(struct config_item *item)
@@ -836,7 +837,7 @@ static int gpio_sim_bank_add_hogs(struct gpio_sim_bank *bank)
 		hog = line->hog;
 
 		gpios[0] = line->offset;
-		gpios[1] = 0;
+		gpios[1] = hog->active_low ? 1 : 0;
 
 		memset(properties, 0, sizeof(properties));
 
@@ -1315,9 +1316,46 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 
 CONFIGFS_ATTR(gpio_sim_hog_config_, direction);
 
+static ssize_t gpio_sim_hog_config_active_low_show(struct config_item *item,
+						   char *page)
+{
+	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
+	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
+
+	guard(mutex)(&dev->lock);
+
+	return sprintf(page, "%c\n", hog->active_low ? '1' : '0');
+}
+
+static ssize_t
+gpio_sim_hog_config_active_low_store(struct config_item *item,
+				     const char *page, size_t count)
+{
+	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
+	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
+	bool active_low;
+	int ret;
+
+	guard(mutex)(&dev->lock);
+
+	if (gpio_sim_device_is_live(dev))
+		return -EBUSY;
+
+	ret = kstrtobool(page, &active_low);
+	if (ret)
+		return ret;
+
+	hog->active_low = active_low;
+
+	return count;
+}
+
+CONFIGFS_ATTR(gpio_sim_hog_config_, active_low);
+
 static struct configfs_attribute *gpio_sim_hog_config_attrs[] = {
 	&gpio_sim_hog_config_attr_name,
 	&gpio_sim_hog_config_attr_direction,
+	&gpio_sim_hog_config_attr_active_low,
 	NULL
 };
 

-- 
2.47.3

