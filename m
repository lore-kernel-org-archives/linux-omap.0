Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711D3B95FD
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534274; cv=none; b=ONAVM0Ezl62Du8nFaIvnC53Zj0XwsP4E6/SlEjiY+6kheZx+g/GrLz8HqgxuZjMKJuN2bB4DlpQC2thTS6mZgfxUzZoydHVWttmgpFAghEdgqNkoT6xzaI2+OD4GFkVokON/Uthu9ZUEFYkS916HeMOoG9IYmxOWNMGXjTe130I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534274; c=relaxed/simple;
	bh=J8vOAbxHqFIcemhsO1j1p/gwR3qJw56MPg1KBgWm1Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlRkooI5cr+mzb1EG61j2W5h4PkGjBpf4G+/w2Z+mtMqTLNM8NAnVjjxKuhKbbsrQJTMNJt93hJWJhOJxHf5iTwT6SSUhU9/UVm/+QrXONw4vFZdfr2gQS3DwpjAjbUj9G6FgbSKVjVNiXUP9MKTfFbgyOBHOwThqsQLJYFGQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=biQEilki; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIViUema; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="biQEilki";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIViUema"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U753os830424
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=; b=biQEilkiXpipI5BJ
	3ya0Lj73D3h7iTmWUk0Isp3hmgxiMFZepJVx6k4eAkdG0EvJZNI65pJSW54F/HYH
	/VTFnigFknR/CYAR5SmpVQgdlAz1xAdBUMPkF09gVI8zBKQ4YDvVeuHhBrrsugve
	WfShuZB/V6+xQv2DKwWB0No6gYMPzVsIFOAzAKwSDUJ/7YzIQkEKoOjI3cCKjxug
	KPj+LwwqewTkebdRzoKAY9kDfxuDo0Ff0X/ulc9jyGQwaqlqMT4xPAwvPVxgNJab
	L3LNzkU+IRXOkGa9p5wRnxMUNWSVtqtt2XeziAD23AyRqWmqJtjtUvOd31J1KtKz
	RCQsyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2cq02yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 07:31:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fb6d713ddso9210771cf.1
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2026 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534271; x=1778139071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=;
        b=GIViUemay4ixvE6XNye31rty8S/YpHv0NaEKSj8cWLF3lDL0HyEU2uUU6R0RAEmMoE
         qRCxsk0g486z3Hkj8to5KlhBDDo9CgoSejQLfakTuRW0dmIlku9YYQguVJmw9MNuhJco
         EEAwA1t4OjWs3mNJ8I9DVaQwEW9O+WLHFtwqJt5XlHsDRbljEvq/SO/gH74bbLjeWyGs
         vVRO6FP5Hdfv56tVfWHxDgbbfRkdPcUX+Cys00p8w0RB+KzdBpIRfxD60O6BSWvGm+e+
         d3Sczpq2cZVWqHP13M29cj21fJ4WRWrMkXQ9JqvUIchtzd9Pw2EvPiLzUa7Sd0hixLQN
         CRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534271; x=1778139071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxYfci1kXSVxnQ7Is9It7s1mhDgddxrEV+/CL+oUtl8=;
        b=lpKUP1g4DI37NHhzkm3kWk3MjF9c+AsbsrUdkYHkYhMXRN6FMolUteSyQR5fbHMoLv
         C38kmr510i1h31MyRl7ufgEVbSv9iKAzDwuwdyP6qaz9rKsD/92fEwHc/CxmRHgQVA36
         ibrVgLVZf2G8PKzENyv60YYEqcP0zSVBnoE/B/bzwzcIsq5ugpenOtL0DvH+z1ASvDyz
         ngAqqQqeuEBsT9hA8Mk80Lf79901WcuW3igze/kTJsLmgIMYSD3UaLv5rPY1B98Sv/zx
         5MGRuDAQnqe8rVFaD4Km8ijDksvEio0V1KUBIBXMEe+/nImw4nHEtMSSI98zVFmp5pkn
         wtLQ==
X-Forwarded-Encrypted: i=1; AFNElJ89hyzgo8FpSNeUPr+n4ISVPK7TKBJsMdALAmRe1vOkGK/1Taw6osK7ftSka+Gb+26VEc3cbRR6F9ds@vger.kernel.org
X-Gm-Message-State: AOJu0Yzni+WPVryavuFfx7QGxoNmZc+aSlwg1X2XZP+IuMMOor02Ybgt
	L1Wui7ROwmnKsDGcIrOa2NdyVi1xiZfevZfx74iCz2P4dBYH1eyRWoxnda6WSDo/HECSoFRKviQ
	6d7iGt9xyIwEH97TDNeUNyJI5hbkMKcwbzswLNjo2fb7dBPLOXY/uFptBG7yKs+r8
X-Gm-Gg: AeBDiev30ct3GdetYOQMkBIWPEZJBH92z8WbkWY90D2kjtAXaaDR3HInZEYf4of3yO9
	Mf0zYy13Pgq/z1dmQ380GS019Z37VefBLJRXKzka4+ZqZDzW5Hrr55w5/quNjivdNeyd50yNgyi
	oWuZMJ0HiMJkdai6pGW+/qZYDq49Y4Gm8NwJHCj1EVKcXt6qXdZLm7qRYBLJfZ2KgQH3Jl9CZCv
	KLIeENfZwwCqPKM/SQN3HteplCz4tkuoHAa7VR8TG0pR6PzlUhEBkZyHnw+VwTHTYDUWM7P55oj
	tz6+K+NcizG48m27Vkc9TLWjzesZ0x64O+qj6H4FhVZo8Z4pNOLvTLWRdCyIOFhyzTnfi1dmWXW
	OdpOH4vr69fIV4sscy7VPpeOyUpZNRl3TR6b3PdwUYYJMyUG+16CVoss59FyF
