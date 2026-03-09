Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4963988F1
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060190; cv=none; b=Sky7K4/78OtEqeRs2sQZyGcPmMfEvMDh3Xlp3ZvFBmuNQzXHzftRvlT6du1T2lXgR66+zyBWc+rDutE+vC6tNymB9aL9BT1bWHwSas1aSiE1+Bxwcap5MPzwwxyHYcSXgaRSpL5ZCgNbZRRcAWSwt/XWKWCXFcN2e+hMplUh+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060190; c=relaxed/simple;
	bh=657u5VcsdCwH5K3uh0YA0oSgSY82ZXzp8LKA80Hy5Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOhEGa00kwUr8lLv+yTrN42KMyADTRD0QXDpDiM4jQ6X/d2/aM+kVwqBnSC2ENR4kR6XFuc4miT5y+xqCdtr93HF7IPZxtJwFTi9AyD3cT4FXQFEHM05b3WWqT3Jr5n95LhQ+QR/EJDTOb7Wnetzl/FgNiFBRL/+c84kwoN90xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqmHL/4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVhYL1Ao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqmHL/4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVhYL1Ao"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62981muH201091
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2026 12:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=; b=bqmHL/4VSNwRWM8b
	zRkOwuPJXJcW6NCQgD7/GLLOPdIJx/ohQONcGW6ViXOnvgJn6xsI0ZJVyeREi792
	XaWQuUNMQQltO7/iZLEc+JwdlnQAIeqsUUvnkkZEf69jnbPH3fGeX3tgn8bnDdWk
	YouR8i1kZZ7SnOXQzUTrfHZLTMfvLTwOMuaBiokL9Yb7r8dZrdVXesdVziwlGIMu
	eO7DFHN47nbr/+w/CjDYnHcGCE0aAcMkxuaCiqm8uggZo0mj1PYqLgKi10tOm370
	qyqgTwG0jEQLGNKeJYx8uxHBqLa2apnj9oZwXGUsE7InwozSFb4Lih/SuM6T/ALF
	/kO0Cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vddd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 12:43:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7fc27cf7so805209185a.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060187; x=1773664987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=;
        b=eVhYL1Aoxn6sw9z5zdXplC58GYXtjpNCiz9U6KOxoAlBz/2EOgmbGJJfDtZtJHNF9O
         NP13lrluO3ujBBA32IFIRqru8Dx6dXzZm1HDNQmRfIsIAekOu3uXJE1IHSgJKuwBLGj1
         4MocqTzcVftFJdZHYcjCyOR5onn6LVN73cnyVVCpNjjZHUc48+iI5L55egBWmHAuhTDb
         tahfG/Jr7IGLNl4iG3Lfj+TowD2I51rQdvACceLwZPDJVRpGikzDmxXm6gxs71Pi9ani
         R5rRjYH0Ba5DN1jNcmasn5xWWdJppg5rS+MxR3izbd2ZH8mdmpf7nFrE1c/vx793XdPk
         I98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060187; x=1773664987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQwazpAS/p8xBP8ywiNVLcoVJEL1G6gSbs/PG65TAEg=;
        b=pSEbwTVbzngxGMFS7ESOAHbIm6zTVoPEFT0w9Pl7Rr8/LSfuk4VI9SSg07Cu1plSti
         NggmHokRCsdiha32mSNVJ5YL5RnHOKPlIKelr4vik9lxk4qDvT7YOY9Zg8IaRQUSPuye
         12oulmboT5LzYbdE62isiI9pPLQuDdaQcUOkw3BnK12KvUqxWd0kgUxxx8HLzUVZY6LX
         lPeur68mfRFemLmdml9xpPEm1LP1TFNFFQChro/cAljJxbh2wPTZfkBm2hcHnM+9ruKS
         f+po/k0e7Pev9Q05pTDmq9gcdBcPCb5lnk+6ePMyT32EUjx/f9UlBwtH7iBRJMFhKptB
         1Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCVHM0ip5XR3D0XXlvZ208awMHVIngFIEKMR/nh0+EmTMkUaoMf4+ZppoV1Te0Spuq6J8m7f6x0Gd8gX@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTKUwDPU6ZX6UQcJoK8c+Qy6p7lr0h0CzSBQlyZkbPtG/Inpc
	FjE4KPbNTA5cpGWqY5KuiPGPe2zeqLPCQqliEbtpk9g91ZtJNoC1dMSzObTFL9dQlBkzgkfK9DD
	WEFHsLGVFnx9jQPnvvz5NfYvZj1v7gY/5b/mUrH128su3LmZhbqjdzwBl2YJj/A63
