Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E853859E8
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652298; cv=none; b=jN2bla6/fq2IxUIcggP9QqjpVl/ycNRkej7iBZUNux44I2ikRj59tB5JOBjtd4ypOxWtGfkDSO0mCErX2JkhRStvs3vISFUzvCPYJgeYuUD5qtFKDDgWitH1hiKt+hl161a8s6bVa/vkLSHTycDeaPmjcTkLdUDTNh8bJ5PiDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652298; c=relaxed/simple;
	bh=+eC8eAmFeq/qr1/xTtK9cYJ8MQ18m1zZJmA0ouJVonE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN6s2qkOPGdJhJbaaazSen1sQWT4Q9sFNs5OXmzhj/tpkSq+zed1Yzz10ns6NYVuQ1+8NTAkwJu1rg3dj+VhKGZK083hGZ9w3AKxiJhHSs2sTF+oZBHo4d7L4WaSmVLilDc5HdnPuNGX5wPsiY84yks2A5Xoxcu2zJYBbJKz5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWfJIxdn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eNMH7iAN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWfJIxdn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNMH7iAN"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64hiN1724717
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 09:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i72EfdgJ7doLImzDWatjm2GnnkPEZNv7sHePPRX+J+A=; b=CWfJIxdn7icUCxum
	1Uo1mlsWgJOsUfxnavJTE9oKSTrDTMVTrSI5u8SPiPfdZrXVOdsvcJ59HAH8WSQg
	y4gvt86Dt6P7LBcZsdu0ojBD+8Ik6jPpTjEF5JMWHiV7tx26E7zaUDSbVpvbmFvO
	J7niurtpXHJ3VuTeOdz4v+jSY02CPsPKRhCYAtvBo+YEyE8vJaMQvbKVPkSNrxnL
	W7l7ROrpAc2qeO3W3hpqqbkDej0UnDO7yXDygEQWCwsFtTCEYEqgLZnMjEqTnRQD
	Owmxo0+Fu5KuaYCmPWFVVrJRFkh7JYSGjdf4GOop6mBqQK/Zul9lPsW2Q2yF9Drv
	7vIdaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udmuux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 09:11:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd773dd409so563185185a.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2026 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773652294; x=1774257094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i72EfdgJ7doLImzDWatjm2GnnkPEZNv7sHePPRX+J+A=;
        b=eNMH7iAN+ZfcOg4NxZR4jDeAqW9aU16cHFKH2gx1IMjGtPWkjLzvcXrF20MPdmwTtc
         ekOnIwdxIBKRg4sQmyJ6F5I7aCw5AJ8yTMtaCtSxQZThjVHTWD46ImmDtAAxqYaNCRVT
         bv22BDAiK4G+/MA5P/TCT51lGhLF8gJj9jG1PrmHNuwppoTtsDaXI2VdbTv+1pldupRz
         AV/W/nXvaQ7dvIxwldcce611iojbI9lyhY6DQ7p7i0GXKmmhQ6U3FjeaExbebaRdsiF+
         xbE5EEtZJ2Z3zGnVusi0BT6qf7/pVBTDIw7OD0yrT0C4qRp3qdHeb0LWGi4RpEi3IHCd
         cO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652294; x=1774257094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i72EfdgJ7doLImzDWatjm2GnnkPEZNv7sHePPRX+J+A=;
        b=e3vCHWpk1kOXhQKrdYIIR9ckkwJw3DoYdESMQh3P8UqDskBpVhkIyD8UxwC8tDfozM
         5AbjSyuSCAkpYPLMXxKCJfquai/h6OoAsHUl6r+AlsJ1oPnqjoCxyFvxO2OmmHYl+sd9
         p/MQl4J6KBLtjnlI3MsK+QSh1miF+wvZOFq+HnlYr0mcaZtAmA+jGEP3wHYaK7K2FJg8
         H99p+pH7thM/uoY98g3NF19SBVn0uoU4TsQ4q1sO0JaCXgav+q+2ojrJzkh6QFwRFaLx
         LcXHxA2ksrdyXpfsZ9i8JJxQK4dkgbr1BB3Bw8NK4oylnUcSJtw8J1c0iAeFLe5/XChv
         QCyw==
X-Forwarded-Encrypted: i=1; AJvYcCUakC7ZzEqPXpR9iug95rUvweTczPqOJXBIaSQHfNjeURfN6eyXizC6IGKVzboHlzI0ANZWItjrA7Q5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fLqMbWwglNgWOywraavmGKNMc9nnX5EPz7zzwHh3KK8TGviy
	Mvu7HmENmomTFThqr1PPPMP52d1f/9ho9g/eAUbbvbzdx2iaXDMMveoVd5wIlWeJvYbh/r92oYz
	4mkLxAYQFqtqoT5EF3ecHICBT53sVuBnqh/0vdw4GDGkF5A7YVqEsg/TR9pvVN303
