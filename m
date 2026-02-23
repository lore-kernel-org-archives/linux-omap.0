Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72961346FC4
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837601; cv=none; b=msK0JcwgRDjQjsrEQ1g4lhxdvfTthH9JhFJtZ9iKY3c1+ie7QKVITOAYA7W7keKTAG/Q5cVo/CYXUaccu6SWuHAg9yVRBmzFSjzKNRI5K6ZIWpc+3iKM4t9GsQdm4MVBkgigE9GIsrJ6sSEg2V4fEZCJyy5L3vL46TpZ9gm70Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837601; c=relaxed/simple;
	bh=GNCZSO1tofFVimQlfEXcivvHDvpWa5BaBkjqLZZcroE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPkC8GeQB+rkH7rMCCSDbmD526deKQTE42x469KdUOFXJ1tJnPvymXDrzLFRjHBDwEBIKJZf86fXlUDd8FsEgPs9dyon8B1H7MVnlCTXmfBPNvoRM9+C841tLTA//IC53Xwf/Wrimp1UrDZ12vrRZOAHTs7VCAE5CUKfwvT4xkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OF24CyJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hx3xBQtC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OF24CyJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hx3xBQtC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MKGhil2989303
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z1s69ZOUW4W/eG75pyy2jJwkNoebNytXCN87O0Rdgw8=; b=OF24CyJJeT8R58iH
	w8BMKHU7AVuj7IBfWA7+aF1MLDSW1w93K637as1xCBWheutodXGU2WvKF5f3Uf+Q
	J0X2Wtdj/ne6oU5oWhseU6ympGKihcmkjbUPlPBZniAIxSX5qHINcnoIAu5gqDcR
	+VFtM+iWAHeQzI8KjnMsLQUDkHIAqbiEtERrX+NbkHlFg/d53LLloCT7zMfjsmAZ
	DAxnspg460MiCk0GUxIzjL1XptcPRal+l3M7Xb8cHOIHu8bdSM+L1rTwDg8ynmxg
	R23GCEjSa69xofpCD4b7SlwlG9t03+EKAGSbzeUpCyV+cizLsBH5M1sOqhF3Q5qf
	heqZsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wk415j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:06:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4a241582so3867335585a.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837593; x=1772442393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1s69ZOUW4W/eG75pyy2jJwkNoebNytXCN87O0Rdgw8=;
        b=hx3xBQtCEngVyzOj8u8NnFEeYcKcZuEF8FwF0Uk6+b0nOAI0f8d15O02aUrDYf+S7f
         zoScNRjkhgJDfi2H7uqEeZUHcQilJi3CmYZh6Hc5cFLwEG2NbARheY1mLJA4G9tYDPBH
         3YYGnTsswJFIRqomM/OkLty7SDpVjAl4UHhjiND+KPZGMfNhPZNU+g2ll4ZRVlQW9XuB
         Q/AzJ489wKh8jRCcdcqliq4O5zUF9jFFQlF1PmTWKAzGzBmR6FlpNrGkzY9Aq9pr7tuh
         qvW011i2t8saIFChLs1OxBmiEqE7btdUcZ/SYcXNDmjHiAImOPtHYEeFy7AcjBFUM529
         Rw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837593; x=1772442393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z1s69ZOUW4W/eG75pyy2jJwkNoebNytXCN87O0Rdgw8=;
        b=vPU8XWD5XI782tE7szrKLyV8lfSTndL/RThSInHiRPKVZ+fGVVjxVZiQ86PPAdaESE
         ssOGFaDU2sPhGrfG9NppoxCRymB4JKgrhlo9VWwcJ3u9rPwpNtMNPSyW+F2DU3rjprHE
         el76dOUq+HYtDfLFRVhVpJEqW1r2ecAhCXM+GArzrK3pPBvsuuCrxxm/r5xGLUIT1U59
         +J0+e4csDsDTPMiFKakCC1DDAM93mJg1/i0CDByBIbfWyX2RcGmHGkXdyzvFtIusdX6f
         jfK+LtuU2Fd+wwxrSlKXIbmyyk+okjRBOvHKOaCt0US9kf7aHZIAx74o4shx28SRlfXe
         zwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJcJmF8xIt37S+t2vHTzOG0C78d1TSfQCq9DlQLV5tvZWazfTVDt6EEjaYKv91bJJ3eGK00SXpHwFT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27giDESu7QXg2nMqsrJjEVdnHkrN3652vhmlnRghVCPzL9OCX
	tK3nx/ePZ4PZ/E+6vH02yxL6k7a9ZZb/PjJa9s85M8WXm9Kx7p2JdGcWX5Y2V9OIFfmgU0mpmCp
	yMyRSIvOqb0G15I+BRmeMmhv9O39Zou2jPx2rlVgp6S2GtVsGzTJlYb39TmBRUDso