X-Gm-Gg: ATEYQzwI/fVd5picfglbDb4dOm/ozAzYGr+muAaSr8xZZvyDBkhGbC0dnzxjccXVO22
	opOlRISw6nCiDtVTiIO+SehYFkS5BVKBc9K6ejkhohnzQETpqeChHUV/b3AOsqmWlDuVe28tqrL
	IbzbHYZw8CdwHdjmJoccT/ud6vDXbr/SGNFcVTjH/DZnxjk6/Z/XO0D7w0Gxeo/TVY8E7aqRwXe
	mv0J4FKk29V6wZbDMUBNioFoocwMGqY6wQYsL//P+tOGGmw4uTsmYiCdbB8VhVAuh7uih0UwBhz
	+m0B1c3wcxatCsMpXe5Ej2zVHyD5+gucEXaenJLTTdDThbhmzBNRkNS5sBLbapGkgWowwMEYKJb
	vQpyQBztZTYddLvnd9OhHK2Tf1KE6PgEM78U4k+oo6sgUuqwQcQYl
X-Received: by 2002:a05:620a:4002:b0:8cb:3e86:d98b with SMTP id af79cd13be357-8cd6d49b8a4mr1509512085a.70.1773060186332;
        Mon, 09 Mar 2026 05:43:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:8cb:3e86:d98b with SMTP id af79cd13be357-8cd6d49b8a4mr1509506985a.70.1773060185863;
        Mon, 09 Mar 2026 05:43:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:40 +0100
Subject: [PATCH v2 4/6] ARM: omap1: ams-delta: convert GPIO hogs to using
 firmware nodes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-4-4e61f3dbf06a@oss.qualcomm.com>
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
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=657u5VcsdCwH5K3uh0YA0oSgSY82ZXzp8LKA80Hy5Pc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBK0MJaZuCEcNXm/8LzHDpWPQN1bHIaz1w2v
 TCs2lep/p6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ASgAKCRAFnS7L/zaE
 w1F+D/4u8ii/H1cE8fIlALXnOq3ppXSQii0gcpwUkzxyl2aq8K2iP9cVIuRXmWGSQBm8jrGtlLI
 uEKZW8XuSSvPq0v1kKz7ocOoUX62HTnzfjnWVp/fqmt62t2FXJaf4e877htmTDMfuu4WAOJv3Vi
 aycFNT86SGgLs7TNaQR8pKpxpVs8K2OXwZkFBdAiWtYE9m3fmtVYO142796Ldt9ZJk2hLEqQQ1s
 Dlm8xOOMtF6PBpBCUjy1N7795nGEocaF28EagBGJ3E+hzSPDkhV7e7BETT2xqAqUV2+D5LtYYm4
 WvG/bcLqvWHzhuvepS3qaRzRBwdbPEDzKgK6NEt/FcN1zjEuPX+rNE9LXgmjOiqKD72AIg/nvMZ
 JePKfzK5cfgOM17iAOXpQCpnNgYdWqUGxZpFzfTMTBPEKTfgtoCF2wCTUWnVJg/Z6HE5YyTGfSS
 rFR+lZgSRmmoDexhb9G3i2US0rL4NW2s70miKvDL/8OGOurFkHImhCc4C1+HNNyhNKPOCmoP7es
 e1UNoclkcwxf4CIvOsOcVEV7yejTycZD3CzLRdAZ8poSH8lgPEqKzss/XQfySnVXDe1UmDWgnmV
 gLqXZvGZoHK5xrjEX5+eyErEz7y58ofVkYqFx0icSyFPJR6v3IrCuoCLMWqToRxANhsryXTsWJI
 DAiNr1FHZFSJGJA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: M0JxzVKUYCL-j-liA1cGCvYz6EygyJD5
