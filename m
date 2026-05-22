Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D093346AFB
	for <linux-omap@vger.kernel.org>; Fri, 22 May 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425727; cv=none; b=j/9hnJdX3q3CBvpz6JB57Mk6cbXyu7od6vclirnyoivvx/V6siF0+8qnqOjykNpvNHG9UuuZJNEWdNQ8KNfEjGsHtGOIfM3LAPmSTwsAywZNRGv98QpFk4YBh1PAOoI6WOmh7NUZTNI+atx53vmKGI5HiFCobrJJ0a16SvuutVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425727; c=relaxed/simple;
	bh=B9CAhNAdGTp5Zt5LCmbUDLKXezoz9dQvKZMGvVbfxrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9+gCVj4IoPXGGKmhNTXcSI9mQSHhoVm54Rd4TQuHpE2sT+01IouSh4gDBjXkET8B4afYhAs2jlOEXHxazUf3yxdclCc7kraeRGUOuykgP0sCYNfFnfa7ViXsP9C3PvuctTBtacOyC/bvLa7GDWc77AmlMdLplIUYRL/Lyh+oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbeIv5MT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbeIv5MT"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a877510541so7969370e87.2
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2026 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779425724; x=1780030524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=GbeIv5MTw2u/PaO2jrKBK2QR0+f6vbEfqatUpYeF/bCRKRhpq6G8Yn6bHVqyKbI1nO
         6aflGJoaJ4FzfLZN2vCoCXevRZkYXwZ0ohRvtIJXvxt2FB4+k9M4FpvxB9W3y197bLcX
         jzZOqcdFQ6HV/axNzl0q6d65TSOGZM1FYwEzSzmHuAQfon6HxozChLLd9/L69PZ6wO+o
         BkUjjOuiW5GpBTuadz6fKqNuP3bZ2aGwkn2/iHq1LfFsfqp/JKOnGWjKayLekJ9Bk1L2
         iKO/ICx3ULCTvLSVIqiJXbMEUeDgTJ6tlBe24etov6zbxICSiBCXgQ+LB7PjnK3fwgt5
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779425724; x=1780030524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uaBSQpnXDZ0Lr2vqL2X8w5SaBUCpNSkuNqugybr2/A=;
        b=kwztHrFt0L8a2ydFAhLm5OGbuXyGnbhKQyKh3q2qul9ONOEYNvc814DcODMpyoBGCy
         YfGRuZmHbJUod+sY9W2r9oz/VW/wtOr5p4fnWGFzUteiB6mG0dwSR0dNS/ELndZFVrlQ
         zbKc52Z+6ExNrL97k3sT1NMKXTv7m0taIVEoVK7YbVrQFNXO2eatzOEl76W0LhjAuu8e
         Vq5jFuBOL10wU0+SnvaBCBJV78EcT62/pc2EEuFhBtv1hGQOHjOdR5PhLquu8SXz7oEY
         smrlvK+mDwBYUrmPcDvtd+0QWLHWRJWW5sR+sKpgBmYuTd5ayKsOL1AV9gUO7XgWV4Oc
         04dQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fZYKz7VjS3MXzro3aADThFJAtm8aIgAJtej+VrdSmwxajL3jmsWWe8OMkXzd1a6N0fnI5J58/kXPM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ULJhQ8Q8U7FyP4r1ZybQ62IiIIkE9D9nw7yJb//F9qBpnWiR
	gnDYxDAJSBDbN6OxF38J5XncpuAhvHAmdz6eJ7SJd4/gDvy5NO8axVNK
X-Gm-Gg: Acq92OHMLMNThKsApt0CVXMdDsR1uZZh7AmoZmR7kSc8nYnROoa8a2iofmUnZM2rJUr
	0C8npbMzzWgslMpXgVTlSI0NAfymrB//Nkz74m4wBVg3z9FNNv9lCaBMChiF7AoGm1c38Fyip6S
	S33LaYpSzg2ahwWBT09K5aJq7fKKR9XzjDT4puvrRdBLLXPc4v8lR6XpVZhbU+marhAg2RBgHxx
	m6jj20NUlqiSIgNe2f5u1hBylI+0gL2duhxUKyzfIcg/prkWXhPMef8AJMLbKZGDpBEUoe8s9yW
	umoN7r4Ic4L3Cm69foPYwStIyDZffSrSRobVIMq2pWKRYlbzV7SOoRRvz18ZdAFXzmFCqcW9ieN
	rOLw5kSRrdVeGtwGvD95+RolNSCJMsDVOL9B21h0UkhIh9aYOUYeM21CjeHpb1nqbMZLJXisaYv
	F6UdF4Xtb97HC8DBpSYHHfe7Ga7r1r3lxZSK5QGMMS4AmJyFrW9AeFlDuVK37DZMvgotBZFvKci
	Xkxw0mszDXseTFM8RE=
X-Received: by 2002:a05:6512:2552:b0:5a8:9988:f1d5 with SMTP id 2adb3069b0e04-5aa323bc03emr387730e87.24.1779425723236;
        Thu, 21 May 2026 21:55:23 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb36d2sm144533e87.13.2026.05.21.21.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 21:55:22 -0700 (PDT)
Message-ID: <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
Date: Fri, 22 May 2026 07:55:19 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260520183815.2510387-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/05/2026 21:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
> 
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
> 
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
> 
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> Link: https://lore.kernel.org/all/afJXG4_rtaj3l2Dk@google.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: resend
> v2: skip the fake GPIO number passing from mfd
> 
> The removal of the arm platforms using this is not yet going to happen
> for 7.2, and Dmitry's changes for the Rohm drivers have not yet
> made it into linux-next as of 2026-05-20, so for the moment I
> would still like to see this patch get merged, even if we are
> closing in on completely removing the legacy gpio support in
> the gpio_keys driver, so we can make CONFIG_GPIOLIB_LEGACY
> default-disabled sooner.

I am (still) all fine with this, even though I like Dmitry's set. I 
suppose you already have a plan for merging this, but I still have to 
ask - why the MFD changes aren't in own patch? I feel it would have 
simplified merging, backporting, reviewing and reverting if needed.

Well, other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
