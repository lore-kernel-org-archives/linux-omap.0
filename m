Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382813;
	b=DJXjWP2noxsUPGNutzxgFaVYzNX64EFfdSCIbtdqBXOmwMw8VGl7ZM2wkJRZkFMpj//p
	 1tRvPHy1vWlZJweArmoB5rXF3QZ1EKEqaSMEg2hNo3NXzeecK12+UDhT3JtNrdyS2YMBj
	 e23ANGMwRBXBYSPvhY4zjnsfvkivmvEuVDDMg96GBWWRHdMEhEJMzcCvoSNACGYo3MSVv
	 6E0Itxncnr9n0A646xqiGINAGYpeGYp2j1yJ2P7eZX1o1jPSSg1Uod4IhI1M4NUl8Ai08
	 OTA2/MErKiwmcuhUeqirPwDK8eWyDX3dWIYQ9W/cVDqNm+BJ8e+yitC7ef5qqy2EDAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=f1PVTEPEeT+k0NIsjo13PPlcE4G2CKOtf71KBMqhCMg=;
	b=E5jkwdw9eyH4xMH6FVc2gFp7lg6OMtVdxC/BjoB1ZwacwwlHF/GLBXqI9CIRVS5VEueI
	 fTeO8yQQrgXMv8YcqsN7soqXCrFZ6NBeYeeTvwcIi7AmiSBd/jP448H3XhsDbeen4cNa1
	 UJ6p7KZWT3eYlfWHjrLnDqwByOrSf039wIijbFYJpRKE4Vq/gvcqzmHcileB6TTGqBbI3
	 u24h6Y0urlaBecjALz8H1+ZSzwCa77Mg2YUfH3v3SReqK0l5660UbG7gWbYoDNjpV3BPc
	 HJGJJPzgq0wuJ3hh+xt02kpZFXdnhnGWB4Tvh/HZAd+kLkY5k4SHh/CESS4SgVrqWOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wzDp6GPN;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B7606A331
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 17:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 290B7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wzDp6GPN
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c45111bebso476121f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2026 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793382811; x=1793987611; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f1PVTEPEeT+k0NIsjo13PPlcE4G2CKOtf71KBMqhCMg=;
        b=wzDp6GPNHiLA6U2AH7HioFjN2adLnu/BusziS8Vf6kSlEHrhwbvIemMzm0kKiPFGxP
         YKOpjEJ3iWcJcPtubYdNW1O3CYCqd/LJtpY+4jp8NNRln9L2oqAvBOiyWk/4CkW2cD2t
         W0t3wWXlDxm3rVFCyE+mvdlvUJpOV9Ybunxa7T4X37OPTVbA9GcrFaWGquoXTGeK9ApI
         KZGUh+ZPjF13ywQjmcPJ1iOKoMJDyp9/+MjhR3O5AcSLFM9VnRXeiOv1blbszTC5krR4
         OUzaC7FiON6YhQ/+mcI7jQF+UdLxVU2+wHT22EyImkj/X1CRTYtdxEaGOJDenZJBXAWE
         MO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382811; x=1793987611;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1PVTEPEeT+k0NIsjo13PPlcE4G2CKOtf71KBMqhCMg=;
        b=hxY4nxqt3o2b3RdLTwZ5rFrHBB7irRnXhRKVTG2WmOKb3q+SBVpeA7OMpHl+EbE35B
         QFrDxG4866KV/nHIxZybAeIc8SFJErStlJrrFD059IrDHvQroiGKt54+++hctMfJDTQk
         DmyB+Al541/tXx6RwTw13D5PePUl2LXC7ZzcRRfN38L1xPBkW3Cps7RuMLkBeNYucqgG
         dEGLHejp769tPfeRf+/+TbhMglAVxB6KvuU+8wB/7wfD5uJolmXv/r/cih/waXqJwQo4
         5Y9ymM9+EE1e8VGLi8M5b/Qi1n8bAC8L1h6456k6rkvp/UTkKQgFKLqpYtm/HKiqhijZ
         aBEg==
X-Forwarded-Encrypted: i=1; AKwUvByAFrzwzFxE/8vuB74Vs1qndDd0RD5cOleapMs34QN/WOKd9/0J7pbiJY3MkgXRIquEqR4CcHsmgoRL@vger.kernel.org
X-Gm-Message-State: AFq9FYIP2ZXMixlkRmdZtN7Zo6D4+CtMs0DQnJjXR/iZBL/mgjsP+3ba
	5U9e2v5s/ZzX99e5XKAspbCc6NlHzQ3ZDBFX8sczmDNzST/5ICmL8tghCSq0jAzMl+Y=
