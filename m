Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D063B961F
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060188; cv=none; b=qWQEZ86DhKPIiqZ8fkEE+ffk0bUfwz4rlrrOV3uYHIAwJE4gFxAiimZO5tcFA6aShNa7BCW83JNrBjgWKVZ/xRKpTBFCrDI+mDIk+zkEESUiLP8hPvQWP2NSnX/YVn/kUbpQQjdjnsxXlhb9MFjFECWjVBlMg/aP+c3Wps21ouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060188; c=relaxed/simple;
	bh=fRjGaFumkIPM5sHwzMJVqJbOfM3P51uoAqXe0hcwzCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fd6UG/X2V4E5OHoROV1bYhxp3VUKH2nbpd90Pjigqt2DuBec/PUvJfzS3aBA8s7HM7A37aaf80JjtIIiB9X/CJFpJxe3NO+ab7XDInr8EBBoYp5y6vi7X7YBTnJjE2i494ZAzIeJb09RwWBfiIetC9mXLunJN7knshNHj/0y/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IHv+fPDp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sp9/QGv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IHv+fPDp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sp9/QGv7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A6eEP2195117
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2026 12:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQgxK+sZo0pv6EN5kq/1WnDmQHdicuSmR6PjheX+D7U=; b=IHv+fPDpkk8TLgUN
	eyuc/FpBmb4kAwPz6oCOD+WpIH1kno9hetM4L7AYmWcEgWH0DpvOXIFCl0H2pKui
	OUok74JIMDw2JzD7d+CASfFLN0seZl5fc1cDSjPpikdaQfWfwsYTgfrjwpNkbare
	UT4ecsRGUy6PJ4xRObqh54ASOeUPS0aydIvdzLqfgPXJyNlgoLS0vwBDPHpnv6jo
	oRdahdg3ppwuqCJgMnaUQm5rQUTiHP+ZkSNJSjEmMMoQPMT45LJ/ymc6cS4IjAbD
	4bbsc03wpy8pOEV8uOWAfHJGbsvu0SBOPPEE4QtUSI/Pwcha9AUvnBnxQ4FnFEi4
	iKL5xg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8g4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 12:43:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd91c0262fso70879885a.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060184; x=1773664984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQgxK+sZo0pv6EN5kq/1WnDmQHdicuSmR6PjheX+D7U=;
        b=Sp9/QGv7qjWnXLhpMBHPU2IhLw7fjJ/tV7IVqhgG8wPnvBWkThMcjSZ8jZXjZhw5Zw
         XKDmpLh+5zFKSCZg6nGctecDv4U+Bf3ANTK1uobmAiv9jO2CJ2mUoRb+4qvTSghbcXdh
         KgSqBptTP8/qgA13IZeMAj8o3o6LiAF7FTun9O7MH+Zi/PUp8aRcOqRRb6anV0zQ9rEo
         xTQOAg2EMhzCufc+jsEL6R89nAKeJRPXAFpK6oEgVCkTYsyqwMYS8x/Fl3hYv6K50j6n
         cPQZnsiEfxXKIt+eqNmtGgr5zluujEAj9EvCWwaEiGNKncbqndCcgYqysp7fyV3dRkfY
         aPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060184; x=1773664984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQgxK+sZo0pv6EN5kq/1WnDmQHdicuSmR6PjheX+D7U=;
        b=nEWrjKLUHEC9me7vdqwzdGk9uUdPk3s2pepeu8mkR9iRIUkbQGwH/dzl3+ieAez/9a
         dXxt9OyFRLkgmZ0cksV6gymNxiSIg3PmP9+N1SsmDJXUr1uZvdEM/WOefRb51Lg2X1B3
         H9t32/2h8WH03oOTBsHPyg+6e83SiJW/DwaN4TuXdkVR7DsAEM9ETB2GYRdlHVhZjZiO
         RZ6JNmyv0w5dV01aARmxeGfshxpvxk5VMdg5mBUaouwmH3EpAhSM4U1dxDWZ3/D/0Chh
         +lOk2YANZX/uT2U1Ca4fWq3qxpJChr1KWkFasG0/VQ+zPkG9GwADMKkNIqMFL1lkc9jg
         p12Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBk56JYOS/SdJ8SkojKWSXr/KBz86XsmMCiUXXXcvi7otnGsqANwAc3Ib3TCekY9bh/robINdpEoVU@vger.kernel.org
