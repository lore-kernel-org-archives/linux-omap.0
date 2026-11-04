Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835801;
	b=FIanUk0X8Czt7lb4mpGl0I6RNwLKHsr01605Ii6I05vzPbAAdRQ/RJUVFU2OG4FsPSJp
	 iyi1h3FMV3fytMdDPwH+E1DvwHTgWn986hSEVlTolSbABfMm19GIWjLtwBmYf+m7ciTl2
	 3h5rBRkjSA7LArC9KB0N9+qfShUMBoLHQzqJD7RqMAZA4BnfdK2DpXurIE48vsioUwD3p
	 Psse9nuF4BkqaolbuzS5Lvp7dPTcuLbpq6HzOtOHmfc+JwRNskTdvGDc/0LzvgMt/U6oQ
	 4lnkVuAXNZu0Mtp4Y0YD/rs/cexwlU83rHqnWmJug77JB8b97hf95PxNCoDqKUWl1hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
	b=O7O8yPDglnbhq/U2kTcoFs4m+kxpBteWsse4+TGpc9pN1EAcy/mPKuds9vHKrvdCL6zb
	 /0E1UCp1XYktrHvGMRywMbSbTTxqkt2z/v9LiP3aO7J0yP8LlKcvbj7Vl9sTZzoc2ZVcP
	 w988tU/Uj/Rr8M7/AyHXNgvqzFJCOnX8J18MWWpeiDhLg78Q3s22Oj+zwMcnfpDv7gf7c
	 Xnq7RzMsmR51PM1b3quvTNrzwkLejgIIL2UhwmCzdZoGAzOxOf7sEoxa++9WOWB/rYlhO
	 dIySqHUwAbVMpIHVbqEk6Mem5EZHd/SCw+a8W6t8IPxsxIt1qUodlE/ZlyJ5kLTF8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTUWy8jM;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC489606A328
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 23:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC489606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTUWy8jM
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso2444882eec.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835800; x=1794440600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
        b=fTUWy8jM1PsytsBsChYqVoszYkib2vcZrvOgSPKUcKRvOR2J5KlKs9FxUqVw8q8iFH
         Bc+DyvtMrivviUhsJf6HrM086DGRaC5KbowncGQ0/M1apkBieWLL4XEYGda4IKzCkmJ2
         9tgEdaQrKAJOCBGJVguKlOnY6y+l2arA7bXhdD70ekFiZVw+fh+PCR3KJK+teTgWZsx3
         Iex+BPdW4t5+1bylYB+A8YBcnddCBGtf4ZdVm56baw+25ZpVvLrU3v4bmPyA7c14pL8V
         9lJaNEMZH6a9oYqTug2PXqB86vxJCcWAXonEuz9BAviQY67Uf4ME4EEbBGhTn4ua5j8m
         gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835800; x=1794440600;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
        b=Oe6juoAIuYQbrPyy0qOqh5MepWG/dZc6n2CB/yaA2+EYYhwXOGfYFm1u0xNSj8U4uf
         kxNUkgwtGaifb2ZTVUBq0RvfTNQfTMtFA0d7ww7V4jZ4spdzTMdXUn92czcBv2UpLYPo
         wv4GUD8NjmRuWnlaRAz16ciZVaS8gWiVj2DXNi7THs3orlPVqFvoTpMuvXrU6pCgFgQl
         7If8Ff4eAgdl/0bvZS3fncOgRUxOVv3Uqd6JU7mMpWkIDe8wXw37jGZIUBXiM0eY8U9Y
         bvs2a4VuIJHUbLMOjtXYZHvPWskmoyoakM2ojQ+z1hr1bArHjo4W/v5EnsamK0HtdU1d
         1g3g==
X-Forwarded-Encrypted: i=1; AKwUvBwa1Da4j6fHEut50wxC93vhDtddthi5gkO/jfp7KpRl/SwLYSVxecLjV7CQLLbJUl2XsgmO/TtsYGxe@vger.kernel.org
X-Gm-Message-State: APuU4Z+API/vHv7fJal6Ag1xiLFn8fI+zpLPf41zd1/VkZV+s2XeWyhV
	I6r3DBb2pa+20JyeEzgG3tm4Rhwi5WZqdZi5CQXIvPQO1MoTW7HAkjSY
X-Gm-Gg: AYBFou3f21biwfNgyBpdaDQBS1dFP5cvbqJDyakkXXZwNpVMkRVTEz+P6ewTXxp85ln
	emoIXYufgbshWLTP+h+AfFnRSWEhL02UIGo4Eld5k4Oi5GbEr0YDpK4coHD01V7vVyGjlPpJNcG
	SvK/3LBcVKe0cGnTqfIHGl2NIsqyCNZuq6k5IRdg8UEVESrMmNqI3rpOG+VS+36tQhcQQ0vOUkI
	nWiFqJaQYSCijkpYHvYQ6H8gKDynWzjeyNpyT1MtGtxhNqzZZIxFM4c/eIilsUVtIj69mSydJE9
	h7PBbhoWI17cg1QC6jUN94+vkp4dWT/G8KscKV+YzhGQ8kztUFvnChREDzXUtp/GMFn5WjtLDNs
	208BI0hIdgYIUG0/w8meu3q5M3clSzY5kJHbtGV7y4e1aOLlfIAo35Xqxoe6UrymhHCl+eCvoaQ
	6KdWgjfV91ux6WqAoNVFEbx3Qd6Eh79yqzjia0+u9NdIuvh1RZV7a9encMO2WEK1galGZHzf7NT
	+VxGUj7FxR8IWK3PjqdOC1dvUWOWHFkqiDMr6f05crVImPdloGVl0DlnKUB0TrKQ1pBApj6ZQqy
	FrTLtkhwg3m2qM30WlEvQA2Nocl7fMLs8D8394+T1ifEAK+kFMRn6GGI3Eayh+Yxu3mb3A==
X-Received: by 2002:a05:7022:b053:10b0:190:da74:2c89 with SMTP id a92af1059eb24-1ac5bda4447mr27386294c88.21.1793835799860;
        Wed, 04 Nov 2026 15:43:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm12650219eec.12.2026.11.04.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:43:19 -0800 (PST)
Date: Wed, 4 Nov 2026 15:43:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: arnd@arndb.de, marco.crivellari@suse.com, 
	bartosz.golaszewski@oss.qualcomm.com, tony@atomide.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - do not rely on debouncing
 capabilities of dedicated irqs
Message-ID: <auvDDyECLJsQdIu9@google.com>
References: <20261104185044.2551808-1-andreas@kemnade.info>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104185044.2551808-1-andreas@kemnade.info>

On Wed, Nov 04, 2026 at 07:50:44PM +0100, Andreas Kemnade wrote:
> If no GPIO interrupts are used, these IRQs are unlikely subject to the same
> debouncing mechanisms as a GPIO interrupt would be, so stick to software
> debouncing. Experienced on OMAP4 using pinctrl IRQs.
> 
> Fixes: 3717194f2492 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thank you.

-- 
Dmitry
