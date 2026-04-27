Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E83B52F1
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286820; cv=none; b=HgK84s+Qq5O52aw05aBV9s+/W8WoGYzZ6bD3dq+SeX5GMehJ1R+x1iVS+QS0yLImiJkepYYrrMQqmIqap4daulxcy+C4ThKYWAfiH/goxrAqIyThRvbke5VXaKkqqFe9kJGIWFrGKeSFItXu7uYe24MGXA3rJPBBm2G5oQRLlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286820; c=relaxed/simple;
	bh=bzdvpv3oXCtAm3pD+12sDLx1Xj/eF5XT07wIxOiRgEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gm493AzlTx9vXT6XgC5TCgHNQB90pjRuIeCWIGzAWFy9r+5rUsf4hgctuD8S0NtLopcKS1DXJ64mi3r3FxBLWLrLxY/+35GgbxSb1Y6TnX7ZijLYnUPi3KfbDq/KWSa1BAS4LxTfZmek11jG7kDuzvhnJ7eivhqGB1QvpgJfits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObMX86bP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bO0bWUiK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObMX86bP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bO0bWUiK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RA3nTG3123502
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=; b=ObMX86bP460I3rov
	h/HnTRn/J888NwsUFC7X30KH9RWzLkpfQlIvbFDg8E0/S6OL8yJVGVlICY3E3WCQ
	ahs96rT9rWMOdKBOYYz2Mo/bVcjLveADkGe8M2EzCmR3AsXmh0968Q9jlJh9SCtM
	te7fq1Ld4VVx99aZ9IQZd6YBON67cHKCpb4ggttqcSslMkF6o2ltGNmmFGpPSqps
	2l1+70eXTloPdYwsaTJE9gTkd/ix4bzX41OtUIRUXtMl48aSa0TjLyAUL3gzX4Ew
	rKUH3eQhVr6zDzX6H4F5ANDPOd4WL/jMKgZ1ySQe9grYwcpug1wmXhuiz0H/xdlt
	+13mvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgg4xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 10:46:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so178202661cf.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2026 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777286818; x=1777891618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=;
        b=bO0bWUiK+yo10miCGi7xLzYx5YOsFbsTLQXb8SPlnpp6jb1cfC0dMVs+xv+UtUOWiB
         S/E/jBawqg2KrxcLdt+D6W6LVn4tOD+riQUgNwNNosrmBE4YZW+heeCLRhU9YOeLcMsp
         9mpfrd5Wmb4zE5ofD/5XRb39ltaZ3UwCfTjyaoZLHDvgOIRpZWGpzkggpMupEcV3CGOK
         eIFgR3ho/Va0ywrF+N6IYH0HNbWdflhboqfYY3glIVdonLeiB0znsmByaIbcWsWid5DN
         rxsFfjwSPrulvH6cILaVOYewURwJnqN9N0fyzS52NmRg4NSVayKvDdfwE4S548VmKFd/
         KROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286818; x=1777891618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMBhjJ4gM4j7t6ItG9Ak3kejPO8aRcxBWs0HcVt7qno=;
        b=h4e0PlkZQSKM1tucl7VHyyPBUfkojFFOOEejIrTvqAAS7UW/3OkD0Id+2+0dlhevF9
         8XqrpTENB3xPYUaWVlEzSFC00oO1cWEahYYDxbV01UsRTKi59A91nPlA2oPjDQXVH0oO
         +SAiwnT1TYU2oNE92WWUfCrp8SO3r2BYgh7gxESEFtpIH9Cf3qQp8pr23qeTE9jkSznY
         SgZy+PRZrlqyOkwHWNDepZXORFMPP38hHQ1smm2rplC1wJHtAvbfsB6N+RD4XRAaHPl/
         Pn/0rVs6EURqP7Laog7ZTN6DCo5/uDbqxMRVvBTfQeyGyDlDNU6MF1yGc7HevfaWfM5U
         drsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7njsHO/AWJEc0L/B6EuifjA5VrzJFukpSfWqzqPYUbLjX08DO3l+u1p5cybQzhx9ppeoH9glDv5uw@vger.kernel.org
X-Gm-Message-State: AOJu0YxJv2NjGu/glkTYXTqBoe71LXvfYSgD4Gq1q2WpVuXcrNc9yYKz
	ZC+NrcindwLmtzwIgFD8bkzQOWXliXVM1bkjqUV1NN8eoR7t35dKRfZMnwsXs6s836gbcuxfxRb
	ns7x55BCHgjKLI+O85P/WTYbQ5r8k8KFCHzIbJDeoltxcGZBaYP1MwF5l4YKtV2cE
X-Gm-Gg: AeBDievWD+auNpduK+hen/6y7ZlsfXDRrnAe6w12g0nVTjMiaEL2yF9tx9OJ3FO0xvz
	s92oksjyd+G2OtL9hm0hmZV1otQje8x5bC5a9nf4dCUtPBBUquO+kzEkWAA87SvFDhzsDsdP0ms
	45IqINMumKZkRfoTo4nOfe5lZriRwZRe7YcGJxQpxyP6Vmu48uJi2fSX7IzgbnspWEswgqZ4ijW
	3zsRRYHRTidxdnYokswMUSQbpUTNRdIR9acxNg7FVGynn67bsD4gKqAspgB4D7zO58pJmdlSXHc
	KtiHJB5yUiJC/9yxAw7Hq66fQlbA6qOe4MSfChRq8LTcclYGU6BkuawHSyQLMr25Nry4tnYR9KE
	Fz5auiYlQgqgWKWCj/RTTS00UJP0k5AzwNwPYPatvBgsi1ZTLjR4Ro/SRew3Giw==
