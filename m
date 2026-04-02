Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E083E51E0
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139367; cv=none; b=Zk9aieQEFKVuy2dMWf4NUA4dJb4AaaB165awnN9fMY9HfHEA2XWnX0rZ8j2atNg++j+RfYV2hsNAIwF96qa5m66u5ptgf5bTOCP6t7uubDpRoNYCdVRWJc42QePAX2AHaYCrn4MLt/H3kjOtG8YL7nfSgg11KUvKL2c5QmVyIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139367; c=relaxed/simple;
	bh=LCXTRWIgG/99GVhp8MFYkc06vlJUWv5VfMB08f8sFao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVe1VpVZN+BXfFVK9bJLJFva2cIi6UHpXxCcWkkI7rZvl+LCoEEKpctCHcBBswsvHTT3FXYIJ2ytn3bEqu9bGylY/F1JtXQr5ij+Pmk6cIo30SW7YRBp7O1Xq5LPSgokM3TX9OGUu5tTQeSQNQc97UgmbBYqExBR1xXaMC0akO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jv3WMqmF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EsAY10go; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jv3WMqmF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EsAY10go"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BW0Ls948712
	for <linux-omap@vger.kernel.org>; Thu, 2 Apr 2026 14:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wES8wcKZ1pvEl/GAGqGsZxc6MwZbf2WUlgbApncZLUs=; b=jv3WMqmFBff5n/3D
	p2Q4nbtgyH7nrv5A28lD+FTh32DfaAjYQfVtWjy/XIWhE3JRLMEnijm/ei4Bj5rh
	KvckIv1qIpteRNPmKWmeBghWcVyUw/ccZE0OdZ4mhMN3p2hCsfKxJj7GsLAZaa95
	Jd0HLcyHDy1CNPKgQzR3YFGq9gFir+g1xxfsGNqrdI+fZINbYfHFqqjulNSPwHfb
	/LDLzCjZ424Jf1kaxV/+iRqX3M/ZK8mVnoKZEtkE6m9S3LjIq1aNxYN/g4NzOlz+
	r5p289hpQSq0k1knzA9gfQj8xYJp7mA+ldH5icZ3f70VOdC8bo0307DZ2Er+DOAk
	9prNJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qnu0p94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 14:16:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b220c72bbso30808541cf.1
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139365; x=1775744165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wES8wcKZ1pvEl/GAGqGsZxc6MwZbf2WUlgbApncZLUs=;
        b=EsAY10gopC+T+bMBF5qcp+J1KNQazp2IvzOAIFh114Ya2dViPKBNdTY+EFZ1+FqT76
         N1tbSHlsKMWliIs3q1SGTBs//hJROca7K7vOf0KCQ1t5I8DzlwkXW1NkjIAvpTNKD2Ow
         1RROEqh/yCCc25N3+i/Pv7OgkIzdzdCIZnfteIDzRsfR5P1/H4OMBOuFEVVnkFA4DOFO
         /ivasqmZgaNTsQJWrMfcIDmBQuovtMgOe0ybGBHMwehcFJwHETYtWDTIqguLE2UedP1t
         coLc+KgqtTIth97jZb9F1uJfw6z17B5kcaSOB7j2nSWFiDZAcCMSngUR+TDw+zUIx9Jq
         TcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139365; x=1775744165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wES8wcKZ1pvEl/GAGqGsZxc6MwZbf2WUlgbApncZLUs=;
        b=dxnRx67inpmtuPVFxucoLJ15IN+tn3dZsEBHRroNWREjmeJKVmCnL1P80uVi7ZZqYH
         wSNGwTMujBFJ8nA3FqFD90plu5aR9xlllBaYBRh4u5H38z1K123VbxYbQeb6WVoD0eOL
         KLHVJ3lHqE//H5wJUhrsukqUDuvH5JDKSHc6U2VjVw9iYtriIMyX+Vwg+D4CI92ZIKG1
         EVI7tk8kOcXUN3VsfXwu4ErjJghVI69bBH9Z184YUB7+U+X0bbZXA1uNQPB/3KmfJ6RV
         lvXoLFaPTQw2IHZLrC0sgl+zOC9KMOr4rsyWTsoa5zsXpOj+Zeazg2Nro93qhwFoV87u
         KzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo49beaAiiP11QrzIqwBr3TSLBS8pa/5QDWC3z9h8cMR/E1EW2tNumsDyokLmrrwD03elGCfbbXY5w@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1kPf3oTm+gKs/ZH+1SE8SzxS4PkKnq6Rq93vlzeWOV8ITzT9
	W3GBJG7zdbq8tOnEDya9K1q9q/WOa0IONNhcPxqrQ7GQi6/rktwv1zJJZc3Kzce07h6rpDL17uv
	TajAcwpaLfhvYsIvsITgLGQ67GXoxE5zHnLjNH+qa9AlT2JtH5pt4SSilnRIqd4m+
