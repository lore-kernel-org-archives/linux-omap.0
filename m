Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7CF4AB3AA
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402092; cv=none; b=YI7YOHXHEoZSsUWdlGxgCsf4GDZJZUuyOtF4jadvDljD0voBxsoXN7xpQppRa7i4GZctGFnsGmsCdDDhjxWeAatg8ONqBCQvzJrQY5wZWiuRL6h75/ZOsyAh76aisBPDr47ys6VmtdnHvEvqhPt+kEnjpBVbkez60J6SKHM/MX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402092; c=relaxed/simple;
	bh=0dyPF7mE3t+RM/QADdAdf/PKx71VS8XRDDVPCLUpasc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOn5mPU2AaYG0NxXBqOW+XUnjg5r86lBxcINPrS+QBj5eq3X4K3i7lUC3QKWvqicPBlF8XQamfYWx5jLyon239tO0Mu0qBC2/GW8ajwu1qIbmad79F1Nz0K1KpQVlJvOFblKYm8Oz4uuRFlEYx3IBAN9yMMRad5AdAUYlxbZR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TabEt+4s; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TabEt+4s"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso927311f8f.0
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792402088; x=1793006888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK8j4zExJxC720gbifUR9mDEZ2k0SEqSK8uj/t6ufAU=;
        b=TabEt+4syARpZYSS7IAUv/4kga+T5mT5y5YV4/TwUanxWgYT/3tSNCDXar14lM3s0H
         2IXDJb6fV0mk26cwkkFZijqxVxtT5Ahl72+Z0suNdAi2MaGf349Kl7Q71ylydqVvKJFT
         KyMqDVPxYmH6P0rDXOtqj36kHXvbsVWJ1wjxkaQKXvJ1LMhAWCtFjKhAxVWp0JQrPF1F
         MZImYUWGFPs/IvyKEJuRB7hzeGc8UZmOytgRX96KnwaunyDKGg+OrTulWUzkS7ju4+oN
         Dg8emLA38yAWd1v7qMBKI0kqOZW/I6e1UQzXhneL8ur/ver9WLJRdpeeZBJvH0qR9hnD
         vFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792402088; x=1793006888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FK8j4zExJxC720gbifUR9mDEZ2k0SEqSK8uj/t6ufAU=;
        b=sbS1VcIGJsooday5Eus8He3SDO2ZDt1lSILKytt882zJ57f6DPTPOXzGK3Etsp2o2M
         v3L/RUfl8L+1WWuWlmaRPM0Nx6+BgIjE069pSQhHbizHVTqVsJNa4YxZQukBuoJG/FOc
         JXOlAncX1QeU5fxu1edfdLhhKGnXIjRc1bVeO64a7AwYw9oAPflJpgMGmrK8qy45z7kv
         tA1uJmx4j9OJzInSRlNIkK6GyLhMfS03pNDlqUQPFwQdNYa77rdi6MDPGWBoSI7EuUq/
         FSOnDZzTLCSV29KrEE5DzpKu+RkgqSxHB/2va0pyVyth7RL3PFAa3JD5C+rbxOJhng3o
         BVxw==
X-Forwarded-Encrypted: i=1; AKwUvBxEfHbUr9CGLSG+vBvyB1Mm/RCXooPjouDKQq3o5w3s/0xa/qS7n6M6DDvX1gMTxM9ppGg9JVm/K3zS@vger.kernel.org
X-Gm-Message-State: AFq9FYL/3itVI8YO423AkfKD/yXGa/ET+Zt3MB+OGUfwLbyc4pwDN8VW
	nzAJbd4rqCl05j9Y82LC5O2CPOEx4G2BHUPyU9UHpuIrdOomMAVwhMAHRFHAnrI+9Ec=
X-Gm-Gg: AYBFou3tAErcE88Ajks193DPclUYDFOhdR+jJhd/ukcst9h32uMqQmRfRPe43NIoikF
	llGhuaX9EBUmHlk8Mkuehpxorp6Usu1noYeIJv/9/s3oyc5pYFByUgvnq96jRrnqkl0FXd8JWbj
	n/p5qRcRCuiHb8fQ8xG3Suz8x+f2VtZD3VsUEJHSCPr05RIt1wZ8hkVVbcQK3N0KWX32rxsN80U
	8tP9DuwowQZA1AuPck788dves73n64ysc5q3t0Rc71aQisoWacrSR+p9MURsnZm4d+vvnG0TiAI
	Y5fASdwTFUzEHfVgeDrEIsED3qXLzXjutne0IvAeTtI1B9e0suVkLYNZ0BIZZ8qED8WPj+XigVo
	v5+He01dJuHvKcBKw1wW621PwIkGPr/gktfWcHYJ07Bu1wPQoUuBwnXx/GY0veFaUBPQn/AneO+
	ExYMh6TeEMMx/lHARDclWFYDricH50NgJXsbEPztV7Bdp5dmkn2Pcj41WPRJL2U9upfR4/gW1RX
	MdgRdSoAQPE+RblV8paEaRi+liYxLzs2DL+IGVRZEpkvXd0oqdNMYX2IQGA
X-Received: by 2002:a5d:59c1:0:b0:48c:4d32:ccfd with SMTP id ffacd0b85a97d-48e0797ff49mr16398545f8f.6.1792402087710;
        Mon, 19 Oct 2026 02:28:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb0:c501:2c4e:44f:2449:8978? ([2a0a:ef40:eb0:c501:2c4e:44f:2449:8978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm23498338f8f.6.2026.10.19.02.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:28:07 -0700 (PDT)
Message-ID: <cb24bc10-aa0f-481f-80d7-71fddf1e428d@linaro.org>
Date: Mon, 19 Oct 2026 10:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ARM: ti81xx: Prevent USB being put into idle
To: Andreas Kemnade <andreas@kemnade.info>,
 Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>,
 Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
 <20261016-patch-ektor5-dm8168-dts-v1-1-b4ce30217028@linaro.org>
 <20261017085339.3533e9ab@kemnade.info>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261017085339.3533e9ab@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2026 07:53, Andreas Kemnade wrote:
> On Fri, 16 Oct 2026 16:41:16 +0200
> Ettore Chimenti <ettore.chimenti@linaro.org> wrote:
> 
>> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>>
>> There is an issue with USB being put into idle with DMA enabled and that
>> is mostly prevented with usbcore.autosuspend=-1 on the kernel command
>> line. Stop the ti,hwmod code from putting it into idle by setting the
>> appropriate flag. This stops the log entry 'clk:0058:0: failed to
>> disable' being generated.
>>
> So the module cannot be put into idle in certain conditions. Why do you
> disable idle under all circumstances and not e.g. adding some
> runtime_resume/suspend pair somewhere?
> 
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> index 9b5c728fb7da..2f55dc32e150 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>> @@ -650,6 +650,7 @@ static struct omap_hwmod dm816x_usbss_hwmod = {
>>   	.name		= "usb_otg_hs",
>>   	.clkdm_name	= "default_l3_slow_clkdm",
>>   	.main_clk	= "sysclk6_ck",
>> +	.flags		= HWMOD_NO_IDLE,
> 
> and why do we need this here and not in the ti-sysc node?
> 
> Regards,
> Andreas

Sorry for the noise, this can be dropped. It is not needed. It was a 
workaround for another problem that has since been fixed.

Andrew
