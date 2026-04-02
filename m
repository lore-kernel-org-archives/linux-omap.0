Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED53E63B5
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139324; cv=none; b=Kpi6dDS7EQgVI4LU9nYQgnv6HhsBtOzoIlZEgDE4zjAUNiW7MHbY6Od5sd1d+S5mzSIRZGK/5B2tJ3w5rWB/UrLTMKqwX29Phpz2Am7Ldi0WNr5I7lRZ70gZ+WSErKyh0NsaW8RSWRP/y0uZ1udKbrry4xs0f4O3hUI8owcchFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139324; c=relaxed/simple;
	bh=biv+GH+fROKOSl4fjZqd21aT3c4FLHEhSXzFKMuT8pQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1nkrdvOBj1z8IKWIubXH6KIKfKhjQ3CmiWnUi5taMM44mylic0Mn8mhj9+tpjOdx4q28owF6n9rEBL+WVnXoNUPHpxj6bKUVFUsq395ziQhiPZCkQHRiECZWrlJ6IbBrm6j9N6WwTaWe9UPYARMmhe7m9zBU4rarRWfokawJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJ9HwgEw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNTWu6jC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJ9HwgEw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNTWu6jC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlJ0B2337945
	for <linux-omap@vger.kernel.org>; Thu, 2 Apr 2026 14:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1QP3yia4CdU5PX7yrF+zFl8JFATM5bcCf24XnEBdAEY=; b=ZJ9HwgEw3XRIYWXB
	5Dy0Wpj5dn+FGEp441qjsC2bPEzYqQzvcRCFp2TTSuP68RwkhbqNAvZA70PHDvBn
	eGfBeQet+Z0Kx/hasgTcjeAiMJJ+ftCYY+DPISLN1C+Q9ZW5iEsZyC84njmCX+Oj
	iaoD50pu+JIiNtP0wZ/1d2ZoF/2uLPBzdcwRYXzLCx/oPNfikHn9kkWNiQjWJV0l
	uyOtjlLm+YMd18I/aO+OQxhGwl9Q09DcsODECgPhtYTgFobVJrD1TmEgdkfnF3eP
	9WBPqvQKDx9EN2qdHhDxjj4wswEx9iRpmMsoVcqWL66sxbvfDYC87b/Z9xC3ODHD
	1Jgv+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw08mjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 14:15:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4987c698so3990561cf.0
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139321; x=1775744121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QP3yia4CdU5PX7yrF+zFl8JFATM5bcCf24XnEBdAEY=;
        b=UNTWu6jCoGZJxdACXDUC1030yqFwJwK1cWFzHX3pnACQrKsy4BC6NmAwSD0VZKEWID
         jEl3mpA4km684UUiJtksJJgvolAe/CZCyF51wQqNZJhRpBxUb6rK7Ny+l7wcfmLxxq3C
         eIXklY+fays4OWy3DJqh4p+oEhRW0rdprQxCtr+zRN/1BL1l/LKRl6mqMUlgGU/G+bpe
         4KRew/qXstuCMSWL4GZqUue2g3sCpltaGcQZpik0q18lKccT3LanCY4CXdYgWOxjg8N6
         i4r+y1+rAmmyQgmwiMO4fzMkB4oI+D8r/qGZqXKczOK+X/mfeqNVnJkE5RWPxy6wCQaj
         SIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139321; x=1775744121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1QP3yia4CdU5PX7yrF+zFl8JFATM5bcCf24XnEBdAEY=;
        b=A+xmT22mgWrZiNmraaYqW3pRXRFR1nnKhRcaGJVLVouKZcRx4Lcqo94G9z3MTs9ArL
         NmZc8uHkTAmgeNWL+O6UEbp7VV5IwqKPLgYvMdmU9p+7EYCAdVAad+J3yAHlNynNWk3T
         0jpGX5c6El3Z9lgG4RFeUV7vX2T8UJPYfmgw2whEaDpSAuYWgxB/ATCiEzUoXjNErRxF
         RMDqXv8DoQshY1LM5ga6UHtkXElKqJtJWiCto6olAWWvNH3y4x/CisKqYz/jlcg/DU4l
         O1hcfsrPGntD0Qb66AATecIOggnT47UNqlA9ENAAGFe0A3XRglQN4kQ4HAuj4wtr62V3
         SrAA==
