Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFB1AA1F4
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837904; cv=none; b=XJ3ycYLoJvbqGb7iRDuWLDfMToWdQeCO8TaYh5ykomtYyunpK9IIPIUYivtGhC1ERZx4ATgqhoY9dIKFSbP2XpqdJmq6VQWdJzvhNqiDBkXr7Q6dU50xycF2PY+hYA1hlbhijQxaaxUPVmGScqwS7P99D1LOR5ERgGuo+MQRe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837904; c=relaxed/simple;
	bh=a8UV6upSERzZiMxLa4pbl6Zm2TvGnZjx+Xqv9pXzXFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnIUsiyzWHJbIiuWPwsl0bxE7FMtOtiwz3rd5Qj6bn+aq0Er0C2Fo7Pu0soITwvQHmHPcwno28IAs2vZj9uT3vHaMmjE1tr2ThQSW9s32qBM/3eDg6Tk/CH3tA+1WWrjjvGni/DK9o+Aii49v5n2a8TXsOSwP22eb+Z1IHL9XWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACBMi7vx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iswfj+rF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACBMi7vx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iswfj+rF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMneOc2783699
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/FOPSFcqGMHY4FSkWDBAalpUhPARtyMNlPvPYteKJJA=; b=ACBMi7vxntgULb5J
	Sm4Of+obwXTOgWEcFFHqcz7jBmTUkJDiJTEQFCDvLXA/xcEcfsWZIKkvpJx3ELvl
	M+erOMeO8dpd1F/M2lVedCmuT3cVHAdwG8QZZmS2AcVRcWyv6/4Yl/7kFgACiv3r
	M0KpB869Eqi5c0s0iM3GUF1eXjREy+S0P0H3Htf/nB3cUKlS+f9qvT/6jhR/OkHr
	fsgMbYD5aCnZ1yAy4IlZZDMAdcUhxMPZaHwE5V51cb8QV7WwcHHyMm+mNocI1oRC
	CCH86WbjuY3aVhL069J7Cb8lMrvMgNoGowS5OLxF1pedVxz9qHGw78HJEkTgYL9F
	EKUucw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv46k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:11:42 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40ee557ef0dso49630971fac.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 01:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837901; x=1772442701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FOPSFcqGMHY4FSkWDBAalpUhPARtyMNlPvPYteKJJA=;
        b=Iswfj+rFqDtP7ahvgqqtWDrFAz8fvRimzvFhxck/UcIbvD8UK0JbBMXeSxgQUKf2IR
         GllUt5PH8Q3j7QbkVoBPutrtALkS/4VBBDWvO7u88HBQVEUua3r0othn1bPezdoZcXQW
         AJBEKMPe5dUfIUfkxmBp3IPIp9CBxXKBgrIiuWjRp0V+hw3xDzvbOjpMC9QHndgPcdh6
         1LSwWojrnioIXkPrZDY3+RlnN/8XVfGll5rHXrYyjAVdA17nSEoDJLYGkI4XQw6jk/J2
         i53N6w63rd2qwgy0K4v+Nb0l7LmxxMrx+gVaoHYzHLQ3uUQFE4QmHEDQbY73eYTeBf8x
         Ctfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837901; x=1772442701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/FOPSFcqGMHY4FSkWDBAalpUhPARtyMNlPvPYteKJJA=;
        b=kdrEpYz748EGmLQhsNYwgpE6wCffhaJrXCq/RWjVhZn1iCQ3y94kQh3Ht21psM2zpO
         l81M+NRo4uiWr9DNmdPpuRrUDI8sKbzAVZ7hay3SWlI4Lp7KhMIMkjGYc4vN+d7mJ1cH
         ZE7koRk4S7fVgAjLNM2YB0XwdektsEjmAjZAiGJFHW51C8zIqU4cRNtbDQwJ6hoUiJDl
         IKMSyvdCPcWgB8Wv0BdLHAQZgB86kjEB/j20TOWs370uhBBBd5N1GYxWhooBn/veT8bR
         HzGqmTbQpdflrpeNieLc5CA1jTs65hdrQTbDqlb+fO6ly4ibsXQ/2bWBN1ZeAmPs/ZPU
         LMYg==
X-Forwarded-Encrypted: i=1; AJvYcCW96dMw3i7nrpotV8+K58H7KEjhL6QYgLCFuKji7Tq8qNCrpqfrSqJLdrQpAsnRSfw519d0//OqBG8i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3K1Y4Ck5NVc4aJ53YGyBXozZLg/HvD531L8Nld355+6WcMcA
	rb7eXfAV+CS36srY+Q80OaqEcZskwUX75tHEgJ74ZE7rO+WFWuLbw/NxvOF7AdztPOxtVaOWsij
	A1K92ojFr4LfNOyFD4bqc2ijPeNEBnasHnV8NXbWVqFsQ0nJAaY5dfOTV2AllhRT2ikzBNALU
