Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E547D462
	for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274210; cv=none; b=IAJY6HlLdcUBy9i8P/qoimSIm74B1BEaiZAOmoDE9RMXJlkM7om7XadVgBEiyLlQGFUZ02TRktVUwCWoiT1E7sfaaaf7n2Q/VgeNz/SU1Bk2mFr7fVAD0aoNo/xX9CI7uLy7PZIUiP+9XzzXdR8e3c3UqbfhhhKgHssQLeH35HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274210; c=relaxed/simple;
	bh=flxSn8FESRA6yR/pkFS3yn3W7beGhz3kdAfMImKpK9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJui5zCeldq81WZKHu2+SgP0aCzm1+W0UAmRQa36k/HsQIDqID+swZui2hcHV43g6CODQnI06Rh4SF03jdpRIMB7cn+Ev1uhDPKKrGJUnxf2SXPJ6tcHZMoJetOM7HT9cQwtGJLeHqEqfh3r5J4a5m82AH9di87tOXcAQfxaWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mJ8lA5/a; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mJ8lA5/a"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-49ff971e903so996241b6e.0
        for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785274205; x=1785879005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfIIhN61OmpJAg95pfveNaV+liLi2NycTn3RfRjueFs=;
        b=mJ8lA5/aT6xYLl0rUNxWNMganuwniv5cxLa/wATBIKw2NjZJQ6rVEsNy6xjIRT2qnv
         6w9jDuna/Oxtdqes5iAWLzrMTn9klxDpZiGy9E+gvImzyhkjrrH/FTewhYMiYQJnXN39
         Nt6CreoPzBLdK1cytwThX0iJgAYnhwN+sD0sqqIGuk3Xpr9kHOgeXXB22i/8kbCOUV1x
         OYL7EZ7Mfly/XHr/hR8/h/wcBJsIj0rZd2ir3sXG7VUeKf090KDrc8GUvQCzNgkbD1fS
         d/3dzP3I+W6Cpb1QCeeCqpLUgt3x0YIQgWuCVt5IeL3ex4+Myzw5+83DRXehpkDFk7su
         ClGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274205; x=1785879005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfIIhN61OmpJAg95pfveNaV+liLi2NycTn3RfRjueFs=;
        b=Nx9ILfG7/NWXHfsVKuPk/F2yCtfp5rHHX+0P8V5UuqPwSAMRsOd99Z4KA9sQ+5Vvuy
         CilWp7X2q6GJOAnUoAj9ZyNHJ+87ChmDFczuHtosZydZEC6dr07Qy6Zfh0Kx+F/f1CoY
         y1oRaEPNd/nf2S3tkUJRvluFKiI82VvBcEWgGpbM58Xifjl6J9dbZ49AYaPG7oHuurZm
         494C6VCcuixhRPIV2s8HXt6SacHG7S4GczU0IKt/96M1wx2O4rOubT5xr2hkbB65OEk3
         g3Ni/uPwy9axNHS/0qVBAeg0WHBMDoD+wuBCew1/gKtwEDWixFfckQrgW4i5Rno6+vfD
         HtXw==
X-Forwarded-Encrypted: i=1; AHgh+RpjUrW3X3jq7NJkXw4QC2JnLPtGTfPIo7yFLbjtxgpcPluWnGcvpaB1hyKUbmerwDhTA0u8kmvFp99c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzay83Oxdhj6YKPp4DUgbDbnTyg9GS8ynv3B4Kclik2kntV/UkV
	ShbTlahN0qjAvbYoLs2ybHKhY2GsWKYuroFFLSztcmFXooUya4pZKSL5Sert/EbfC9Y=
X-Gm-Gg: AR+sD13+7dAATBEo9s2KQ9Ab3T5VIwjXEberDbUZLDod0RhUKIPn2L4+DN/Cl9/iSb2
	Ohjh88E2dXwCLjEe4+dqS2nYVFbHGL1x4pKYNwxs2/p9AXCudtW3C/A3DjHNtD403Q4oiPV6Dxl
	o29keTMi91aqkOV23isPdWjom3+9OBZfjBoYlK9BFh1m5FcuBm+urld+EGwnyA1HYhfgXw06GEt
	7TSgkoXZ1T2IjgeeaONY7BI81xZ1zZkrL6Wrg+ohOud4CQpamgUHDC8gbdA6i716zwuCxIUgNTn
	Qs3ZCkZ1yw7UzujuAD+sUtHKGtDKMb8856exYEZGtaVJCCH8YIgkViICwQwUKa/S88zFRYAHOUV
	ZFcEdhtSb9ikB7NZJk4FA1A7OtvyML4mVoQarca/YUVifAONTHRA3dqu8rD7hRJevFhfkW3k128
	KIxgWKCv3eejL6wSLaR9sMmbj/8sSLBKR1yUbrHDHx4n0ch+gpj1+hyplLyZ/IDpu76J4FQeGIQ
	6hVECpYVrzg+z6BwvOOHM8E3VVxrn2ZsCNFndC55KAGkRlfOA==
