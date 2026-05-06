Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F633EB81E
	for <linux-omap@vger.kernel.org>; Wed,  6 May 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065639; cv=none; b=AiQgxyrnlSHHWkFlqhMK0YvMS6W5tTfafUq5VS/+ascPGIFZSp4ZU4U3mewpau0kdGLwNWEFJGsktHPoCFFeGmZXzCpmPAPTrwgYPzveaxbw3oUTYrWvKlzVZ27RxyzQCv/k6sOiS+u+Z2KZOTZFEnNWJnOfZmvC7pk40BnsQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065639; c=relaxed/simple;
	bh=VE2loX7GEHkLBIkfThKrvN6f+NIyZbdVKwUIZSotPoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cngmoiFpNG35tEN2dx1E60U/xU/0MDODdugNJniz0HaGywAiECEsRwfoyW2ewoLUK5aAIbCNHevI65Hc+7XK0AOLddnxLyZB5TLPMeShCnqcy2eOb46Oij37UkHcaeXkNAM+sPX1E53rBWh0sO11x1syt1oY3ea0kUlq4RMRC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyEvSjlJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyEvSjlJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8704dc3a8so3496597e87.3
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2026 04:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778065635; x=1778670435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSXiRsYq+8taqfodn6O3tOJPun5BIE/c43g1ysDqCow=;
        b=jyEvSjlJre2yiqI/y4H+nmHEwcqNWsZD8J9bzWDM+Cf5oJCuMg/FzlrwdjrFFO9ii5
         UJbxyK4LZ0SbHkNzipLdKBoaxdIMdt+6SC1RyGiOMsCNO0sAZpPBsgyTt4H5dPUrwCtD
         J4zBIAzusHpgp3hgFXkxma3Yy5Fcd3fL79pZxLkUjsYgQ8kzPGsoP/B8dtu6V7G378OH
         XcKAnZNmJ5XyjAKkuNCHCrDf/mPr36ONlA0rVvFfn+LnvYLupSe/E6K38fK8lQnro4ZR
         xKrmSBCxYSlpKvRLGUBMqFEymYaEf3Gwmva2sfteRAKY0lz6qYYClB4piASTMgWDEcN3
         I7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778065635; x=1778670435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSXiRsYq+8taqfodn6O3tOJPun5BIE/c43g1ysDqCow=;
        b=ETC+awRi0bmMKBwVzq3C3xGYNGeWgluNghe+Ly6UESyWp7mjkgyuRmt4ElXZF0rXYx
         gPBF0t8JgeGkIx9czj6hLAMvo8LV8226sClV4BuOZfPinuZR2RPsx5OQb3CyYdwPtiKo
         B9fTzL55NE6T3PfvpA8Em9y1F7o/CD5fILPHetK8blV9eAjb2kENtKWfZgobUrc2PCIJ
         YPIZQO3zGdu/qycTngfQrCK3jILCbwe1Si5HSc94pEYiMSGfRjZcOfvPP4fkeu7ah1pg
         UAVjALKOzUBmXNOm15Sn8E/FHgGXsQpGXvEXunz3LBd1YE5iPCMvJcKwP9oPGokMbwY8
         FTQg==
X-Forwarded-Encrypted: i=1; AFNElJ/8Kfa77mkbWTEJ0gMkYa8Y9sw4mJ5VmGaGSEQWJycQhoOHSaYclt686vpVO3ezoX8ENB93QGIKEOXV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tA5l9RtxKQWa8pOgCsVGR+3tOm09aB09mMKuCn8S6Uz4hKMi
	WVlnxuSXGQD13rIASR52Xw1FsIjYA0hfhNEWyudbopT14QMpEMBujIlC
X-Gm-Gg: AeBDiesc8Iw2Xh1qsJaT4e/7PHdfvZxUbmC1b6L2Qm3NDCqU2Q8fvgI8+7VS2+yDu3s
	2eTLyZreGlf/7PRma2WfCarQm9htRLZl5fGeepyRUoYwXAzMvDNV05MTsdk67eXiXTE71AbY5eY
	Wyq+WWY31bT6BbSzHD98DIlrxmrpgIuxA5WAjeNcRwRxqcPcsizaE3NpFcSlGC4OaB+AwRT1ML9
	MUX/ytjMnp8hNeaN2f/ND9m/k1j2KkFwawhEwvqhxZ+iVDIV4XXsjkJPbkAl+4WTEwr93+S4VNW
	90IBblmfMeLFQ8yDBGtYvJsJ4IcZoVD3yapwj6kffj7UOyoR8OUB0KNes4yAvj2NrDWl4MkH3P+
	Cw4fl6qDw7At085wFXxyg4fQranGcaU/zCZ82iIUgvxkKqSF/hiTlhcbK2HtnUNxwx9jrIRw5g1
	syPlcWARLg9cBDMUSN08ZrPHffKkUUnQZwbVtDi4KTHwaCWTlPzBr747s6
X-Received: by 2002:a05:6512:692:b0:5a8:707f:904 with SMTP id 2adb3069b0e04-5a887a9a8abmr1144133e87.0.1778065634368;
        Wed, 06 May 2026 04:07:14 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5a8616598c0sm4343635e87.83.2026.05.06.04.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 04:07:14 -0700 (PDT)
Message-ID: <5a3615d6-e203-4728-b062-4dc827d370df@gmail.com>
Date: Wed, 6 May 2026 14:07:12 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arch: arm: dts: cpcap-mapphone: Add audio-codec
 jack detection interrupts
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-sound@vger.kernel.org
References: <20250122164129.807247-1-ivo.g.dimitrov.75@gmail.com>
 <20250122164129.807247-5-ivo.g.dimitrov.75@gmail.com>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250122164129.807247-5-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

It looks like this patch from the series may have been missed as well. 
Could you please take another look and consider merging it?

Thanks!

On 22.01.25 г. 18:41 ч., Ivaylo Dimitrov wrote:
> cpcap audio-codec supports headset/micrphone detect interrupts, configure
> them.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> index 83fd58157579..73e27b95105e 100644
> --- a/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi
> @@ -69,6 +69,8 @@ cpcap_regulators: regulators {
>   
>   		cpcap_audio: audio-codec {
>   			#sound-dai-cells = <1>;
> +			interrupts-extended = <&cpcap 9 0>, <&cpcap 10 0>;
> +			interrupt-names = "hs", "mb2";
>   
>   			port@0 {
>   				cpcap_audio_codec0: endpoint {
