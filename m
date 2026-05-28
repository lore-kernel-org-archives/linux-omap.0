Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCC38837A
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958083; cv=none; b=iH0v6SBzNoK5DDAM/CUAY4SpeVutzH/i7jjO6ruwd8gUfhwVWshyRoYoyCrOzk6RS1k5egkowgd9djn2hNDzbKr6ObKP9WsiKrfBMin15DO7t++QbrToKyQ9OvZthUJoIVA9qTGzBKKs7zlw1S6/E/HtL0U0uZXtLvkrMN0GlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958083; c=relaxed/simple;
	bh=SiiQ/8Pjo3hRAm8eRhuhyDhrCISkb1+d0Fn6rjQzIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDrUs/zjUKwqOsX9hJCK0K0Zd3Us9I9g2g8WRxN44po4DV1ciSexPP2eori5vlj6FvuoOtNupuKy0ePTutvO3qaHparVlDw5AaA92cEmXMToggF4pPOQQoo0kCxVcj+C7u3sDC5Te9YbTe9829jqa2RuX/ZRN7fht1LU2QRkapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D06xo4wa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gE506u0m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D06xo4wa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gE506u0m"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S76QjW1975748
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=; b=D06xo4washJmnHQ4
	rbdbXIkPWeykYMtCpytbUnX06Dc7JDPdaDUaCt30fH2JwVLIdgHoEyrMel+ArvdU
	FDLAtI3865Fzwnf/u0kK0JtUcC/bUROA+//1yjx3EhM3ztWJ3gamyO38zeSkQtQU
	0zQCfNgjFgGsQFYC1VkDdRXV1HUL4XXFCNljo4HJYVNihs8Qdm+J7fGNRiAz+8wD
	b7KO1DS8j3JitasiMXHXz+2Ble8PKbB3qJQ3liPnRfQNvB8S82frDMXU56o5BIRM
	8yPaawnmA4yGkAQaEFjLoHGtduge7DpdMhB4aEjgv4haVv2j7/nUuzboyN/U9iqn
	mpp7Mg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3t2a0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 08:48:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-515224a8aa0so51986111cf.0
        for <linux-omap@vger.kernel.org>; Thu, 28 May 2026 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779958079; x=1780562879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=;
        b=gE506u0mSqTQ6XfVJ8bbod3rZTnz36De0uCkwhmfZWoU8LsO37y3aNQ308A6xEqQD6
         /R2a0+f0weT+lhj5qFOY66dknAHEI1OCly1bQx+NHmqtIuECRzQfx/KB1RREz4ERi7KW
         ozj/BbYoOsWVVS9fCs8p+oqPW/BWHkUyby2Li19EyFktJAJ2GbEdZL4/smt1lqeeZ9hB
         wYrPXJq2GWv5gV5usD+qzejbeN1Tn13g5Vs6Q+XSoJDVFmVDShH0XOso9/MZYaLLc0IK
         4tCqK4BTTApRQmjmLXMeAR2m1wjltaShujMM3ROlLn5bupsjnFn3EAQh1AwkKWKCO/ei
         csXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779958079; x=1780562879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=;
        b=ABst9Qt6fPhW7H00MXhlVc7u7WlwwewmSztXJX0MWvq6NBcitkFoJaWrPB64rvo6kY
         XwY3h/rCbOLwXyre5lyj3+4wwrZpO3BsGkEVhl67kGWh8DQKKuH9nylYn9J9QwU23eFd
         L9JYDZxBto6PSVe4uH70L2K/L5Gv70Pk/n1AI8VL3gbqHEt42Pz+8r5GJ4CnQ2I8ql7Y
         fLnREKN0VsJUs/GfspVc4zxFJWjrQHED/hULwbvibYGnEy+JdGEqLFAUXwo3ETg71b3r
         m0Z+oVc+zn8tyWddp7IwcmL6ttlin/81Ng+Qnj39LPMwLPduIwKKkUbBrUTmUuSPOHFj
         cj9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8iufr4Z1K6hwQ2J7C7worw8X9TxrnWBE7yBdJN5Rn//Cxyw3gMJ7PAIJ0X9iM8JnxTflWv4mtzr0qV@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJkYxGTBJoI2+hJ8I3ACApnlp0gX0lbwJOEmVLopJjXAgV67F
	7UhqHsI5VZuWEdWue9zOYEaz/ikmy19DIrpr9jdQkUQI72u/6nW3Ryj81VZ1zHe16lveVAGgYOk
	qBF2c7gZup+QWN070zzJlGE0XSEZ5JEOJhQ19VWknrx1LSjnwmkTb2L97mPpJPH0I
