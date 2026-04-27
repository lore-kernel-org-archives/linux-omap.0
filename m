Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A473B4EAA
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286823; cv=none; b=pOWmRqAFhUnp8bjbdwPwtXQetFPKah3zYmaubusjT+WwX/XzOR+Gfcs2n3CkYPsNqLWQ9qryB2VF3TK56sf2zypnkQCsCLCPmkRm61xwRNaiFafa8AMVdLWOe5dBHjqmm7D+c048SrXxGqtuxaeN/fCIMafjIFdzqd5GKA0Ndvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286823; c=relaxed/simple;
	bh=OhSErTTrG2hhJvOqcSYjx6uyZSzmpq0bHLQ7dDSdh9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaSmWei2hspdfpWhoD1xBXas9tfOlyMBA/nYyy306QLmPFfZPuVwcXJsOldQ5WqJIMdkaMkZOE6ZJkTNBtdGxhxMHmgYna7nN7P/gN+LmvmCjvMwUqRy6LWrTmO+2KcxH9vVtJo0v4ze1+PiH4zPmSzA0YVR7X4fTOsKOKe9hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xlc3hfrR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfkaiCfL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xlc3hfrR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfkaiCfL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9OclY3825222
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SqqUHJ/5XZ8IpQaHkA/f23LHDUIE51dJbyQs9T3z0zU=; b=Xlc3hfrRaQX1xhjd
	Gv1Uz0bBKCGHLpf5UHNyHNqbIHZA2aI5pB8+0f0lW4w/qO9VaBI4xSykUd5T3kLC
	ltwMAafV9RcTbxG8rFM9m2LPehvVuTIOFGnw2IcGnmwd7aU28L9uuTntqTahF1X7
	51HVtDrct7UIZZf4LAb0OsP53GjtwKcvgS6Cwsp/IhFifi2mYcUDvRCIgWGbeY8R
	t2GO57mUB8iHTOucH0gkMyIWhbL1AZ9rHfcKIdhpt9PqtNwVasgGiQISyZS2TWXU
	TaS/IVUOoVdNlLynaR/Sk0lXMzHRIZg9/8Af+1krGwTzV/WDoDg1bn4727oxG3H6
	M5fz4w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5550bjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:47:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d890580e1so135797951cf.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777286820; x=1777891620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqqUHJ/5XZ8IpQaHkA/f23LHDUIE51dJbyQs9T3z0zU=;
        b=OfkaiCfL92/E4Ni7txZjtxvwTtoASVm2+7sZkQZEVjG8Kr5njlUIRQjN/T5dpTUGa+
         Oth2Drrsbpecl1yIqruQXu9AVrTowy11y/iFO9iq3Pne3Bd1j/mD8MzxbHUtAnjI7e5m
         5y82UYdtOSmBuYnVPt+CZRe4iaxaKWlmzNB+ZYf+wuwlqhOJAbYSa+vlLWD+L+yuWdNp
         5pIVhtt09QOBZvodMTU7HBhiqWPDv1xOXjtbC+YT5nt1K2L5vaLuWuEnXINofLZ78LEv
         /NKDgK13PN2tDaq1jU3bbzhDktReU2cQqvVtxcu+y0IpohD605jTwSbLfPFicsWOolIr
         oOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286820; x=1777891620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqqUHJ/5XZ8IpQaHkA/f23LHDUIE51dJbyQs9T3z0zU=;
        b=rxXvL9fO+tVswuaZuIwZaSGn4oDOqIpoDW2XiKDP0QDxL0Bt53puF3kBxMXpEOAejY
         jfYVI20U6u2x93Y4yinGG5dNn1YNqTyogYA+3x0kJt8Q+QbddOtNcu4tF7o1RzlagLcG
         FEpSg5UovRpngo7b+YqqXGJlZ9UVPO/2C7aXiiU9YeGgWn+8yUSCCDyGyV6+3MAr3nis
         hd/Pn9F2JZFR4u9zj5aA5gp9U+KxzQVc2ASE8aJHFiMfYqImf5lH/XmI4NR4h2Lg/Iph
         8fMKQzVLA95Hkmy1bmwRqydRmJxDgGMVA9FyQhCt0lvidz4o/Ga229y+YH9SDVWFI1FC
         E2Hg==
