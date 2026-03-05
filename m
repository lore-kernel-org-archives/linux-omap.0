Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE437BE8E
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704310; cv=none; b=T7spfHBAcM50Lqwoh+akb2AUysQ4FI1RVoq4Rdn5n1dC/l66m0MdJ6RogtUwv06sQ95VzHAb0GEJMZNLDaVY9rzhcMG/8+BYIg4h9KyRULQiSTutBcjRL+eWkMLF9p94rHLeNdO/A7BNTa5Y0e0O/A32gheVQoneT7dCPUzbt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704310; c=relaxed/simple;
	bh=asFRYbS+mWsBdMTNaAjlr1kv9Sq3WYDbm6irXLJp2J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGD/xfJ9DNvAHnVSWE3DZBO2AvVRwLrxqSne8hgulpfj/K2GN32QOa6CjvYrL+8Y2r7U9YNwidQjdOnrRGcMYHbD4UvWMfnqqQzjBLUepI91L6C4rQxwzNyN/GhsGWVgacF3ZJHqPcXIjMstUtcU3IZq3NXCKhVi3FoPV/gT984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE1at4dG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqTNxfno; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE1at4dG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqTNxfno"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6258avBL1193218
	for <linux-omap@vger.kernel.org>; Thu, 5 Mar 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=; b=DE1at4dGMoW0MPoj
	fkTM1XPnbaXH9aOtii8tMvhXZrHf0+cANP9OsxrvjZFRsMmqGtC6L8yRzmPBUjnB
	0bZb4g/2M4jJQPf2/9OAno2qDzeFI6D40wtuqXeqFs/IHqUl0i5EPWUHZKVVIY/O
	rwgpXcQDFhXpr3mW5UQY8n1mS8ePYv+Gzhbt4XN99Bn0ELm7TbaP71qoS6SCnV31
	jWY2dqSMvz6jnGnZycfawLKRE/xFmFMQSaRxb4BxnUxtBzgNCexoCgiQkrPD7Q4U
	YZmDIJIaJJ+BTsntuEuxDhA/rTQ/TZDX+SSJXFWtfdeo+ikncpU4dYalpZCl/deB
	6/3fJg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpqwgb0y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 09:51:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899ea295601so76528956d6.1
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704307; x=1773309107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=;
        b=dqTNxfnolhchTXA7hTdZdD2yyQMMbHfy4UJG/6UWfolY1scPf4ttfhannRJiqPUR1s
         tuJtWa78J1voKdgkRFjE0t8rm+HJ7LqsIXtnslc0LDk15oo9ohRlH5IM+ODRfpTFUSPT
         hNUgS1VQUMuwEJoKkcs7wE2HPs7ch1sl1DQF59YXGuuw2C7OakWq9bWLxZXzhISdzSwO
         PYTYcE2SfBeoZQTpxeSrfTzqus7/aSEHHX42qsnX3kV2aWkcNIwezL92sNYiSJwkJq+Y
         GCZycB2bFe02UXDX+MdIVMm27ehRn/Qm9R6WRD0UUxSy1YnFyQCidhQrbFcy07NEwdIi
         KbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704307; x=1773309107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=;
        b=LV6Pa3vgAuxrDJC+d1b2hr4FVAoTz/utusTsAPD2oJ66Q9mjNOQv2r7iN6F37POjjs
         yb70iNrZDxyNBEU2mcS0o4usfyj6iJ0oE+Gn7vCqmxIXxC/aPmuD7wuNp6NGVKLmkZ5N
         MCxUVV1eCgOn9R4pZvT7RtKNRf09xJY40nFbXb2SWzfpcgsnkKu/GtX8QE9AvmHAAhEg
         jkFh5Mbd43To0nZzgaAArpZrX/AS1rB4DvYl1kiQ8plVqcgTisgopDL7iJWbd4Kiu4D+
         kL81Kj2l66b69pN+QFAs++LFoCysfPVmfptedxmV2Q5yE0QKCLzVGu3ViCkMFqJmzmaf
         qyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVldsFhqeKIRuoExXz3lUXEwjk/tuVwYeCWgxsUZ7q9nJbR7AA8LmLCbznSEuSzPWwl0ZkO/CKi2MKS@vger.kernel.org
X-Gm-Message-State: AOJu0YwhA9nqTIoAkEVwPFvBC/VxtNcq38yWWaSdeKljUKO9kLDg9IDD
	l1kRykWAggtGl2nOGako80F2RAu2PlOETZjW375jLro+M65jvnHTJ4dbkEOOLFXKo7qzBV+Posm
	QhwFVQf6QgtwxRdcQMUOPEwIj9UJ34eA0WnZinP/OF2PaDXE+ovzvKdvxaA/UegKv
X-Gm-Gg: ATEYQzx7h8d6A2n53SwzgjpAxG6KCe5CL4R8dEQGP/y/oIoA0dh/9csdM4ytNUFTZDy
	MPAX9ILXKryn8avQiR9oghR2DBLAbJzeGkeC0R468Gx+XD+7v0VF+6zjf8PyocInCKtjdVFB5Wm
	8m48/QTUpYiPa/QIv3+V5dviHQAQmxgly4+E50NYvb4LuXz4BJ/zQ+LP3ge7aPUHhv6U5gGzH8i
	ntN8d95q1CDhcwOei4ryWF3Gu6/qfaVRBO3gbITzXtawAmh2AKCliBJXMbr33u/2ukIU64wWJDg
	VpGjri9ctozEeTVf4LkY/OvOgiQ35kLst0gbTOZ0Ns1TLtvf8BuU9IbRnUOxSz4BoClX9CzFF6E
	cMLxJK/bYvJYwUnEwrjXE3fSyONHn2PPcGhOsRftro1smzTIE98py