X-Gm-Message-State: AOJu0YzXs+6gznOFRcdtqtUKpSRPFAna7SylxK/eCwbx7PTfY7r4ZqtP
	z3ydy71cIHvaYpILdW0uxv0kFK6lyYTZHhf+sxga3J4ShNT3JlVA95XrP6NK9nJTT8Qe4zJu7jQ
	WOCjBdYZ/tbdjR2lJgayz5uRypx5C7d1lZuuHySmADu8vsFNfChcJn+Frv2W/1NJn
X-Gm-Gg: ATEYQzyOG6UFi8H0/ablyGwhuugzJg4JrMWkto3FOie3cJ7rFITp158MbWMEgEKt2ka
	HYDbhxNVbC4kLD3kHp0+kruhPlLmQrwZ6rPkCsizWHmfFYGfZdOiNtGIZZYna2h8dxpsks79qUz
	OpMbU3hjn4q3bhRC20tnC+Se9v+v/zqHiefLKT+VnXa3sr1vwqASwhQgIDB819M66Z10eIfgngB
	xg8Z0elHJTxo5oIByhD4HyhY2sWK5CLXrywzqsH1u8pBu5yF3hMcaS92qriTizk8M6+KIElqI/Q
	jc70gmUqRE/TVnA/XLSyKHHvV/6iY/0fFooSpdia0mz0mkkMUKfKV0V9r3R3cdWvcpxmq8tidf+
	cX6d1IBTF98qu53tsIaK/vpSotjszlNPkWL+Cw1ZezorthysChXpg
X-Received: by 2002:a05:620a:489a:b0:8b2:dcde:b670 with SMTP id af79cd13be357-8cd6d515a4emr1308510885a.70.1773060184223;
        Mon, 09 Mar 2026 05:43:04 -0700 (PDT)
X-Received: by 2002:a05:620a:489a:b0:8b2:dcde:b670 with SMTP id af79cd13be357-8cd6d515a4emr1308505885a.70.1773060183666;
        Mon, 09 Mar 2026 05:43:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:43:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 13:42:39 +0100
Subject: [PATCH v2 3/6] gpio: sim: use fwnode-based GPIO hogs
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-gpio-hog-fwnode-v2-3-4e61f3dbf06a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6257;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fRjGaFumkIPM5sHwzMJVqJbOfM3P51uoAqXe0hcwzCE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBJXQFZO+NRl/S5LzA+qQAwFD56PV0C8Dpzo
 Bt9U43MMBGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7ASQAKCRAFnS7L/zaE
 w58ED/9w7/bKWzQRUd1R/MISkd+LsKPQNzedK+n4MFp9gHbgr/C18awbRdMU+vwaD5A4XbI8bIR
 /HoOGV+8CxRMHeEr9ML5c2vfnrquThtJnTy5lOruJ0z+q5XzyWRdWDBfoT47GF/SVAmrzOWLSvy
 i0E6mUh/zy23RrXwEWIKq8VHGA9niYBKO1TNFB9Yf2Tmel4vVvxtQMv9ytuAr9hESZ20FtFvEsP
 0IrDctLoWPVb0vwYm3qKAbWnFvwcOorkD3fxl2vNdXFOurMvtoO4EU0Fo7Zsn3Oqqsy7dvy43EZ
 fHrsYt7JALp0KdIf7pHjEemadWvk7Z97rF2oL3ftLjVceM/3hQuKY3KG1E+BPm2Wptf65ROSRP5
 4cwZHZY8lt+Tuq8ZXcREOCN+7VyHE//3zIvEHRuKfqjKm4ObsQQurkdMSpwUv12WQaXPGGzEKBQ
 rg42+gAdjPdoLL9pNS78gLjtLwG09YYCEaqmZqWmmJFR1gq/pgoTm2gunDa5OF6TuFcvuhvN9k4
 oMF26Li6lxowY2aJPsojvOm83X7DzTqZyiMEP5slXT9xRYkHB+UMoRr+2bXdhT2jKSgX3n8tOzf
 5Hwa5UasAbzhTlm+8+w7tQdY+egeF6HQ97o/RPH0qn0y91CLxti2FrboMeUl5B5DOYPhyp9O0VK
 L8bQNwyfQ4k86Xw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: NkvlnSkQ4Vrd6IIN_CXjevRlJIV-HkPX