X-Gm-Gg: Acq92OG2/zQ9x3R2laPC6BiMcPl2yJHFpg0vTehBa7LvJAS1FILxolqOPJUFqZWZjLz
	nZGPWbiLq7rIp7mSAB0v/qiE27WXeaqo7hHNfcVcyOjsC+mfDKAei+1u6qHio4/4uLhIkGKfPav
	VnzIzkFS/UjA3z5AxN8QCO2uuSOQNjGpdnhnXOEj7aihwwH1ZWNvw04csOGlUVO2VYtyQJBlYf2
	GH8oXrpF1wyBjcTyqdy4JC78MaS72t5VEHK6aqv4yO+LDiYjmcBvoooWXmi4naj40HMO3zf7DWo
	yfVdV9JZHYiLcvylZ31ufR2gs0GimoMr43n7qVjOhCv1GZbVXz8X4VMZzuqYLku2Ceg5ZCKTts3
	fGK07dPlJW0B4pbG5+OWM5CXuMNec7c/atAy43BunaHpgikDwRGPxXntZJy3PMeSO6dggD/bU8s
	DQVlpWX1Bai393SzC/fj6waEYb/g==
X-Received: by 2002:a05:622a:251a:b0:517:14b6:a2a2 with SMTP id d75a77b69052e-51714b6a335mr70490161cf.27.1779958079286;
        Thu, 28 May 2026 01:47:59 -0700 (PDT)
X-Received: by 2002:a05:622a:251a:b0:517:14b6:a2a2 with SMTP id d75a77b69052e-51714b6a335mr70489891cf.27.1779958078802;
        Thu, 28 May 2026 01:47:58 -0700 (PDT)
Received: from brgl-qcom.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0afc77sm10817465e9.33.2026.05.28.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 01:47:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 0/3] gpio: Use named initializers for platform_device_id arrays
Date: Thu, 28 May 2026 10:47:55 +0200
Message-ID: <177995803708.5037.5318741720946502441.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LajUJQ5ranROdLMD0fv-AGnK0mqVGw90
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a180140 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VaStRuOlacOtyYye708A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: LajUJQ5ranROdLMD0fv-AGnK0mqVGw90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA4OCBTYWx0ZWRfX882XDlnMqCa8
 b7HWuqsohY3EzT7R895fCduwuvsMwl2AhqnVdwtfT8WgZOyK7ymYZUT3DjlvnwelT5N7AwG+KUO
 JGcVksB4ij+2Qr1GyezHQxQKNFtcq1nCgj1a+RlUh4ZVJ0ix4VnAIDZwEDFcsvles+sFRH33nvP
 AjBALdzTD196ugkvvtFKNAlO4wKCEL8oz0G9imUcd63K36Qp2FCxxHNHcCbfC3EtJSJQ5aWkLdH
 Un6Slj9bMlWbO041VBz2dcBgITdXnk1FH2xRiHTG0VJhQqxQpbQZ1DLr41lnBoKBBiHBL7HBwK3
 mjAobdYtNdLJVkQXeq++kdyCWbW3aHOP2do60dyRpFf6o5l+nc9ORu2i7HJ6OAKV7b0h/cMpgIr
 +LGfQaTENJxhlvrVNe9juAsluC0DHrL8AcU9BK2/0NN1lcuOnl9zUZjgNBUo9KIZsDlmhWRbLoa
 TnshEfvwfEHbsNJQkFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280088


On Wed, 27 May 2026 16:57:26 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.
> 
> This robustness is needed as I want to do
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -610,4 +610,7 @@ struct dmi_system_id {
> 	 struct platform_device_id {
> 		char name[PLATFORM_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;
> 	+	union {
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 
> [...]

I fixed your SoB as requested and fixed up patch 2/3 as one of the drivers it
touched no longer exists in my tree.

[1/3] gpio: cros-ec: Drop unused assignment of platform_device_id driver data
      https://git.kernel.org/brgl/c/516e4d886941568174f46985fbb7c960c516ada9
[2/3] gpio: Use named initializers for platform_device_id arrays
      https://git.kernel.org/brgl/c/2d43fb71f4ecbd10649a277e8790e7ca27acfdfe
[3/3] gpio: max77620: Unify usage of space and comma in platform_device_id array
      https://git.kernel.org/brgl/c/a8754838f83a9905af516f38dd2633744a94f71a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