X-Forwarded-Encrypted: i=1; AFNElJ9NAU1heZrHdq1ketqPUfDGwHfTp/Qm2n2gEbn+Fszm7MRf4uPuxlNbc8tMsUK05J5cc4UlqyzH6guJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22HOHwfxiYlfJN/MxKiAL5bvVnITt27pLdrh5aBZqdjCIh/XK
	fvuwbdlK3I39vGkyCHwAT90wxWSl2ElDkGo6ezjkT/ytETnEuXzvW+yS9suGLEKX/PzfHZIz2SK
	kZtD/SS9/KU/EyUGSW4FeNS/MHhTv0R/dS89Oa62PCrlgF3auXpim8umarqhESaDP
X-Gm-Gg: AeBDieuMQ/qJRX0Nyn8BH8qc5bGdVlc1NsoNQ/mw4Xs3I0XWo/IG9UW8ZJEb/MPWz0N
	YN8kWs/CDJmVqA6zCQBgNxSDtx9nsRBM2LLFNVtl+5JYOM4D5sOi1a7VDrfM/uOBwTxn3v5msva
	J031x9Fejwnjmpsn55gFOWOkCfcRKNib+SK9vyKqznz0ZQ3PD7sL4uWJKYyeT7sCTU3LPsgACMb
	yNf6Qq7XB9J/XYspBaLvXMkLDtW13Ab8UmPR5zivLoVVSniotUb26ik33WJpUvpYGi7wYpMHNWN
	Drw06vpjCub/RinYvKxNMMkpXb9tloJiUMs5ZTQVQBPTFOrWcPS2AqNBKkvVL85HAPATe2WpDcZ
	qU2w/XCdqPlV5qjVjb+rpJTyJxNJJdgIPF/dAHu8N69ZpS8fDPKAGNWlH/lsnHQ==
X-Received: by 2002:a05:622a:1787:b0:50f:c1f4:e3c2 with SMTP id d75a77b69052e-50fc1f4e5cfmr325748041cf.59.1777286820385;
        Mon, 27 Apr 2026 03:47:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1787:b0:50f:c1f4:e3c2 with SMTP id d75a77b69052e-50fc1f4e5cfmr325747581cf.59.1777286819942;
        Mon, 27 Apr 2026 03:46:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm80353681f8f.13.2026.04.27.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:46:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:46:34 +0200