X-Gm-Gg: AZuq6aIljaOiLFzZCm/XaL3bMVcD6GNaKHEf0M8LbCd4mGVIQHgeTktxYYdvGMSo46C
	v+QyFpuIC4U8+6C1QQpBv4ZZ80y0Vzc9GKP+QZ2DA0PROCyx7NNwXJKiOaulVhkiOAYHiAie26M
	quqhafJbZKtxHJHYpJ8UwEDBUkM1ygvebKze3EwNLmxsk8Haac/QQOFWhLZ3HF49jksvidCMtXl
	4zHAJrRfBV2S3B5b7Ly37JhRmrA6Jle8za3EZcVPiPNjEWYaYyvxL9pnsAV1YhKz09B19KXeg2w
	wQJ2FgefO14s/lrr5xO5wCGUkXegcj8fLD9m33fauFSNsUobRuB4+KMrWCZWYshnyfJ6lPvZmo8
	p00q/yxpbKOlXeGpfQZw6NFDIpnR8QDkq8rTi2iGxKtzEiQbbc9nD
X-Received: by 2002:a05:620a:468c:b0:8cb:55d3:2a4 with SMTP id af79cd13be357-8cb8ca08308mr922170485a.35.1771837593230;
        Mon, 23 Feb 2026 01:06:33 -0800 (PST)
X-Received: by 2002:a05:620a:468c:b0:8cb:55d3:2a4 with SMTP id af79cd13be357-8cb8ca08308mr922166085a.35.1771837592722;
        Mon, 23 Feb 2026 01:06:32 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:32 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:57 +0100
Subject: [PATCH v2 11/12] i2c: nomadik: set device parent and of_node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-11-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=984;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GNCZSO1tofFVimQlfEXcivvHDvpWa5BaBkjqLZZcroE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh66xd7+MQZXKYUp1lof2Wde5NsKOrQrt95U
 eR8Ce2ipBuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYegAKCRAFnS7L/zaE
 w04VEACsdT4VCfUT8Out0yUzqZzfml7dMxtbxcoCnGY8tQLapaBzscsfnI+5Bu5NVsBjRWz2YfK
 GKz1PyQVjNRu6C8ehswM/RGsSkjYRUxZSTdjV631sUHy16gbpFobawG+M6magVodquPAsrG2efp
 fw078QxbHLsGtHgQUf3QlBUOhMk22ArZLQ7UVI4eWPuitiP6f64SssRo7tqJ//BaGhTLtlxLgt1
 jvZJM6D+hpoylJBTdwdFh3LNOWlNngiDMmXlJ+TYP7vEyQAHqGifdZcZ2gOjEZvuuGtO/lEw4zo
 SozwKRkeYXSwgcaSyFO1dD01Yswbq2jYdHSqqQ/U6ptyeOxHXTthssXS7L2LPdlo+WWnkUba/Bf
 4oG7Kg6fqOGDNbJAGQFzXbP88fe9GJvo21ZhNEA96KsQPTOoYosm2cONZstWSuGzQHRYlbRNoD0
 o41lI5eyWu16TVPGP0JRYBMjXMYTYSlhuH3hkyYXocF/XU6tyGdnIhI9kAYh5ZTFmS7uDBVKtYs
 9Tyx0EIpX5yv7J38BgWtyTxoLDGrIrU5OAym2Uw4iiru7lO0Rf+h4+zA/T/ASHlw7uHwH0ZBqTF
 evk49M+ClOODknfwmlUK6g5DkzMRRmmnMtP8HudXzwpA2Gyo6WgvZHRgm23knlsypDaTyhOz3PZ
 EC6ZWixHAae92HQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=699c189a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tIHrhau139UvCPJ7cvIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX5ib6jOz/kWcJ
 iMN5/8qWTYP9GGCBQmpCmuY+FnB94JRVNorP28V0xeqJ7Lg1UwyBv/3yQ2hehL0XwQNlWSKW7LM
 eha4nCaLGcQzPHtUhvzZR7HB+LhBYaPbm1AA0mE5ahK7JLjWA7ziIGCiZ0wOUXLpdwPiwqP8R72
 QZG9jI9WYa6ym3vF6MwF2p1DHwJiAYIgzDEkgHEuIbIrq0HS1PA29Ce7YcV4tjMCdZmsI6mM3ku
 f+3qdw0wdUyENF6coNNvz+KaxKpVp7v3ksw+R45XOtkcd5h3Qplq2Ez5jFHKXrkVc/YSTx8vfGA
 4o79SlpLI4Gu8qRNsdSHRp5sHnBNeUmbwwvma2LCYIgVK3SfPmGFR6noIW6w/fsqH5u/iVvfUbY
 +IawR47bxr79yOHDvW8vDSewYCE95vv4C6/jg6+Phwx10Q75VPCiIJ5OgjaaeDncshLZAcnczD8
 q7Fd8jmf3Ngj0dEbp+Q==
X-Proofpoint-ORIG-GUID: ocKIG5WgA0B_RPlA6hiQAMdF0y7LQ_Ag
X-Proofpoint-GUID: ocKIG5WgA0B_RPlA6hiQAMdF0y7LQ_Ag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device and the OF-node using dedicated fields in
struct i2c_adapter and avoid dereferencing the internal struct device.

Acked-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b63ee51c1652080e414f4302bee16905914c1288..12b4f8750886d7f6f5b6027b00691240952a3694 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1148,8 +1148,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	init_hw(priv);
 
 	adap = &priv->adap;
-	adap->dev.of_node = np;
-	adap->dev.parent = dev;
+	adap->of_node = np;
+	adap->parent = dev;
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
 	adap->algo = &nmk_i2c_algo;

-- 
2.47.3

