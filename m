Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678713D903C
	for <linux-omap@vger.kernel.org>; Fri,  8 May 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267532; cv=none; b=Fwe5NbdM4aZo3L0PD4pra081BmAt8FCUyye2iAHn13g7zdtwIu1kRAJ1UCJveuFQf5UsKijQcZDy4TUrylNlQ+uSXS1zZZqKV5PXBcT0MIx8R5nHFQJ64PYJJ+YFBssQ8Te5jkE+9+c22I/CMTVFGipAiEEzLL4CznzGGpjBOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267532; c=relaxed/simple;
	bh=35hG0HdlOuBJyHY8RCSdFniIJFkyns039V5MQzPTfo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcuEV2PC2FiLK3jkaFbZIx4GO/j7Ney8sZugSX6r703QOU+D7WrbWrYJ2Xldv1bZ2fsmQHD1hRh/yYF5rol2AK7j6FSq09dkFw6o+mqMCVreuIjQ4LvSU1deKYFYLi/3gGxNd/ZFRhJ8Sd2x32l+VhYyJ+7uGYYUs3BKS2Zn7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=lQRCtl5m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lQRCtl5m"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366089e42eeso1644953a91.2
        for <linux-omap@vger.kernel.org>; Fri, 08 May 2026 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778267530; x=1778872330; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5+NNyyxPxYROTl5/sBNxEkLDQhLS7g8md3d9cMY7P0=;
        b=lQRCtl5mgk1zKkqsz7spE7SSpQO9F7ST94fP73qvGQ6EpkqcQuJBsa127/c0rLMzvP
         RTaq94W+TUktf1FyhXf5z64yJtmssc9GMh3MwlZc+MIGDtoBrhtrTm0nsN8TpQLNB529
         FbeYGrLQ+y1UH5Vf28Lpk/bop+DZhDPjaLi1QX0n8o0z+nqf9QYbUUyY45YezvWRWYta
         ils0IG0fgDbJeo/VJKDZ9agOlN48tv2L6ZdPAXwRwD6NEh8Q0QNo1HE4OKcVQ4D+0Gr7
         iU10GN5e6xMhAfmiGeqYNdEdWpTyjy3+xJMX8GlK8ZvjwX18T7HM17HGe0aTeqMNQD39
         a7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267530; x=1778872330;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5+NNyyxPxYROTl5/sBNxEkLDQhLS7g8md3d9cMY7P0=;
        b=kO6NjJwGgt481vDZvdbHjlTpu3x6RNzg5IybgdlsBD6ENb0pwcipHq5DcH4tRJcvSl
         AkrDBzx1lM1y5fQfkkhQqhKNtL5QUAoyoVFm/nuRkKB3ddnfEO58yKm1w1MQoMmGg/al
         rHd3RCd67uhtcWh1R5FfSEagGHhY82UfNzlJo85afqqnjztdWW63MmsN2n7NBRIMp5jM
         Sqb1sM9A/DiSLjks8tR0ZS+UiE8dB4N9SoG2KUuK18buM1QPE5ucU18LNMRUZzUrw0rj
         CaN0NkDjiDRRjhvIUw/PoaXwOHGVguxP5pjxV4EHwPFbk5GVXJrdOUGCap3TXSvY1a9T
         xJsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MUHhWVrQzsh1gNd8Bz15TdcQaaeTkqbnV5g4vW4h3Sy3RVJ3GrEOE71L8N702I5txDv6YaAatt+9W@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYJvq6WKLle+lmBgLAlMLgGneGDfxp6WXESVlpzFT3t9Caz7J
	VXAUYLdUZfSipNze++3CCIBDIhMdVNOhE8+3iA1N2Xb/HFzMd8329sjSIuVuZU62JQk=
