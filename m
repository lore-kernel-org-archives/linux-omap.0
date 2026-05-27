Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA733C81A3
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869045; cv=none; b=evsSCYVSJ/XInelRZ5G50vKrLp7m7Y8PugesImcSi/9DhKhFoGai23O/aaS/3BJ/vSSPxKHMQ7aeYsHhM111JN1eHn/LqYLa/hShrf6tr0wAo0L1A7aBhUMZ9jRCYDwo4rp4uxnXI/6yzgPRv20MaLzJLGhMEwEfSKz13rjKYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869045; c=relaxed/simple;
	bh=ZGqZL845qyTXPK+tlB9pFfWL1VcdzPYHM7htCSoE4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQLcFppqQxfKI+/eel9llzHOugnja95YaZEa6P+4evh4qwIoiOI60/VJuCHhawTCOrj/NIbWDIyIsLfaG597xYMsNKdgeuHUEZi6um/izSGXlu0Xj7rmMhgqrQJwrdqSXxeKGWeQpEkfLfk4yJ5g6HWtvtBeE3aZUjqWfDcYbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z5csz6s3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z6yowKH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z5csz6s3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z6yowKH/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R6G6mY1804278
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 08:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=; b=Z5csz6s3ut2SvmjU
	fXVeJy8Lmi41Gg1aCF3w/dxNeYKrIN3/op2Sz3iZjBvmxXaTF1Bn/+5BRgeuU+ty
	jygZ4bViqwOwsD7V1eoa+O4IiPUFuGmMz3+z7RqSBdFjAWjFggdZelmGmWGc1bwk
	V5nKBThxTppHXJxI3B5v5wQAIUZaw/hjmLurvo6WBJVqDCS2kD2XkaxXBFZwZGCW
	s2qsfnL+u9JgY7DnuXhzH0TygVPZjjdWdQxPwDkRTfa7WvwprKwaLGQZt4zZ1aic
	dnBff+nwfXjZ4+nyUHzAcCeYiBhxXpFhGonEHCrRjHUMN8TSJo+1Xc25uA1GQo5Z
	xqlggg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rgcv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 08:04:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516ccfa109dso107672011cf.0
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779869041; x=1780473841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=;
        b=Z6yowKH/d69RVgPidTjwvqqQpKzGRTcdvXy1ltKQtFp/K+exOyzgfv/BbPCtC9rMJ+
         4sNi+sfKXzcnaIveW0nMxSDKBkSN2m7Je3kM/ONtBYH0OWLfeyADiQc6pgxw0TQxed+R
         DLqbLcsrLY/zLSFTY3aHcp1OsJymRXxJQXUPQOdYfAZzMzanOA31cV4nKBX3fHYtbrLP
         MFpfUnUfKgJqyfp6dHsSH8wuijJI/C2V4r6Mia0Af58RUEgM+/fhJmFFdkYOPTB1NCPS
         IJd++DeTT98xi/smh5X6m3nLuoj/sO5+8b/TiZRLnQ8L5rH9bT8GZqWzqb5LtD6hNz/J
         AgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869041; x=1780473841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MkxY5VHM+Gf4iGD+fZqDE7SlRll0D0csA8BjLC9/20=;
        b=Ay1UccqC9TKsnETVj1bTmdguZqJgsoo7d5HvZvhZCzE74DNNDH53emaplHBLlGGhwc
         o4LVfOrwK1mN684ZpjuJzAjbfIEj9sWl1RQQBsjw9nCOO7qtXiGj3cRvARKndylU/lIS
         areNUqGjVO1PRHsj0vRObiB8PcqcXi2j7przbcchv6jjIv5ggTh0CxdJjKUKeMAjRNOl
         ecHPTuR1fSzR19mFGwXoagEWXIjqrWj5STeXFpgNJPw7ADHcRu+j/15iXJzyv3+wJefT
         QHL8Zbcquv/gIDP1Z5k1sYijkjckw9yfpcIKwVNWuGF1h0e93pWh930plehf/uIFFXqf
         IAeg==
X-Forwarded-Encrypted: i=1; AFNElJ9bhy33X4DJEXMmpqB5fRITxrlFaI29xBVlvPcKSyf3tfO+RpM0+axxWWTFAVfwWmJ978jNZcLPxz8X@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzL7zOrdfFTbtzHWcCriuUrG7ZNXNI6+ffrut8mGkukEVz5+s
	LU9NoRO2hiSG5XINkd544p4vIUQTo2HoBCIugqIb5xvVfrsWkvrphOdF6BNAot9vLVNlSwpsC6i
	DuhYaI5IYtq2k6ZCnoazjMyaY8k61fTmSKQRFhY/U0CGgEuErq79aAxojw5Tiv+bT