X-Proofpoint-GUID: M0JxzVKUYCL-j-liA1cGCvYz6EygyJD5
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69aec05b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=IpJZQVW2AAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=5psZAbpHc07LGj0ksyMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfXxhjg3AX9KxiI
 bMmZPejxfInG62z8QlnqpjvzhKctMhe2eZt7CmWqK0LtQ9mqevcBI+0XLDVOsDxj0juG4yqUJ7a
 +O0370HoLdnQwELwM7xi9Xi7K8XwQ9X+o+pEjjumFvGrpHPqrB5A/vlmHIDPyJUFWsPM7W+WlkF
 TQkxj5gFBfxcMkoUxCWQ7JXL0KG3GYjMrYmcozH2dfzSK0os2dri04Mi+zGsIwgyUpnnkYsw23w
 KYL3uOaYdtxnYCicvVx/hULHwGrikOItMQc984Ute4e/6fFcfRbpuXj82bh8IO4WC27z3pM7fGH
 zRMUzcgwaG3ZqKQVIdwasYxwOwqM8/WQmjL5EXFNbl1DpL734756p4TYqna2OEF+lqkV0oTsc/P
 c07fDjSrhd/eHvWgElWWjcAu1syPza1d0w4AYggyIT2zsHejls8nO8aDzlk42UjsEZt9IzoJjjn
 uJGwwWBTAaoVoExmGiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116

Setup a software node hierarchy for the latch2 GPIO controller defining
the required hog and stop using legacy machine hog API.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 16392720296cd224732450c85419c35bbab506f6..1bec4fa0bd5e8bfc58103d1f24b22176707fd26f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -556,10 +556,30 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
-static struct gpiod_hog ams_delta_gpio_hogs[] = {
-	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
-		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
-	{},
+static const struct software_node latch2_gpio_swnode = {
+	.name = LATCH2_LABEL,
+};
+
+static const u32 latch2_hog_gpios[] = { LATCH2_PIN_KEYBRD_DATAOUT, 0 };
+
+static const struct property_entry latch2_gpio_hog_props[] = {
+	PROPERTY_ENTRY_BOOL("gpio-hog"),
+	PROPERTY_ENTRY_U32_ARRAY("gpios", latch2_hog_gpios),
+	PROPERTY_ENTRY_STRING("line-name", "keybrd_dataout"),
+	PROPERTY_ENTRY_BOOL("output-low"),
+	{ }
+};
+
+static const struct software_node latch2_gpio_hog_swnode = {
+	.parent = &latch2_gpio_swnode,
+	.name = "latch2-hog",
+	.properties = latch2_gpio_hog_props,
+};
+
+static const struct software_node *const latch2_gpio_swnodes[] = {
+	&latch2_gpio_swnode,
+	&latch2_gpio_hog_swnode,
+	NULL
 };
 
 static struct plat_serial8250_port ams_delta_modem_ports[];
@@ -684,7 +704,6 @@ static void __init ams_delta_init(void)
 
 	omap_gpio_deps_init();
 	ams_delta_latch2_init();
-	gpiod_add_hogs(ams_delta_gpio_hogs);
 
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
@@ -693,6 +712,9 @@ static void __init ams_delta_init(void)
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	platform_device_register_full(&latch1_gpio_devinfo);
+
+	software_node_register_node_group(latch2_gpio_swnodes);
+	latch2_gpio_devinfo.fwnode = software_node_fwnode(&latch2_gpio_swnode);
 	platform_device_register_full(&latch2_gpio_devinfo);
 
 	/*

-- 
2.47.3

