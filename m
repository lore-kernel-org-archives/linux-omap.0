Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A393E3C5E
	for <linux-omap@vger.kernel.org>; Thu,  2 Apr 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139323; cv=none; b=U7apdy360LlgomnfMSKxE5XFz6Yoktie/eXaaLRqlaAZVvvORAuhNZ9TR6/Pxb4JuXzOoVljbeUFf+7586fOcti/fCbZO44vKt5nr4lVBFzn6HJ5eB7Q/X2uz4kVBYqt2ir7OhSZ3Pw2wkdxvZ+aq24Zk3bhI0fKZYpFdj5xu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139323; c=relaxed/simple;
	bh=9xHP9YGJtqo9V/BvuF1Xk3Wt1TALDLTxAhAxwgZviEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tAgyXTunHAVRefeLMlypE3lF8ba96gKZoYC+KulrvnPVRPFDPPA9PyskwXAd3s8SYOPyEQRaHqN0xdvUQmtxVkSHl+QDmVKwQ2wg4xqpgT6HCiFlZd0d5FoHe6k+8lNbwCZH6wyVuMyuIu/k38NnPvKT0QF3TtT4jCmxpclJmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMfUXqfE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EoNY9yLb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMfUXqfE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EoNY9yLb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632DDtrX1128506
	for <linux-omap@vger.kernel.org>; Thu, 2 Apr 2026 14:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I0iEYnM6TxpFjlb6DDopS2
	eLno0oaG8tAIZJH9RCSIc=; b=VMfUXqfEvL1i05v9ML1s09gEgzAP8RxxtyO0GR
	PbaWK6ex2ZXp4fX9pnyChWWI5ch0d3wSZb7Sg4H8+D9yUJ1dD4iv2HZJVKOyiyvR
	dWbzTl35sh18TTuk9fhAl3F88y7Q6ZDomkjzYPiLjMLwgC0afQoPeQ2wCU30ysBz
	BHa6PLsM/2mlEpORmwLwQCtX43DYgaT4OEUbyhVXFh70asqmwERtsSnw97QUGv2a
	+o8G+GZrcQZzgUDZG7oABwbqQU+8LzwG+dHeOq5TciIXJTNyN9qy4lGSBcZi7SHG
	J2+V8SIDyGQehrSL9uKLW9uevE+ocum0dLc02mderrSyyZrg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96k9cg37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 14:15:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b31cff27fso7386801cf.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Apr 2026 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775139320; x=1775744120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0iEYnM6TxpFjlb6DDopS2eLno0oaG8tAIZJH9RCSIc=;
        b=EoNY9yLbDkP979NxoSZwivU+pNZ/dnf4MoaVJCDskcbgmhg4FW3c5oa8qCJlAyjRoY
         vj3jJle34xPeiWmJTw58v6UrsEW2bRd9RHTZRUalHX1XefnoMedPfKBgf03MBsnSzVEL
         8uPX0wVkKfBHFnx2nVlpHTgtbQhxSHBLxOiiY/4zwJQc0Z6t9q2ogikdXTTSYIuft8/W
         SpqrJCsG3g0daCpovKG8GMSv3BwaVZjC3jUPsUEElW8VvPzY8WKbOY1KEpi6MU0fytY9
         Mr0OfOqeaKQArL2d3adjrvYgUgnlS8kg2xvnaTe15FxfsMhrWxEItNNZRvZipD3m5wgc
         tzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139320; x=1775744120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0iEYnM6TxpFjlb6DDopS2eLno0oaG8tAIZJH9RCSIc=;
        b=cA+PfNcYb4Z6KgLAMGrve3OFvTPxMKVktta9QyOS1cceFr091kLhs94QFDMNXRwKCQ
         UkEz+OSH7o65dlSVoZF6PFEcF5G5TsUgE8br7nxp6l3VZMonIOw1VLf853PQtv3iJ/oq
         dO/OwQoecuuDRbJvG5mohHqn2ag4EpNvRatwi/Ij6CzHE1xMrAROGd0Qy+uwFFROtWV+
         YV091B6r/cPOsUSSKurudNIwMpPmhJA8dlyQvgx8asw45kNdNM8VK5CDv4OgzMpZ+yKh
         ba1V/+vV+MK4ajHHV6HLIHA3/dpxSexMxwWJZiRgn5JxDFh7nh5OxFai5OqD6yDTLllW
         UiGg==