X-Gm-Gg: ATEYQzyKFzeWF6uAJa4cTAwGQq+tAB5zwpEQy54KJTQX39xV98uOi5hee7GgGBAUAEk
	f7DH1ykMYsgU9A3yvMBqRgg39Xi2xo2bmYq9qwqmqEUFadebzL3nYtIgU6+IJquHV6pahUngrvL
	FHIaQNBvwf4rhb3lQPE2KkXL7WxSMo2dmIav6jHvyfpdnc6L0++wxcqyJWqfMhMN9pWAAaitsfX
	hEzgZ6vD6uqNVLMI2Dk1u6y4o8dXVXGk9yxXB1GTwDIjPo71gBeZ8Ym/gQOunKHH/mK8ez+QqQO
	bt4+yJt/WHIhw42Ei8wDPGNl9/q2lawY3nGbZPNmZqzsjmFgFi7gz7JPQoV24NdofjtY7NPzq7D
	leOwcIFuQCyeVR8xXryfmVx0kXneF9mADWzIHCpwCYvbnBD06Qow=
X-Received: by 2002:a05:620a:44ca:b0:8cd:79f2:dc50 with SMTP id af79cd13be357-8cdb57aa4a8mr1434709085a.0.1773652294349;
        Mon, 16 Mar 2026 02:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:44ca:b0:8cd:79f2:dc50 with SMTP id af79cd13be357-8cdb57aa4a8mr1434705685a.0.1773652293841;
        Mon, 16 Mar 2026 02:11:33 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b468cf785sm2932198f8f.12.2026.03.16.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:11:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-doc@vger.kernel.org,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/6] gpiolib: unify gpio-hog code
Date: Mon, 16 Mar 2026 10:11:20 +0100
Message-ID: <177365228183.54363.13735316568548509348.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b7c948 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jtPpctr3BKvZZnv9HkwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: HY0rGJ_CU2pwXzSzT8GNWA-M3morMTfS
X-Proofpoint-ORIG-GUID: HY0rGJ_CU2pwXzSzT8GNWA-M3morMTfS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MCBTYWx0ZWRfX88euBWF6McSS
 S/JJD4fpsvfE8z1sSCxucdkNp0bmwUztvKJ8s1Oxolt4H2sc9NABug9UPRnTz/hmo2Q4nNaI8KE
 dcXuY4v4scGjd4ykBGSPwGdFQZVM1xhrU3fJ+ymEdttwZ+goQUPOSalH6e0k+PPW0KxYVJxDmch
 GKuiz5N3kwPqwGSx5fnav8Ksf7uc1liq/6AUxBYE1JpG1WLxsZfqG+Yxz4PSfwF7Nw9hGFs7Sqg
 nUj9Vh/YfkFG1Hl/6iLC9dBEZsUPK8GhkQqGDaJeKpX+8LyzBf8fK65y9J/ARQMWkVG5FN15Mmt
 AReyCPSqysetOnzqtO9PUNCiboYLRfZlLIuhoxwUJarZxa3tuIa3fyXGQQeGVE8HOEMEfME3dJj
 c8TIczLW+L4MzBFKSRv99X17tvMKTt7wLuDQmiYWZEcRM642n7r5Y8UNXD16Kc3SqRZU8GnjHJD
 JhkoWTHd0UK5Imxbr4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160070


On Mon, 09 Mar 2026 13:42:36 +0100, Bartosz Golaszewski wrote:
> GPIO hogs are handled separately in three places: for OF, ACPI and
> machine lookup. In addition hogs cannot be set up using software nodes.
> A lot of that code is actually redundant and - except for some special
> handling of OF nodes - can be unified in one place.
> 
> This series moves hogging into GPIO core and bases it on fwnode API
> (with a single helper from OF to translate devicetree properties into
> lookup flags), converts the two remaining users of machine hogs to using
> software node approach and removes machine hog support entirely. In
> addition, there's a patch extending the configurability of gpio-sim now
> that it uses software nodes for hogs.
> 
> [...]

Applied, thanks!

[1/6] gpio: of: clear OF_POPULATED on hog nodes in remove path
      https://git.kernel.org/brgl/c/bbee90e750262bfb406d66dc65c46d616d2b6673
[2/6] gpio: move hogs into GPIO core
      https://git.kernel.org/brgl/c/d1d564ec4992945db853303dc2978256bce8c0b4
[3/6] gpio: sim: use fwnode-based GPIO hogs
      https://git.kernel.org/brgl/c/5cfbd0eb784f19436b5d5a9a7e0dca862619739a
[4/6] ARM: omap1: ams-delta: convert GPIO hogs to using firmware nodes
      https://git.kernel.org/brgl/c/e627fc9fad93d59765dd16adac1b2a9bf68d7523
[5/6] gpio: remove machine hogs
      https://git.kernel.org/brgl/c/dea046e7f46f2357124a465e058c92cac3e351c5
[6/6] gpio: sim: allow to define the active-low setting of a simulated hog
      https://git.kernel.org/brgl/c/696e9ba9a3da3d919d08a1abf05c9288311858f1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
