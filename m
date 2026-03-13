Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11A24676D
	for <linux-omap@vger.kernel.org>; Fri, 13 Mar 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361046; cv=none; b=JKbsxCe5le001xj3FzcECprWQ1KROPeNNs0quHX/64F5FU4bh2/02WKrwvWszDBbAim9ffTXoWR/+FeIE4YXNlfppl9l7cf68i/+fVtyLIs9licynwHspxPyQO/MVODNT7mwtVb8YPakUnU4QZPChpu5F4K8WDqw49KTe6ey3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361046; c=relaxed/simple;
	bh=sBDJiycTYdIuQYP8aXJgcHXx7wyBEVeAIRSLsbiJbcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ozOVaxW99/l2zrs498zaTpawHYxZvOoWTer35q3mJKwzLejoqXNodNLfZFgzrg3xRBSXeJwa1iSQWR+9PxH2h8jv1D7sTtAZShU3hfGJkYU0c677eM3OdPFJsArWVOUwyDRvkMPCL9PxQmsrD+rRaZWJEVnJzrT7hR6eW036rEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sr1xJkyR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sr1xJkyR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so607564a91.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773361043; x=1773965843; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyKlpEvu/Gz33z23N2eapbn1Hxc35CxSf0FmojMpCCA=;
        b=Sr1xJkyRUpTM2mE4LmrkDULYojX1NkeDB5HO/UvhCW1bu+5Rq++dnWRUT9CYqhmQ11
         x/ycV4BlHEkvYlTTChTph86r3OFk6g+feEef4CeQTcKlGFxp0arov/9jsGvq0LZFfk4F
         WH4bi5fyvr6dlpwVfcN/cRWn/j8IsbjF9YYYAlq3TnPHbtCtj6aFynltMlHSbOMXSaZh
         ClzrVxqqSYhPGYEWT/MHZpB5IDDFCYbfmRLpODYd5CKo1rLqaRkMeNPyR2Iir9fdxgpl
         dOB6w8hlk3Eee1osHKgElbUQjF+jX8151kHYdRTClkN60XsLxQIdA1sc1HpCGsvf5eJx
         Okeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361043; x=1773965843;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyKlpEvu/Gz33z23N2eapbn1Hxc35CxSf0FmojMpCCA=;
        b=Mgj3xlS/dz8vAHvhn/bgKW2q7bGoHeTeamEcwcx34OZUeugdiFo/4beDjbDn8TIwjW
         P0PeCpTue93LVEuEAb3D3Ubs0FOYsijaURptZsjRklntMXKRBdlTrouMekHz30gkyrvW
         QlbtlR0iikJbrCHab6RnpCkYhOKuaKRunQWTOBmao8cslVO4VvY9GYeHP1NT5EPViwRc
         0Gp13rj0koSYVQzz18j7l+KYoRcnwI6mdVNf3D9kb9eP348pokjlayqmlc+ZyEcblxEx
         ZzSVCN0tijZZxw/UUqJwBUqMvXy9acmtK2s/691zkDjauaVXcvfbXNKlh2x7znFvHxAu
         +tpA==
X-Gm-Message-State: AOJu0YzGuJ23Xiu9fVMyW++9e0LhbYiyZ5sDAjoJSRoqiWjEOk6fTqQH
	bqJHDXHpX3LgZjdYknMyyi9MvZUO6t8qEr9vQSk7HpM/kaYxfC4w9JSbVdPrQmyYoFs=
X-Gm-Gg: ATEYQzx6tvzMoRHLy4s7u85KME21wrrx3cQHKB7uSOHZtQbh7GeT1yy8/MM6RcQuBsN
	3TB5w0djJiZxCOzbgD6P+T9xVCjN/r7UcfwEyIPdzgyVJDk7kn2ojQEOr1pebMYqFWsh+N8teaS
	LDlo71+lSPCSO1LnMqamse0IMpAPuI59Ik3FhBxSfJgSbmrt/qar7I4k4+UEfp4o61Cldz+IrOW
	FIPRuVS1oc4JnzhktjoGwl7YQxKtKNyHU9oTC63ZkWkIX07j0V2S0gAoKIUBFTQlmBgH/A27vRT
	WDbGThfPTF1t3WM42eNClrVMiBKDUO9lagaMuJnwYkfhf0iyc330YjFuI2ecwoqe9SFUnxTjMEa
	KoN06DlpOSorfZcDZW93fnYBToDnEwal6vDeimje7OjzPkcXbuhe3AjTz3ZMZwRPJgD5oVfVh4j
	X+HkGVLvGdXMbp4KHP8iu6bdwIMVyhtg==
X-Received: by 2002:a17:90b:3b87:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-35a22082de9mr1145911a91.29.1773361042647;
        Thu, 12 Mar 2026 17:17:22 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a22cb532fsm312631a91.1.2026.03.12.17.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:17:22 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christopher Obbard
 <christopher.obbard@linaro.org>, Andrew Goodbody
 <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] ARM: dts: omap: dm816x: Correct pinctrl register
In-Reply-To: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
References: <20260312-dm816x_dt-v1-1-ed3370b20799@linaro.org>
Date: Thu, 12 Mar 2026 17:17:21 -0700
Message-ID: <7htsuk1t2m.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Goodbody <andrew.goodbody@linaro.org> writes:

> The delcaration in the pinmux device for the pinctrl registers is not

minor nit: s/delcaration/declaration/, but no need to respin.  I'll fix
up when applying.

> correct. These registers are actually 32 bits wide, not 16. Also the
> mask for functional bits is also wrong. Functional bits are 0-4, not
> 0-3. So the mask needs to changed to 0x1f.
>
> This information is taken from the TMS320DM816x DaVinci
> Digital Media Processors Technical Reference Manual.
> SPRUGX8C March 2015
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

good catch!  Thank you for the fix.

Kevin

> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index 407d7bc5b13a364548087dd5fb2659286bbd8537..a1e0e904e0f05cd725e71da70bffbde2dd2b2e38 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -94,8 +94,8 @@ dm816x_pinmux: pinmux@800 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				#pinctrl-cells = <1>;
> -				pinctrl-single,register-width = <16>;
> -				pinctrl-single,function-mask = <0xf>;
> +				pinctrl-single,register-width = <32>;
> +				pinctrl-single,function-mask = <0x1f>;
>  			};
>  
>  			/* Device Configuration Registers */
>
> ---
> base-commit: f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7
> change-id: 20260312-dm816x_dt-abe888f372e3
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
