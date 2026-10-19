Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427567;
	b=t6xioJBKQYzMdtp2crxKUihzFP43PVwtIGxzpE2O5GcvyBBTWWAP2dB77OiejBKe14zY
	 TUkvsHXv2svAgh/DOYU3v4iWnF+cPsqB7XW36nc4jinrPNVcKvqxSp8yARAg0E3i+Zk+D
	 YCeVXuGXy0/7GMfSyjWsqgrhM/0b90wqOqZ+EcBlCwAl6n9bBduoPTtufJC0u19Iw8t4B
	 NEyDz+ey8vk5MOHANGDMTKW23Whv2WqxQgfbRICGwhsgi/8vGT1043FG78mT61Fu/Aaor
	 5Kc3rys57RQeH4IRipf6noHh4MVWJUko6o0HwN5zIUiJGanMIrEEnKU5a007Cc1dnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWj6P+5N+9+xj86kghtIJTrYQUXSGty1irTiTrrFBnA=;
	b=3ZirSyQwETLUa0+5cALtEw31LATGlkg3Dh49C2oEkXdd6Wsg3lWMsvM/QoEvwWNUXTlJ
	 zzJLqfVycwR5wIcX8+/dBOUqXTLkx8uBoiQRSaskQP6t7LJVxeuLnmyPqILDnthoUB7dR
	 1fQtUMZb49uZkeIuT854xEuJz5YQib2H3SriMPhx6G8phd834TCwSUn2LAbn0deA539Q0
	 5AVohenXQt1ghpf7SwYVJDnHIEV+WHDMu/2qGHaF/M5B7nGQcxeXmUd2gisnJQHTnOsZx
	 ZvJgQFDpnA/+RwCwlXdRTCkiFcBKAOnNk195LbVu/jiU9Co4Vi5BHnNreQdVYF2y5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uihAlf9K;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E957606A320
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 16:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E957606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uihAlf9K
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so1920122f8f.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2026 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792427565; x=1793032365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWj6P+5N+9+xj86kghtIJTrYQUXSGty1irTiTrrFBnA=;
        b=uihAlf9KMF1E7leWuq2ziF+jrvFzjVQh7yDYYwzmE3kGwVMD/K26Cbe/WTxyj+aj7T
         mAesrIGwyR4p4Ql43E484qxEkEgCc0OkE9YMJdVzd0q1ccVEqcLEq3T7yJPl0GDq5V2M
         VjoLaMO1/sSM9Xw0782GHEKPJDIi+C135kZe6YY73odVwoBYIbX6GUimHcMSomwtinBM
         qKmut9yiRk+wIbHsrkMrx1UWH7snwPL6op9IUbn8BCco5lV+VMY0sdLxsYG91VuGKJcF
         hK4ft3UJvUPrYuW9Afwdl5axq6UN2qcIMClH3N+BNIuY2d/Yl/VQCVizt+5p/aBByBlZ
         V6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427565; x=1793032365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWj6P+5N+9+xj86kghtIJTrYQUXSGty1irTiTrrFBnA=;
        b=oA98/DTrOxlHAmcYznYu0QeJNqnVppk4fAhAphjffQ5Sb2r6odObXilMTnNkOSSe9g
         YnRU/tkGQoPJux5qidKBkZCJEZABgQzpOSyvpmD/XIfA8qyMHxF4Tm3lXay5FcvUx6wb
         n+vpmwljNssRb36aEfzhYN9f/rYaXsqvdN0ge9YWV30kOxC4MNGIOHiUaI+TR9+wPrJt
         IBfcRd6+/z1w1fWN+6flaRtZWCBzG3L/FyF0Gmmu5AUewzf+b7Qfmz6ptukI1ga0lK7I
         rDAqmG6x/6X1QHY0CDhjoVJLE8pttqHGHXLqxn17BxFhcj/sSj43ADxuGjL+/3d6Zuqv
         MoGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoavWiHjMP4RbKO18vY3uA26loYVIdlLmxrEkO0XrIKHDMBD7NDOtUdSmKLwY8qQiuXTg/ulC+TpYj@vger.kernel.org
X-Gm-Message-State: AFq9FYLnXYQSP82lkE9mNhTsAhc2QaOF5BAxkKHNqlCb39jO84qfyoYO
	KUYOtb2i0umgN2V8MWHzF/iP4P51dpGhKIXdRnlIAnK6ciF0WldXNrLyUvy9K5MiC4g=
