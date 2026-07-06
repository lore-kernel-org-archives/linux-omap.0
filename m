Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C6420E78
	for <linux-omap@vger.kernel.org>; Mon,  6 Jul 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373164; cv=none; b=riM7yh3aoIJQZefMBnu5X5ZXn4LE3VCsau0XUbTIdDWM/csoocc4N6oAALr7lEEy/3VHmJfzlE3xMssPKe3SMJWtxaBAfGDjTEPNWH3YvVXyrlIbXxfq/iIxN5EbnbR6mEtVR7Dwxbj1KQaxeZj09xz3pK+RPrn7EnG0pgvuULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373164; c=relaxed/simple;
	bh=GHu8E+ZzIjl1pCy9QBxel1fS5I4F/Qa4IkmUrQYcut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYUr6WtIBI8XGDbQy/AWE/Up7/XZMfPNyJjPCmzPJp9hFNsbS1/bOFKzL5hnh48ZT/kTRJkw/f1M32q3KXxfMlf/46aU7a0GjuOYL+perEeqzGBaJrCELczRx+evHMHodIWErVmaBR+bVGMtpyWy/e+Myagi/6mLQL783hsX9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r017DZ2y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r017DZ2y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c83474ddso31282535e9.3
        for <linux-omap@vger.kernel.org>; Mon, 06 Jul 2026 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783373162; x=1783977962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihP68MSIVTxfpMWP1SL0q+2pdJ2V1J6RQAuUgDHhRvQ=;
        b=r017DZ2y+ltqd6XNJksy7oeelsuhCj80XVAzVCweQtH04ubhbpawn9W3jgTJnJaDOG
         NV6qtsLtB58SVVjHIqrdA3SlRn1yakUCPEj6MrUMLS+lSIsOxUM281NYOzHuG9vRh+Ao
         EIWsWlE5kLwdjVcA6le3Zc3tXQnVgjRW8tsjR0yCfXaWscd59BmyPJbPOtWHLorzgqkE
         B599hS+4Gk4Io0jYLyR7e1x/jFt+a9U3lWuo5biaddnUzlNBHHVzfTZMVZfprle38qyp
         ZlQLDtVCb4u0mDi9K9drLpI6qliiP3mj2yv5NAdkOAQsNzM3LU1j/NttTxTEQrhnSYA8
         ZfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373162; x=1783977962;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihP68MSIVTxfpMWP1SL0q+2pdJ2V1J6RQAuUgDHhRvQ=;
        b=G1gGfbUDBNWeAGPAUykqyTA4RFr8onJGoJIu74d+9AvHH/X+WHred0x9CZYWsYGM+L
         ZVFx6L4yt+B0YiPp6qTr6C1NP4uWP5ZId+LisIn4oZGjPbBCS3JnOqMpDf3o0Bmooym8
         OQEbaVGDAJUp861hr5WB28+o9SNh4a1Npa9o5HU5XnmBrQlbR4gOR78XIXI/oesx2E1X
         TWGXEDM0pZaNJpM8Rq7QenJ7w6ECn5NGiSNTGvlH9CR1na7zXmNecTTPtNSXK3CPCtKJ
         AHuj7WGH7yFG5itTK1ohn2nHVdAsYtfeFFgbozzw3E4lzR7iUvqdpmPt7ESIamAEcBFF
         I2RQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkWp3lFGLaEdf4fu3dnSqhqAmG7VFzobe2enJh02VtpcmUbtlwUPn35P+3tFFULys0v0YX0OlHi36K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9D2+CdaRgjpXxHcjupjYl+xCOU8LKZ/TEh2u2OBbUQ0eHmrD
	rCiwERdX5sBuwSMBKJnLkFmr87FBbiYZ2PtF9TqtjJL3b2ex8Xha7odi
