Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AD4570FA
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006794; cv=none; b=O+Zj04mRWbrqSnzK695klw5WccMtnou1Rjs+zoxbu9sHez+7EhcOfeOAzKhdO6gJ/QD4/DtL44l9q+I87dPi0zUbDiud6U9+JBbRFDBShz7UU0mKpPh5AHzPdxg6HgVsuurx5W/sOQQsXxI06JZ8JWg6bUTXqS7CjqlZK0EB0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006794; c=relaxed/simple;
	bh=UOTeQSx76a9v/ZV3YujOIEiYlAr7+SRsnm3/O5Z68jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LHRj5271k2xtjOOFjQ9J+JZkeEFLGTPhnunUkPkc9704gx9iL3tAtjevNtjGGnQOu1nXiPJyBJFvOgJmCRsixbXnNc3qqJCQJkjnRDWL5mQrCKy8UI9ki6aJXRuWqGe45+xtZHuxVHtlpqX/WlSwgSwNEaCf7rWiG5uACw/gSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jNIPkims; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jNIPkims"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so4404096b3a.2
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790006791; x=1790611591; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOTeQSx76a9v/ZV3YujOIEiYlAr7+SRsnm3/O5Z68jU=;
        b=jNIPkimsgzwGeAPw1T5J0ZZWbbWbvmf9gqRj40Y/atoUYgKG2yWh3HESwt6126nUDp
         FD+Rmk79KRReyBBYIl4nF0UXejvRBciVXLpQ0x0P4HGhci5O8iuKBzqiPsMrmLMZpiFB
         lTbphc8C5mH2TgoQvoSliu53nlAZUPM7gnPf6JVk1XoAUGXqWGbf8eYG4gdjGZ8Be6kE
         0hW1vjiNk54/tiLuCoDH+rB/8p0unN4PncOQIY7I8fOQderqwGHSfRx+8mIky9QBPvd4
         jWCVCSqDpodMotBD1r5UZ3EgftUBugTYiLbiO0CekAfIDwDxZ7IOPCqLCaPurh0VfluR
         DhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006791; x=1790611591;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UOTeQSx76a9v/ZV3YujOIEiYlAr7+SRsnm3/O5Z68jU=;
        b=1p/JT3yl0FHBo9DDEYpzD6lZjtRodCfLDAAtmnlVoQfmDd1gj8V5wvsHk8vc7PJ5LT
         H24Iov1cFm2qkFB47N2GBPQQzY/8HjcawyN6oTFhXSC4/LgbJ9tYlj9+wrQ4Vjf/bt3Y
         auaI2kgjc7pyLg1aHDcBWeCq2RlmLSxYYzPbvUOIp6YD1XUN5Vc97NFK1aIWwUimrjAd
         jDSQNwH+7rE6AoCjCFs9+EHKC3bHNAQaKpb3QE0o7C/UWkM5o1z8NyU7ugg8Au3jOyim
         VdgDHbOzkYBmTlAOO8vrA6Zy1s0iZgfPGg48vf0W4L61FIpe2NNtX43eI65BmW7o0kwL
         31iA==
X-Forwarded-Encrypted: i=1; AKwUvBxRgoijbR851upvlBujDYkJbgMxJ5w89kl7zVmOH069eQZgzgnk67/jSA1/IwMWkFAwh4xMzn4rUzmx@vger.kernel.org
X-Gm-Message-State: AFuF++kme2b+Cdzg8qk36kucJfb4GeNlw+AogqL/nf6C3bNHfZPEVwgP
	ligR5lGWsH/fhlCUnIEUPFHVYbW7941PxT45mKIo7/tzJMacbhsrkgD1DqQnhh/RWR4=
X-Gm-Gg: AYBFou1Xx5P/vLOu+fdqNiOH7C3ZJB81QxB0yMlzrpah0K1mdWnKL2Tqz+P6Xs1DjR0
	puUwzIgmlV+bt3jSj2HmjuNTBUCGhgYQdc3hw4m8dlDXsXVGe/ovpfZ44+9nxINapgqNSNcgKPs
	cao2N45ruNQb32dqBjcbasvsygz5i3arpVxs9P+UnAgNi6jcoxQCCSS0gNZ8K3xjHlwqfb1ZquV
	kNOMVopP47iTQRy/c3HmG9+U5a4lmRbVhi3oRBZg6dddkRCOIn1e44JYs1md9OUP4VqGyBaZE6+
	Efyy3JzgePs9jANm9ikTguku45th3YCEf1oembxuMJSx5bUuO0sTMetjSff7U0EpfJ08sLVqWEa
	Nglgo6P3+p/WocNJIkDczQ7jj6+BTJTNuBe4LUTXhby9+59+ZBmklYRHiLzittXHlm4PFcmXPQS
	cdMk4IcrfkRR2i08h8AWJqWfSwlzOMcYvQrENlEXT/v15PnPb95NlAtVGeGw1GzvtxoN8=
X-Received: by 2002:a05:6a00:ac8:b0:878:34d7:6a30 with SMTP id d2e1a72fcca58-87834d76f20mr8319100b3a.36.1790006791257;
        Mon, 21 Sep 2026 09:06:31 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-877a95f915csm3487490b3a.29.2026.09.21.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:06:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>, soc@lists.linux.dev
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Kemnade <andreas@kemnade.info>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul
 Walmsley <paul@pwsan.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Helge
 Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Aaro
 Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 06/14] ARM: omap2: remove omap24xx support
In-Reply-To: <20260914140821.1805449-7-arnd@kernel.org>
References: <20260914140821.1805449-1-arnd@kernel.org>
 <20260914140821.1805449-7-arnd@kernel.org>
Date: Mon, 21 Sep 2026 09:06:30 -0700
Message-ID: <7htsnid1x5.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The omap24xx SoC platform was used in the Nokia N800 and N810 tablets
> released on 2007 and was among the first ARMv6 CPUs in products that
> made it into products.
>
> Unfortunately the early ARM1136r0 CPU cores had a number of quirks that
> caused a disproportionate amount of work to keep them compatible with
> later ARMv6K/v7/v8 implementations.
>
> Drop the support for this SoC in order to allow removing ARM1136r0.
>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de> # omapfb
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@baylibre.com>
