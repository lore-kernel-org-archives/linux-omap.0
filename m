Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648681;
	b=MNHxnFnfpuBms/cKlmO6rZ4gviBeV5Z7dnvc2yMAF1OMRbnocrYYgvY5x5k03SYxrQ77
	 6rD3jbkYj5qk1jFhce439POTaatlrqRmveW5ILjmVskNffxu8NfWAZTryN7uwNEVrRcNf
	 8bBnuczZosy0LsZ4pDUlYBJa2M5ENTGeJdGtW6CdS2EVBCnpjfrp3J7qbGePSZTdwg9aX
	 8TI524cMDjLFwzUqKoAxPkewCzkaAjVAeQfZ4NMlAATocXFzIhyMWfi0/JhJCDP2yKJy1
	 di43v2MIFm3bINav6n8S8JqllXkPCbxuw6T19+X7lfQrmrourXQ+fYEhKmgee53dxNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Weu5Zca/hPX7MdlI7TVErZ4xT18FxVN+YlEWkEZPcA8=;
	b=qi0jcf6rGzrFGE9JXdpdVnDkpCvju/E6XOY+PfrVNHnSVDvfOEYyYsThrXaS6g17u9CP
	 XAtwTJaf127nhmYNlgRJdRNN5vawHiS+zaEro2U5LaJvmIJo/JvToJcTeXnwBtr5IzTx3
	 r+4EmkLaRHN6xBWvke90k90zHidNpl4WnWx5E6IFyvvdbM8a2EJQhpOIeBhjtQPiQSZg9
	 rlZrYJViOGXr6s9hZU6p+6QVC20ftsZjhDi4c8s+JYUkHsq+R2o3CG13/+f9gBLdkUpO6
	 uzm2Dn434TadU4zL670tbLRiJsAJEloyIt3aqK85z1PJ5TYBQA71DU77xRLN3JU+CVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v2zabGsB;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BE606A327
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660BE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v2zabGsB
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3047133f8f.2
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793648680; x=1794253480; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Weu5Zca/hPX7MdlI7TVErZ4xT18FxVN+YlEWkEZPcA8=;
        b=v2zabGsBMccgcYnOKyyoJfrpcS6FC2kf1CeYjOep7ud5b84amOVeXc4O9Bn7QHljxM
         kleSVMzmTjk8J7500JVzYCCNljyqjHHUgpYpYmKtuYqxR+860A49+oGL6efFuH9uJKH1
         o9WuQnPigNB98hrxPxhmFhmrpcNTrCxsVh1HPM0+aBBM7CmTzECx01VZlas2N3sB+xpw
         zevN2gyXBQ+fCAZi91gsLVJTORdB0l3CzBB2NdQQ+kiJy6PW+JWVNwpb7SMh0QACuPNL
         7Wc16yRYdIpVtUDoiOkiPrknjvJYA8VEUTpxyooGhTNXENUS3pjVefS32oOjaz8C0bfv
         g86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648680; x=1794253480;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Weu5Zca/hPX7MdlI7TVErZ4xT18FxVN+YlEWkEZPcA8=;
        b=vQZ8+zEpq0RmgpxoQ0jKLk06CDGDushx9hTLdXSDpH0D0tPJjc2wpmxz29jbD+RYZ5
         uG7zV/TvW87/RHGVP6DVj7nteSIV9An70/YbejJ2E2toUf+zugJhykElppJqD4dnliPK
         RlkA1Zo0bpJkHIxHyEZ5Gtn5NOWcF9fY0Ma5n0RR3VEoJzH71dqaRhOhhD6zXvXphgln
         oW1iss9j+cN2ZLo9PA45Ghptl7DZtZM3DJLmwfaaS4t1flaQ5U6fAiaj2f2vjC4M8eqY
         l0BhlgClM9+mLljzOi+6hLDgD3hVP+Q85X0sg6yymKIpFqA+H2hCprlQjc8Z08avvRMS
         /Ajg==
X-Forwarded-Encrypted: i=1; AKwUvBzCHXAH2VDSmLO12gsvkDE5PwLJTTOp3OtnxQ0pvgLiHX9CwNaAEN1RGmTyUVCz61YGCdFDEI6Rwny9@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZW+FEc8dQzJqaS4PBgXRzq/CWdPIsQHXk6ik/2suG/8FhPrz9
	B36Gx5osvibgIvjro/daxvLYWVp14OKGwMQe9+dRvyKFNMtE5k5ganKAA/WYinuY6Bc=