X-Gm-Gg: AfdE7cmgJ+ZJ3U1rBJruWfGa+hD0aM1klmeOc3Jvh9IGPIX+aD/h535M5mZhO1wnex9
	USkL9nTaa3Tz6HoCxOJESQLLVZCRT0zmmSNlJxQmlok9BvyeRHrKDgNzmz0RDTBwCb9kROfOMa9
	DZbrJq8EJ5C9iOmTV575GC8xR0YByOe/oVb8HRXs4kkl3iqyu1kDJXcp3HLNJrKgpDXQ9a+9bl+
	vRKrIeiFQ+zYRKwxQ5JOFQKdl5ihgKvaEJVsVrhVfxpWZ/iZNCj5epwdHRgXpFZzeiApXPeZSBY
	zb+MoWSVcAeOHGdyMmn0IND18AtYAaaeO5x3oLyiUjI9+yn2yiGwTzTkgZqjiorVF8C8n/J1ZR/
	oHCmSHM0ds2s7r1WC6ASGgtwW4CfLUSpI83LAwKbGBfoMChgR1uLwruASU6kJJZSV0iWl1/7ig9
	wk+wEF/QKLfS0uo3fuDSNPKCDa
X-Received: by 2002:a05:600c:1d0c:b0:493:bed9:b53d with SMTP id 5b1f17b1804b1-493df09b330mr24203455e9.31.1783373161558;
        Mon, 06 Jul 2026 14:26:01 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493e01c8159sm12334715e9.1.2026.07.06.14.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 14:26:01 -0700 (PDT)
Message-ID: <2b192691-54d8-4449-a18c-b87266c6c73c@gmail.com>
Date: Tue, 7 Jul 2026 00:25:58 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: phy: motorola,cpcap-usb: add chrg_det
 interrupt
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260705101105.1798069-1-ivo.g.dimitrov.75@gmail.com>
 <20260705101105.1798069-2-ivo.g.dimitrov.75@gmail.com>
 <20260706-visitor-calorie-b805ac5af970@spud>
Content-Language: en-GB
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20260706-visitor-calorie-b805ac5af970@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 6.07.26 г. 20:14 ч., Conor Dooley wrote:
> On Sun, Jul 05, 2026 at 01:11:02PM +0300, Ivaylo Dimitrov wrote:
>> The CPCAP USB PHY driver uses the CPCAP charger detection interrupt
>> for DCP detection.
> 
> This is not currently true, the driver does not look for this interrupt
> at the time of this patch.
> 

Right, this is bad wording caused by the fact that initially the driver 
patch came before the binding patch.

>> Update the binding and example DTS to use the corresponding
>> "chrg_det" interrupt name.
> 
> Sounds to me like this new interrupt is optional, since until now it has
> not been needed? The patch however makes it mandatory. I think your
> driver patch also makes it mandatory, which will break older
> devicetrees.
> 

Oh, it is indeed not needed for proper DCP/SDP detection, after some 
experiments I was able to teach the driver to do proper detection by 
using current interrupts only.

> What makes this ABI break okay?
> 

Will send new series with schema/DT patches dropped.

Thanks and regards,
Ivo

> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   .../devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml     | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
>> index 0febd04a61f4..523a8f8480d0 100644
>> --- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
>> @@ -30,6 +30,7 @@ properties:
>>         - description: se1 interrupt
>>         - description: dm interrupt
>>         - description: dp interrupt
>> +      - description: charger detection interrupt
>>   
>>     interrupt-names:
>>       description: Interrupt names
>> @@ -43,6 +44,7 @@ properties:
>>         - const: se1
>>         - const: dm
>>         - const: dp
>> +      - const: chrg_det
>>   
>>     io-channels:
>>       description: IIO ADC channels used by the USB PHY
>> @@ -91,10 +93,10 @@ examples:
>>           interrupts-extended = <
>>               &cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
>>               &cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
>> -            &cpcap 48 1
>> +            &cpcap 48 1 &cpcap 13 0
>>           >;
>>           interrupt-names = "id_ground", "id_float", "se0conn", "vbusvld",
>> -                          "sessvld", "sessend", "se1", "dm", "dp";
>> +                          "sessvld", "sessend", "se1", "dm", "dp", "chrg_det";
>>           io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
>>           io-channel-names = "vbus", "id";
>>           vusb-supply = <&vusb>;
>> -- 
>> 2.39.5
>>