X-Received: by 2002:a05:620a:4405:b0:8c5:3067:903c with SMTP id af79cd13be357-8cd5aec446emr644637685a.11.1772704307402;
        Thu, 05 Mar 2026 01:51:47 -0800 (PST)
X-Received: by 2002:a05:620a:4405:b0:8c5:3067:903c with SMTP id af79cd13be357-8cd5aec446emr644634385a.11.1772704306918;
        Thu, 05 Mar 2026 01:51:46 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:26 +0100
Subject: [PATCH 1/6] gpio: of: clear OF_POPULATED on hog nodes in remove
 path
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=asFRYbS+mWsBdMTNaAjlr1kv9Sq3WYDbm6irXLJp2J0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIpxm8mmJ89njb6VW6uBXMeoNjLVFgEK4G/7
 o5qRQijDnGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSKQAKCRAFnS7L/zaE
 w2ZEEAC2PUZMyFEneqHPYBmxvm7P6SHUaTj09ZmnewmcmRX1Ifjnh5Owxce4J2PXBfO51XuviuQ
 3ws20+W2Dijv0XJmzoq1nvGp5TLupbdjCSbyQJUFx0ra4QKROzaeuiDk1zVjKxOdxN2Mq6mWsI+
 ZlPluD8qWKSXqyl7F51SOEf2A3g2mZlYMooA4yXeYXW1/BdB42IY+L01RH+Dj1rJUAXyHEOQG+P
 U8Kfj2/UF8LR5XXWT5p14hdLAjUoPPQgXGTWwGykCZAQ87fvt2xofkwnYQvg5AfnJOtN3Q1z4Rb
 tAhCKqWUmyuGnM1cxyrYcmUwGyHxKu/JbGD8sHTiyhcr5/fNv0usioIXka1DEZ3AOJTQw+d8wmI
 I7GLTtfU86WrlAGhUm29Wiuvs3M2eoJzdOPwtCsPo8h/a+p8hTczNCsCu36zMJ2P3zBdQG+qK18
 4gkv7hrrC9HfvUV0GM7w8dzGf4XIYnh+G4OlakqRfusunUJEHOP02Qul78UfSEcXCzLbLigiuSn
 6WmVCIKsJ7XGLKM5Gbx39Qo6WlVAjrF9PYKHeyz/Hl8XsWUjEO324tHHi/ZbZFIYFqUcJcE7nOU
 cmH1y7X03mA+ecUrM2+7VkLkOq8SSkSK6J/0CKFWpOvOfbE5jfo7RPTULOkoh78+xaYksHk8Ma0
 x9BWcpJG25QWsnA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=bdlmkePB c=1 sm=1 tr=0 ts=69a95234 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wIkqWORfvUmHQsOhi0cA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: zRDfhc8x31XC6OXmSBKloJvzQzYn2UAc
X-Proofpoint-ORIG-GUID: zRDfhc8x31XC6OXmSBKloJvzQzYn2UAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfXz16LAasjZ1Rr
 SP+WKomvr8W4AGb32CQPRDnx6FXuN9boDgd2P2f044+JH4vXrS9gO53mLXCfxEp1IyvJsTYeVRP
 UVO+9aR930945wWAM5+GDL4VkdMCox5UaQGT1TeeP5cM9fQE1rVLlPnVFXEP2bSMwPxQUB4eYX4
 WAA1tznvmH63Ap35KjM9jlxW2tEcRzWyD0mEnMxSAXOmtKbyppU8KOZcoMyPoYeupFSwq6UYNcu
 8EtpWQl1gMWTsxS9RnXv2dFmd3Q20qKdY7/yL10FFl7xrM0h6fkAE7Gd3V1mhMo3eUuhxu2/GlV
 h+dO38uq1WFUaGZ8Ot9Lrh6fff1p8Ag2pVd/7z0syXRGTH9PrWzygJ7rgLnMnuXZBfbCxG6RR8/
 Mg4p+s82ETaw5FdeOY1pZUv/M6mfv2XDm+wF+BqMWLovYeotIKYyNnJj0FqQE6wEgI9DC4v6QYq
 OhVyQ3H/gDuHXB7Z9Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079

The previously set OF_POPULATED flag should be cleared on the hog nodes
when removing the chip.

Cc: stable@vger.kernel.org
Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-of.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ef1ac68b94b78f09e768cc740e893632b8817505..08b7b662512b825086cd70440be98b59befc3ffe 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1210,7 +1210,14 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(dev_of_node(&chip->gpiodev->dev));
+	struct device_node *np = dev_of_node(&chip->gpiodev->dev);
+
+	for_each_child_of_node_scoped(np, child) {
+		if (of_property_present(child, "gpio-hog"))
+			of_node_clear_flag(child, OF_POPULATED);
+	}
+
+	of_node_put(np);
 }
 
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index)

-- 
2.47.3

