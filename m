Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394573630A9
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764380; cv=none; b=enVibmksF+yYUXwySeJTiZ5l6CPdOpZ2IOtzpkLe6Q88Y9HP0wDAjtaywbUa5zy3g1jXvRNnWMD6x8BVgFPdtoT+KwXA0Zfvkx0tSblYxNK7QfWNE11jcOHpPao9sGzLHbore3hhXhhlN5JCjgislBSOZ5MY6nM9ii3ODiEFREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764380; c=relaxed/simple;
	bh=ZGrWf52oeBBqADxGu14Guifyom7bsa4Hs/K5NBsfGRU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pN0JcSUlPY+7bx2zuwEYwOgS4UlZ01qf+4QCDczHdz9HLwliMqAL9AsGz5wBOgNiycl7lgz0//fq1UDxjrj0tO+Sbez0FI9dafmHMzzjVFkRpIY+BDiLMDH74Xn6gOM9LHFI/P0caKhBpIxddKNnc7HI16wUmWLfAhE1TTGpJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bI4Fm2+H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bI4Fm2+H"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9c9913ddaso8750975ad.0
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2026 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782764374; x=1783369174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/6qIpnhPVhhfHCgsZiPzBiGzVmZr69CeS6pHxnA2to=;
        b=bI4Fm2+H6hI7RBekXKlPjVKtwRAZhxBf5Euxwi6zmZDLMkGjOzSu96IVxcqW5vGR6u
         rs8CZLA3suXUtD8yYkohvdAk4Cn8kecM2lF5qlhwO75Ruu0nY1c7NeCHj3aHrmwwz8+X
         tN67Om5Cr9PaFlhaE8rIhE7m7XDo0N7wkHe9s/LGtw/DfILOtP9//9BbtL6wKg6T+fXa
         0ayoYiA6D0Sw0yiScmuYM9krAONMrZePPoqStxCQkzm3tyNmqAtXgVJAksAMhQ/6fnQ+
         ++Ba/YW8B3/9r78hSV8NKJjJLL2m07jOk934u73ea73NZhK6ZcNSbKcUJBml4SotrZZJ
         OMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764374; x=1783369174;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/6qIpnhPVhhfHCgsZiPzBiGzVmZr69CeS6pHxnA2to=;
        b=DL22Nm8cldBC6RJ01cH2oXx1+j0KmX32h8e35KktXYLzbYxvFYzb0CnKERyeesmzY1
         bIxiCY/LvNTH1pn20o/ZhWKg3CWppvKYW9V3kOc4yz7SdCZuMbHxbpH2zEXnq8LP7lVt
         k27JE+ELd+ATfY2prx6j90Xn/odYfuZoHg03VwtrjIo4eqdHUe8wXH+d1csdk/AArw6r
         34PL/Xt2YnPMIWoYYZYIaD5iY4Ft7ZRX78v5v14wH8JaW4PVvM/dQE9Y27i1YPFSMChs
         D731FWPjqK5pFS7qHxgmj/OvLVpnCD8rHCytMYRUDAQKD3NHWwUAlixmL2VfOSCrrphO
         Z5cA==
X-Forwarded-Encrypted: i=1; AHgh+RqZJBXVyq/dKcVd0vKX5jSo2o/lDftHM5CpPuO64kiNHhRdVZ1zfJ7mBEw++ujA8sLYMTZuh6HvSqzs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91N9NrHOEUoFG2UxR+VRfZdsm4OYzkDNJ6R8XmFAKhatApI8Q
	NmUTShCdbujqo0EWu84qqUMsH3EnuhtYWe+Ni/10TVrgUAzdq1SiicaZSI+0fwtjf2A=
X-Gm-Gg: AfdE7cm2JUWriEnm5EqBNfCtWgshIFVjp37ou4h1X0bq4YZQvD3WbyVe7CfbYqZ9XPp
	o04vkL9yVDmaQhCYjYNzwajH2osfA3/f5bPr3mFPRX3yM82EFzuQNAsPIfDOemgAbZY57QxAb9O
	DagzZmx5Ke4us8Ncm9MqPPjD0FBT3Yzpx9UnIh2ujbmDT7c+6ta5qJeo8+GiLlvOg6RHqqFqfrN
	C700y9mzK05R+GR53/4bC9vsIHqSd2QJdqkH6/RmexJqYvJOuisGAxb6OaHBvKu3napWT7FWJ9n
	eJ/VmecU6ECAZGT2cmLqWdZBXDJkHo4cnX3vzlLEXMUjMWaJApwDROMyI+tnwB7PDBM77IbMISp
	5cqu+IkDZvs9sffu3J/NF+hgRihvX6zKi5qHZf2YQFdurZEz3pQNYWbfJzKNEEx5iC8Bq98Cc0b
	cnTS+gMcgMHkCRKleiVHto
X-Received: by 2002:a17:903:240e:b0:2bf:2ea3:af30 with SMTP id d9443c01a7336-2ca2e43099cmr4771235ad.4.1782764374247;
        Mon, 29 Jun 2026 13:19:34 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2ca37a7103bsm126315ad.14.2026.06.29.13.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:19:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, rogerq@kernel.org, tony@atomide.com, 
 linux@armlinux.org.uk, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20260616175152.1373709-1-andreas@kemnade.info>
References: <20260616175152.1373709-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: enable things required by
 iwd
Message-Id: <178276437349.1055800.17884672250163835354.b4-ty@b4>
Date: Mon, 29 Jun 2026 13:19:33 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Tue, 16 Jun 2026 19:51:52 +0200, Andreas Kemnade wrote:
> Several crypto related things are missing for opreation of iwd, turn
> them on according to the list being printed out.
> 
> :~# /usr/libexec/iwd &
> :~# No HMAC(SHA1) support found
> No HMAC(MD5) support found
> No CMAC(AES) support found
> No HMAC(SHA256) support not found
> No HMAC(SHA512) support found, certain TLS connections might fail
> DES support not found
> AES support not found
> No CBC(DES3_EDE) support found, certain TLS connections might fail
> No CBC(AES) support found, WPS will not be available
> No Diffie-Hellman support found, WPS will not be available
> The following options are missing in the kernel:
>         CONFIG_CRYPTO_USER_API_HASH
>         CONFIG_CRYPTO_USER_API_SKCIPHER
>         CONFIG_KEY_DH_OPERATIONS
>         CONFIG_CRYPTO_ECB
>         CONFIG_CRYPTO_MD5
>         CONFIG_CRYPTO_CBC
>         CONFIG_CRYPTO_SHA256
>         CONFIG_CRYPTO_AES
>         CONFIG_CRYPTO_DES
>         CONFIG_CRYPTO_CMAC
>         CONFIG_CRYPTO_HMAC
>         CONFIG_CRYPTO_SHA512
>         CONFIG_CRYPTO_SHA1
> 
> [...]

Applied, thanks!

[1/1] ARM: omap2plus_defconfig: enable things required by iwd
      commit: 118c9c57c9a4b28209489521da229b58b43458ec

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

