Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D9272E61
	for <linux-omap@vger.kernel.org>; Fri,  3 Apr 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227334; cv=none; b=NToUG85KrWAxtW5CbsegHuot5AVSoPYP0x+/JVDVJummfw/sigDPmaMdawCD8dDxvoTIHF1yF8ZDLJ1ICOxt0D0wDd3YSKMWoMpk/Zk+ucDTtZm5JW1WxVC6ezcjfWOuNwvwi8sncthZlAjeyPbz4kYqis/tJnBY6oWV4qi2x20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227334; c=relaxed/simple;
	bh=3vVkIcNYIIdq5Dkb4dWOz1OUuravUKeK17twdeeJ21g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9IOGB9mm9az2sLMqynD7QlZtsFn24EQEnToVtBHKiDQRTz7Y0c9W9hOcwqaWyaq/euylc3hEmOL2qUeAheRhQf0s+LPKuqc881Y24iWW2JWiFVH7Ec68isiuwBIqke5s7UXhhFZg4/48HT8lyfkTXVbbrjRk5sy4xFQVLRiCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=OrdMA92W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="OrdMA92W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso19899155e9.2
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775227331; x=1775832131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWTR6rblr2fx5wm1rQ9MFyWeL459JHJEvbHasb5FYls=;
        b=OrdMA92Whdc4h/UpXzNfoRN2hywQJKhrLrECsCzJ+ROaAaNAAqizS7imk8S0Kd0bch
         1qKteftT5zcnYQN/BjsTvgGuWVaNrFpHja3qjbzQIEu5zsMbqCLeXYA58/JREdjO8oW5
         kVBv1z6V3nbsnj5RurqMUlI3lyyhk6Yvd89hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227331; x=1775832131;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWTR6rblr2fx5wm1rQ9MFyWeL459JHJEvbHasb5FYls=;
        b=Dre0Z8V5xNy8S++cF/JACrxezUTFmW9VicZ6toBa/QVMaIHurocEQuOdwDb/tqJAOu
         DSvZb/XYX9K6rZbU42Dwvj+ZVklNd77Zg/sRZ7zIeh+cgqLTuOyWqFBhUdzALTOM/cha
         /u5Za6gy3y+6OmFGs5r/xx9vIhbwCneXVz90QnPF6UCVUHZglWTnuZyRe3hEx+BGv1r3
         RHhdsEWpQ4VMkFfn/fbCgxo+xvnmooa/ZsWT3woastC5oloFiBjxu0iWCg7U2QkXJRZ3
         m0srUi852wWVTX7WNRIl//h9yiP9wUyzFhyCEP9PhZJTUQp2MNosajdvGR27i4QPldTe
         kVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXuwiYDdhMraITmP5N3p6MIzsDZAtbXBUYYXVauqV2lQkcA3BsMP6D+7x9kDFzUolD3jdkNEADfICL+@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwsvlVo3kIUto2naV+RY4he9yU8Fk+mT6uHaoLvPn/pKafIos
	KkqzGdlK7z5MdLpu5yvJWX38mojtkLoS332wqjwKQTP2F4wR4Fmmubb+2+g/kbOP/sU=
X-Gm-Gg: ATEYQzxQrWQXqcRqJRn0AHXgEPEoeNcfrw4qb6P97tgWCD4DUh654yJriMMMsPy/9vP
	GAKyr4ki172JVVHS6uhWa5CbvAwpEkh7SpP5+o5QDHzTWdvrAnPfD64pkIaMl7qNQCCA4MzYj0V
	NIawKSHGoi38BLixKCLm+RS++FRCrDV9EKqbLKyVsG1mDTcZutjmYrqGSIjfOM/Hu1PydiG6EDO
	vRXNXYOqu5FjMJUsvLn5EGlbE2dwLz14TbhL1+TpMr4bwgJWGhW009aAJ1P8OtQeq4890CpBDEb
	eAK7hPUNzDgEvS8p/rKwQfaXoLMRrfzCxMVT56qvTqKdT10vUhS32i9A3uw//uNqPILM4TNLRen
	8NoxTDDDvKRG3+4qFqldBEnD7dsbSRYs8VAxz8X0NmOC0dOuDRM7uIFeRKYmElSXKAwPJMczfMr
	nUy/6Or7uYDn3FvWswc3vAXSbOaZojP+tq3qCwsMDO6tWP/7A0V9UQmF+Osb8Ep5ixa/UcFx237
	K1jbPABNrybDMr0Q/pFaXRzx/DoTyuSwmGxTkyK2txY7beOgw3fGvJSka8gabCxqg==