X-Gm-Gg: ATEYQzzSWVn15yIulokFAZVSw2NtSu0xzao3HVLBJmluNFLgB3NlCeSqN2YmWdufaa1
	+ts6gNoJI/fq/Q9S95pUTnZWKVBokAHw3lPi+GauWEcsHljq59nzsKZgRcHDoHftfowftUhhiYo
	LJtcCNeJOVJeF6nKQACgASDaKsLupBX2mu5QlovydZ5vTichsJjK97/5ySI4H1iEAYYO32lSqcx
	sI25k1dbaCCYtH5Ln4jsQ45wAM5iayftz3gycXiaTlzCqYJrYuNB1VOx9hDQeL1TM1B7MY2b5kp
	Ujgs2amRqw/mnGbGBRdNVCzUmSAZSu3qUor4DbeIDD6TxsgkrZXwqB7ryeTm/HMV8HV9Q76SDWY
	2abmr62TelaJPcivMuNYIMfymkiNcHQjnBLHSsvxNdczk0Zqqjilq
X-Received: by 2002:a05:622a:1648:b0:50b:7d38:9453 with SMTP id d75a77b69052e-50d3bc8d065mr106377981cf.39.1775139342866;
        Thu, 02 Apr 2026 07:15:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1648:b0:50b:7d38:9453 with SMTP id d75a77b69052e-50d3bc8d065mr106332871cf.39.1775139322170;
        Thu, 02 Apr 2026 07:15:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:15:04 +0200
Subject: [PATCH v5 3/4] driver core: make software nodes available earlier
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-nokia770-gpio-swnodes-v5-3-d730db3dd299@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LCXTRWIgG/99GVhp8MFYkc06vlJUWv5VfMB08f8sFao=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnwjyviMXX92bx3A1RXtxXU4Yu4V8IwHdYnS
 LameZPSOhGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac558AAKCRAFnS7L/zaE
 w833EACzWlKbqVGcfZAhKjZPDmJLE3XoLYXCIx6/AmX6i/x38OUku4A8Hy5Vu6BnJmTohfTi3l6
 ICdFhU7cVmlDO7NZtv4bBQokXVA3qUHb6ucwParLHw4jS6OPQrClb9B/GM91u20GomjJJOeKJtr
 a6E4/Rd2atvM8Q4nD+Q/V8fg3p1O3AOoJ+OeSZQa5JD4/7GzGHVErq06oN/Lh9g2so7xlUv0Hlk
 1mt5+BUNingwKzQ7YP1d04QJLigehOSy+bOpAvPwUsBiAzwRhFB4UJmgxrhXCUekYXxDNQlbj58
 wv50XhJTMr1sJpYVLAnJeXIgpuW376dd74Qa+ixJZXo+5ov/0scoZV9lATu7VCGPm7JNJ8J0cOG
 xN0eUm2khXwnOVfXlM0JYIbDg05TMFeHJzcvlNl4vATbxBudv4YHGgvAkyPeRyhUTcdBoNeTfK5
 sopWdebg5X8SzCgGQMTBzhK04LSrxiHZJeucP0zYrwAr7JAy/y2FI9/AfWTnc5RYOartdhkdCLL
 f2JrVcdSLAaMToMNOHZ4IZZddi4+nQTcg+/9OWnYESTHZ1sIgnTJxDuA2eSeJP6p3syatFohtfm
 BsLzPKbFSQBNnOw5sF2wGIz4DDXMqcrv1XY86Y1X/LEm7kA0uxNj6scB3+QtLzDjjbqTOe7RBIt
 LjjR/jmjXCsDhcg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: JqdKUmb3m2JOW5IcItEUoQAC6hO-DoIN
