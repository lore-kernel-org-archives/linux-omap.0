Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0254A3F1F
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147556; cv=none; b=J8ut3y8pS4LaCdlQfYmf/lSPjfYb5nBJsBE9xQkFGgyWr4nukyjrqL4VCL0lO8gA6Ji5vr13woZ+5Oo0qXm/yFp5VOAQswINz34T1p0g/Qyzumufsdnb0O7bTHLaayMPdFvGyIzoQpzkmggkwdKiNkJIsx1kUTsPscxL2nc/hX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147556; c=relaxed/simple;
	bh=EIna21TClEpTv6sU11YFri+uCAOmnbQs4gkq3+Yi4uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmG40/b++W6peZhU+0RTdPjgqLhAbKzmf+R+B8dNQ5wb9rgDES3itKeXMvf8TFnd3mGu2a2SneExAI5sfJ6aFc0jVqbV3SD7NgiN1YKg+UIlsXguYjY6RTlMACX0qPaRnRmLzGtv/bleY4Y1scX9euSAVgBMH2xfgJwCOY9iDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVuD1rzr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVuD1rzr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1204258a91.3
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789147554; x=1789752354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkBe7WUuSrDM7uq5LTSTLslXHOwqfZgVboPet1pdmR0=;
        b=rVuD1rzrF+L8OWjaL7LkT5Kbon4EXXtCngg6PjNFzEAUqBojaiegJ4ZEumKh4as7nn
         5h2eQ7E+uVWctPtSEUYKz0WMFxmDLm55Uco2n9BE6fq9eB7ar0RFqb2WvkSmS6dkhlkX
         l+hutYB7VcQeOqDXA6Uuq0Ux/Zy4NtlYGWNstnkvFjkrRuA8A0qFAF0JQR8QkaaaVRDY
         loRJaRSeKX5y6eSn0aKh9FTq/ODLZnwZ9OHapLAxGYIyAdqhgZGlsg9z98OTkPPGS5xc
         Sd/FrUx0Yaga9yBhhhVW2oF6zupcsxMQ1MyJGkKmoz8caIaqJQ1h+DsGpMqeWBFyAXKA
         2c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147554; x=1789752354;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZkBe7WUuSrDM7uq5LTSTLslXHOwqfZgVboPet1pdmR0=;
        b=ig3XRJWa1Bmay9qN8UBkjLNhbnsTNxvrRk+EDckfqlGwVUer2YgdoWNMAeyxSWQZl1
         Wmt2CyC4DALtosHZJzijY66LRx3rc2CkMdp7p0fJV8mw0uRac7w9UYtfshOfZAwrDTQA
         Px7cKTFGcgkeUfFk24a32cvAxhKezp2LoBsugp2nHF5Jlmj4mMXQTfOmfEaYSqpWqk2L
         01Kr9vnDd0HecVSVwXaYjfXr9tCfMSXsZvVTB8KYxiOmTqQyPwhFjA3W35McIX1sjPNE
         WqIuB3ivO5Jc158aaVo5zCvbYqLGFH/SNgFIfSZ9T4/MGJSi+kcttfLSTahOfDo+6VMC
         63qQ==
X-Forwarded-Encrypted: i=1; AKwUvBwATOqCiAhCLEhvOahOyEiNpXPmZn2IsluuWq+7u9WRZsyvQ+wARRtUnGwRT8TZNsuTrmA3ViEgclz1@vger.kernel.org
X-Gm-Message-State: AFuF++lxr15nsKD9x/j6OmyCfBZME0vNMizbuovBu7cdxNu97dbkrDwL
	rlSNcBCzJ8I0AkX+PDWEkGnDXCMPXZZ2S+qZ7vWq67/GZe+fGPDOqPIK