X-Received: by 2002:a05:600c:4e14:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-488996afed9mr53212995e9.5.1775227330527;
        Fri, 03 Apr 2026 07:42:10 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:94a2:a200:2ad9:827a:59cb:148a? (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm45021385e9.4.2026.04.03.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 07:42:10 -0700 (PDT)
Message-ID: <5725f03b-2750-428f-ae66-5f1a24dd0714@smile.fr>
Date: Fri, 3 Apr 2026 16:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values
 for MMC1/2 subsystems
To: Moteen Shah <m-shah@ti.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 kristo@kernel.org, vigneshr@ti.com, nm@ti.com, stable@vger.kernel.org
References: <20260218203823.1825554-1-romain.naour@smile.fr>
 <8d4a2839-5b1e-479e-a462-dbbc3d016020@ti.com>
From: Romain Naour <romain.naour@smile.fr>
Content-Language: fr, en-US
In-Reply-To: <8d4a2839-5b1e-479e-a462-dbbc3d016020@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Moteen, All,

Le 31/03/2026 à 14:19, Moteen Shah a écrit :
> Hey Romain,
> 
> Thanks for the patch
> 
> On 19/02/26 02:08, Romain Naour wrote:
>> The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
>> value to 0 for MMC1 and MMC2 interfaces. These values were updated in
>> kernel 6.5. As a result we have some occasional regression with ultra
>> high speed DDR50 SDXC cards while mounting the rootfs:
> 
> This error shouldn't be limited to just DDR50, were you seeing similar behavior
> with other speed modes?

I have a followup patch to enable back the SDR104 support with j721e SoC (SR 1.1
and 2.0) and I noticed the same behavior with some "specific" SDcards.

The J721e SR 1.0 doesn't support SDR104 due to an errata.
Nowadays, even the TI J721e EVM board revA (reference board) uses a SR1.1 SoC.

See the post on TI forum with further analysis:

https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1626659/dra829j-q1-mmcsd-ultra-high-speed-uhs-modes-issues

It turnout that the kernel is not able to detect UHS speed with some SDcards
vendors after uboot initialized them with UHS speed (SDR104). I'm not sure why.

Still, the datasheet was updated with a new set of timing values for HS and
legacy speed.

Maybe I should remove the part about SD card initialization issues, it may be
related to another issue.

>>
>>    mmc1: error -110 whilst initialising SD card
>>
>> A similar issue may occur with u-boot after a reboot while
>> initialising the SD card:
>>
>>    mmc_init: -110, time 67
>>
>> Update the delay values for legacy and high speed modes, based on
>> the latest revised datasheet SPRSP36K released in April 2024 [1].
>>
>>    (MMC1/2 - SD/SDIO Interface): Updated/Changed the
>>    "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
>>    Default Speed and High Speed modes from "0x0" to "0x1"
>>
>> [1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
>> https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
>> (SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)
>>
>> Cc: stable@vger.kernel.org # 6.5+
>> Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select
>> values for MMC subsystems")
>> Signed-off-by: Romain Naour <romain.naour@smile.fr>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/
>> ti/k3-j721e-main.dtsi
>> index d5fd30a01032..418e6010ef1f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
>>           clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
>>           assigned-clocks = <&k3_clks 92 0>;
>>           assigned-clock-parents = <&k3_clks 92 1>;
>> -        ti,otap-del-sel-legacy = <0x0>;
>> -        ti,otap-del-sel-sd-hs = <0x0>;
>> +        ti,otap-del-sel-legacy = <0x1>;
>> +        ti,otap-del-sel-sd-hs = <0x1>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>>           ti,otap-del-sel-sdr25 = <0xf>;
>>           ti,otap-del-sel-sdr50 = <0xc>;
>> @@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
>>           clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
>>           assigned-clocks = <&k3_clks 93 0>;
>>           assigned-clock-parents = <&k3_clks 93 1>;
>> -        ti,otap-del-sel-legacy = <0x0>;
>> -        ti,otap-del-sel-sd-hs = <0x0>;
>> +        ti,otap-del-sel-legacy = <0x1>;
>> +        ti,otap-del-sel-sd-hs = <0x1>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>>           ti,otap-del-sel-sdr25 = <0xf>;
>>           ti,otap-del-sel-sdr50 = <0xc>;
> 
> 
> Reviewed-by: Moteen Shah <m-shah@ti.com>

Thanks!

Best regards,
Romain

> 
> Regards,
> Moteen
> 

