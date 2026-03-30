Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E273D093F
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874463; cv=none; b=Akh9lpnSxzziDy5febSRSF3lFf4r4ceJOGHr/X2iYMTqeaUiv0gxiU+disnEGkSWPy2VjpSYfJ5nM9MxsL6idu/Xu0MkyijaDx0YHWoQHsP6QVOLNOLuC7TGO+KBT8Nsa9durUMQMp9Lbek3LwIdey5v4bnjf8G4wPlUsIA0m+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874463; c=relaxed/simple;
	bh=ebXxP6oyGThso9D20ueCVw32ARrB2td9WDVDT4mVQlQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1Tq9ReLBG2eAROeuAV/w68RWGSnAEV8wlTEcrlrpyN5Ta8Nnc/D/EW6kjoQvAzeSNi37lKkDnGnQKdvnnAOMMwaTRZITe4V2josJotpsYpTcQqO7g7Opa8vaK2wIvAEtKS0FWsvDpcrBUY9o5jsb33AGpAtgbKyjNp01Gmc5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Opung/CB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmpMwLQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Opung/CB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmpMwLQh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UBZiEA4013777
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m1ZC22yEKqv0I/CPaWdZHN
	u0Gid8fUMzBO/v5Cza4Sg=; b=Opung/CBz/HA4ZQjM+P2dBde1ixiEOI+r+me5E
	Hy/q9anjFRYMLlBqwA5yumdAL2X1hfnAv5nk7j5jTRqm1cZjhNrFvXvOfRq3iLaZ
	F0F2NEEq2sHgVFoxHjy3sUVSFi7fYzlHFXJwmpFvZVpn7mLHG48YDOuUIdNlt+4V
	j8eZeId7VspsS33LfIfwMn/O48kGvKq+c5SnxwGY1yi5bmfS9xt4XmLvZFjdIdhK
	6ZepZTY3k91HdXQgOLahDJGoxhA2tWmL4ih07lE/F7taPjWmUgnWD7e7jYhmhmy7
	fxrqDWRhu6eJzJXu3AxZiYceQQva4IJkzKI5cbxBlcs698Rw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regr8p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 12:41:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093a985e21so92681571cf.3
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774874460; x=1775479260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ZC22yEKqv0I/CPaWdZHNu0Gid8fUMzBO/v5Cza4Sg=;
        b=RmpMwLQh4hQ+xrxr6hPNCm+J5Lwo7hctnLYWnpr8bM3HhpHSVsVD7M4re6d6OPKK4w
         0dE3mlwnqRmQCMyRV+RO/swOoHJR6r4ct0Ey2Ppk/NCOazz+DPU9a6FVUOM0dHF1dUEc
         5OPR9zvc30uorGVILhoFI+vpIv7GQDxTQJQbGmBFGjpANYDNos5liYgNmBWLCuSkD96E
         M4h6b2JEIx3YSPtFPo8d6hEpwPDSBqqY1/QoMGMz06OICLhPFKfFYc30rKu+cKKIwJox
         2EVh/uH9OtxA/lgoj9NKQ2qM+gv9p7nps7SnY0yu0AnlwB2l3KUrP7AOZFKphcYFmmJ4
         BVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774874460; x=1775479260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1ZC22yEKqv0I/CPaWdZHNu0Gid8fUMzBO/v5Cza4Sg=;
        b=ktpoqoIKXu9x7tSOfY3e6e15BL0NIuupfNe17iGBohcSX0ETctoWeLnragcgQjop1x
         eIXQYH13Dt65SL2Bi+Uq0Dqg/Hds4mtGy3Z9A9KmZ2eYi5IgUjAm8TxJYbOCa5tUomN/
         El0/vKVC2QijX3ET0hOERiDI8EtGzii6pbkZWX6cPHiEvAqRZb3nwPqaJboz4FC4Mzcp
         vUWDOhIqcbtDhJhy4brNkJe+dGFAFcoXs/K3nRhgg9XByziRHLKycyW+O5VGHqNFgYeK
         ncHym7MPE7knclJC5RksXPbSnbtxgVlFMvAJ6ClXv4WaDaTFPhs/S/nfs6jPD5bwX/d8
         cZKg==
