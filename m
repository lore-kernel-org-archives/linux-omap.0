Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A383859F8
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437632; cv=none; b=GqPC7YzVrh1QLAVKPGQNR2dzb6pVpo2iwpcY2SlgTy+pnUmiJJxCYtToYMYX9lyh2H1NTJr+gybbXqUTjNmqz6tGFZDLzu5CbvkIA0dsBFvwhas+eWKjwMm/MHQYsQhvhACITPqXe7U51RSpeYT86CApxUUxKBBSU8k8Ozl/iCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437632; c=relaxed/simple;
	bh=xSIZpSl0bzT5ncKHIOJrQHcDCKTg9OSZ3st72BWj5dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=six0DyQaneuQHOQVwW7GqzDTRob8yIKc2jtxcrgSh2gc5sEBhs87RuThxiCtrzzfNZx0mhyA8iZ3g57C96edzuyxhvZN5BNmsWenzh6XDIkUrg7cIE1zH+TGG8ueb5oGHyxFNvLy0ol9F2lBsnsZWrhkDVT6k3rql++Gye35ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFjC6SVc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFjC6SVc"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38704f70ea3so68345981fa.2
        for <linux-omap@vger.kernel.org>; Sun, 01 Mar 2026 23:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772437629; x=1773042429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e68qiM5Z/tLR2me+b5hOCaInO/EcJkXq3qS1H6cb7Bs=;
        b=EFjC6SVc9p/eFXdAZNIgST336R2XCOSFernJ/n2gRKzFc1U2hrJxIruAKk4yhUIS+q
         H2nMCLm7FRMSFxb1533zLePDJ0iEUu/BpOfAdJs47hQQyhMrW8ONnrhEM9TGZqUST6HG
         ZKGJTe+3WIfVLmhjjd2AeCQb70W/CO7IONLAhiQTo/9XJd/s5N4u2Dz/6QTxBUvXfjH8
         bM7ZejXHZMcGJ483hrWMsLalhV7cPIvSvyyINI8x8SCgJDI0K68Fy8uRAucfqeSYQeEe
         vZcqcWj1aAZCf2B1hCLw/UieKQ5Y3GWj5E7rZoOYKTaSCwOizhXxV29SEWvKJaWqyKIp
         ho1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772437629; x=1773042429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e68qiM5Z/tLR2me+b5hOCaInO/EcJkXq3qS1H6cb7Bs=;
        b=GuVeT43WUJoU1kqfn9HSRqkNYEit6DA5QQbQUx2j3EUS3FnTdaGymPgjiXSGfse41w
         E6worxx04Ho/sFaopiGpra6Xl53ItY3SJOPYQY29X1+xz6kiH2VijsLn4JRwlnMrulop
         l4UEMjTMd5MFp8BlnVZ5olXLpW9RR9xaiiTngJCb5TqBehlGuZRQGzhVUiyEgPxVlv+G
         v/BPuBN+YbXAsnGIARvekp2tYNzIXi1ac5A5fPFNaDfCmRYg1y5hYPyqSOYca+Csrok1
         +MzfzElniyn3SQh6ljIBBfCfCsSKp1XDff1Tkm8e5E7zRwrbRddBU8j7YY8lRtK/ciii
         cl5w==
X-Forwarded-Encrypted: i=1; AJvYcCUGv5CKUkkHBYaTLlC0C/iwRa+geU1dt0X4Ocb2iusPmyJDCcvB3jYDXe12jdAHp55szW9D4m8jF9wk@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYLF0UhTo1wOk3UySPwOPgW0s0npH+AJ7Wg/PBCa7eILzvAcW
	+cVzHvkQaL59/pEvPnMkIMZ6e32uGMp+n1wywUY4rdIQdP0NWOCEpHyrEclMJflJ
X-Gm-Gg: ATEYQzzUAPrsBGf659Ov4w/xgTJ/ZdUQHV7mE+O8gaa8/+y/lvj8MdmYHQAK9y6Qfhm
	IR9K/ZC9k/Y8TKWjVf13sc1tFXIbjmpvwyeA/Jtf6u16dGaWdLbOgbBdcT/XqYTloenpuv26Y7g
	BWuBQFvOk+qLcSt/o5+tSEHM659YMYinBWVpKYz54Uown5wrC/LxhIzgwDUqp5bXv9D5st2gu0C
	QEKAu2tDEiM1MpTh91AvlWc6t5oausP1s8zmJJUhk2K9YfRk80JT7yvgPOh56IEzksD/Xh99SAP
	u3LBXqnbXt5lgI3eqWKAbdtxuASvrqk3GPCwMu91d2OaGuJ17ATi/jXrfAifIzL7p3Uie1jHOcn
	gFJ9HVNozm1u9wojKFgnpI5AKc9/bRnOx/2VvI9qZZJLHeYskdSjllTOQ+PvOKTcEPgo95HGnzS
	d2uvGk4WkPFpJ9iT3x/naS1OvkkQ==
X-Received: by 2002:a05:651c:1c7:b0:383:1c5f:84c7 with SMTP id 38308e7fff4ca-389ff130e18mr78428611fa.12.1772437628986;
        Sun, 01 Mar 2026 23:47:08 -0800 (PST)
Received: from [10.38.18.76] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10a319f05sm3299418e87.50.2026.03.01.23.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 23:47:08 -0800 (PST)
Message-ID: <ac23aec1-6dce-4dd5-8990-9fad40998478@gmail.com>
Date: Mon, 2 Mar 2026 09:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] i2c: allow setting the parent device and OF node
 through the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
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
 Matti Vaittinen <mazziesaccount@gmail.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
 <20260223-i2c-adap-dev-config-v2-1-d78db0a6fcf7@oss.qualcomm.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-1-d78db0a6fcf7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 11:05, Bartosz Golaszewski wrote:
> In order to stop i2c bus drivers from dereferencing the struct device
> embedded in struct i2c_adapter, let's allow configuring the parent
> device and OF-node of the adapter directly through dedicated fields.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/i2c/i2c-core-base.c | 5 +++++
>   include/linux/i2c.h         | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 9c46147e3506d15d53b9b7d6b592709de56e41b9..dd8cec9b04c64b8340d20e018ab5ba28f1f7f5c9 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1561,6 +1561,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   	adap->dev.type = &i2c_adapter_type;
>   	device_initialize(&adap->dev);
>   
> +	if (!adap->dev.parent)
> +		adap->dev.parent = adap->parent;
> +	if (!adap->dev.of_node)
> +		adap->dev.of_node = adap->of_node;
> +
>   	/*
>   	 * This adapter can be used as a parent immediately after device_add(),
>   	 * setup runtime-pm (especially ignore-children) before hand.
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 20fd41b51d5c85ee1665395c07345faafd8e2fca..72677f29aff161530bc3c497d1e07144a44eb9e4 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -761,6 +761,10 @@ struct i2c_adapter {
>   	struct irq_domain *host_notify_domain;
>   	struct regulator *bus_regulator;
>   
> +	/* Device configuration. */
> +	struct device *parent;
> +	struct device_node *of_node;
> +
>   	struct dentry *debugfs;
>   
>   	/* 7bit address space */
> 

Hello,

Automated driver test system bisected this commit to be the first bad 
commit, linux-next next-20260227 was tested. Failed tests include driver 
tests for ROHM PMIC and accelerometers, which are connected to 
BeagleBone Black.

The failed driver tests all fail to first i2cget and the tests stop 
there: "Could not open file '/dev/i2c-2' or 'dev/i2c/2': No such file or 
directory".

BR
Kalle Niemi