X-Gm-Gg: AYBFou15mehQZmLrcWzLgdNpR8R4t4cqsn6te3TnWLF24Asj1VqH5mxnxMgbEmW8nQC
	u/ndURTZ3kdJWp54/Dpuk9UXrZz+rsdkPA1GJK0ywHq4O8SCIvf8jxk8zbdRIbPJqCjq71ckj0d
	oHKX6JLbKnl3lP30GQ0vKw3PjxHexZh9yUu+QL8pRo4o18mdHXGimQiPfKDuk0KOGv5mGJ+7ER+
	I5IiPu618G0xwOotrLYfFPr/BIbUnjaYeVUAQKvWDMXNJ4AWnUi3SQeD+U0NwgB0zvroU7hE9V3
	Jf8PuNzJjFNAoKhJ/swO//ev6WHhs+qHDVYoPK8IvqfRBXo3R4gP6OuvKK3RE3nj1S8RUsXNL+R
	/+fxu6AaN0i3nhZtUrjpcDxd4mXDrgN/03FMzULXYNTY/H3Kt4T404nv2c4Zbha0kABNIMeBmtJ
	meKuit+KqTU68nUzuKKz/YZDSu18VXZZ8c9DlRhtTztbf4Ny2k7jHHzkDaAmXbr5Sd+22sWCqSR
	RMwInhH1GI+x3v7ch02baNNUwpdhfqq3UfqICOAuXb1HjIB8//jLs8r+DX0ug==
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a1d75ad08amr209137105e9.4.1792427565319;
        Mon, 19 Oct 2026 09:32:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb0:c501:2c4e:44f:2449:8978? ([2a0a:ef40:eb0:c501:2c4e:44f:2449:8978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc809csm3538555e9.8.2026.10.19.09.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:32:44 -0700 (PDT)
Message-ID: <ee975969-e310-4950-af09-f57fb423a9f5@linaro.org>
Date: Mon, 19 Oct 2026 17:32:43 +0100
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
Subject: Re: [PATCH 06/10] ARM: dts: omap: dm816x: Update USB node
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Ettore Chimenti <ettore.chimenti@linaro.org>,
 Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
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
 <20261016-patch-ektor5-dm8168-dts-v1-6-b4ce30217028@linaro.org>
 <20261017083957.7c2696f5@kemnade.info>
 <8a8313f1-d525-45d3-9044-b5f7a00b256d@linaro.org>
 <20261019154503.2111a89c@kemnade.info>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261019154503.2111a89c@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/10/2026 14:45, Andreas Kemnade wrote:
> On Mon, 19 Oct 2026 10:36:37 +0100
> Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
> 
>> On 17/10/2026 07:39, Andreas Kemnade wrote:
>>> On Fri, 16 Oct 2026 16:41:21 +0200
>>> Ettore Chimenti <ettore.chimenti@linaro.org> wrote:
>>>    
>>>> From: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>
>>>> USB node was not working correctly with DMA enabled as the supporting
>>>> code had been updated without updating this SoC's device tree. Bring the
>>>> device tree more up to date so that it works with DMA enabled.
>>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
>>>> ---
>>>>    arch/arm/boot/dts/ti/omap/dm816x.dtsi | 41 +++++++++++++++++++++--------------
>>>>    1 file changed, 25 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
>>>> index 7f3ef3a00ab8..5be9efc60785 100644
>>>> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
>>>> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
>>>> @@ -574,18 +574,27 @@ uart3: serial@48024000 {
>>>>    		};
>>>>    
>>>>    		/* NOTE: USB needs a transceiver driver for phys to work */
>>>> -		usb: usb_otg_hs@47401000 {
>>>> -			compatible = "ti,am33xx-usb";
>>>> -			reg = <0x47401000 0x400000>;
>>>> -			ranges;
>>>> +		usb: target-module@47400000 {
>>>> +			compatible = "ti,sysc-omap4", "ti,sysc";
>>>> +			ti,hwmods = "usb_otg_hs";
>>>
>>> Why do we still need this? It is depcrecated.
>>>
>>> Regards,
>>> Andreas
>>
>> Without that line we get the following on boot and USB does not work
>>
>> [    0.110148] omap_hwmod: usb_otg_hs: no dt node
> 
> It is somewhat odd to use both ti-sysc and hwmod. It looks like a
> half conversion.
> 
> For an example how usb_otg_hs was converted to ti-sysc for omap3, look at
> 42a79edd4a3dc1bb8e89fd2849f9e8e1e1c13977...v6.1-rc1
> 
> It has no hwmod stuff left.
> 
> Regards,
> Andreas

Thank you. That was the pointer I needed to sort this out.

Andrew
