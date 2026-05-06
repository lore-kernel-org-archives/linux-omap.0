Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC8425CDF
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065186; cv=none; b=btMKKpqpdu7OnX1o93CgiOTH+c5DIsPGW28zY2Zar8ZGykE2bn6DAYc0caFWRL5hcGsmubY4mUGenk9+uQXV3obAsDHxLcCykCH69/nX8v85rrzoFA/P/Ey8JcyDwyfp3C3CxKDMB9Ea2p30zKw6KvcabUB6qqK1RYPlcb8NAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065186; c=relaxed/simple;
	bh=68tySyh4OCRbTeMjA4Q3ATFLu5St0nhIXSCwG3pciB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQe4C5qtEfg5yMMfy+/hvTOAR7hH7h1ASULU++2lE6EoS3kNWJCRhhLonvww51JLJE1TPRrG4p4hAq1mzmePQKEpMCtxzshOerhi2d37l2cpduWfTEYILtVLzp4dCRH1I8x61jaQvj2rP36ClvCkhI41Nb+grWcUVZqcmRitn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMd0gAT1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMd0gAT1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso68890725e9.0
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778065181; x=1778669981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7mCE4spOzGHm/dSut48qSV7WdMjsy0PphKRPfYRcpo=;
        b=sMd0gAT1FYcCxVNXtb8XsGV9ckUy6x97h2Lv0xJiBypiN5ziq8UjbBjLyajnZncwPC
         VMXrCDkeQrkM9WSpx9Cl8kna/3Qdy6+p+gKSnDPakoiiQVr69sTufEgU9oFFzlnkD14t
         1C414/SVfP/eX48S5w/hAqDsmWWrzLv/5ISmlI+M4mJ4yG2KRWUq/M0gDtG58kv3fiBK
         TsHmur2A4BXfkVT/gtFq25HwTsbYytZcr49xrAoI77hanqQpOLhIo8gWPXATTm0Soh6/
         XJT6RqereGEPgd/9GwjE+PY1eASpNDSq7G/F0uZwV8jjJ49gDkWR5v1leYvz1TWZmsP9
         PZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778065181; x=1778669981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7mCE4spOzGHm/dSut48qSV7WdMjsy0PphKRPfYRcpo=;
        b=eTh7WwOW1qrWIGdyB951iuA7nI2N4pWAQwHpe6mE6g//Vn16ZxStVqCRFcbC3S/rt/
         mttkb7H9+5QhM5MrE9s3awSJ8nzZWAm9L60qLnQ1g4jKC0LOXcLg9ABzh8oidUqcqbEt
         5VlItvxUPgIbJtFKVzbDWnL1+rXMcg8ITJRmqMhb9kMESjC3Zxj4f9ol7+ES5Z14CnIa
         ulL93DwVnnE61CUr4lKmXVtXFtTkAnKkLE+g8z7ZnnMaDWxp0bfD4MLDtAjjJssrVHK1
         a3Vkofij4kgsGpMzrBcQhSK95aqlqfSKOVtjbeSuEzd4vwZyaMOH04//iBoM0Y4wqqzO
         tUlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9eU2rFDljG0xrNb6jAyp7z9PR53EAglA2TeGMBAHosPo9S7hbiuGojfsqB/MvH0SKvlFaVesvQcnv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1txOPNyQYpsKAKGprbroPUuQL7uOqN9p7FPs5FuyCfn8oSsP
	UsXo4N0ITL3yG9yzGu7MazJqpm+bBh+Sg2FjnwNj+Tq8nQ8LBJkSsYLy
X-Gm-Gg: AeBDietL5fuxCWeTU/0LiMd0lEYINEkLkg0JX0P8VbvzcGqTHDATp7d6kJiKNbNWyN1
	vqHZUgWw1/uA7uVFVa1HsMT2gyKq7y4uC4YU3VY4Q0nTxH2H+/KPkRfIMdrZUoOvDLC1MXCDmXt
	f70ETr35ZXygV6Fr9rhpEHTAVcws1JVMi6iZmz8FQj4+MKKw6dDvrj5118lMyp3ij3qKnZ4OlP/
	wkLDALRnxNgXbOq1uYqdGlBi3Llaj4STWkmOoC/UvDYTn1WNkmVQoCzPLpLl49+sBfRNdNMBI3f
	v3POZMgxOv6IB3ejLDMdMN8yJWHWckT4R2VdsPIAw3q0DOXF4h6+WQkptBSFZwVe38cnc031FsY
	DGL7b8JBeq/bB5xzwe5o6gwvGADHNfq5N5AL9Nek2jFx5xjdyAvGpW136oK+IcddNQ4KTrsykmM
	HZcO/q/C2Lq/TWOG3EkbUmM931R1fv487BzU4Mrs79h7vg6g==
X-Received: by 2002:a05:600c:c094:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48e51dd89ffmr38486615e9.0.1778065181007;
        Wed, 06 May 2026 03:59:41 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e530d8691sm31468585e9.2.2026.05.06.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:59:40 -0700 (PDT)
Message-ID: <115479a5-3471-4f49-ac7f-48da5508ee70@gmail.com>
Date: Wed, 6 May 2026 13:59:38 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arch: arm: dts: cpcap-mapphone: Set VAUDIO
 regulator always-on
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-sound@vger.kernel.org
References: <20250122164129.807247-1-ivo.g.dimitrov.75@gmail.com>
 <20250122164129.807247-2-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250122164129.807247-2-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

It looks like this patch from the series may have been missed. Could you 
please take another look and consider merging it?

Thanks!


On 22.01.25 г. 18:41 ч., Ivaylo Dimitrov wrote:
> VAUDIO regulator is used by cpcap codec and currently is enabled/disabled
> by dapm logic, however, when regulator is turned off, various cpcap
> functions (like jack detection) do not work.
> 
> Configure VAUDIO regulator-allowed-modes property while at it to enable
> low-power regulator mode being set.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> index ea02fd403a9b..83fd58157579 100644
> --- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> @@ -267,6 +267,8 @@ vaudio: VAUDIO {
>   		regulator-min-microvolt = <2775000>;
>   		regulator-max-microvolt = <2775000>;
>   		regulator-enable-ramp-delay = <1000>;
> -		regulator-initial-mode = <0x00>; /* NORMAL */
> +		regulator-allowed-modes = <0x00>, <0x40>; /* ON, LOW_PWR */
> +		regulator-initial-mode = <0x00>; /* ON */
> +		regulator-always-on;
>   	};
>   };
