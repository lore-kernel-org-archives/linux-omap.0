Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D1379982
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704311; cv=none; b=J3kduj/4y1xcVH0ksR5PiWSLfZVQew1iT9p6aWWPdCgVgXnqufbdimcPPsR5Kfz3QwZ7DxVdt0bMoCCLGcXf3fHNL84Tmr2Hw8dfKxWFvs32Bgrffa/DmGboszI/QLwdT4GrK1Y/HI2tv4HNwq7k0b976g4G5GsthJgzxUHR+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704311; c=relaxed/simple;
	bh=rQwmOJb4O8I8mlsbHO9IDxXCoYF1W2cwc11R5kOlHIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jwK3+o7GzGDVr2c5WgQ1okeHtEP/t8w+UQv/B2LEMUv9ND/al4uGFYi1GTbDTo5A2DbCRnMJ5DHwX1l3YkP29rTkTgGDWDU3gk9YPF7DNopV2fLfdV52uuPBHa3ZPnFqjGHvQWfa0ekMk62CCyiwpw+HY8l+XUSfsvlSJmZcU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjwycJoz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZpeunA5G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjwycJoz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZpeunA5G"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62596C0x020989
	for <linux-omap@vger.kernel.org>; Thu, 5 Mar 2026 09:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l4dDUc9FKxci0scJ6kHbvI
	vVEUKnC5+r57TdAfo6P2A=; b=IjwycJozHkc4TDTOvjpyY1NZOr1UOQIcuqh7UR
	ozgyF9oYbYgSLELweLxgJ83V6jlkNpW2PDyNXVdNB/Wy7CKR55XEv2n4xINUbVyn
	nz9e32mOVSGSSQeIfZaV+RBzVgWDMiCHoLCEJHPxswmUqMNa/t7tgqaqW7v8/dNR
	Yg+KdNnUN/w3eo3Mwlg/hLt9FKJzl9jWC3O0DUTKrKbynjEW4/drwiLw2iADjrDI
	cd416GVaYbXH8os33v5xXOtZBGt6Ty9LVo+K/hj1v8BCCuZDBS1kgypTrPTi5Rio
	4ORMDo8c3R6R8kluva3E4bhznqiZiZNEOxdGUGQxywIQBn1g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuptj78s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 09:51:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3a2eb984so5481211185a.0
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704308; x=1773309108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4dDUc9FKxci0scJ6kHbvIvVEUKnC5+r57TdAfo6P2A=;
        b=ZpeunA5GjJbNcnowCcdhU3jHbl4n7WvjBmLdXmYAeKg+fI1Ursj+979wM3WmFYOoqJ
         /+uMJxEpG4PMFyIr/U4L3gsQTZmiHe/OQ/bupzT8T0m5EEB0oVAqMGUKBz/AizYDtDl+
         rskG7Y7+WP6W7zOn2cWUsDpRHlxSK2HEql/uGz5gw+3Ow/9bfh5q4T45Ga4z2Yerw1Qr
         A24L0lw/reqM1ky4kx7uzTglIINtCroTAf7nmc8cMQsw28LHIHgzw+QVBOJrYy6wla6B
         Ent320M9M1dDqBe3KBN75s7oA9OlVzx4V1g75QfoBvnUmcs3NHEV0EmhCFyU05nKPnVK
         nJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704308; x=1773309108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4dDUc9FKxci0scJ6kHbvIvVEUKnC5+r57TdAfo6P2A=;
        b=rsjJoiZDAuoxiTFE7Df2g757Kd1cdyehNoQZsHRQokoaoiIpJHSQRiARgdlzBF9XTU
         BUlAyro/LBWWczrE8wo7CgnnSTHO2WRvHh67Xsd2iEkoXcCUOk6j9aRy0Ko2DynYocSE
         AEan7DCWGz9Y2NW2qkDAKbuK3vZMXtO+y2vPk508o13PXz2AB2OC2Exg+XWWbJ8lzKip
         pG29f4orteqs3T/9+WOWUXCIwsbvS6uYo8v3eSY9+Yf2hwjleHFzoxnkBgbSIwXfhalJ
         /usDWcBMqekjk6p9Hls0Z4AY52ffpuPZNaaUYZwaI3H5Bx/WIicS65UYxEDa3fBFdwT7
         JYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7hPbVP8yVUUzmwNpGx48zdI2H+W+btUxs2AjzARVwCgSvF0S+Qrvd2yK6BWwhZ5bDxJF7qZxBrhu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5h1U/bJd6diYAmQovsgaFeKvyfPqe3/HyMY7pg9urXqMkM44G
	H3eB650+BGVviQgqNTIZHFe0iVtK8ARl2+k4HJJyP080RCyB1wcnKpU8GeeaZsSKDq3D93kDvZx
	sESMliX7V9gNOJKM3i5glNriAvZ46QpJYRPShCIAN3qu46gC1Pvy2FkwhilIGEevY