X-Gm-Gg: AZuq6aJ2c/S29bi3liFygdj7+cSRAw03IPT8Ir23REjwiyDGdbSrSqaNfABHxZp0/hR
	4SWBUgkmV5LNM4VX7mQduTfx+LcQPIMVROIAJC3dg2Dxq/uatV2lcCc3Bm56azlYfvdvvfCYAio
	Ujrm85o+h9ptcTBKyBYey7yjloduFLlTceVGoQ9BjpE9iOdOQFS7bnlYYSntrpW3otdWXOVwrjR
	UOkquwUvd2ei/Dk6jMKPJQCv1GOeD8K4tkKff/z4YvIiFWVIFsXA+D/SbAPZl69Y0BVgrAxmUSI
	kAU9qnILUNTBMsOQkV42hWa/8XvEBsODnuGqYaO3t8Zw5snZn8TAW5cqBJv4jHidiTg9IRN5Myv
	QyoKzT51BUoa8naKeJYJGRwraWlwEaUvXBoYuIV77F9TA9tTtlmoi
X-Received: by 2002:a05:6820:f004:b0:679:971a:337 with SMTP id 006d021491bc7-679c424dff0mr5185477eaf.10.1771837901608;
        Mon, 23 Feb 2026 01:11:41 -0800 (PST)
X-Received: by 2002:a05:620a:450e:b0:8c7:13b8:8b55 with SMTP id af79cd13be357-8cb8ca6e6c6mr944315985a.46.1771837590759;
        Mon, 23 Feb 2026 01:06:30 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:56 +0100
Subject: [PATCH v2 10/12] i2c: gpio: set device parent and of_node through
 the adapter struct
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-10-d78db0a6fcf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=a8UV6upSERzZiMxLa4pbl6Zm2TvGnZjx+Xqv9pXzXFc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBh5L9W4QURdlXv0MMYDy3Wx+w14PFc5E2/TU
 a0C5IUrGYyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYeQAKCRAFnS7L/zaE
 w1AvEACvwcgSdpL3LU2XuYTrJqc2aiozZlmvj3/1Ie0jMcJEH2AK45frU0bCSRvr2gqCa3Ii60X
 6WLZVGY6RlNRcdxRXLRSZBvSE0Eoce6hkv6Q5YC3L1/cw8bbzrNV5usBKi4oO3Zm99AILawCmwd
 zJ+97Zpcy7O2/PN26x+KI5d5VP1+tngkzEvNqH3Nla9aCUt9PpyjL1f0AVJJb6QVS+Lknv/Ci1W
 GHiSaZ6FFGvYN0mE6bz2csmla16RJ5R2WSSWG3wGVcWhwECiQgsRSByzTQO/NEgkl6ppgN7lCU4
 8vXuo0q0t/6Z5pjWzh+HsqehjDvdQzAhjip0VqM4lr7bjbhfjxeHbYytbLQbTwk8nQU9WeTFJza
 B0agd251nKKlp3X2vDs/zC3adAlD6rqXJG0Rekke0GvHOmXCHDoGI9G0FHspKYH1R6IQESj/atf
 RFAxptAGIlRdEyhIssjv5tEk8tNpkgV+aOdxx5Ww6XJXcURDTdiVmts5AfQFkdMd0GVo9xAeXih
 xNbmcFwpHrWa5hjOt896Lld2Iw2ooAPt60qFvm/35aEkwP/nPU/SgLJGtHB9Hevf1KvleecWkwg
 odc4uoBYOug8l9+6L6rue9mcvWyrA+2VwZWcYKw5+CK210buMCsqUZJkbIZDwejQ88avb1U84yT
 HJ5aTEt7TNzEmWg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXxz7UWNlKw+eB
 xleNxPMR0st6H6GTBOrI5xECW7/BD0/6Smf5bXQcMENiBEu2sgyEnyt9bmwYz+/pj8pjWXIYp2C
 oiiWB35h9klUeOv8uK97zHiam3VmgmZ84SC0W//3V8ZTVqJYvHPpMdcX+RCBOFBa7vpUP262uF4
 gnnjL1EySV42UVLn4pjG1foIzSNdMRqNbCACCfE71PCj82pUM/RkzhmiWyOHtawLRSFBX0czJ6v
 rDh+EwWExF/DXEwMD+2azD4ecd3XIo76hmR5PMrjeANJq5uy7M0POocgiBxHvzRv7+ENRn71UGv
 vCdggRc0nC9EZPJ5AvzpGgpAgLpzdM70x5/IVCgqxdaI0A5OEI31obt/UG9W3VjkhUHnCmbxpRO
 XvPX7cSK1NKv1+4WQ45v/28RBqZ964aVNlXFKELl5uxYvKOouOIY3RZLfRn7u0jUA5HSGzQm6c8
 nbdi8Ec3UTqTFjIBXdA==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c19ce cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hPzHJ5MbA3fyhucrTyIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: P4uwfzHkKoStUSJuDR1JmvQ01RDedc5l
X-Proofpoint-ORIG-GUID: P4uwfzHkKoStUSJuDR1JmvQ01RDedc5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Configure the parent device using the dedicated field in struct
i2c_adapter and avoid dereferencing the internal struct device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index f4355b17bfbf15c402e71096ccbb99f5a35bb479..78f8bc2525be6d1fd9a7907df4c253f33bbec9f0 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -425,7 +425,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON;
-	adap->dev.parent = dev;
+	adap->parent = dev;
 	device_set_node(&adap->dev, fwnode);
 
 	adap->nr = pdev->id;

-- 
2.47.3