X-Forwarded-Encrypted: i=1; AJvYcCVjIckb1wM42mqhzyCCVk6qsNFK4DLQAyTLEO2DD/uPwM+xlFi5rWE+Frr2aMPSkmgd2kW3IP9C983/@vger.kernel.org
X-Gm-Message-State: AOJu0YygcSE+ab8zAtezFotjacbRQYGqZABs+dYRtw2w7o2UAAKNUyCF
	5gfNRJ6afq77bEwVLiRa6yQLg7s0ASjhxO1+Jf9/8nskkYciIg5XdpoW+67bPocexN98meLwJfl
	EfUXKFaCFqmN5WF16irnb3Y7jjUTn2VpwsdQXGruaTr8Cz4U5N6Lpm4XaqXbAbyEQ
X-Gm-Gg: ATEYQzwy4mROJjJm0xFCDQfvY9B0Ca5dMlunXCdIscJHZhOoGUMyTNLFGTizzVu/9jq
	YyKkoei4czq1lJ3tECCmRYlndAk0CpWeaYyMRRjrc3hipo77m+6IbjOEwZ+RjsfUexBIcjcgl5W
	3UXSsMl6rn0EucavKx5R3sKRepJsVysYe9th+8wDhjoN6/0P6mdqVcf8Z9DtlV55qIkNiOJDcP2
	ZsetxE5dumAsueiNMxpLG3x5bvLjyctA+H/4ZxouNZ95tQEAhiGKVD7X8MUqo7I6d/kBStGcZQw
	vGzCVbde4AJgJGxGLJaBE9VmdAjwb1oHq8WH5ZCJyzYnW00ruqrs16Nn1nuoILS9kaOp2wo6B2D
	kBHEJfrFd5+aQLhYb0MqDiLDph4XMwtZvlbj3M52J4Uv/lLdDsXEn
X-Received: by 2002:ac8:5a91:0:b0:50b:5056:fcc4 with SMTP id d75a77b69052e-50d3bb92f71mr104572671cf.4.1775139319273;
        Thu, 02 Apr 2026 07:15:19 -0700 (PDT)
X-Received: by 2002:ac8:5a91:0:b0:50b:5056:fcc4 with SMTP id d75a77b69052e-50d3bb92f71mr104568721cf.4.1775139316950;
        Thu, 02 Apr 2026 07:15:16 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm192824885e9.1.2026.04.02.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:15:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 0/4] ARM: omap1: use real firmware node lookup for GPIOs
 on Nokia 770
Date: Thu, 02 Apr 2026 16:15:01 +0200
Message-Id: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOV5zmkC/4WNQQ6CMBBFr0K6dkhDKQVX3sOwKHSEidJiR1FDu
 LuVC7j5yfvJf38VjJGQxTFbRcSFmIJPoA+Z6EfrBwRyiUUhi0oqJcGHK1ljJAwzBeCXDw4ZtLN
 1Z5VuygpF2s4RL/Tevec28Uj8CPGz3yzlr/1nXEqQ0FW1bgpsjHHyFJjz+9Pe+jBNeQrRbtv2B
 eDGddLBAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9xHP9YGJtqo9V/BvuF1Xk3Wt1TALDLTxAhAxwgZviEQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpznnpgbWuE8PB92kyk7oxM0EhrfC9uGBqdWjbK
 5/AVS9z4L6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac556QAKCRAFnS7L/zaE
 wxWDEACXpxQ47yMXyNOUQwCxOnke7iYT5ZQOnqkVVZvzIPH/rpFUqujwJTR6i77GBhHklwMd76n
 nz0VXCWCxBstpkby2i801FON5C1se1aityaTE0UexGxIDX6a7UlDqNJfpwgkyWNdGXm/bhOawr5
 Gt5aQZHe9u0bHKJf6Ocv5YdO/ATOtNygibon8PvTR43Bu1iynN3LWQH2I29xPtQfSTPf5eYtzef
 4CtWkr1jd8ZqLnth3r4J1T68um/z3XHqjl59apZ4/gdQh9EXsx1pJTYwrwdIt5RZ4l5ezVnpDWa
 Wrg4S3WMXyWmKmJP+XPoZkzKIcSImHJqA1Qm5Q4Tq2Do0G46aRg8WPiSIOsqjX7WByQ/gBEqMDN
 WKvH8saFlplZ05ZJ7TVQKwRxBKHMhRzq0QdullzLHCnEJ3tT85P7P4Du9Zl8TKbWZWmKiXny1qw
 a7p1JALeRLwCRDbgDVY+ZPhblU3YF5s7AmgkX5UOxZMhvOxZSwyPtvneHGZs66I5Q0S3qS9tH7R
 aT/AcxEeqJZHS96PIYfpFFkFYl0yb9WrxZh5E2tu3Cl1AqPJ04bO4UVKuHbtXm+LvMgp5Dy09jm
 PlR1ufRVBI7A7QanvZfKMEz6Y+EcB88mzBac88+prWUsCZT7PpV00MHuHH/11UE3KZURkZDNdF9
 6tH4XwQ8V4izhbw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=doLWylg4 c=1 sm=1 tr=0 ts=69ce79f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=WeWpliTHXVVyQaQyHOwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: SM8xOo20G9dDmLmf_uQYFzFcLTe6bJ4d