X-Gm-Gg: AYBFou3PDsq0fZ+LmyBm9njA/fvvQjzF2yQLgKHF75cVamNbud91WCyckPud3U6w9d9
	iyrof06JSEXyDOZXIQi5L3RXUSB2AQqPKAPcyZ6ezRYl+S7Kc3RQX26AcI8qfd3LEEiImmF7rWU
	FLeKInCVCZSTGniNMCJg+bgVeqAVMmbHY67XLum+CA3wTPsZqy+9OsSpa6Lb4uP8y+z+FOMcZXR
	ctyJYe4Tiqqvyn8yFuDrupWXHBlxVSLz+FQ0PmtSSVCTM7U5uGbow7f7vDzaInJtJCtyVa12FJ5
	mDC6CeResBlfqbM9rm5kH3SuMrPsGrUFudWVASIdaxXdVePkO6gTNU7Ofa5SwDQXTpDBEMP6A4T
	C9TUivSDz2Bo7ucnNeJJa3wd5DY02rZBLmVEXw4dhUgFVnxLoYQWD6OW7vLRlWrer8gCA2kMjjp
	adKjzqUlKiFa4+NSpXwylfw8NhHc3wZhfLGfc6HaghGoECCWoKsBBGQ8tSDWywQ+oam3vcxzPFx
	G0pBGHaEEhM+Gbdr3+WUpXO0wCNM5JeM94fCpj8BpbkKWTlcxMxVpbRj/flbJ1zZHf7VasD3sgH
	Mf/W3knhflkq3Ia28/a9ovO4eZOuGDlPvVAbFQW0nNzJpFBdyo0NJaCK6IJiWdyX7VgI58wRwwC
	Xq3D7iIwFypvQeGOqS5TU
X-Received: by 2002:a5d:4e05:0:b0:48e:21f7:79ff with SMTP id ffacd0b85a97d-48e6e50575emr5450463f8f.33.1793382811276;
        Fri, 30 Oct 2026 10:53:31 -0700 (PDT)
Received: from localhost ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm4656186f8f.30.2026.10.30.10.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:53:30 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 18:53:29 +0100
Message-Id: <DMID5D64EBS2.3IDHDRJOWK3W1@linaro.org>
Cc: "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Kevin Hilman"
 <khilman@baylibre.com>, "Roger Quadros" <rogerq@kernel.org>, "Tony
 Lindgren" <tony@atomide.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Christopher Obbard" <chris.obbard@oss.qualcomm.com>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Paul Walmsley" <paul@pwsan.com>, "Russell
 King" <linux@armlinux.org.uk>, "Rouven Czerwinski"
 <rouven.czerwinski@linaro.org>, <linux-omap@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/9] ARM: dts: omap: dm816x: refactor and align MMC
 node
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
 <20261028-patch-ektor5-dm8168-dts-v2-4-4544429251e2@linaro.org>
 <20261030113032.51b92b19@kemnade.info>
In-Reply-To: <20261030113032.51b92b19@kemnade.info>

Hi Andreas,

On Fri Oct 30, 2026 at 11:30 AM CET, Andreas Kemnade wrote:
> On Wed, 28 Oct 2026 17:06:05 +0100
> Ettore Chimenti <ettore.chimenti@linaro.org> wrote:
>
>> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>>=20
>> Update the MMC node in the TI Sitara DM816x device tree to align with
>> the structure used in other similar SoCs. The changes include
>> refactoring the node to better describe the target module and its
>> sub-nodes.
>>=20
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> ---
>>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 33 +++++++++++++++++++++++++++-=
-----
>>  1 file changed, 27 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/t=
i/omap/dm816x.dtsi
>> index fc124f9ecfa1..e3d49651b44e 100644
>> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
>> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
>> @@ -423,13 +423,34 @@ &edma 20 0 &edma 21 0
>>  				    "tx2", "rx2", "tx3", "rx3";
>>  		};
>> =20
>> -		mmc1: mmc@48060000 {
>> -			compatible =3D "ti,omap4-hsmmc";
>> -			reg =3D <0x48060000 0x11000>;
>> +		mmc1_target: target-module@48060000 {
>> +			compatible =3D "ti,sysc-omap2", "ti,sysc";
>>  			ti,hwmods =3D "mmc1";
>
> do we still need this?

No, we don't. I'll remove that in v3.=20

As per the comment for patch 7 (USB node update), I'll send two separate
patches, one for DTS and one for the hwmod removal, making sure the
hwmod removal is applied last.

Thanks for your review,
Ettore
