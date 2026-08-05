Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3E3F1AD5
	for <linux-omap@vger.kernel.org>; Wed,  5 Aug 2026 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920667; cv=none; b=R0Hhf0bkoDaxF3BvpVWxZ8JcXpEJNkLeAik6z1vab4lbLE6HnDCPjUdXE58Y4ew7RS/jYOceUXRh2ZaYMkw3mzMWjX+ZKFDJxSqnpUEosQn/FKu8+/z5bIwcmxap4c6CsH7A5Ea/pcdVjil4IBg4YGorupgX6F1tUu+GbrF1v9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920667; c=relaxed/simple;
	bh=8i9bOYGYQzHQYLKHdvPuhGvLZ2p2ffvSKqoVSbpRvJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzCl7mR70fT0LqZ0rGaco00s7JWhPd5YQkMQOG3c/4r+gJCufY9z+VSS3zbX5e3qwLc0DECugVWfMFbyB2GBFkN5bBSCbiEvUDp2XLzPau1R/Log7XMDt8vW/4sSTshq8eqVSswCcsU8bc7i6B/LcarLdnIipjU8dbXrf7qMJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=YsRXNOrx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="YsRXNOrx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955de8797cso4582085e9.3
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2026 02:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1785920658; x=1786525458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8i9bOYGYQzHQYLKHdvPuhGvLZ2p2ffvSKqoVSbpRvJE=;
        b=YsRXNOrx6eb9xeLrTVvf7fMx0nK9A9orhsVCbS0zJZUwNkiPvgKzR2kzM4kXwGma+j
         Xb7X4nILybHVqaI3MATi4vcw+4kx8bwfxoUGpi/IdZT0XNm/1uR7Q1W5nqaq542eUqZy
         uzWpJSLANCdUieDtgMQmXcWLLUfA4qzy17Syg+jxiW7zYZ+Ovag+uJE4tkHW+wLaPPE9
         xvhhk4xzJYa2FCvhgXS31VsGygXq6hltLHffSrps3VhtD8tsSlScKFTxLDxnzAbhbZz4
         D5gQ6GfsZ89wHkVQ6iP5uTmccpRNkg8k+qQfhaD6rLC/OvHhzUu4ovFnE147LQH20oOv
         ZxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920658; x=1786525458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8i9bOYGYQzHQYLKHdvPuhGvLZ2p2ffvSKqoVSbpRvJE=;
        b=hfx4J9+aCRgnzUrasy0zv9av4zbMdQB4+Ch0n0yVGD8LOOX7YrB6cX5jXSnpLO1+zU
         +xi9JEC9LxzR/MBWuLqXv4ZOATH+7CSVJOtKvzbwawDCCeUTFpjZqertvUQUUg+G0dR0
         /kqj0/9/tXWMNyQXMCrhichymjWDGKlXLECCzCVJ0IyBx42YHgiAnek0+mB4Ieaat4B7
         7wCiNBlD0oZ8WV5x+pZiy8a0eTRJ7SZC1QxTM6nYhPVk0fjIpNNJtdnphAMtyBcz28gr
         MQ6OGyTP0hVSItYKOtHDCnaYM9u5c7r5Tk9Pj0ahP3/C28L9SvBWZmr5+TsswcU8UXPp
         OX1g==
X-Forwarded-Encrypted: i=1; AHgh+Rqu3YM/Drg6yFojqUPpoVmQt3A6dJelksK418xHivf0W3skPI3apSCkBHYcsPnNBqM2pUvn00ltMM4l@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNbtsX4JTkIxE/wyzv0VCCVx49bNr771ySqiejXzKLGwlqF5e
	0kWkdbEXSMnNIqoekDbBuU/XgScyoi1W2LJIJp+W4Ohohpq99quCGqG1UXh8e+cHE1g=
X-Gm-Gg: AR+sD122lJa+s4ldtgyNaYcE/BPJubi5sTrd3ea/KF2e67j5IBVz+LQu2JONl0dNq5M
	OhIzYyjW3rXGxiaSreT53btmzcXBjxlIQMZdH1x0s4SkiDG1J41V/KTWILljyK6tfzRaTMb6bFe
	f73bitYtprDcDeFOQuDkt1qHUSmeqUDv/7WDdOBCNMv57tBjG04ePwLZ0+Rcn0lUNaCK7JaGX6M
	qIQ5WW4h/JZhb95uX/pgmhMAYPRRe2U2uNTcvZeUgq/PA9McxEkVZVt3PAoe/pVA+CbRkSZYTjw
	xmexnQkshaLBccMZ3JEKlfC0XAHj1AogrDcsSnWlXQCup9Oou3BI35JX0N1Qwzsc/e5UUt8cEdh
	UYR3W+YJSN4UcyaVEDi7xoYruqt/dfgK9jl2QhcQEbyv2XoRknJC02eSj7u+OWIceFM0ah5etqu
	UFEOa12tB25kaVz2NlSvJtyUyho4+r0PxGuUyr322xkvOM9TKs/Ad6CaSjRBzg5X3GHz9M6auWW
	em1B+OWjGA=
X-Received: by 2002:a05:600c:840f:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-4994e7111e4mr54811415e9.3.1785920657181;
        Wed, 05 Aug 2026 02:04:17 -0700 (PDT)
Received: from [10.115.255.165] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e5192c5sm48097755e9.1.2026.08.05.02.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:04:16 -0700 (PDT)
Message-ID: <e406af59-53d4-42d3-8e3c-0de552612567@sigma-star.at>
Date: Wed, 5 Aug 2026 11:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider
 definition
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, tony@atomide.com, rogerq@kernel.org, khilman@baylibre.com,
 andreas@kemnade.info, aaro.koskinen@iki.fi
Cc: Julian.FRIEDRICH@frequentis.com, upstream+omap@sigma-star.at
References: <20260716113947.92513-1-david.oberhollenzer@sigma-star.at>
Content-Language: en-US
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <20260716113947.92513-1-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping.

Greetings,

David