X-Forwarded-Encrypted: i=1; AJvYcCXsWPhZ5yukIJsXux9K/dlgAKa7HQKboLxWaQgjX9P8wQVk0WVg11nnfPZsvMr/QHljIVcC2DRTQC1O@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXlY0+8PLe5qDL068eMbtr2MjG1fUsxMNfadCraOpXJyPE9Am
	TYxPra8d/IxuZBlmGh5K4aLUO2NbUFBllAVJv6umfyGsR6Y/lj7RyL/nzUuUXpnMxwOnXWJ+SXz
	jdGWzURxwW5kMUi/eniFv72QKKm8UOkrGwqMBMM3+XuksE1zDc1CP5JXpGG09lXup
X-Gm-Gg: ATEYQzxxhiCg6Br7RXWXdeujSArAgR2rHcYIJLDotX159QYaqQ0EcXC1xK8iIzE7m/P
	yPCTfRW8afO4xVV192WsrtjxDA1klDK6YRa6AEgvl2NnM8+dZXJ9YEwRE1Lq9Gs37FvMU33U/IW
	Fw2PkJAtAEe0sWxQHOVOs2cMtXQV+JwqoPYn+TiVzWqqtYGuzlBjhGhEOD2yfvMBzuORq2ot4Em
	gJ55L+Z6MjuOFD2+YmpFF1kWDXJp8LqMsHj+lQjF12jPH2L5nBZuLcaI0ctwrNLLlnfRHRXC3bU
	l0NlL+ZBQrPLSeJl5duzLIvz41Jin46YRdYybsPvm2tNp8nK/8fPoR5BbRFskzFQA0WOXeuBFX0
	upbKficWk3KMK+p60fSlMOvQLDA2eF2fBiKuBDHsVQZWxUqhv12su
X-Received: by 2002:a05:622a:e:b0:50b:893f:7d89 with SMTP id d75a77b69052e-50d4fcf5467mr29566641cf.36.1775139320184;
        Thu, 02 Apr 2026 07:15:20 -0700 (PDT)
X-Received: by 2002:a05:622a:e:b0:50b:893f:7d89 with SMTP id d75a77b69052e-50d4fcf5467mr29564051cf.36.1775139318611;
        Thu, 02 Apr 2026 07:15:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:15:02 +0200
Subject: [PATCH v5 1/4] kernel: ksysfs: initialize kernel_kobj earlier
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-nokia770-gpio-swnodes-v5-1-d730db3dd299@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=biv+GH+fROKOSl4fjZqd21aT3c4FLHEhSXzFKMuT8pQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnu7om+n7+rbJOz3z08q9B8Y3FEV7dYeTCln
 OZLROiB7lWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac557gAKCRAFnS7L/zaE
 w+WKEACdYAfS2DGORcLixPHvLig3V48ch0qzhA4/SOrOeb8/L90oRYwHpVF3FIN8XJzcj+sXrqR
 mlvTnt8vY4kXOYEKWN8M9ozIXntN3nD5cBV970wYhYxNEddy/g6xcFc2D7MLu/vKNsU18jaLRG2
 uUqYfq1288iNrwpEa20YD8fdUsTj68e4RHXkBiG1F0WsNOEx4fJJGeAbiQkB26B09EfDCSkvZxx
 ItkmsL/OjanSVB+1Wad3WZWFE5g8Dwx6PbqCZXp8oja4Xrpo7opxeKIF1dr5YFMwKvCjlZR9TvQ
 332efEH7bJT0Tov0H/xOSgTKMOezKuVG+EN+cODZ+CsZrOSyCtMYBENElpyfAf9vV8SB60tGFGa
 BpJ2VG/WASYT54LNTh+sopX5OYCnYlCEDRZFIlatE6Y4WgPGovNHUKI8I0R2e+RUME1wSggR6p/
 HTLsIgc8Fq1kTvZL3ep+ygvuwb7eV0fBtv2KR0Hsb4gTnePyZSnwVeFxfCR4Zi2HIWAE1OZKOBP
 mkH6cVwt35lSDpumJverYjHAkR7wJRlqMZemeZDsWnjW8+NU3920MVWAUGAJ0MbCHUAqTVuYIL9
 GLLpdx7e48FFJh6X8e8ShyK6edBvSrsYGdzeN/5jZcUgZ+LBlWFgWWQN0SDMd1lC0xe6hL+gyz5
 LMEtq/0VCF+he0g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOSBTYWx0ZWRfX0yyJLpptT8+G
 AbPuy8gB229xJRWkBXv8nMYDBUOC74d8bfvKBuNupTtfgySXtZWR1wzxmqzrA5HepFUN/hmLaqd
 8PU0CfENe1K92Qi7rZ9bh/Gud0/U2cxJ56kM+ZVqgjaTp4ZbnbVFXgS5pc7MfrLNfuV5ThaTKtt
 1xKPQ7lBElXLgzaBo5jj02OwV11B955gydpN92gf87kWxeZOrnWfe9GzHjoxnUWPLhypOszhoFa
 yNbKU/xm18+QMic+MNu+fjjMO/URg9sK/dnDbINbh4B6d4qu23gl9P+nOnQ26NmOaoHocBkxtYS
 +UhdMcn8ZRCK2NHfHVgusFsKvBU6blJ3ENDAQ2qcL3ESW+/moiPMA1QMg79dBvEsh03qBNCY4Cp
 U5Y/w9U4OGvMtSFho57iuFa7D+KXhzjLXcJXIKhsnrpnu3XylU5XDNaTph99Btf08Kvi9NRzD3U
 o3I22rmtIQBHRI1oiIA==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce79f9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=cUGsBi5UaGteNmT5bNcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: qgvpwkAL-5_dudjAfpUksChLTga4hGGg
