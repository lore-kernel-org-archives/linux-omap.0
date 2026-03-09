Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F53B4E8C
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060179; cv=none; b=E6pVu30tWYfSQlFSJ8oj8bpdZ774Qd1D1t6G+mFzH4HPQt7HJwvwRU24ByCdd0oo33DtvM7CUPRYesbD/mQG2odFfr71NDmoovve2M1XrgcWkxA3MhSrRbQasj8mBlK664A95YS4YsNNhF9t1pNkCOShSk3FiGkzm1lbjpvCRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060179; c=relaxed/simple;
	bh=Xj0gmt0RexpVsqfhALjHcAJE7cfbo9jtVd+NFBum06o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bsfVnPYTpGi+5y27BDUs6xKyk+4bMeAsP2o31qUnQDYl1CsMwdNxZEn6SiV8SuFcwF4GtSSCyKk9FC2psUsuewCMU4qU6WYOQXxzEKQNa4Gm4TEbRMJvNlwrPz06PiY6LoIJq0e4VvFLq0kb5adLI9uzNLm5tSIu8Y7Hc7Wp0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqxw9ISY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdEpLSSm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqxw9ISY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdEpLSSm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298WLuT3774178
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2026 12:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7HBaxrO2k4GTWb2jS1UOro
	FLGj68Wui7NVYAS6ltQjo=; b=lqxw9ISY/iilcf4MLQRNereHLgM3TpoHnFNJp+
	zMCdTJcO0wY9pFjfguyEEnwtK8va3Vsg2ua4IqpzpofAJhUtSYORY7zBiO8LVlzc
	sJqbM0Py3KhePLPFbw5voFB7ISFF0rz/NrPhfkfCmuRTvh4g6UPGQvSVEZYWmGkx
	DfNQmaug/64RokxxpAzH8Q9jMf+tMCDpHkpmLzPZO7ZBsOa0wYKPgOqLVymXBqEn
	mnf1cHjTg1D7iYF57ucmtMD+aGxqqNEVXo6WgGC5gxmM+qdaVQA2QzR2BGY2ftQX
	s5dSt/+W2jjenPz2VhfvDog++ZmtREB540envEBILqbTq1mQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa8uq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 12:42:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7c4ab845so731368285a.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060177; x=1773664977; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HBaxrO2k4GTWb2jS1UOroFLGj68Wui7NVYAS6ltQjo=;
        b=AdEpLSSmTrxcQ9XmJHbg2YVHc35tGH0glW1vcxB66oQEwTUdZNlzFOQpmziUnnf5ej
         mWQ1zHzouCGyNuQ0P/Eq5sRWOEEBqVdtXjOTOs3GjSZ4dxEawbfF88le7BfWInHZp82u
         RKOrXmQgJlDNg+6N1y1tgXYqUKWUemaD4f5sj+JjcMYgy7yI8qABN0A7HUS3b6fYcAer
         iT2flhF7lS3f46NVJcbrK0ljX2o4pUAhrvCvGyNh181k6h5Hb8i1g7hmcGcO+fKXanXd
         x1FdOHieuagRtLDM3llcG9kuu3TOhIUH/ilGwrNdgRdtOzAX1SXznIWz8Y4UbXUlP4St
         B6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060177; x=1773664977;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HBaxrO2k4GTWb2jS1UOroFLGj68Wui7NVYAS6ltQjo=;
        b=mUflQ1CLx+ixWrhmyvJbYf6TI69BQm0H+G7mo4QdLdGLtFe4R0RwEmYYWwdt+JQhIk
         GyVDtPM4U/aMxFAGEer0zGzYkZle2hHSqcuH7oVl1ikj5BxM2V2XBlnwW/98Ni5BSI0p
         fMXOrCwxxbl61hW2rgXBXYq0gEwnxbOdZzxd20R7HTleQrc5dFzBIoxFbQj2Dv6fFpho
         ldPpDcyaWz70IVYetlJAFS9b8bwJp9KJvo+8XYmZ2fYBvNsr8Pxyemc7UsiRmpctCTm6
         9ULeCn50b9Pa6wmbyW6gHXOhF7WX8iaVKMIPtUnOxRjuaihhqLsdbmyDCpS32w8SbhwR
         JPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5cyQ6ji0iQYyDroOGVlFWdTNM3+Ma+j/o/q5X7pWMiC0u77nLx7EeaJWzgwsWv4KPL4sBR8CBqXjm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmu32LtY/ID+ceEBv+Ov15DBZyTLuexqz8KsrWxlJrjRlmsjSw
	3O1DXqbSgPCyPOKHslzTJB5aTeB3X0S6kk6RBcTDQ0yDcycPy7FopqYwmaWcq46MJgmWStKXoDi
	LjSqx9BMoPd4V7vKblzmasMr//35g5wahu8k4TqVH3xRAu1TisJarPT4zig/iTNuW
X-Gm-Gg: ATEYQzzKC6D1e06IPOvbeJbY4OiSp6EWCBAiW9yilYrWnyjVWem1cNqCGxYoCD6xdvv
	x5EaafvuZJtXXy4b/iz09/53NLYotehtqvTCQGncEaXUcbSGbgjs2DyA3ZEuP2AxqGUtu3odo1Y
	7dPwZ+TVVlfvnWmivNBV2hx1sQP6G6VsOCCjf6BpAjdYSrRlLuIINUltaCRZtz/4E1yOHH72BGS
	/Z2JuU2XGze05jW8V10T0c0+733zDvAulkculvqKWeep8Sfm3AlEx3kgZjNxJHVphRT29o954wT
	YqFj7IZBgDHfFH+xfeRvyu/DqHfkZgrtMMr2PNc1hlIGYDHO/0kG4Q5SsOWgJEJEKU2xPjzmIXN
	zoY7e4NaIUl9650oAyJe3HLQ3G5epL68twBa1/tKtB+t5lSxpSCcZ