X-Proofpoint-GUID: JqdKUmb3m2JOW5IcItEUoQAC6hO-DoIN
X-Authority-Analysis: v=2.4 cv=RoLI7SmK c=1 sm=1 tr=0 ts=69ce7a26 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XRX4SzNu4mOsujJFFI4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOSBTYWx0ZWRfX2bSYB4sDZByr
 /xI3WMGdKM2J6agYCQgLqqx04huQTzNZKYskljWRqfq2sg6lj66W4HLrOuZgIkDr0mLJRdxVSYy
 Y7k1DzJ2uhKHDIAnAEObPYbL2MUyFfh16p+9a2pyGJ7V3Zp1EkOnsE9EkdH/2hC/CVJZmGaQRUJ
 6PlUGPSnZIjZqmK7KHcTAJaxxaDGlBZ6oTSJ+ziuNwIYDKF3gkW+vCgUrqY602VdQ5IxGVeyIXw
 z+IrJi1Y0bxRd5TrhKUqFS2NaYFzPwaqvHG6GwXPpyZUUJFYropDG3g5fSwimOPhvT4dovuYhvB
 IYG3inMaZxwhxkwhg1P96BzF9HXcITwwSWCmJN85d8+rKPWT/VldZogDIJQfdekERr4Gu+XYjLp
 6aeprqUJPj7au8roowFCUUtXr+B1nggE+7PFyS4BAXq4h3ePMx7eR2DRL1IPnseKl8ymKU5Y/II
 7xYpegt13ynK3cjrXZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020129

Software nodes are currently initialized in a function registered as
a postcore_initcall(). However, some devices may want to register
software nodes earlier than that (or also in a postcore_initcall() where
they're at the merci of the link order). Move the initialization to
driver_init() making swnode available much earlier as well as making
their initialization time deterministic.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/base.h   | 1 +
 drivers/base/init.c   | 1 +
 drivers/base/swnode.c | 6 ++----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index afeda89fd4710c4c5492b5f19134e2aa8e1e581e..30b416588617bbc3fb433654c999c9b533d73752 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -312,6 +312,7 @@ static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
 
+void software_node_init(void);
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
 
diff --git a/drivers/base/init.c b/drivers/base/init.c
index 9d2b06d65dfc6bf8759f6c232e2d3f753da139ac..af8014416c2460fac91b08ce919c082bf961fcce 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -34,6 +34,7 @@ void __init driver_init(void)
 	 */
 	faux_bus_init();
 	of_core_init();
+	software_node_init();
 	platform_bus_init();
 	auxiliary_bus_init();
 	memory_dev_init();
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 26cbe1c2a2e043a2315764085207561069c23ccd..a80575bf598b509eb1469cae8a09c601726ce0c8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1127,11 +1127,9 @@ void software_node_notify_remove(struct device *dev)
 	}
 }
 
-static int __init software_node_init(void)
+void __init software_node_init(void)
 {
 	swnode_kset = kset_create_and_add("software_nodes", NULL, kernel_kobj);
 	if (!swnode_kset)
-		return -ENOMEM;
-	return 0;
+		pr_err("failed to register software nodes\n");
 }
-postcore_initcall(software_node_init);

-- 
2.47.3

