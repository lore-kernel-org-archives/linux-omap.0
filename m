Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF24352022;
	Fri, 11 Sep 2026 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139835; cv=none; b=S7ByHGOqNlkXS6/e9Zkx8GD0LAenXSlDmZr8upU6g3oZgsIOcIF4anRmZkXX4kvomOaIT9SetTF+aIbnipZxXG0XOcqsRGXZKxEDBomoiFjcGpz5glH6myeNLYUwd7nkLUHptru/YmPjPkTKeg6ZKkE+FtzNlN/9TClq7brnfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139835; c=relaxed/simple;
	bh=XgGukFaLm9ClfaJCRUXEngx70lnGu6tnboJmCPbDz9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGbxMlexYcXpuPREyJSaBQzh4ms5o0VFlHwc4+7DYOnndjUXenNcDPYdESNrrO91xEw3BSjo7Ywl2rR3Yb3D25qbqBdLV3zvOHDYktxhJLFJDLJdGTfsvy5uB2ZQWn4TMi7X+VvXhiNsJ6QnIsSki7I6ZK8TE4JkWEKKwvu2JKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=du4jAI56; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="du4jAI56"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 759C04E401EF;
	Fri, 11 Sep 2026 15:17:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40F99601DE;
	Fri, 11 Sep 2026 15:17:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFD0B11C7AFA6;
	Fri, 11 Sep 2026 17:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789139831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MmwatGe7e6Rau0WxZg3LCruAvqvk5vMaFR7mz8DDi+g=;
	b=du4jAI56UYGTI6LssNs4qBUtxs8fkFEcaiKb2fM2arVS2NIADqsqIXA6wwDGyXtqmxLKHy
	yjNDExDnHOpXb6jCpQouJIx8MwMsC8/YhP7fcSFmTMhmeaFJJpdOwc0BjUJIqFqtcVr/k1
	eNMZxSAfsvIWQUoCnSZMEyZ+cxqe3csfLVTs8/XDpCMbrOpmxvdffyqSP/JmDPGN8DRw9q
	acJN+JxW9/V5ngO3vR8ecl4BLkCyh5FoIWBlqdNxoOxG4ElpN5zZ6fLbNArvt+NfEnrkAA
	Z70aZGK27kVmQhVifaXmZE7e8GFi6CTtvGGdP3uK+WefBopl2D579gZTXfuALw==
Message-ID: <14eb1c72-fab0-445a-82f2-5851a855f723@bootlin.com>
Date: Fri, 11 Sep 2026 17:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] watchdog: omap: Preserve OMAP watchdog across boot to
 detect faulty boots
To: Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <407b9420-0ec6-4d95-960b-633677edf760@roeck-us.net>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <407b9420-0ec6-4d95-960b-633677edf760@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Guenter,

On 9/11/26 4:29 PM, Guenter Roeck wrote:
> On 9/11/26 02:17, Diogo Ivo wrote:
>> Allow the OMAP watchdog to survive being stopped on kernel initialization
>> so it can detect a faulty boot in cases where the bootloader leaves it
>> running and the watchdog driver picks it up during kernel init.
>>
>> - Patch 1 removes a duplicate omap_wdt_start() call left behind by
>> cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling"). This is
>> unrelated to the main goal of the series and can be picked up
>> independently.
>>
>> - Patch 2 adds support for reading the watchdog boot status. Probe now
>> checks whether the watchdog is already running and takes it over instead
>> of blindly stopping it based on early_enable alone. This introduces a
>> regression possibility, explained in detail in the patch's message.
>>
>> - Patch 3 marks the OMAP4 watchdog node ti,no-reset-on-init so the
>> ti-sysc driver stops resetting it. A detailed explaination of why is
>> also provided in the commit message of the patch.
>>
>> This series has been tested on a platform based on the VAR-SOM-OM44 from
>> Variscite, running a TI OMAP4460 SoC.
>>
> Please address the issues reported by Sashiko, or explain why they don't 
> apply.

I have just replied to the Sashiko reviews but I'm not sure if you got
the replies as Sashiko did not include your e-mail in its review. If you
did not receive them please let me know and I can resend them. In
any case if you could give your opinion on the comments I left on the
patches about regressions that would be great as I think after the
Sashiko points are addressed that is the main blocker for this series.

Thanks,
Diogo

> Thanks,
> Guenter