Subject: [PATCH v6 3/3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nokia770-gpio-swnodes-v6-3-b693296c1985@oss.qualcomm.com>
References: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
In-Reply-To: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5755;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OhSErTTrG2hhJvOqcSYjx6uyZSzmpq0bHLQ7dDSdh9s=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7z6YcBfkMt9UuRGEend4nL5byjiGFkmvx6V/F
 oZDtJQO12CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8+mAAKCRAFnS7L/zaE
 w3OMD/sFCON3isNQJhXlxtBo3bdC3sjLV9tW/vsgJx/KDJli8B1tIDysvU0H9tzZK2BylD2NRlc
 ZtJEptW0d/aIaQ05UsOWWBpPXun+CJPwn6+/lExQXDjfGsGtPhX5CQqxECiX9e6OQH+9f4T0kzs
 IDQgTdxZrGoX0nhxUYbAC5FPqmR2fbYG81Q6tu9N/5Of9i6xSucbtupe5Yhc35bJ0iFV0Fj4rK+
 Yj/S/KQ5Gby2EjrckOdCP2bdDWjs8Rhk5gKqaYDNTPVAPPfCCTxbkhxIFUESILSPAb4Yt/dPSGc
 D4C7cpIwUFJzgijaeqn7KkhhIPrTfB21sGAZYANDMJq8xKVuBPKGbeUrcChaXqFA5vAnq8xRD+i
 AZXKqdbrd14MpCwPdKQPHwvUVICeNOiG8ERAHFMDhuhaFcqm4feM+bTEGJTEClbKFM9HDk8S9Y+
 hCoLAfmgPG1LOhMH/vkeMp9qmOUvftV7b2uFopbclnyVMYAVQLZ9MOrEWEO1acN0V0FZ8O0Pjsi
 wS/ercEkVGDUljBNAPgLEJWiuoTgYFeM+iKC23K363KH4Q0faE1FP+YP5ziE/dTHfonHPpgCGpF
 HwOmTPIAkJVJ3mwZU7+KtsSBfRsmLgJkS+PVOsnr5XgYQ+ZWxyB9Wp/vRafq2a7umvTpg8+s3T8
 4Xlk5INFlRAirow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: E8U8_B54zKE8ne6S3gGgKCgavYd-bRwY
X-Authority-Analysis: v=2.4 cv=CJEamxrD c=1 sm=1 tr=0 ts=69ef3ea5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=8ufHpPoMNYqLVR2KE8YA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfXy5eLxfjg5ni1
 WfYijVlosOurADooce9oarAhWJ8/NI4SBOsw6JVd0Dk06eQtizwDImZCTBSXSsCHzvEJVVlIbsS
 ga+N5Rhtfxm3PMs7n7dG11+SnjBGTJa03wfejQYcS/DSX2VTinm5AaxAJz3n5xtf4PVG4VSVWNR
 fqanlZKwePbnnbqO8fFt6tANIRP3033H7X+THJgV9Ssd9bH88hrDO83A57p7HmX8mfkcucO7j9v
 3WRmtMliBl/K3XgO1EfgC77RCODri214t3iELUUVm6U40ZHwXbeC7SY1uYmbY9Oh2uUL1vMlidd
 0Q0XxYmdyezObM63gZGfPL2c6MPsA/lUMZnQwahwEivl0vtCUBbRgZiGd9mznmm4v6Ms6izgQTv
 UnyTXDVLt1QZudxiquoy32VfFTN82EfuB7A1S77u23Mhxnt9p1TxEdedotaTHGk1HEeM3WmzLCl
 ULX06+FwVMVAl3QcznA==
X-Proofpoint-ORIG-GUID: E8U8_B54zKE8ne6S3gGgKCgavYd-bRwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270114

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
 arch/arm/mach-omap1/gpio16xx.c       |  7 +++++++
 3 files changed, 15 insertions(+), 25 deletions(-)

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
index 2904ce38c001505d48d0996f7053369bbf683209..abc71bb562df18fb1f683c6f216c698a38cf09a9 100644
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
 static const struct platform_device_info omap16xx_mpu_gpio = {
 	.name           = "omap_gpio",
 	.id             = 0,
@@ -62,6 +65,7 @@ static const struct platform_device_info omap16xx_mpu_gpio = {
 	.size_data      = sizeof(omap16xx_mpu_gpio_config),
 	.num_res        = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
 	.res            = omap16xx_mpu_gpio_resources,
+	.swnode         = &omap16xx_mpu_gpio_swnode,
 };
 
 /* gpio1 */
@@ -98,6 +102,8 @@ static struct omap_gpio_platform_data omap16xx_gpio1_config = {
 	.regs                   = &omap16xx_gpio_regs,
 };
 
+const struct software_node omap16xx_gpio1_swnode = { };
+
 static const struct platform_device_info omap16xx_gpio1 = {
 	.name           = "omap_gpio",
 	.id             = 1,
@@ -105,6 +111,7 @@ static const struct platform_device_info omap16xx_gpio1 = {
 	.size_data      = sizeof(omap16xx_gpio1_config),
 	.num_res        = ARRAY_SIZE(omap16xx_gpio1_resources),
 	.res            = omap16xx_gpio1_resources,
+	.swnode         = &omap16xx_gpio1_swnode,
 };
 
 /* gpio2 */

-- 
2.47.3

