Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507174;
	b=06kFVIkAFyt3w82pGBMCZRqeWUh01ZZrJAFdGFUz169r4ihkeTRxqsfxRx9xG32yKRSi
	 +Wqidq6RhfaeUh8Zh87gbKIkt0Nk2yZiCQ449ETd6Uk/SD8WebngMneDys3evS9elwE06
	 409CVwJFZW8Iq2dJSpi67obkJHjcFAR0WT2HtqOS8NRqQ8RF1MbcoMMjMedcPE279G6Zo
	 ROHyp31M8x7OZ87hQideXfp/qHSUI4l0ro9jkhO6b3sZ2Do90HzpMXQTD7prsLef9hJWt
	 cJR/aL99VL0a7FxHDaQVBaoBqvCGW38Af8SnEgcsAL77l6VZDbGZGS+GaIVbI1S5uxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tvPvYGksmHTWeqyNsQWxBvyC/kcPNDGmR79WDiO9WKY=;
	b=RBlvE/narwMkQDvPeQSaAy5B7I4qP8envJyFahIRfP9C3jJoDHIA9aujIBRhPmkogvuK
	 mK252V56vLsNM4191xr+kDUxdu00VS6VZcPmOynSFL5IstyLqpgR1qiWM0S04FZI/bFb6
	 EEZ10HRBqdS0RtlNcnfirLuxdsv/QKsDjuUXXovJBoIddDvaLwehnyZnPV7cCFHiE3uqR
	 t29l+wAXXFk9zum3ovdWp++/A9fmUywfJTkLo0ps7Zb3Rhup5uuVlO2yeR5FSumrz8hph
	 ia65KgJ6jFvBeezA0UpqwOqAVDYNB/Wa3/x/rieF7aSTXvQg6kUx2iWd01xM/Z87X4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LnA3trdc;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D0606A327
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 18:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5D0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LnA3trdc
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso18657f8f.2
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2026 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794507173; x=1795111973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvPvYGksmHTWeqyNsQWxBvyC/kcPNDGmR79WDiO9WKY=;
        b=LnA3trdcVWMwTnKTLbaOHOhAqd2KqrmCC1w9umS0vVBTxUNFAnMiZDPubBbugO2S0v
         4VnrccP83ARKl0BwyWLu7FEyQ8RDPoe9yzjHqlo5sYIYg2iXigBfYbvEobN89R83NqFs
         OvbbwXh0drfouYC0K+4L+euiT/09A1sDrNVCeFpFclI6f7Sj0G7WidM7EKN7Wm7XP8oz
         FajxuqViOs2dYpLd2gzh63PvShJ14pIw4TbmJ3TMDIxFvIXLa97aw1fQQQrdj+4bQa3s
         6Fg6pYv2E0fcO7xMtDOt+wIIsLMKiiPtXI3TeihSIIkZ4QqmA1MbSMro6WoWhdeJTX4n
         sUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507173; x=1795111973;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvPvYGksmHTWeqyNsQWxBvyC/kcPNDGmR79WDiO9WKY=;
        b=IqoEDoaq8cyiFqNKx3SWXqSaQTc5AQtrxq4fJca9Th7tpIlBqZLEtHBlM2iBblc2uN
         g6cMIjPTRJHVoVbJ56R4BNbAvzlH6OIC2IeYE5FXJ0Enu0A1H5PrLXr0vZsd8tlyZhYP
         pdOuV0N0A54bMjeZCnu+Ry+WJZpq4E3Meu0S4VXiWQPzhU7olMpVAwFfLXjJ7YzWO7pc
         Uz60LI0za6l+DSJ25sNpqjMxZ90sve3uxsGbCxL0/cWs0x+aadPzoqyiWGf+TAQx7q1F
         HHXhDrdweSSnnjqNvcrUX9uKlNC/IMBpEA6sW1O4v1CBp+C5FIuKOma4c82xEvHZlQx9
         bl3w==
X-Forwarded-Encrypted: i=1; AL+hErFJtYHBkduhqKO4OLHSxeoYbQIWA0+/FKG4qT0JGqmbxRfBcpw083uGfmwAJfOMLueaG+JHHkbOf2kA@vger.kernel.org
X-Gm-Message-State: APuU4Z8q+VbERGfFYKd0edSyS9TEJt0hGi9b5jCIEP4FXj5D5j6jNYNH
	N06KhT0at2KtFiUF5UqbXKlnezUExIpg30TAiz/r6BcV4qWWSClvPfh634LPQNFxtzg=