X-Gm-Gg: ATEYQzwrv0JjAG/h6tTpGBzit2v/t6qQrblykHg806boTCgcc94Mt8gUbrKTddfOkuy
	FUPH1P7Lr1s0cmAPBRvdL8H0Uhz+LYiACM5WxxeBeOiszeJkbvYiCigl/nRQq/3jWt1uX8eCss6
	jLxIMQBpyTl0iJnk07F/GtFv2wagUc+eoZJhKMV8SiFf0SUKlPtfTKBxJLs8w0Cq0zTG3WoZq3I
	LVWNX2nlO78PSCi4hTCHie0czwDFbeSevqWtc7r5krckzivELMBVUcCFRnYjPKavKns5/l1fBmz
	e1vQ4z4qarrxttfnBY2UBsReuijErnGaqunq05UEuopH83c9Oge2jKB0i6ElMf2+A6+OuvJoVRK
	z9UUjkHsIltGBg37KucgkNvYl1o1VPpaKIYj7kiQLnagnIh/n73Bg
X-Received: by 2002:a05:620a:25cf:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cd5af7a53fmr647693785a.49.1772704308477;
        Thu, 05 Mar 2026 01:51:48 -0800 (PST)
X-Received: by 2002:a05:620a:25cf:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cd5af7a53fmr647675885a.49.1772704304504;
        Thu, 05 Mar 2026 01:51:44 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/6] gpiolib: unify gpio-hog code
Date: Thu, 05 Mar 2026 10:51:25 +0100
Message-Id: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5SqWkC/x3MTQqAIBBA4avIrBuoMYW6SrToZ9LZaChUIN09a
 fkt3iuQOQlnGFWBxJdkiaGiaxRsfgmOUfZqoJZsS9SjOyWijw6PO8Sdce3tYnQ3WDIaanUmPuT
 5j9P8vh9JWtyHYQAAAA==