X-Forwarded-Encrypted: i=1; AJvYcCUvPopm4g158uB8bCmakGnC+48v1Vkbo9QRWp0Q6Dp+84UkI29Zwi6BDfaqBQzA8kVGPprOTZEtaKbi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jjjKd7R9VkyeJUqL4vwmotGVhDNElAvUFex5g8IZKng7GMF0
	4Jx+cfldZXRMtsotIgfWu/j0cEIQ/MI9tZESrzqoP0T5bMoxoyqEW+NmQjSl+j5yXJd654VWNSp
	/g2TkdV3P8EGXl+o4HTHMTwdEBoFZDuT9P1ARUjgHbYtUvyh/Ci7jTmjAtf9Zfd70
X-Gm-Gg: ATEYQzz4TAsmPiCzKidhVVCbikBVoZkJ5tl82lNQihzt6lcFsott4OvnhBJUhG5knOl
	1f1VY9/J2dfbRpPcJ35LurbkB5kdPugkT0GhiNg1uxI1NBVsYftFCH08fReyAcRs/Lp3t3JJl0D
	tY/6yM0F3CuICwsRIy3hlVvB2xIbnpYAR/IoUysLNhC6CEeFxwPQUq6H59pQV8QeRfVwCaYMWZT
	Pi42fNTs0IhtSZnMBVLE8l3BTG1mYkxZZV3+jmbrPOIMhLkShVpN38j+EgI2vU8WEuXrbdOHpkg
	lS/75EkjzbO7IapFbTlPxKvUQILXQP5zRQi86Cab9Z3tSaNQvPsbYs1cxNS7DDWP+vVSb8Ptgr8
	hzIffPpix4zodR7r4YJ4TnmQOcYRn3jnac1gtzTnDKPeIYUVtlKOk
X-Received: by 2002:a05:622a:229d:b0:509:1d4b:f860 with SMTP id d75a77b69052e-50ba397bc8emr179975291cf.58.1774874459624;
        Mon, 30 Mar 2026 05:40:59 -0700 (PDT)
X-Received: by 2002:a05:622a:229d:b0:509:1d4b:f860 with SMTP id d75a77b69052e-50ba397bc8emr179974841cf.58.1774874459199;
        Mon, 30 Mar 2026 05:40:59 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:e931:8d81:9955:76ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf24739easm19576153f8f.30.2026.03.30.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:40:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 0/3] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Mon, 30 Mar 2026 14:40:45 +0200
Message-Id: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1vymkC/x3MTQqAIBBA4avErBuQLPu5SrSwnGoINByoQLp70
 vJbvJdAKDIJDEWCSBcLB59RlwUsu/UbIbtsqFRllNYKfTjYtq3C7eSAcvvgSLBxtputbvraEOT
 2jLTy83/H6X0/ncJbKGcAAAA=