X-Received: by 2002:a05:6808:e82:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-4ad5b794abdmr2108852b6e.4.1785274205564;
        Tue, 28 Jul 2026 14:30:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1? ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6ed2bc54sm235967b6e.5.2026.07.28.14.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 14:30:04 -0700 (PDT)
Message-ID: <df107a87-b63d-4818-82bb-3488f4d461f3@baylibre.com>
Date: Tue, 28 Jul 2026 16:30:03 -0500
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am67a-beagley-ai: Add gpio ranges
To: sashiko-reviews@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
 Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Robert Nelson <robertcnelson@gmail.com>
References: <20260728-arm-dts-beagleyai-gpio-info-v1-0-783ec90d54da@baylibre.com>
 <20260728-arm-dts-beagleyai-gpio-info-v1-1-783ec90d54da@baylibre.com>
 <20260728195706.3D5C41F00A3A@smtp.kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728195706.3D5C41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

Mostly a question for you since you are the pinctrl-single dt-bindings
maintainer.


On 7/28/26 2:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Adding `pinctrl-single,gpio-range` on K3 platforms causes dynamic GPIO requests to silently overwrite the entire pad configuration register, destroying previously applied board-specific settings like pull-ups and drive strengths.
> --
> 
> --- Patch [1]: [PATCH 1/2] arm64: dts: ti: k3-am67a-beagley-ai: Add gpio ranges ---
> commit c5d1a1cd5d0bb91d0c680ae90328952c44500103
> Author: David Lechner (TI) <dlechner@baylibre.com>
> 
> arm64: dts: ti: k3-am67a-beagley-ai: Add gpio ranges
> 
> Add pinctrl-single,gpio-range properties to the BeagleY-AI .dts so that
> GPIOs get the correct pin mux when requested.
> 
>> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
>> index 5255e04b9ac76..599d576f694f6 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
>> @@ -149,6 +149,19 @@ led-1 {
>>  };
>>  
>>  &main_pmx0 {
>> +	pinctrl-single,gpio-range =
>> +		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
>> +		<&main_pmx0_range 33 38 PIN_GPIO_RANGE_IOPAD>,
> 
> [Severity: High]
> Does adding pinctrl-single,gpio-range here cause dynamic GPIO requests to
> silently overwrite the entire pad configuration register?
> 
> On K3 platforms, the pinctrl-single,function-mask is typically <0xffffffff>,

Is pinctrl-single,function-mask supposed to just contain the mask for the
mux bits (function) rather than all config bits?

The DT binding description is vague:

	Mask of the allowed register bits

Does it mean all bits in the register even not related to function or all
bits related only to function?

Looking at the code, it seems like it should just be the mux bits (function)
since pinctrl-single,function-mask is stored in pcs->fmask and pcs->fmask is
only used by pcs_set_mux() and pcs_request_gpio().


> meaning the pad electrical properties and mux mode share the same register.
> When a GPIO in these ranges is requested via gpiod_get(), the gpiolib path
> calls the pinctrl driver's pcs_request_gpio().
> 
> Since the function mask is 0xffffffff, pcs_request_gpio() will execute:
> 
>     data &= ~pcs->fmask;
>     data |= frange->gpiofunc;
> 
> Could this completely erase any previously applied board-specific settings
> like pull-ups or drive strengths from a device's pinctrl-0 property, and
> replace them with PIN_GPIO_RANGE_IOPAD (which includes PULL_DISABLE)?
> 
> [ ... ]
> 
>> @@ -267,6 +280,15 @@ &main_uart0 {
>>  };
>>  
>>  &mcu_pmx0 {
>> +	pinctrl-single,gpio-range =
>> +		<&mcu_pmx_range 0 21 PIN_GPIO_RANGE_IOPAD>,
>> +		<&mcu_pmx_range 23 1 PIN_GPIO_RANGE_IOPAD>,
> 
> [Severity: High]
> Will this have the same pad configuration overwrite issue for the MCU domain
> GPIOs when requested?
> 

So in order for pinctrl-single,gpio-range to actually work correctly, we would
need to make this fix first.

---
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index f130c7cb998d..cae21cf92ca7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -280,7 +280,7 @@ main_pmx0: pinctrl@f4000 {
 		reg = <0x00 0xf4000 0x00 0x2b0>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
+		pinctrl-single,function-mask = <0xf>;
 		bootph-all;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index 5288c959f3c1..1aa73526bba4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -11,7 +11,7 @@ mcu_pmx0: pinctrl@4084000 {
 		reg = <0x00 0x04084000 0x00 0x88>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
+		pinctrl-single,function-mask = <0xf>;
 		bootph-all;
 	};
---

And then we would want this change as well...

---
diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 4491898d8294..29e401f16bc9 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -112,7 +112,7 @@
 #define PIN_WKUP_EN			(WKUP_ENABLE | WKUP_ON_EDGE)
 
 /* Default mux configuration for gpio-ranges to use with pinctrl */
-#define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
+#define PIN_GPIO_RANGE_IOPAD	(7)
 
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
---
