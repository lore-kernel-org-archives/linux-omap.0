Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356564;
	b=X8ikHtpp3ml4LswwD7PBpsz+Y7dBSBP5hZ2dKHfZnFTfcKx3Aa9IgRHBZZbAfhGInWak
	 vNgO2tVGNDwQ9baB0/Ily8Eew9wvIu3EP2KWg2Lwn0hH0fUQlwiZDvbr7IylZj9RgV4Rp
	 +2uOs8DD6JC+clEfYCTudOw8rq2+S71OVoFag3MMkM0TwZo9MFbVErlk5+yvaWXJlphHC
	 PwwpOATnFjthxBoMuEK5ICdaYmm6hjXVE0teVaH+6YTcl17kf9Umi/5gUCK/vZ+hGMSVz
	 JDFveEmkTzarzlUVGyPVbFS94AFDcIzozEShD+HvebaTfk4VizPo9Kb1fTOEL0iunoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=J4oicOzhhzNrrESdfBNh/uYtU90CfHBxyRHjHAR9JIs=;
	b=tA8auMWvl7s23va0h2/A1hEeVT2CyVaPH1BPg+HiePSnA+f5OcfA+e/TuhkdILL0konh
	 esvgb1GT5vu+ifKq3/q+qCxz3FHNzM3iXOiwvERAX0dZACxD7MRc/D43S2vErlA97xd+J
	 /s4KyThbLY8U8OjkQYoDzc2M8O7JhglT7/dqjK8bGbAkl39L9WauZPL3sBQPTRC3DsVbc
	 9sDRvonD37cX54p6HhGtDet+5QKyD949zYKWr8so7zSECK+1+Un98XPH+Qo8mFdpShThc
	 ap41n4aBY0eZlNa45HL+UqRXT7Jb72z89X5WNa7hqaJzynzEwU3X0K4SwQ4qYozvDPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lxrnUnve;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CC606A31C
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2026 00:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lxrnUnve
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987a2ba0cso15752495ad.3
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794356562; x=1794961362; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4oicOzhhzNrrESdfBNh/uYtU90CfHBxyRHjHAR9JIs=;
        b=lxrnUnve40EXWhxMOyVdjBURsLMxnVf+IrFcqYPKBlfev186wtjus+SJLrXb4v0YVc
         NmnyRnJKWo8xscWJZYVQJ+btdwHUB5woeG3IV5dbBkGds6npviMOquM/zWaggTK2wWLq
         dH+50seMF0msvqI0NnS6NIgwYsXKKIWhIUSHlwmSrPMls02uz5Li4es3e/MO944Kkngn
         FEhmP7vV+BYhqN6nyFN7JQXBRitXa0hdrycDrmUXuy8SkcLdREVIO1Yd5Jv0irc78yai
         9lyJOTJyBcigAlXGpT8f67Z+F8FObd2xTsMm1yvnhaNIaWpuNOf5mxeF52UxYXerZ97Y
         lf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356562; x=1794961362;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4oicOzhhzNrrESdfBNh/uYtU90CfHBxyRHjHAR9JIs=;
        b=21JvVl849/0Awy8AR2bVrq11Cveda3SuCCyWMPjxMIv1wguUC3AMs3vBVuct35khef
         wZyiT71o2QnZ4DGmnLC36UynDMQi3r1zD+SAJ5/Jc1m9kv7sIyKcyKJiZQHM8evZViGB
         zu+CCcLHcOncMqRkIITt/+i69xciGcqw6nnf7beWkosDQbyyEKTkEAGCTyEI5/sKIaS2
         U3kpt/j+b50eayOwv7Y95WOekpXRgpbOX5lz+i/tZgtYNnBCzIi6wJGLqJztfnL12OB7
         nAEtd31psrrB011OQxbrO51uHvy2ENnjNyWUa97H6F3J27q0BUJdGmXgaC5910aHSftk
         wN0A==
X-Forwarded-Encrypted: i=1; AL+hErHehvpGyxdC9Me2TRwK8vZ5lOgsY9YiLCqluXY4xddrNWQr5kzBXpGbIyoWx2xohi1MQ2ZFHEzJH0iY@vger.kernel.org
X-Gm-Message-State: APuU4Z/Alq5YgStcQXoZ2MIABjf50lgogp5I0GUaedRVm9CTC/KSpueF
	KB0Az5ktyO4xfUT2ZT4e3F/2aiM2Jp7Sfah6+izBZD0hcWpbd6D2Da/Zp575eeimsYA=