X-Change-ID: 20260224-gpio-hog-fwnode-b46a53196253
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=rQwmOJb4O8I8mlsbHO9IDxXCoYF1W2cwc11R5kOlHIw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIkgjKn8wsYQdnDa6vZ12Pc+Y6pTgCNa4C74
 pXtrDKcXs2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSJAAKCRAFnS7L/zaE
 wx1OEACIl6fRdGiMY6XiNPs+wPhYwJCCC7ygnK5SKbf4ZfA4QVw8jZtlPnuxDGPTKGWKzh2ce5u
 jKyxn6s5tTcytgFl+vlLG0t4ZEOgTOFdedlbN26Dlo02avU3BY7FmBTypt6FpiZyuu3dnpn711e
 WgS3NiiasnpGAl8MD5zfxqkij2t78hkzrRc+pXuOP48atyJwOYOKjDvFMU+ZJXWb15l+pmQfj+0
 XZaL/Jkarq2qOuFXiNuhsIsxm7jo03Ts7M8bBnKtcdKr9e0ksbQLT6ethIDmPkfvEVoffAwpewO
 zKl9v4bWIrVtI1cyo9Mq1CbRlff4myd/gVRMrJUm5r+sM+iXds8zKGEqp+8k+kftNcnwYJD7wIP
 1ADDJ9fbvXRo8pSjHTihqBpfSo8Uc7zodC09ywWi+sIWxWRjTUv4yYVVA9BS/GhzJAw+TXmDWMU
 7E+s7qApuBQvA0l8XrzKuU2L8Z8C9+voBZ8B3qhg9+d3qy8aWM7RHiaLJpifmImH6yXYTl6l9I+
 zb5YHUnjLJ/0Xg45FWfXIe7sghEiO7LIbbsbaF7jlFDe0VmtCcaJEwYE1VRU8RXTLZuMIpaYY8w
 rDNN20awgzHH+CM0JhjXqdSoOlq2PL2PMgghzfyE4eCOqVstL6oJEwCVwrnRMs8d2skyU8m/EZX
 1rXdW7DFDhYPaeg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfXwDpH56x5Dif8
 N55ck+jEEGJwde4cskCyfSTS77RlxpENTYjibE8OAD8Gs5hydJLu1CVnNZBt+SkzoCceGqA+Tva
 0EPp7nyTYB0LorI+heKv7/emp6tm36ZHH0pcUjYDaUsGNVoDfm4LH/84rm0Z1wuwrwOjfCduJxf
 j0KOcenAW2AE8w18/c02VQLKMzDSYG8xE+1gziGtSvKiB7179jWZcIiFDcIyx7XqGd5+4P3sEex
 HKWzQPr9ieb3f2mhCZ4t0USNFllKPCWEsW+4JPAgFxmk9gS9nQ1X+xKozsMh+I4YfPUAYpbNi2A
 +d0q80ZH5wyq0qBZD6l3koiRLTHqWG8eQ7QqHFt71PiwpHgV3gDGLmE6+JroxB0uvAKsWKhFzXm
 Dz2fUrUx3XZvlkbhgbsHwyPomwEnGxCyi/RvOhi9ABI+lLGK0MIgvcLuXoHLFfcLrE7ai240uRG
 61MqvTRZFySQ/SC/Pgw==
X-Proofpoint-ORIG-GUID: Xm4cJeYsuTmGwckmOzDFd0zGSngd85T0
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a95235 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=KhiCW88sooxdVpxl3PQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Xm4cJeYsuTmGwckmOzDFd0zGSngd85T0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079

GPIO hogs are handled separately in three places: for OF, ACPI and
machine lookup. In addition hogs cannot be set up using software nodes.
A lot of that code is actually redundant and - except for some special
handling of OF nodes - can be unified in one place.

This series moves hogging into GPIO core and bases it on fwnode API
(with a single helper from OF to translate devicetree properties into
lookup flags), converts the two remaining users of machine hogs to using
software node approach and removes machine hog support entirely. In
addition, there's a patch extending the configurability of gpio-sim now
that it uses software nodes for hogs.

For merging: I think this should go through the GPIO tree with an Ack
from OMAP1 maintainers.

Even with the new feature for gpio-sim, this series still removes twice
the number of lines, it adds.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (6):
      gpio: of: clear OF_POPULATED on hog nodes in remove path
      gpio: move hogs into GPIO core
      gpio: sim: use fwnode-based GPIO hogs
      ARM: omap1: ams-delta: convert GPIO hogs to using firmware nodes
      gpio: remove machine hogs
      gpio: sim: allow to define the active-low setting of a simulated hog

 Documentation/driver-api/gpio/board.rst |  16 ---
 arch/arm/mach-omap1/board-ams-delta.c   |  32 ++++-
 drivers/gpio/gpio-sim.c                 | 200 +++++++++++++++-----------------
 drivers/gpio/gpiolib-acpi-core.c        |  70 -----------
 drivers/gpio/gpiolib-of.c               | 148 +++--------------------
 drivers/gpio/gpiolib-of.h               |   9 ++
 drivers/gpio/gpiolib.c                  | 139 +++++++++++++---------
 drivers/gpio/gpiolib.h                  |   3 +
 include/linux/gpio/machine.h            |  33 ------
 9 files changed, 233 insertions(+), 417 deletions(-)
---
base-commit: c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
change-id: 20260224-gpio-hog-fwnode-b46a53196253

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