X-Proofpoint-ORIG-GUID: NkvlnSkQ4Vrd6IIN_CXjevRlJIV-HkPX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfX94gdvWtREQKR
 e0jrL3/yZz95iXk+aJBM6HNdoGtwlMwYZxnSYpsmJ7dlAZuztXHn6UwGvlJeCm4yZuzUKrgwI7P
 +i9Mu8iiGapiwnsnzKjFjqs2dpZGfkCqCJaprO2REQbA1OUv4+W+QFzcvb3SLB2QrOIsbxONPNP
 5K3aiDIfNnjD12EOnwBmyfw0ESx/TJMx2MeysK7SdbmF4MFMQCbOFjUrWY8TpFTnjkSLEwss6xl
 zJet2HKOKjAbxPSanqSqf01NrEM13lo3FJMcJYA+7WVym0gHqT07QvtF/5NOmADKvZ6sVBQW9Qd
 0r8CoksZqI2soYVM0FT/1Y2NSZ/Dw8VBi9eHNYLKfMTSA+zCEA610Ku4CSppESBe0vuYTUWjBk+
 EgGpdadLJuvdK/xjvhYG1atZYm1gNdHWSfR/KK/UvjMSdYEqUTjXE0Lx9Z4Az7PRGpBITs1rxgL
 X2wwggGoGlYEBykj60A==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aec059 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=WMYs8r0CEYFgD91zWOgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116

Convert gpio-sim to using software nodes for setting up simulated hogs
instead of legacy machine hogs.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-sim.c | 162 +++++++++++++++++-------------------------------
 1 file changed, 56 insertions(+), 106 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 13b87c8e6d0caf62ce311dad409a9b4d3f091caa..51bcbdd91b4b027b7a340971a11cce5280ca1295 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -40,6 +40,7 @@
 
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	5 /* Max 4 properties + sentinel. */
+#define GPIO_SIM_HOG_PROP_MAX	5
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
 
 static DEFINE_IDA(gpio_sim_ida);
@@ -561,8 +562,6 @@ struct gpio_sim_device {
 	 */
 	struct mutex lock;
 
-	struct gpiod_hog *hogs;
-
 	struct list_head bank_list;
 };
 
@@ -774,102 +773,6 @@ static void gpio_sim_set_reserved_ranges(struct gpio_sim_bank *bank,
 	}
 }
 
-static void gpio_sim_remove_hogs(struct gpio_sim_device *dev)
-{
-	struct gpiod_hog *hog;
-
-	if (!dev->hogs)
-		return;
-
-	gpiod_remove_hogs(dev->hogs);
-
-	for (hog = dev->hogs; hog->chip_label; hog++) {
-		kfree(hog->chip_label);
-		kfree(hog->line_name);
-	}
-
-	kfree(dev->hogs);
-	dev->hogs = NULL;
-}
-
-static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
-{
-	unsigned int num_hogs = 0, idx = 0;
-	struct gpio_sim_bank *bank;
-	struct gpio_sim_line *line;
-	struct gpiod_hog *hog;
-
-	list_for_each_entry(bank, &dev->bank_list, siblings) {
-		list_for_each_entry(line, &bank->line_list, siblings) {
-			if (line->offset >= bank->num_lines)
-				continue;
-
-			if (line->hog)
-				num_hogs++;
-		}
-	}
-
-	if (!num_hogs)
-		return 0;
-
-	/* Allocate one more for the sentinel. */
-	dev->hogs = kzalloc_objs(*dev->hogs, num_hogs + 1);
-	if (!dev->hogs)
-		return -ENOMEM;
-
-	list_for_each_entry(bank, &dev->bank_list, siblings) {
-		list_for_each_entry(line, &bank->line_list, siblings) {
-			if (line->offset >= bank->num_lines)
-				continue;
-
-			if (!line->hog)
-				continue;
-
-			hog = &dev->hogs[idx++];
-
-			/*
-			 * We need to make this string manually because at this
-			 * point the device doesn't exist yet and so dev_name()
-			 * is not available.
-			 */
-			if (gpio_sim_bank_has_label(bank))
-				hog->chip_label = kstrdup(bank->label,
-							  GFP_KERNEL);
-			else
-				hog->chip_label = kasprintf(GFP_KERNEL,
-							"gpio-sim.%u:%pfwP",
-							dev->id,
-							bank->swnode);
-			if (!hog->chip_label) {
-				gpio_sim_remove_hogs(dev);
-				return -ENOMEM;
-			}
-
-			/*
-			 * We need to duplicate this because the hog config
-			 * item can be removed at any time (and we can't block
-			 * it) and gpiolib doesn't make a deep copy of the hog
-			 * data.
-			 */
-			if (line->hog->name) {
-				hog->line_name = kstrdup(line->hog->name,
-							 GFP_KERNEL);
-				if (!hog->line_name) {
-					gpio_sim_remove_hogs(dev);
-					return -ENOMEM;
-				}
-			}
-
-			hog->chip_hwnum = line->offset;
-			hog->dflags = line->hog->dir;
-		}
-	}
-
-	gpiod_add_hogs(dev->hogs);
-
-	return 0;
-}
-
 static struct fwnode_handle *
 gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 			  struct fwnode_handle *parent)