X-Gm-Gg: Acq92OFOkum/2aNuMUqgmVHzVkjjYwPHc47CH4qfIyKzbGdLeRQyxipMzWpra9YA99F
	lVNu5Ws626WTm13Xi5SBVif7SbTTe6hstJtGqv5ZQu5P2bbyP6YnCOrVX/aQjrGY+H/UOfFF4Vi
	R/1EGBK7an6W3TDTZLHI+Ln4+O/4dgyjvzC/Aur/wTOtDIBWw3HAIa6u3QL3k07yWVLv0JEmon4
	9zM3+yAo21RmNLcp5XK9foWDDw+IBT9k7JbRyqQY9BIYm3GjE+RmBNBWO+zw2/lff9ZTNN4ULgA
	eVXuWv+nnvGzFh7GxFi4I8E48A/eqYJaKfsJIfyQMuh46Wtc7mgUhB18K0YOYFn+OyW7i6w2R59
	CfxhcptE4g56jlvUYmCdSKWWhjVkCnT/LDQNXZfqDaO/GYORZKvb06Lnciw52b3nqFehtxpgJV1
	6Wo97x5qOuOYIlB0+E7f0=
X-Received: by 2002:a17:90a:38c5:b0:367:c442:3f24 with SMTP id 98e67ed59e1d1-367c442412fmr468771a91.19.1778267529688;
        Fri, 08 May 2026 12:12:09 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-367c2ca4f04sm528093a91.10.2026.05.08.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:12:09 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rosen Penev <rosenp@gmail.com>, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM SUB-ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered
 by other areas):Keyword:b__counted_by(_le|_be)?b"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] ARM: omap2: simplify allocation for omap_device
In-Reply-To: <20260330213528.18187-1-rosenp@gmail.com>
References: <20260330213528.18187-1-rosenp@gmail.com>
Date: Fri, 08 May 2026 12:12:08 -0700
Message-ID: <7hv7cx90mv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Use a flexible array member (FAM) to combine hwmods array allocation
> with the omap_device structure. This reduces the number of allocations
> from two separate calls (one for the device, one for the array) to a
> single allocation, improving efficiency and reducing memory fragmentation.
>
> The FAM approach also enables bounds checking through __counted_by(),
> which provides runtime verification that array accesses stay within
> the allocated size. This improves security and helps catch bugs during
> development.
>
> Simplify error handling by removing the unnecessary multi-label goto
> pattern. The new code is more straightforward: allocate, verify, copy
> data, and either return success or error immediately.
>
> Also removes the now-redundant kfree(od->hwmods) in omap_device_delete()
> since the hwmods array is now embedded in the structure rather than
> separately allocated.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Thanks for this cleanup.

> ---
>  v3: add a verbose description explaining why. Powered by Claude Sonnet
>  4.5.
>  v2: remove kfree and fix compilation.
>  arch/arm/mach-omap2/omap_device.c | 29 ++++++++++-------------------
>  arch/arm/mach-omap2/omap_device.h |  4 ++--
>  2 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 79db4c49ffc9..77a75b0b9ae6 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -307,35 +307,27 @@ static struct omap_device *omap_device_alloc(struct platform_device *pdev,
>  	int ret = -ENOMEM;
>  	struct omap_device *od;
>  	int i;
> -	struct omap_hwmod **hwmods;
> +	struct omap_hwmod *hwmod;
>
> -	od = kzalloc_obj(struct omap_device);
> -	if (!od)
> -		goto oda_exit1;
> +	od = kzalloc_flex(*od, hwmods, oh_cnt);
> +	if (!od) {
> +		dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
> +		return ERR_PTR(ret);
> +	}
>
>  	od->hwmods_cnt = oh_cnt;

minor nit: isn't this assignment redundant now, as kalloc_flex() should
assign the count?

> +	memcpy(od->hwmods, ohs, oh_cnt * sizeof(*od->hwmods));
>

> -	hwmods = kmemdup_array(ohs, oh_cnt, sizeof(*hwmods), GFP_KERNEL);
> -	if (!hwmods)
> -		goto oda_exit2;
> -
> -	od->hwmods = hwmods;
>  	od->pdev = pdev;
>  	pdev->archdata.od = od;
>
>  	for (i = 0; i < oh_cnt; i++) {
> -		hwmods[i]->od = od;
> -		_add_hwmod_clocks_clkdev(od, hwmods[i]);
> +		hwmod = od->hwmods[i];
> +		hwmod->od = od;
> +		_add_hwmod_clocks_clkdev(od, hwmod);
>  	}
>
>  	return od;
> -
> -oda_exit2:
> -	kfree(od);
> -oda_exit1:
> -	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
> -
> -	return ERR_PTR(ret);
>  }

Kevin