X-Received: by 2002:a05:622a:58c7:b0:50b:577c:e259 with SMTP id d75a77b69052e-50e36c1277emr560394261cf.35.1777286817588;
        Mon, 27 Apr 2026 03:46:57 -0700 (PDT)
X-Received: by 2002:a05:622a:58c7:b0:50b:577c:e259 with SMTP id d75a77b69052e-50e36c1277emr560393961cf.35.1777286817174;
        Mon, 27 Apr 2026 03:46:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm80353681f8f.13.2026.04.27.03.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:46:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:46:33 +0200
Subject: [PATCH v6 2/3] ARM: omap1: use platform_device_register_full() for
 GPIO devices on OMAP 16xx
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5830;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bzdvpv3oXCtAm3pD+12sDLx1Xj/eF5XT07wIxOiRgEU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7z6XnHxXLbQ5/CCsvyIBlDuIW5n7WWWzycWjr
 PSV19KUtheJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8+lwAKCRAFnS7L/zaE
 w4bKEACPiNJFn33zMYyRDA+LIFkjWo/O3e5YsekS5di2eUt0NBw3FxcR3usc1yz7G01/ZatGQEu
 2FOZSg1BRM8iSqTOE6uTWrlZVs7TC5jGMP3wYXr8KHMWxlaKga+eg0IJ9VUUcbfeWA6yrgzSuUe
 rEa5XgQi7Rf5QTpkthcejRuIOojoyIidI3FQMOnJh28Ct5i1tYdRr7fE886KoSwCb/Xc1LDD0O0
 SS3HNHyy42KAhSkTwDwQ8qhKSDvxgoRGTmqUf777NbXOvEUkT3mTduQtw843Z7btOJnfWuLBigE
 b3UXDdl4w7xShIYRq7b9Sv2AtTaOaPljLiWoksKb+qR9izqZyP5FFE9zn3jBu8lphIs3fUn1PuM
 H0S5KvamU5V0frfEoMpsh/0KOeSrPy3U3R8KPMNJDUudj2oknT34c6hk8lDOA1K/UybEAysFyWh
 CMj35cUgryxQMKejE2Fg02nvQBzI5m1fINDI8cq9WlyUua2W9j7601/izTeG899K2FnCT1z9eq/
 1sz3Sks0eJDxpkWHNGECwZqn1pkyZp4F1JVkScDXZtxvgY5hq+HgJxU/3YbFNw3voCCnOxg1a3s
 nouMp8PRNA2P91t7qnuSUG2MShXLZWvp2pJtQlsAf2jqmvneSXcpQMBKS/y+h96NEXsp3cYPLSC
 jSvinHE1dlM0cyQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDExNCBTYWx0ZWRfX8hA1H+gJ1UE+
 Qs3ZeC+xIvi3QA6BTQI5Wl5Rr5xisqjFw0zbVwHDzzhmPfAhdXzguov/GiN18/w778ZXmNpbZWm
 pSycMNfIKdI2XTqCD1SwToaVQcQTcg/Kj6BHX5fh9RZg5cuPeCdlrTXUCCM/JuedRyDypFp6ExX
 Dk9aSOvJEMBA3HyxbXDO4omjk90UCWn46zKeJtf7pVMPx4moehlLoNQ5YYeyNvATdhV3DaNpfaI
 elRwakprk4ZHeOv13ZWXLkvwdsH/X7lALBZQhU/sVddaKqv9DiFQZ+PNZgxMo6ZdwrPvlRMOhVE
 C0W017FEAPX2NWRTUvGDLKWB0aBWreb6znMnvERJUAxSm6pA+ezoLntlSfA8HmzTFMfz4Nw4K9C
 CotE+MiHr/Zib0LufLA83txYXjqC1C+1if3e7uKtJTDwfRSQKwBbWnNL3nad95l0ID3pkH/Qnqw
 cikEjQ736KHA1BRXpsQ==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69ef3ea2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Ng6QAm6ffPCIYYv3ADMA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: r3Z6-FBwPFiaI0DG2a548JkGvbyPtfAC
X-Proofpoint-ORIG-GUID: r3Z6-FBwPFiaI0DG2a548JkGvbyPtfAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270114

Ahead of changes attaching GPIO controller's software nodes referenced
from the Nokia 770 board files to their target devices, switch the
method for registering the platform devices to the
platform_device_register_full() variant. This is done to leverage the
new swnode field of struct platform_device_info which automate the
software node's registration and assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index e8dbe173bd33fae72c7c884f930a530f78096839..2904ce38c001505d48d0996f7053369bbf683209 100644
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
@@ -210,8 +205,9 @@ static int __init omap16xx_gpio_init(void)
 {
 	int i;
 	void __iomem *base;
-	struct resource *res;
+	const struct resource *res;
 	struct platform_device *pdev;
+	const struct platform_device_info *pdevinfo;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -224,9 +220,9 @@ static int __init omap16xx_gpio_init(void)
 					ULPD_CAM_CLK_CTRL);
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
-		pdev = omap16xx_gpio_dev[i];
+		pdevinfo = omap16xx_gpio_dev[i];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		res = &pdevinfo->res[0];
 		if (unlikely(!res)) {
 			dev_err(&pdev->dev, "Invalid mem resource.\n");
 			return -ENODEV;
@@ -234,14 +230,14 @@ static int __init omap16xx_gpio_init(void)
 
 		base = ioremap(res->start, resource_size(res));
 		if (unlikely(!base)) {
-			dev_err(&pdev->dev, "ioremap failed.\n");
+			pr_err("ioremap failed.\n");
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

