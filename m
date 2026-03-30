Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC43C9EE9
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874466; cv=none; b=HdwzD4okB3aUqLXcTk497YSjejntgmLGQEWB+Wtkgl3wo5lU6uap35855sg5kPnIYMB2THvQCZITR2mNO7o8JQISb8flsAJ9jNyV2DYHmPYGbSmLSsngnI9cJkje+lc40HrwW8UIBsLc4lQDFetYRjPP426BMWyh+h8U3AdUQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874466; c=relaxed/simple;
	bh=P5PymIvljl6p0WRzyDTMcM9zlkuK6HlOeCPW5+0Lkaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx9JcRKsLmGNhgARBa/li3W0uuOgBzJNFX6M+azj2itam9ffDzHnoMqAhzntUKbIquBDGY6R1696gtJvvTbAredl0sAGtG1pLNLbF1WXwESKvrTgkTcKEorzcHQjxSdFKKnLCS+JSO0P4zj+S+LzNbuvJkEE0RdtNN7PYzTkj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3xyZIR7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FStVzr3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3xyZIR7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FStVzr3D"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UApm5b2723192
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e448+MMxh+/7H+vtw0PBLnj/+MwlVFLeTPvEog6+haY=; b=J3xyZIR7IZGl1n2j
	KOon/2PvGrQXPrvW0hr7FhOl4Pk6qmFlI7jHpbLVmZccARTygxT9T/9pwOF09tjt
	kWQ2SHkqSbaSzhpMI/UylI8Er2gmRjuPYScIfqWx7wtg7HldWZOwP7IP9esC5n6v
	CNSQXzLKqK57ymwWjTMKH467dBmq1ARTLWRI8Lub0tXj3PRL/opFRWjW0TvFeERV
	Jf7KbpSN50eVNqGRRovSTru+ItpJA64ZsexmxpmAw4bOTSxoBMm9ihPdXTT3rekn
	60Om1QqTMOXp6xRPIptJFSQNaBhbNjAPtfNUveg7uBen9f3zYbrERQLGER4ZXP+9
	YRfhRA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7qt0ge02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cdb995a1bfso1232749885a.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774874462; x=1775479262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e448+MMxh+/7H+vtw0PBLnj/+MwlVFLeTPvEog6+haY=;
        b=FStVzr3Dp5azZmKbDNe25uz0njKMgN4uoIPk6T+mrD6lxiuFUrsVERvup2yjFS+yZL
         CCpOXuYy2QhLc2bYVJbVOFTGSqHHQX325klLs5rNTv6vAjka6/goYw7dtwoppURmGxUy
         W7chFlG+bvgsMu+hjtY97OzET/WFZzQibGpCqY1UcDCz/52KpDD0P848LEJHjngfmsiK
         QmZ6w3sHeCFZEb94zFEyy36r3+TtmHynn6CimoRRifEYT4yh05JbHUIkxc0c9us6dvWE
         I3Eercdizy2jtYPPRTaEXkcBQlRdg7YZUoh71jG33Pn4rwVb0zwoWv0OToP0g0JDNqMU
         tO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874462; x=1775479262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e448+MMxh+/7H+vtw0PBLnj/+MwlVFLeTPvEog6+haY=;
        b=UkUbBc+2x8xEizzyssVxgiJHczrjhIXSfCOZDIHytPNBZMQYnFk45D7YOrNuydBfiQ
         df6QvxrPT9XoIW+YVgPdzdZk/T3ztTePc/nngFQEunFZ3OVgOBfBezxiuNmTOj6vxeR/
         KPbRjOn2bdI87glegDAs2vKhQ9QgdoVIKU7MNdEocH0rB+0vJY7ZGf7ODB/Ra5v4FP6q
         gnM+pVwDnoY8k0RY4He7fWvCu/RuIr306BAWisykW1d0F5LA7f38AwfHQzjgQ7JPRSuY
         0ygqsFz1z/W+qPm1UzhiwhuYoII35rM8u3ZXWTmM/V/E++BQOh4ZJLY4ECt7UOCHARM/
         UoMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzHHn+4Z4cGydtuS/Wxckeu/pDVX2EbJALm6CI2AlY5T8iayOlHlhKSIaJMfaRuYqDqs3DBurQQWTv@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsoH3lTQ+mNjkekp7bMuHrBwDjTerbh2OGnJWhJUr+BsK77jg
	vgoRG3kp2gNVOf15he3UQ27KiyykTohQbxVGG80s6oaY7xXnesulmpRPkOmuuKp3f6JGAlHulXX
	giCAhxCi5ZxmjGdR2CE7R4mcZPU9NxTZgvmuHkB+IT8grVCja5SIbc8i5S4qav7Rp
