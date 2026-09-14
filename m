Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4040B373
	for <linux-omap@vger.kernel.org>; Mon, 14 Sep 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374772; cv=none; b=XXPen+yvWHZRxhuCi69PP4Hib7HJWUy6ncx4nFSsVrHa2gyzrAgB/OEEW2tArpXEnbqH31dar5EJEBg0dMl2UPHUuhTBrDpa0V8QhRt8dj70IXPPmML78jtPXAuxlOTGxdNOrMUCPartPRTvPdJZlaFemH1PlcB5wYYdjG5KTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374772; c=relaxed/simple;
	bh=wQIW58kd96Mxvk8XVo8GGflIQ5a1Ent2zmnDJu8T9NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9FFtu7djVbYztNxtaQWpLCWt9x6uwZZw4ukBiIlffs7n06FMbqWC8MsVpGjxKDEE4E9vwIeJk82OqRuict5hH6lA4w9z5qwt+UWiI552fgab5vX/kHWrjj3c5dqjQDUbRkIjyZrFAF0cypvkNctCUsnkEMfCTGABXlAOHhBFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2d/FvAvt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2d/FvAvt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 91AF21A0606;
	Mon, 14 Sep 2026 08:32:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 632E060323;
	Mon, 14 Sep 2026 08:32:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF4E11C7AFD9;
	Mon, 14 Sep 2026 10:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789374766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=t+bhyABek7V/xx++E1c8RabUELBTBXODnbFXuaAAKQQ=;
	b=2d/FvAvtyc/nTCI+osd9aWSzqN3jILc8tPO/hoImrs1bErK9hO29yZuznpWAQ1KLbDsZAF
	VEn/Wa/kJOlX3KwrGPW5TbqsABU1F2iayhdQmkxK7jF9NzPcsT2rFg4bzX2uWIsRhvPJrh
	lMZpnW69DbP0OLRIXsr/xLcqfowQNtxCNSL3jp38UiRBQXpPc47MXSkR5Qu77BVKgdJMdI
	lgRutwBQivXKAkON0WsRRxp+YhQVKdE7rT80cm9UE+Vcxp3SrNyFyS3Phat1rqLYDajzmP
	SLi0Vq9YQE5JEuRCxb5N+G42oNkbsDlSzysWDB1bx3aZUQtvgipfGUHLaJOPdg==
Message-ID: <b86b0f43-4a86-4bc8-865b-1d767992597a@bootlin.com>
Date: Mon, 14 Sep 2026 10:32:42 +0200
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
 <14eb1c72-fab0-445a-82f2-5851a855f723@bootlin.com>
 <f1adea74-8f87-4442-aa12-18536cabec3c@roeck-us.net>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <f1adea74-8f87-4442-aa12-18536cabec3c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/11/26 7:25 PM, Guenter Roeck wrote:
> On 9/11/26 08:17, Diogo Ivo wrote:
>> Hi Guenter,
>>
>> On 9/11/26 4:29 PM, Guenter Roeck wrote:
>>> On 9/11/26 02:17, Diogo Ivo wrote:
>>>> Allow the OMAP watchdog to survive being stopped on kernel 
>>>> initialization
>>>> so it can detect a faulty boot in cases where the bootloader leaves it
>>>> running and the watchdog driver picks it up during kernel init.
>>>>
>>>> - Patch 1 removes a duplicate omap_wdt_start() call left behind by
>>>> cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling"). This is
>>>> unrelated to the main goal of the series and can be picked up
>>>> independently.
>>>>
>>>> - Patch 2 adds support for reading the watchdog boot status. Probe now
>>>> checks whether the watchdog is already running and takes it over 
>>>> instead
>>>> of blindly stopping it based on early_enable alone. This introduces a
>>>> regression possibility, explained in detail in the patch's message.
>>>>
>>>> - Patch 3 marks the OMAP4 watchdog node ti,no-reset-on-init so the
>>>> ti-sysc driver stops resetting it. A detailed explaination of why is
>>>> also provided in the commit message of the patch.
>>>>
>>>> This series has been tested on a platform based on the VAR-SOM-OM44 
>>>> from
>>>> Variscite, running a TI OMAP4460 SoC.
>>>>
>>> Please address the issues reported by Sashiko, or explain why they 
>>> don't apply.
>>
>> I have just replied to the Sashiko reviews but I'm not sure if you got
>> the replies as Sashiko did not include your e-mail in its review. If you
>> did not receive them please let me know and I can resend them. In
>> any case if you could give your opinion on the comments I left on the
>> patches about regressions that would be great as I think after the
>> Sashiko points are addressed that is the main blocker for this series.
>>
> I did. I just wonder if the effort is worth the pain / cost.
> 
> Is there an actual use case ? Is the problem you are trying to solve
> a real problem, or a theoretic one ? For example, the patches impose
> a hard boot delay of more than 30 ms in omap_wdt_is_running().
> Even though that could be optimized (there is no reason to wait
> that long; the value could change a microsecond after the first read),
> it is nevertheless a mandatory boot delay.

Yes, I stumbled upon this problem while trying to do exactly what is on
the commit messages, so having a system that does A/B updates and uses
the watchdog to detect if the boot succeeded or failed. The current boot
delay is actually (1000000 / 32768) * 10 = 305us, so quite a bit smaller
than the 30ms you mention, even though from the Sashiko comments I need
to take into account the prescaler, which in the worst case brings the
value to the 30ms you mention, but if I adjust it I can bring it down to
3ms in the worst case of a 128 prescaler. However, for a system with
prescaler=1 the delay can be brought down to 30us.

> Another concern is the impact and potential side effects of setting
> ti,no-reset-on-init (and the possible boot loop cause by it due to the odd
> 30-second init delay). After this change, a running watchdog is no longer
> stopped. What happens on systems which do not load the watchdog at all
> (for example because the driver was not configured) ? Will that also cause
> a boot loop on such systems ?

Here with ti,no-reset-on-init the ti-sysc driver will shutdown the
watchdog driver after 30 seconds, which can indeed cause problems. When
I sent the patch I thought the timeout would be 3 seconds, which
considerable reduces the possibility of a bootloop. I will look into it
to see if it makes sense to change the timeout value and reduce the
possibility of the bootloop. My initial assumption of the 3 seconds was
what actually made me not add ti,no-idle-on-reset since that would
completely block the watchdog stopping from ti-sysc.

> This is just a couple of problems introduced by this series. You better 
> have
> a very good reason for it to warrant having to deal with the potential 
> fallout.

The reason is that in these systems the watchdog is not behaving as one
would expect: if the bootloader leaves the watchdog running it is a
reasonable expectation that unless the kernel or userspace services it
the system should shutdown. With this series I have tried to achieve
this while minimizing the risk of regressions, and from my point of
view the only sore point is indeed the 30s timeout in ti-sysc. If you
agree with my reasoning and think this is worth pursuing let me know and
I will change the 30s timeout for v2. In the meantime patch 1 is
completely regression free and can be picked up!

Thanks,
Diogo

> Thanks,
> Guenter