X-Change-ID: 20260330-nokia770-gpio-swnodes-5da8ba35946e
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ebXxP6oyGThso9D20ueCVw32ARrB2td9WDVDT4mVQlQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpym9QIpjWDEaGIC85qzZdl9V6Rcvu5F+r9iru9
 WKPqG41tIGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacpvUAAKCRAFnS7L/zaE
 w2kzD/9NUZiXDzZZSpnZvE7U0Y+j2FXJqL4tLwdObSeStH4IM9mpXwCRyn/c6oGyMD/91QDjPrv
 3DXHCm+kM5GEO5tKMe8LEuZjFE/6n/CuEagUvVTETyucDzV8y9mn6hNvCaLFKCwVWvoTGZR3s2U
 MxEFzkV6egJoA9Zd7G5plqtw1QJHQiAVnmjRj9X8JBwzwJJfrgoJwpxppBG7a/K1l1km1peQRZq
 7RyrC4AS2Cy8uYOOXoqVxD8VfwNE9UC5+ucjUO8sC9Pg/Htq62nkxrtNM31umoP15ttqXLLZqH6
 wxQf8yJpXDhfej5z9KIq/GA38t4XK3lYfga5Cpba6MhKUmPKyebmrL+J7IMuHZwwyXoqmmqEq4z
 iQDw/kik4wEW5u7QOSPYMsN+QMoDLimboGo/esNyyGuikM8eIAmOcSDqOmwfT0+YES8cWzAqyLC
 Ib2ejc/sqHiHKibK/QryIgqjglKpyQ97ashiz6vhHzB4yybu0d+L8IElKavAqTDymIYSvxlJnM+
 iXTd7S24TG/CcztQqKIWbtkbzcRIhiourzV4XFw350GW9vuoqyk64oC37G3/ke+o10XDFxePCdJ
 Z53nn7cIso/rW/Co9BqjlmdawBZ5GFo8Z4zveeJqZYEWgj4bBNvMMZn5KpgWfW3Jxu9JaTmrqt9
 0fLcx3SsNRH9aJA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69ca6f5c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WeWpliTHXVVyQaQyHOwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5OSBTYWx0ZWRfX8QLhEQMS1unJ
 BgwboYUgjtD2ZZdvI345FRCf5jWCSlrv0hOUZi/0vfLK9ZCuWfz/AAS63T71HfTGEfLVxyGF6CH
 eohphA3l+JdSeW4HF5GZb1hwRXaAaKIPLu0dq50hPB+vrjsc3XXkntmj8L7RWUnIkJxVk3PScD5
 qoxErzZIKz7T2O7SOg5cgn6IEQXBKTFgrO7rSFEq4vDpWTk7L5fg+ScZ9vv7T953bp/MkzW2FDA
 tvXZaPq+piJ4lWn9oHA4eLqZ2kK4MaOdAJyW0VzJ0ay1U9CzChb/QigtALq+lgj8lXxOFqTPiNY
 bdo7sjqj4+8EkLA/NP7d6fbQ3XElZTAkYKOKOLqqK3pEj35PosnUcLSRSRksdYLxUe1/2d2LKA2
 x2U9/K4V2z40OZQG53u+ny/Qu3M+qPIiKbz/zmOktdZPBnNXHlhl36nx4spZVMAJZJ9YhGwoCJ+
 honUXyKwjV9WO4b2Mng==
X-Proofpoint-ORIG-GUID: 9aEtfV8_-TClB73qAXsVMxUxgV5Jf5HS
X-Proofpoint-GUID: 9aEtfV8_-TClB73qAXsVMxUxgV5Jf5HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300099

This converts Nokia 770 to using real firmware node lookup for GPIOs by
attaching the software nodes describing GPIO controllers to their target
devices.

As determined by Aaro's testing, both omap16xx_gpio_init() and
software_node_init() run in postcore_initcall() so we need to make
software nodes available earlier hence the new patches in v4.

Please note that while the goal of this series is to allow Nokia 770 to
use software nodes earlier, we're not modifying core kernel code just to
accomodate an old ARM platform - more such conversions are coming up so
the change will be useful to more consumers of the software node API.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v4:
- Add patches making software nodes available earlier
- Remove stray newline
- Link to v3: https://lore.kernel.org/all/20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com/

Changes in v3:
- fix references to the MPU node

Changes in v2:
- fix build with CONFIG_I2C_CBUS_GPIO
- only export the two symbols that are actually required by the nokia
  board file

---
Bartosz Golaszewski (3):
      kernel: ksysfs: initialize kernel_kobj earlier
      driver core: make software nodes available earlier
      ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-------------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 28 +++++++++++++++++++++++++++-
 drivers/base/base.h                  |  1 +
 drivers/base/init.c                  |  1 +
 drivers/base/swnode.c                | 13 ++-----------
 include/linux/kobject.h              |  2 ++
 init/main.c                          |  1 +
 kernel/ksysfs.c                      |  8 +++-----
 9 files changed, 45 insertions(+), 42 deletions(-)
---
base-commit: e80f5dcc54bf5d494b725e2932571488daac33b8
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