X-Gm-Gg: Acq92OGv/N5dijQg0+qRGr65U4NMFaRjKDHyIl0u7GzQSyXkTkQ5lCDAT3sd0rcAnmv
	qrauqtjed91p0Xw4S+H5xtMId49xUlkQp/S3DX8czvp+rfXt+Xai01rb4wBUyI8L5bpD9cF0Zig
	+dfEB2ukMn/dhKjQZQHoxu6hDvXwCZlax16jZPYCzqNcEAoFh+7Nq19sq1CuD2LJAJMGgZIzdsu
	Uq3cDClKVark8B0L+nha2paU0l0LKX6df2T4wSn6q+rUX2jGZn4hnqKd0uMg8JMBUO/2+eNhPOB
	YAXFNFm+xOBGcddKmWIw4G+3BCl/04SvkWwiwaSrLndp1xDn92TNxJczV3BHeYwSCa1/yZEvGSY
	7dHG816uK4MnLv+qnHPVxortC5gz3JDCbtcSpw1/1im3+SJWpHhiF2tTK9MO6pcTN35bF89ZQLE
	pYceILWsP1P96i1nlphD10562FP1Ss3fZdmQQqSre88RKjULe+vQ==
X-Received: by 2002:ac8:58d4:0:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-516d45b200cmr299429811cf.16.1779869041210;
        Wed, 27 May 2026 01:04:01 -0700 (PDT)
X-Received: by 2002:ac8:58d4:0:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-516d45b200cmr299429381cf.16.1779869040697;
        Wed, 27 May 2026 01:04:00 -0700 (PDT)
Received: from brgl-qcom.local (2a02-8440-e500-3194-8c70-1be9-4d87-8bf7.rev.sfr.net. [2a02:8440:e500:3194:8c70:1be9:4d87:8bf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm371665135e9.10.2026.05.27.01.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:03:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
        Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/3] ARM: omap1: use real firmware node lookup for GPIOs on Nokia 770
Date: Wed, 27 May 2026 10:03:56 +0200
Message-ID: <177986887080.4201.14057302691715759454.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a16a572 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=akhc-qRKS61dJtW-bLwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3NiBTYWx0ZWRfX+hDv3kwCr7mz
 GfogXvnAUIFZH9sIyU6s46xGiVKL2fPOjLnSuJChx0Zyls5N+FnrhdJgLDHiylEm9UKqjoNdg+z
 2SBuKSd1Wo4VfLQ310A/5n5xLTqjKjbPiDuLsqOZEmKt27EiY1crWRATNFQ6/s5CWg7vsfBg37Y
 Rqv98zUnczcclPLIeHaejvmG9brF+CZ96bV3v9k5oS62NqoSchnj1TFoBwXVlNbQl7egWy3BXeb
 0rAFuJuOekpOZkEAKoaokoC1OCDSJICbiucRgecgMlnEZf4o7UijhS/8KPlK7/O4vCKsKDeuOzf
 2njlnhhutAqf9W5MjEYOwIt8TKODwK4fQ1TI+Z85BPjiVyUhGdZDUcQsNyyw+uYjhLWjNjEkQdW
 UEtk2QcwhFx8EeXyBkmk3m8tTwEVrQWnCrqS6k6jr6xtqJl2FReYZZqQ+MoMi4iaChOTzJrCJkD
 zUCEcrv/MKPvON3FdKg==
X-Proofpoint-GUID: bRTlfGNOAKfhoPlouq7oe2oOuwj9hySl
X-Proofpoint-ORIG-GUID: bRTlfGNOAKfhoPlouq7oe2oOuwj9hySl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270076


On Thu, 30 Apr 2026 09:30:54 +0200, Bartosz Golaszewski wrote:
> This converts Nokia 770 to using real firmware node lookup for GPIOs by
> attaching the software nodes describing GPIO controllers to their target
> devices.
> 
> 

Kevin told me in person I can take this through the GPIO tree as it already
has all the Acks from Aaro and Janusz. I've queued it for v7.2.

[1/3] ARM: omap1: drop unused variable from omap16xx_gpio_init()
      https://git.kernel.org/brgl/c/3288e99f9968c37a8b654d5f4251382fe11bf854
[2/3] ARM: omap1: use platform_device_register_full() for GPIO devices on OMAP 16xx
      https://git.kernel.org/brgl/c/2bdf432e15818a81575e691e4ba0e3a3259d1711
[3/3] ARM: omap1: enable real software node lookup of GPIOs on Nokia 770
      https://git.kernel.org/brgl/c/61442e46fb9de57718a36f54c9ce1ce66ff7750b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