X-Gm-Gg: AYBFou35Wvu5Dc13f8J+ptWPv1V+c0/JR4FFwlysXLMESuPBGrrZWYEWL497Mow2qbo
	EpFz7Blp7mvml8/ZFWaNoehI8H+yoLN+jpAMeEPoO42mazh7DkyGRM/czE+fJpJB5MyPNdwJ5/Q
	ivioFkg0DHp4biq9ERTKWkaUPRMm1FBTrYzDuN7tj8VyMUQXPK2S/PtC8bFdzYKE6Yt+4K8Qsvi
	dbnFL8wwEfY6d0vgVsAes0m32ud+NRPmDdaNVQr8+ZxwcP1HKtEdZfcqFXOZaQovhPb1hBp2kSO
	OuH0W0hikJYtO1FaDCKNOdSO0yajUSGaZG8URs5/0KzE+GiG/Qt7jh9/lbLp6hG3Lv/mTvRUTBt
	S8Bfz2pW1QlYM0VoCtW3WNqd1iOZFHrwxAZTjX+rAjZO9hYWN2W4h2858RIfO0yw3WXQ8RF5UCP
	CSQVy5gRMpEq1r+U7S2yv6Z8N8sso+vK5M76JbQvPFmfss6oAio9Ctd2Ul7W+ZOwEF0mL9AJlU6
	RQMvHWAkqALlRuuaiuZkvk/icP6MR288SdYFJz2z5U/vTXB
X-Received: by 2002:a17:90b:278c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39d9c1b4d9amr9025809a91.12.1789147554299;
        Fri, 11 Sep 2026 10:25:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf015csm8838529eec.4.2026.09.11.10.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:25:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1adea74-8f87-4442-aa12-18536cabec3c@roeck-us.net>
Date: Fri, 11 Sep 2026 10:25:51 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] watchdog: omap: Preserve OMAP watchdog across boot to
 detect faulty boots
To: Diogo Ivo <diogo.ivo@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <407b9420-0ec6-4d95-960b-633677edf760@roeck-us.net>
 <14eb1c72-fab0-445a-82f2-5851a855f723@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <14eb1c72-fab0-445a-82f2-5851a855f723@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 08:17, Diogo Ivo wrote:
> Hi Guenter,
> 
> On 9/11/26 4:29 PM, Guenter Roeck wrote:
>> On 9/11/26 02:17, Diogo Ivo wrote:
>>> Allow the OMAP watchdog to survive being stopped on kernel initialization
>>> so it can detect a faulty boot in cases where the bootloader leaves it
>>> running and the watchdog driver picks it up during kernel init.
>>>
>>> - Patch 1 removes a duplicate omap_wdt_start() call left behind by
>>> cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling"). This is
>>> unrelated to the main goal of the series and can be picked up
>>> independently.
>>>
>>> - Patch 2 adds support for reading the watchdog boot status. Probe now
>>> checks whether the watchdog is already running and takes it over instead
>>> of blindly stopping it based on early_enable alone. This introduces a
>>> regression possibility, explained in detail in the patch's message.
>>>
>>> - Patch 3 marks the OMAP4 watchdog node ti,no-reset-on-init so the
>>> ti-sysc driver stops resetting it. A detailed explaination of why is
>>> also provided in the commit message of the patch.
>>>
>>> This series has been tested on a platform based on the VAR-SOM-OM44 from
>>> Variscite, running a TI OMAP4460 SoC.
>>>
>> Please address the issues reported by Sashiko, or explain why they don't apply.
> 
> I have just replied to the Sashiko reviews but I'm not sure if you got
> the replies as Sashiko did not include your e-mail in its review. If you
> did not receive them please let me know and I can resend them. In
> any case if you could give your opinion on the comments I left on the
> patches about regressions that would be great as I think after the
> Sashiko points are addressed that is the main blocker for this series.
> 
I did. I just wonder if the effort is worth the pain / cost.

Is there an actual use case ? Is the problem you are trying to solve
a real problem, or a theoretic one ? For example, the patches impose
a hard boot delay of more than 30 ms in omap_wdt_is_running().
Even though that could be optimized (there is no reason to wait
that long; the value could change a microsecond after the first read),
it is nevertheless a mandatory boot delay.

Another concern is the impact and potential side effects of setting
ti,no-reset-on-init (and the possible boot loop cause by it due to the odd
30-second init delay). After this change, a running watchdog is no longer
stopped. What happens on systems which do not load the watchdog at all
(for example because the driver was not configured) ? Will that also cause
a boot loop on such systems ?

This is just a couple of problems introduced by this series. You better have
a very good reason for it to warrant having to deal with the potential fallout.

Thanks,
Guenter