@@ -917,12 +820,61 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 	return fwnode_create_software_node(properties, parent);
 }
 
+static int gpio_sim_bank_add_hogs(struct gpio_sim_bank *bank)
+{
+	struct property_entry properties[GPIO_SIM_HOG_PROP_MAX];
+	struct fwnode_handle *swnode;
+	struct gpio_sim_line *line;
+	struct gpio_sim_hog *hog;
+	unsigned int idx;
+	u32 gpios[2];
+
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (!line->hog)
+			continue;
+
+		hog = line->hog;
+
+		gpios[0] = line->offset;
+		gpios[1] = 0;
+
+		memset(properties, 0, sizeof(properties));
+
+		idx = 0;
+		properties[idx++] = PROPERTY_ENTRY_BOOL("gpio-hog");
+		properties[idx++] = PROPERTY_ENTRY_U32_ARRAY("gpios", gpios);
+		properties[idx++] = PROPERTY_ENTRY_STRING("line-name", hog->name);
+
+		switch (hog->dir) {
+		case GPIOD_IN:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("input");
+			break;
+		case GPIOD_OUT_HIGH:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("output-high");
+			break;
+		case GPIOD_OUT_LOW:
+			properties[idx++] = PROPERTY_ENTRY_BOOL("output-low");
+			break;
+		default:
+			/* Would have been validated at configfs store. */
+			WARN(1, "Unexpected hog direction value: %d", hog->dir);
+			return -EINVAL;
+		}
+
+		swnode = fwnode_create_software_node(properties, bank->swnode);
+		if (IS_ERR(swnode))
+			return PTR_ERR(swnode);
+	}
+
+	return 0;
+}
+
 static void gpio_sim_remove_swnode_recursive(struct fwnode_handle *swnode)
 {
 	struct fwnode_handle *child;
 
 	fwnode_for_each_child_node(swnode, child)
-		fwnode_remove_software_node(child);
+		gpio_sim_remove_swnode_recursive(child);
 
 	fwnode_remove_software_node(swnode);
 }
@@ -977,12 +929,12 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 			gpio_sim_remove_swnode_recursive(swnode);
 			return ret;
 		}
-	}
 
-	ret = gpio_sim_add_hogs(dev);
-	if (ret) {
-		gpio_sim_remove_swnode_recursive(swnode);
-		return ret;
+		ret = gpio_sim_bank_add_hogs(bank);
+		if (ret) {
+			gpio_sim_remove_swnode_recursive(swnode);
+			return ret;
+		}
 	}
 
 	pdevinfo.name = "gpio-sim";
@@ -991,7 +943,6 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 
 	ret = dev_sync_probe_register(&dev->probe_data, &pdevinfo);
 	if (ret) {
-		gpio_sim_remove_hogs(dev);
 		gpio_sim_remove_swnode_recursive(swnode);
 		return ret;
 	}
@@ -1007,7 +958,6 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 
 	swnode = dev_fwnode(&dev->probe_data.pdev->dev);
 	dev_sync_probe_unregister(&dev->probe_data);
-	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
 }
 

-- 
2.47.3