X-Received: by 2002:ac8:5a0c:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5102ab5ce91mr26359741cf.14.1777534270012;
        Thu, 30 Apr 2026 00:31:10 -0700 (PDT)
X-Received: by 2002:ac8:5a0c:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5102ab5ce91mr26359251cf.14.1777534269537;
        Thu, 30 Apr 2026 00:31:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a:f446:21cb:22e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm59515035e9.3.2026.04.30.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:31:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:30:55 +0200
Subject: [PATCH v7 1/3] ARM: omap1: drop unused variable from
 omap16xx_gpio_init()
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nokia770-gpio-swnodes-v7-1-c88f74c90dd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=J8vOAbxHqFIcemhsO1j1p/gwR3qJw56MPg1KBgWm1Zw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp8wU3IFS0fzm52KuRz8vZ9jnjkYXKp8dgiD8yg
 rUMlcVe6cSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCafMFNwAKCRAFnS7L/zaE
 w06dD/4m9RCZVbL5FfpHf3Po0kybG/VDb7u9MGxFtkNWG5xQiIBAJB475iiNgui4Ilb6ysX3CFP
 FW6iC/AOp6MDFRfcNxEJuVKNS9uSIP1gCAnuUu0mcoeBCqbUuMz1sov3zIGB0EgQhC+xhWY+fjJ
 gWi4Z5D0jLFz3f1ulw4grvWwm4B3CC71KPbOIJ/IXFP29XalvEx+qfQ2INJwSHqmPS84xohI06t
 ZpIAOFw2H8GKeqjGZrGZELUG9NT+1/VvgETJqD57N8GNxpRJi/hewRe8u3DkOmDwUgGgK+Yzr0s
 LVqmAOuo1u41/st79UCc39NAKE4Urn4kZL8DdpThFMqCfjeu0jgAVR969FDPhzpI6FDQEzJ3Pnx
 nZreA7fqnu4pXkyay3EAhuBKFotprhRuF7GcuBjBAkwO/mRV+L7fpYdT5m0bK0w+vSbiPghwm8m
 AsbM3HlqmcLqGmWmT3wHZydHz8ifgpst5nGjnaZkPNN3GCGq6f1geqkpX+ew5eg1vBCgm5Lp+Hk
 398ejYLi6hbpjAbm99qXplqW6FhlCTsHNRSVDOJM37s+VrQznEKhqHDTKNs39gpYr3bU9e6z61w
 doZpXfuEpG+mUOvKuo0Rb6/EDu5tTl8KB1qlt7PFwTWKbCOnfcULJXFOhqcL3GWVq2Ok9rQ1pn2
 6xz0VLSU1838EAg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: BrzmzaojGquc_M8GJX5tIP-h5jIFXimb
X-Authority-Analysis: v=2.4 cv=aYRRWxot c=1 sm=1 tr=0 ts=69f3053f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=FU2xtZrg5b9VnPq6Jt8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MiBTYWx0ZWRfX9r7viEj7qnDV
 WAbV6f6zEktd2qHdgM6yBDYl2GOXYejotsOdQokTxI5VnVSm0Xmeguds26Bnqvfm5GEOQvs/DL+
 aYKGiWI4uDwnPv1aGakBLYxF8BFVmkfyYQvVCUelVy5BQeJOFakIEoSyMVij9q8lohuTzto4PS5
 wQcq4vz43BE1iJR+Y0s7XOGczaVQUJzQohI/ddmHc1OSgQV8J5IN2/AmItf1RipJtJQJVOgIpzp
 gsisNYnc1MgiqEKKA2XZ4K6G2HL1JTtGIFvmoUM8ifQbBxcKbav2lLMSw4mVMO5t1B9gqgwdg8k
 RRgrWB7Df9LNKffk1siejWDG/mJazRgqfiQ1NJAAEVYRJGOK3BHtSOgLJafyliy7AmFh2rOhlfd
 gi4tv2F7pJ/t7kQPt93+3D9sI0ehioxhT4hUNxbMRgdzBVc4ymZRTmInYuS5QHlEgkKMe2WZwvJ
 M4yh6Xu7RazevxHE4og==
X-Proofpoint-ORIG-GUID: BrzmzaojGquc_M8GJX5tIP-h5jIFXimb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300072

The pdata variable is set but not used. Remove it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-omap1/gpio16xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 55acec22fef4e73f20935473602ef6cb2f4f379c..e8dbe173bd33fae72c7c884f930a530f78096839 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -212,7 +212,6 @@ static int __init omap16xx_gpio_init(void)
 	void __iomem *base;
 	struct resource *res;
 	struct platform_device *pdev;
-	struct omap_gpio_platform_data *pdata;
 
 	if (!cpu_is_omap16xx())
 		return -EINVAL;
@@ -226,7 +225,6 @@ static int __init omap16xx_gpio_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
 		pdev = omap16xx_gpio_dev[i];
-		pdata = pdev->dev.platform_data;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (unlikely(!res)) {

-- 
2.47.3