X-Gm-Gg: AYBFou1wTL7NjUp9uqDklEieiTRWXPlt/qBptJD0Lg835GoDA9PWBr0SgvXc7nNztlM
	5SQBK8+EQRTv7lkqasOEezZgEfhttl06BoozW3gfrUbIhHRY81nRm0bYw9cp/lV+BxEFaCBu4rH
	CuKILJ4stj6Lnbnf+HRysauj8ysxlaUDlTw95j38lnZsAqLvLqtd7yRdjc0LlonUnqm1Y4g0AQd
	GXLZBC83ERGt9b/+psK7i93npGFC+sw1hXqNx3Lj7Xmid0wkgFUYGdPxGuXJD66TbYpS5HuTtqb
	j1hGa0zAGIlD1MDaJB3I3YP+uhM5InZhUs/F1QpFTMlmqgKwKk8vL90cSOzT+EoSSEXVUHemEku
	yJCbzJHHhzJrt9zQFX6HTWATM9BKpXEbKsN5nvqY84jNgOGHnx2awZ4rPsq195717xQWm2urpmQ
	v6NBxKsDK2VaUw8618EGk54nPwrfaJAncHa1LTUgr3aJDnXAaBGpC54ay2Yt5tScOxroP6GWeMg
	2ks1B2DiyPix7+qUB+5aQ1moZFHpT9rnVgUK4+URtlTJTySZSqvcgc7on5hENttX+jVi6BaCXDa
	f9Taz1VYUt7UAwHVgsGw54wTGbGB6gkAYDQA0wdSbJxacl337P+ZoxmLiKkLJeUtwgOO5mXqrtR
	ijDahrE5auzHKmRggRiAr+aXMdYZLV8L6WamJ/O5Zdg==
X-Received: by 2002:a05:6000:2611:b0:48e:4e00:b72f with SMTP id ffacd0b85a97d-48e6e50c8ecmr23807080f8f.32.1793648679554;
        Mon, 02 Nov 2026 11:44:39 -0800 (PST)
Received: from localhost ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm23147608f8f.32.2026.11.02.11.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 11:44:39 -0800 (PST)
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
Date: Mon, 02 Nov 2026 20:44:38 +0100
Message-Id: <DMKZE3GQVDLB.18QYA9ULAH75I@linaro.org>
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
Subject: Re: [PATCH v2 5/9] ARM: dts: omap: dm816x: Correct speed for
 sysclk5
From: "Ettore Chimenti" <ettore.chimenti@linaro.org>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Ettore Chimenti"
 <ettore.chimenti@linaro.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
 <20261028-patch-ektor5-dm8168-dts-v2-5-4544429251e2@linaro.org>
 <20261101222942.1a78c6fb@kemnade.info>
In-Reply-To: <20261101222942.1a78c6fb@kemnade.info>

Hi Andreas,

On Sun Nov 1, 2026 at 10:29 PM CET, Andreas Kemnade wrote:
> On Wed, 28 Oct 2026 17:06:06 +0100
> Ettore Chimenti <ettore.chimenti@linaro.org> wrote:
>
>> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>>=20
>> The default code for setting up the clocks results in sysclk5 running at
>> 1.6GHz whereas it is expected to run at half that ie 813MHz. Force the
>> divider to be /2 to achieve the 813MHz speed.
>>=20
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>> ---
>>  arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi b/arch/arm/boo=
t/dts/ti/omap/dm816x-clocks.dtsi
>> index 76ebc6c3c3e5..cb990773b098 100644
>> --- a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
>> +++ b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
>> @@ -144,7 +144,7 @@ sysclk5_ck: sysclk5_ck@310 {
>>  		#clock-cells =3D <0>;
>>  		compatible =3D "ti,divider-clock";
>>  		clocks =3D <&sysclk4_ck>;
>> -		ti,max-div =3D <1>;
>> +		ti,dividers =3D <2>;
>
> so this changes register value  0 is intepreted as divider 1
> to divider 2. Sounds strange. It just changes the interpretation of the
> register values, not the setting. Maybe checkout the register value from
> user space with tools like devmem. The original interpretation was right.
> So this change does not make any sense. I think sysclk5 still runs at
> 1.6Ghz, but it is displayed as 813Mhz.
>
> I would expect some assigned-clocks / assigned-clock-rates pair somewhere
> in this patch instead.
>

We tested on EVM with devmem and this patch correctly sets bit 0 to 1
(which is /2 in the manual).

However, should ti,max-div in this case be <2> (and all the other clocks
that supports two dividers)?=20

I tested to set `ti,max-div =3D <2>;` and it seems to correctly set the /2
divider as well, but without specifying any assigned-clock{s,-rates}, so
I'm missing the rationale of how the divider is selected.

I'll drop this patch from the series for now, I think it needs more
investigation to figure out why it behaves like this.

Thanks,
Ettore