X-Gm-Gg: AYBFou0+a0LxtM8eUSskMTsglPZrPMEzE5tcYnweja8rN5pF2D69pqwREw0DsU2OSWI
	KMAo6rNhZyO8bVtYFDR3Pwa5CGinAZRa8oXZzxD0VlfcySpnjRtntQVvjGAB7JWivAMie7j8XCO
	nTsxXH/RB4P0v/EBytNsHa0hlIJD8ncA/fR2S2XOePj5zWsUS5abD1YAeZNZXdGWPkXMwc5gUY5
	vzhStDNpYyQ0wnFELc5AWCwQYknWtfCBUnQltO1ml0+sCHkj+uS7yT4/FJqinbXuKORm8IFc5kv
	VB7MFcr5LFUxtbVKz/Xy5Y+RAKtZuJRtywWNBXaXNIg0nso614Ew7E1qMDbuYO7H2Fh2vQeROU0
	blSZs/tmiXAKU9xWsj8B3MItJbLl3z50t7RUXuBs9v4yTnM4A3wf5xaiVRLLqBwYj40O4xVVnJw
	3Iy+Wx3vtyaIyo73EqequZXNu58Qt0sqInv9ohMv5lj7s0Ol1RDYu/yCIbYUHfseju7yBVh/urj
	aA1HyOvNzblAs7z2vouvlAb9JlybUJcwlm7LSsQ4vKoQOhqNVA7Rfrco2IJ73zssK7Onc1zEjyP
	KdQyEwULT6sYFvKaWqXv57ESbE3Xu9TM+2bvdgYrye5bUw/tawAL7vhucRutTWm5WssW4tV8i6Y
	Bm5REJMc=
X-Received: by 2002:a05:6000:22c1:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-49c6fc9e5bemr472663f8f.4.1794507172668;
        Thu, 12 Nov 2026 10:12:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:e16:1f01:b442:1e4f:d5a4:2a21? ([2a0a:ef40:e16:1f01:b442:1e4f:d5a4:2a21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60bb2a5dsm556563f8f.50.2026.11.12.10.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:12:51 -0800 (PST)
Message-ID: <bbce8927-1b9b-458c-827d-46f2bb795da0@linaro.org>
Date: Thu, 12 Nov 2026 18:12:50 +0000
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] clk: ti: fapll: remove ti_dt_clk_name helper
To: Brian Masney <masneyb@kernel.org>,
 Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Michael Turquette <mturquette@linaro.org>,
 Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-1-dc6bf0fabae4@linaro.org>
 <179444595968.1126566.13848954974182834412.b4-review@b4>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <179444595968.1126566.13848954974182834412.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2026 01:12, Brian Masney wrote:
>> The fapll driver uses multiple `clock-output-names`, so we cannot use the
>> DT helper in this driver because that would assign the first clock
>> output name as the parent name. This change do not affect other SoCs as
>> the only consumer is DM816x.
>>
>> Fixes: 9e56a7d4263c ("clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()")
>> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
>> Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> 
> I see what you are doing here but can you give a more detailed commit
> message / argument here in favor of the change to make it easier on
> others that will evaluate this about whether or not it should be
> backported to a different kernel.
> 
> Brian
Maybe Rouven will step in here but the main thing is that fapll.c should 
never have been converted to use ti_dt_clk_name() as it does not work 
with the binding [1] and usage.

eg with the node

	main_fapll: main_fapll {
		#clock-cells = <1>;
		compatible = "ti,dm816-fapll-clock";
		reg = <0x400 0x40>;
		clocks = <&sys_clkin_ck &sys_clkin_ck>;
		clock-indices = <1>, <2>, <3>, <4>, <5>,
				<6>, <7>;
		clock-output-names = "main_pll_clk1",
				     "main_pll_clk2",
				     "main_pll_clk3",
				     "main_pll_clk4",
				     "main_pll_clk5",
				     "main_pll_clk6",
				     "main_pll_clk7";
	};

The use of ti_dt_clk_name() results in no attempt to register the clk 
main_fapll and duplicate attempts to register main_pll_clk1 of which the 
second fails leading to an early exit, the clk system is left not fully 
initialised and other problems follow with eg USB failing to init due to 
lack of clock.

Andrew

1. Documentation/devicetree/bindings/clock/ti/fapll.txt