X-Proofpoint-ORIG-GUID: qgvpwkAL-5_dudjAfpUksChLTga4hGGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020129

Software nodes depend on kernel_kobj which is initialized pretty late
into the boot process - as a core_initcall(). Ahead of moving the
software node initialization to driver_init() we must first make
kernel_kobj available before it.

Make ksysfs_init() visible in a new header - ksysfs.h - and call it in
do_basic_setup() right before driver_init().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS            | 1 +
 include/linux/ksysfs.h | 8 ++++++++
 init/main.c            | 2 ++
 kernel/ksysfs.c        | 9 ++++-----
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f258aeeacba184d2025b932d90280cf2aabf4b0..8bc934162e712cf8ddf033e53bf3481054cfb7fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7843,6 +7843,7 @@ F:	include/linux/debugfs.h
 F:	include/linux/device.h
 F:	include/linux/fwnode.h
 F:	include/linux/kobj*
+F:	include/linux/ksysfs.h
 F:	include/linux/property.h
 F:	include/linux/sysfs.h
 F:	lib/kobj*
diff --git a/include/linux/ksysfs.h b/include/linux/ksysfs.h
new file mode 100644
index 0000000000000000000000000000000000000000..c7dc6e18f28e8a12a66d64ffffb13749d424a881
--- /dev/null
+++ b/include/linux/ksysfs.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KSYSFS_H_
+#define _KSYSFS_H_
+
+void ksysfs_init(void);
+
+#endif /* _KSYSFS_H_ */
diff --git a/init/main.c b/init/main.c
index 8b7633b7ab720b9c13a231d64291d35d3852602c..96f93bb06c49013bae8d3d6b7afca13d6277a868 100644
--- a/init/main.c
+++ b/init/main.c
@@ -36,6 +36,7 @@
 #include <linux/kmod.h>
 #include <linux/kprobes.h>
 #include <linux/kmsan.h>
+#include <linux/ksysfs.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
@@ -1482,6 +1483,7 @@ static void __init do_initcalls(void)
 static void __init do_basic_setup(void)
 {
 	cpuset_init_smp();
+	ksysfs_init();
 	driver_init();
 	init_irq_proc();
 	do_ctors();
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index a9e6354d9e2579317d3b1bcb54223432d3ce0950..f45ade718054af4eb72fba88dab10c86287986ee 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -8,6 +8,7 @@
 
 #include <asm/byteorder.h>
 #include <linux/kobject.h>
+#include <linux/ksysfs.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/export.h>
@@ -213,7 +214,7 @@ static const struct attribute_group kernel_attr_group = {
 	.attrs = kernel_attrs,
 };
 
-static int __init ksysfs_init(void)
+void __init ksysfs_init(void)
 {
 	int error;
 
@@ -234,14 +235,12 @@ static int __init ksysfs_init(void)
 			goto group_exit;
 	}
 
-	return 0;
+	return;
 
 group_exit:
 	sysfs_remove_group(kernel_kobj, &kernel_attr_group);
 kset_exit:
 	kobject_put(kernel_kobj);
 exit:
-	return error;
+	pr_err("failed to initialize the kernel kobject: %d\n", error);
 }
-
-core_initcall(ksysfs_init);

-- 
2.47.3