X-Gm-Gg: ATEYQzzJxzrYiitvP71T9kHQCtqYnjwTzPS/JMR06RsxQYF8/TXfvW47vF/93I+ERos
	45jdfRiT7W9J7S8zVMlenUo6v/8GRFx0g/Z++HcX3eOjAZd9gMbhxhebFgJxBWY3S8PtvMAHbwU
	Egtxp51C/5vTBDYp4nZJHJsNa8RcNtYE0mJaZ3C7eeSOraZgqOdb8/hDZhTjcSQDwBdl306twUr
	nMkvRUD3KrPw2T5svSr4EOhPYbvVj65JD9J52wjq7Oai3SRbL7Hx0TXtPOEBUiDKu7yZaYE69Hv
	DSsd+bcWxzZ2peQACNIpjrJ+rFk6B+ssarSroHMBIOaQ4sT7Av3rBN4EHkYaMFa78Jw/VDAnHDQ
	5uUD435MrrnPUm+MPQ91dyv/sdo/f1riCpnmk6okLWH9oYHr0r7+T
X-Received: by 2002:a05:620a:4cd:b0:8d0:3c58:c7c5 with SMTP id af79cd13be357-8d03c58cb7cmr224183185a.58.1774874461816;
        Mon, 30 Mar 2026 05:41:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4cd:b0:8d0:3c58:c7c5 with SMTP id af79cd13be357-8d03c58cb7cmr224178385a.58.1774874461364;
        Mon, 30 Mar 2026 05:41:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:e931:8d81:9955:76ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm19576153f8f.30.2026.03.30.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:41:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 14:40:46 +0200
Subject: [PATCH v4 1/3] kernel: ksysfs: initialize kernel_kobj earlier
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-nokia770-gpio-swnodes-v4-1-b68592e977d0@oss.qualcomm.com>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
In-Reply-To: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=P5PymIvljl6p0WRzyDTMcM9zlkuK6HlOeCPW5+0Lkaw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpym9VDPYcvUDtQcRRyLXiSGwTCL5TtoBoMitI9
 5KEwtMyxMWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacpvVQAKCRAFnS7L/zaE
 w12lEACc3qlLfd7n/bdgg8wuL8w0hRu8DG0YSa1pHDI7Gz/2qDM8CkzS7RgvlWa2k9XnRqaQpvb
 qYlWakeZWTehD7eXQEl+Bm6pA/ZLje+dyUXLIEbTbQMiGmcJUb4X4rABtrFmCu9hx982XFNiojI
 WjdfnBWqz1ESmg7UbHCJrQqTgNEsUFD3Nr65/Fmx+RxuOCJUn/vf3fyo30+G1Sw2NX5bnXnceZR
 Zm4+KUApxI0R10dWCzZ1fEmzrGi0Et1gE3FDqN3ahC1BJ5PP4GPQqCaCRTQ1uj1Te0ApXEmK39J
 AW6qSVVVOXY+6Nj1ISo6gqwoDTgT6AsATzX6WskIW0Oqh5g/U/vX90qEyvAYOjPTy1vl77R6bXD
 6utqFHsR1vZKI7e1UEfRORFVSijqHaWoTM1DJpqtUOAhrJbrHRODBNPbarb5XIPH9oQHzS6Iwae
 i2ral9+gCb+6p2fCD2UTRMADtSpIiUx8V4dyFUVCsfAklTBjxMpgA4k98LE37uXj8ntc0WoMadP
 Bcbbp4Z8FP99OrFMBssRy10jzs8sptHkzebdUIynsjjAa5dyjq1ofMN/Sqb2947QSPJ5nyt9oZX
 pAHLUktXKQ4yg+wkDsLCKFJAUV0SZVPh0hc0tcttlTqMW8GkyC9bmRr1oF2WS8G4VH08z5VmBjC
 gMl+KvVfyvagquQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XN09iAhE c=1 sm=1 tr=0 ts=69ca6f5e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=cUGsBi5UaGteNmT5bNcA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: P0b5bRaI6MSJSI6OxOjwDp1Oeq6tRufB