X-Proofpoint-GUID: SM8xOo20G9dDmLmf_uQYFzFcLTe6bJ4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEyOCBTYWx0ZWRfX1VxN/WP9ToNf
 mvcmVmfpdHRnWxEZ+Qpcmh+2zhLTIZ/Jk1YP5L4TBKaMbNpGtTsQX9IlMQAY3Nte2Cr2zPaBQse
 o5jfRQciXnDLnCbGpiSRG70H1b2sjnSn6ismdYA1UmaChTCbg4wONGshh29Z0vCVMFWdMhgkpd0
 76Vxnwu3+rp598fJwDgraq1T6FlecF/AacDBmu3/CZlLOAgXJ4n8d8JHRWtZU1KzcniW6swX4Fa
 xj4VgQKdnEJ48fIKFTfuV/Wy07R8PiNOu/BtB4YTHUYzzTGVecTnxLdfrXRB1IKChdSAd3C4PsN
 4/e5/VOV4Juwi5R8XVO4eEGLff+5XgOWzgBrYfOgB98q0LCRBqvlBe+xCAZMQG6YOEjxd5zp6If
 dl14a6ODYS898UiRZFjs/vgSp714ZPx232oXIJmP80STz30+5Qw0ZgurhKY3obZNdGc1cLV1mqV
 oHKYfmU+Nc2V5yZs7iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020128

Mergin strategy: It would be awesome if patches 1-3 could make v7.1
through the driver core tree after which the final patch could go
through ARM-SoC separately in v7.2.

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
Changes in v5:
- Put ksysfs_init() in a separate new header
- Remove software_node_exit() in a separate patch
- Link to v4: https://patch.msgid.link/20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com

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
Bartosz Golaszewski (4):
      kernel: ksysfs: initialize kernel_kobj earlier
      software node: remove software_node_exit()
      driver core: make software nodes available earlier
      ARM: omap1: enable real software node lookup of GPIOs on Nokia 770

 MAINTAINERS                          |  1 +
 arch/arm/mach-omap1/board-nokia770.c | 30 +++++-------------------------
 arch/arm/mach-omap1/common.h         |  3 +++
 arch/arm/mach-omap1/gpio16xx.c       | 28 +++++++++++++++++++++++++++-
 drivers/base/base.h                  |  1 +
 drivers/base/init.c                  |  1 +
 drivers/base/swnode.c                | 13 ++-----------
 include/linux/ksysfs.h               |  8 ++++++++
 init/main.c                          |  2 ++
 kernel/ksysfs.c                      |  9 ++++-----
 10 files changed, 54 insertions(+), 42 deletions(-)
---
base-commit: bd0f139e5fc11182777b81cefc3893ea508544ec
change-id: 20260330-nokia770-gpio-swnodes-5da8ba35946e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