X-Received: by 2002:a05:620a:4046:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cd6d34ab0dmr1378440485a.18.1773060176743;
        Mon, 09 Mar 2026 05:42:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4046:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cd6d34ab0dmr1378436285a.18.1773060176243;
        Mon, 09 Mar 2026 05:42:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:494a:62d9:d95b:cb98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm107803345e9.8.2026.03.09.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:42:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/6] gpiolib: unify gpio-hog code
Date: Mon, 09 Mar 2026 13:42:36 +0100
Message-Id: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3ArmkC/2WNwQ6CMBBEf4Xs2SVtgRI8+R+GA9ACmwgLraKG9
 N+tePQyyZtk3uzgrSPr4Zzs4OxGnniOoE4JdGMzDxbJRAYllBZK5TgsxDjygP1zZmOxzXVTZLL
 SqsggrhZne3odxmsdeSR/Z/c+Djb5bX+uTBR/rk2iwKo0pel12xpZXtj7dH00t46nKY0BdQjhA
 9K2p1O1AAAA
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
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xj0gmt0RexpVsqfhALjHcAJE7cfbo9jtVd+NFBum06o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBprsBB1aZLZwdS1DQIku31HGfa2MoNhnTpMGzZb
 JLRFop2WcWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaa7AQQAKCRAFnS7L/zaE
 w+UjD/0ccqlsrSqJu19sPl9xke01einnbpk5+JXINWT54AT2zeHBzHoVQRUkJPxP5iQARZVWUHl
 Ci05G7NvTTpYWQMEbHTKW9mhnCb08ULMAoxCtHR8CFDpOI7xtHKpXjPOaynWMqp9iu5Rsf/34Sc
 asB5k1ehZRzwOh1q+4NQMiYnkuosvGPo6xa2gQkUF75C2lRMUNFDnovS80kjYAt7VBVDzsxnaWo
 PnqrSNRzPKs3TajFTDqc7o3h+QBCMJag4D8vTlIUls/+A9LZ9otxftRgd7p4U2iWvMsdKaBKBX1
 kYWNcRQBX4waH/POSwSRgiXF6LvUuX3gyCELFpxCZmoMNTk97mKIRCE7tFjAiU/FgcrZdceNh4N
 M1lUcY8gTFLLfit52BTuJl3cNuca6HaoA2ptkX6vH3UrHoUWWVE0DMVSgakeZMK8JKE7pN7sG0o
 G90n1LhL9vq/DXJrQoWA71yModHPyQbyWOT8IK7MIOfD3qAmGGbFLGkc83Oi0+D5gU4wZufn8xC
 gSQ1TaX9/M4nIYkl5fhrj8NGlo1bjkGzB57FGB0SIOOs/mdt9AGrHG+KBttYziGAwSJa9YIfYuV
 2zzHgpwsCSpCe/eU3lRRm/ZusPTgG8DJNgxZdPcfVRGhgMPakNTVv7N8Hn30of52SzijfW90DEo
 0WuNsgl4p5SjZtw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: BJ8_uA-7hRBPcB9JcYH2f7F6bxcdbBOw
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aec051 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=KhiCW88sooxdVpxl3PQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNiBTYWx0ZWRfX7QffMDj2mmkD
 Rh+1yft5K5WHIZrCkda3HDr6sSfhfXGclHPIi+g6bebjQq+20zD5A9mJZZd6f8Zkl9oH34UuS1/
 1QyX2yGYVYucVQa0f2T+bKWPAl0g5EJphYGVN7MoKGlKwOM9pci1U6GYcAaEQKyjxEp721PQaJC
 lrBbC2q8zkcgTHvj1R2OA6b2q3zyvqDQJWpNkBnf66Nti4ozQNvsZ4ClJbxRO1msh1P/6IpMxRU
 tvgnmWF1Uv67T6NDMRfDfKpQ5Dd3QuXg6snySq3sSSl7uMrasjEQUFYcgFORy0+gyCHEhggzW0Y
 5WdWxfu0AGp1+73dgqguRx5suMmu9eQqUTKNe1+T5ipOm/moinx3mV2pJU5aDEtVdOHbUhiVQnd
 UqZosf6bjrX6PfYKB63nRJpzrhTnZiHWhHo5ragw1bhHujOztjs5hZfI0cUyZHEPvO0s+3Hu+70
 I6vd6GBvHod5c+kFwCg==
X-Proofpoint-ORIG-GUID: BJ8_uA-7hRBPcB9JcYH2f7F6bxcdbBOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090116

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
Changes in v2:
- reduce the leakage of OF APIs into GPIO core by replacing
  of_phandle_args with fwnode_reference_args
- fix return value check in patch 2/6
- shrink code in patch 2/6
- don't allow #gpio-cells to be 0
- extend commit message of patch 6/6 to explain the need for this new
  feature
- Link to v1: https://patch.msgid.link/20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com

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
 drivers/gpio/gpiolib-of.c               | 152 ++++--------------------
 drivers/gpio/gpiolib-of.h               |  10 ++
 drivers/gpio/gpiolib.c                  | 137 +++++++++++++---------
 drivers/gpio/gpiolib.h                  |   3 +
 include/linux/gpio/machine.h            |  33 ------
 9 files changed, 238 insertions(+), 415 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260224-gpio-hog-fwnode-b46a53196253

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