X-Proofpoint-ORIG-GUID: P0b5bRaI6MSJSI6OxOjwDp1Oeq6tRufB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5OSBTYWx0ZWRfXz+J4ez3pqfHi
 0yTI84GLEDcMg7BmOsZYHusmr22KNrIft/lre8k2Tk8l/rguz0THFs6AUJdCVnej+tvO2jF1aD2
 8hESDC3XnI/SMmcJknhbbzVekFke6rR6OpXT1bpRyH5ZTgfUM5HEnQd8UWYfMN2BW5SuwxoM6Id
 ezXMwhakdUgLV+YXzP/b9HiQ3Dbf1jQ9xpfqaCKaNU/YmkBtPETCYb9+XVMtrzOCQk9RSjSyBz2
 yDhjEjvicdaLXduGW/LH/zjvO0ioR0dRl3qS/V/+DLOgZf7/Vs6Oxmwfw5WDcVTrDIrwVaJkHms
 9rP59XtUTt40NCFuIvQw+9ubs0UWmu2AD2/plXkbquKDY3HEMDSiMeEWYwloqEz7D3ti7GM8WEA
 aowsIxVqWp4+0CyD92hsk1FcFdGtKP2aLsSsRrpg6/O6aeNKFj18cSGpcvadI+XXefiusLlgKdX
 DTnXvxaBSBQeUK4brrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300099

Software nodes depend on kernel_kobj which is initialized pretty late
into the boot process - as a core_initcall(). Ahead of moving the
software node initialization to driver_init() we must first make
kernel_kobj available before it.

Make ksysfs_init() visible in the kobject.h header and call it in
do_basic_setup() right before driver_init().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/kobject.h | 2 ++
 init/main.c             | 1 +
 kernel/ksysfs.c         | 8 +++-----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c8219505a79f98bc370e52997efc8af51833cfda..71b9086621c35b7e4ef99b9d3b6707db23faf58c 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -219,4 +219,6 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count);
 __printf(2, 3)
 int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...);
 
+void ksysfs_init(void);
+
 #endif /* _KOBJECT_H_ */
diff --git a/init/main.c b/init/main.c
index 8b7633b7ab720b9c13a231d64291d35d3852602c..1a9046b563e469057cca72ce39a0701c9c4d49e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1482,6 +1482,7 @@ static void __init do_initcalls(void)
 static void __init do_basic_setup(void)
 {
 	cpuset_init_smp();
+	ksysfs_init();
 	driver_init();
 	init_irq_proc();
 	do_ctors();
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index a9e6354d9e2579317d3b1bcb54223432d3ce0950..ac546562a6a1202a752de2d36719c6a193520a79 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -213,7 +213,7 @@ static const struct attribute_group kernel_attr_group = {
 	.attrs = kernel_attrs,
 };
 
-static int __init ksysfs_init(void)
+void __init ksysfs_init(void)
 {
 	int error;
 
@@ -234,14 +234,12 @@ static int __init ksysfs_init(void)
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