X-Gm-Gg: AYBFou1ySfkTMlD9W2uEvG3j7yCeWcvU6GFg7dDNPdoVCAUVbRh/ecEIRxNZBrhJvJ1
	2XX3VX0jJRVks+aN/5znpYAD/vrJmy5K/C6m8h1LrVb8avuAkBd/YM+3nEahYrljw30NNjl/WYB
	loOA/T2HZr7tzWS643DeRzD3b93E7P21/wLs5jZhP+UWmg2Tb7lea/Mod4AQV30FIm0qRL1uqUk
	BCliCQ2JlC7CwUOfgBz1MuKGOe0GxuE50b2hy2HVeWqhRZcmZgSFbnH/E6fHH7duK/DjGzEeLIs
	65kQdwAJZXLU6Me8sFsHgzOksn4ciYzKjeyzQ7Juxh3DRCxFKrGWdR8nRYYqlL/l/fZI70K388l
	SZwKoFxdYlbJ/G1EW48C1Qi/3JA6mKm4qyEoqkDRAAg+LFoXArrtB2zmfVpJRD8hQM/SGqoGqTq
	GqtPu9hGDlvGY0jS/qgjncKw7WioMoVls2bS1oXFrF95q2GORF/Rx1oqfdiB3jz0fY7XUEtRIjs
	AGnVpHHfcDEQJiC6tEV+MryXKQ8tI/9rlO/5y7Ccy2eJ8zlh23djVGT6d8Yet0S2Eo+l3lbhwnL
	1TX5CNtUMHahaR52fP0WYuLN
X-Received: by 2002:a17:903:b47:b0:2e9:3395:cca8 with SMTP id d9443c01a7336-2edd7a4638dmr8404065ad.46.1794356562384;
        Tue, 10 Nov 2026 16:22:42 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2edb6a4234csm14094595ad.10.2026.11.10.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:22:40 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>, aaro.koskinen@iki.fi,
 andreas@kemnade.info, rogerq@kernel.org, tony@atomide.com,
 linux@armlinux.org.uk, andi.shyti@kernel.org, thomas.richard@bootlin.com,
 wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: OMAP2+: fix omap_device with noirq_suspend
In-Reply-To: <20261110211531.679943-1-andreas@kemnade.info>
References: <20261110211531.679943-1-andreas@kemnade.info>
Date: Tue, 10 Nov 2026 16:22:39 -0800
Message-ID: <7hwlqktdww.fsf@baylibre.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> Fixes cases where device runtime gets resumed in _suspend but then
> pm_runtime_force_suspend is used.  So the device is disabled, but runtime
> active in _noirq_suspend leading to duplicate runtime_suspend calls. So
> rather check for the device state directly to indicate if changes are
> needed.
> This relies on pm_runtime_force_resume being used in a balanced way.
>
> Fixes: 7da7fd7e66ac9 ("i2c: omap: wakeup the controller during suspend() callback")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> This really needs intensive scrutiny but might be a less invasive patch
> solution better suited for stable and paves the way to get out of the
> omap_device theatre without too much hurry.

This looks & feels correct to me.

I also tested this (along with my WIP patch for that NEON count
mismatch) and I have a very stable suspend/resume on OMAP3.

I tested on omap3-beagle (retention) and omap3-beagle-xm (off-mode) and
both are now reliable across multiple suspend/resume sequences with
these two patches.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

>  arch/arm/mach-omap2/omap_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 77a75b0b9ae69..52afc9089a5a0 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -393,7 +393,7 @@ static int _od_suspend_noirq(struct device *dev)
>  
>  	ret = pm_generic_suspend_noirq(dev);
>  
> -	if (!ret && !pm_runtime_status_suspended(dev)) {
> +	if (!ret && (od->_state == OMAP_DEVICE_STATE_ENABLED)) {
>  		if (pm_generic_runtime_suspend(dev) == 0) {
>  			omap_device_idle(pdev);
>  			od->flags |= OMAP_DEVICE_SUSPENDED;
> -- 
> 2.47.3
