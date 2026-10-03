Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC7351C0B
	for <linux-omap@vger.kernel.org>; Sat,  3 Oct 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037794; cv=none; b=OOnSJSffCGGXeLs5SkXOW2OHbX5AgZGAQNVihts7eD7+CnuGGySyEv5OvadMitn/mTdwkIPexLk2DBcZp21NFHhGp8BmVRCJWOOGIk1yd9/z8zQ18DkDtjMCCAC7I3Go8jGPlznDJ7JCj6zrF84MSpe5NLMpKXiH2DVVCr4HuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037794; c=relaxed/simple;
	bh=0FDlgE8/WtKxquJ1GTctYIuuqUHSqOHXaOawd/W2wAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaNe9khNrVp87VUg8Z8lX0yYcdwTwTFK2q0VREYX6cHLd27Hfq9/ze2XAL1bgAFoM9Aa6/nmbfQPP4PiE0L0KbNUzYeGm51z782zwhJ5gP4WxsZvYxom3uqzGg8CDq7sIDsATtYai3SB5dfz7BniMkshIWOrUYFvUPgmxpnmRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfRVTunU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfRVTunU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so4228465e9.3
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2026 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791037791; x=1791642591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=DfRVTunU9jbFEsqPT9kqur/9LUCxYqIC+cipGl1i2VS8mMiqkJSoQUrdrA4NYvYU1F
         i5yqhKQBaDUnT6qZmuLwxlfrps9z2NNB/Hdl41KPPHWvE2HNvKAW15itrkWMckQtckOg
         ESuy/bZmn9SSge4YdhSFTpilIczq21qJSYMN0VhVdO4sLjx7112gOGUWV1GoyRItZqfn
         FUZnvi9uX5E50UP1/cIXtLqwIxIE5Hs7mGkwjA4UptForWelIRe9wGNegybDXpI6ls+6
         mhgSiNy1FbIthXXp48buPfw1UoEYPlTCsu3OKx9lf2IqqNUN0GYbMXqRQO+TyS7arerY
         6Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037791; x=1791642591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Nh4xYcLHpPWPglzT1Rb9TR1ScNizAo9fpmTf/BkSqU=;
        b=Z7aqNW3tQ3s6CBlMXn1fAMGe5vEm/1RnTkEFDDvmJuoq2EjEKVIIBEkmkZBk2cpE3w
         TPG2M4X093CNVTW4Yeq0qQ4vTjBYkStKaZU091HRJ6pcGG2riKYay82p/YndhtOzilNI
         p9J025ewJV+n+c77ObmpruYuniis5IaHkpH0nhnuFp58BWQqxNx9ugYaabeZ0EJ099U8
         hf9IdThpAJKEusEQ6RE4eEMgBvAwj7xOQcYQKWxMydLdu99zJiLnis19CdkS7a1weD36
         ahPYdVCaUYJpZHdLl1pKKk2qQuXGB14IhO7Wi9YeBqRFmW5rQR9Vbrp6dejQ22FXU0MY
         RhSg==
X-Forwarded-Encrypted: i=1; AKwUvBwmzhX3Q9dBWgmG0ewWWUb5xddLACR1mQRw5RzGSYxSdlwuQmJRoDRG87qUONKXYzKfRjQkSBnUl/cq@vger.kernel.org
X-Gm-Message-State: AFuF++mb9tK0F6M3rOfajLHFpQaf/O0oIg/9AzGf22G0pGJJrOo01LPh
	UMqQux62BfcFdSE6YZuiVijUmoGW/surnSixWpQSlGyj7Zjn8RmbF+iQ
X-Gm-Gg: AYBFou2zIqSLjaiWh2Prtcq/0crCY3eDY6Yls4b9IHpL3cDg2DelARcjEl1nh5h0itl
	O+501DBNH0arRLi6p/Xpso0XX5iFIPi7j6Cw+Vm0a+yGt2lR8x470iqxPG2yDrrU/5iENTInp/d
	rjOT+J5giSjsBDtHX/HWdsW9IgwDWOwzoONPIhbuIMsdv+FSjTzxfUeGASnk6O4WmsCLUymZdu6
	Qw4Ub2vNCFS7Z7xDDGjPyMiWhZ2CKGKk6yiJDaR6fR3OkdyqJwf6alIZObEguOzAgr6xe+kxqZ4
	mv3C0nqQiZKil0Qz9A4roR7+iK49Ila0MBpCNJLcy3bvkrI1YhleZeMQel7NwzKl5muGkLeB8oP
	+V2/cl/BgkRlS9YWl6coJy8vD5AiDga1pvmHcNSgJr5Qw3J3Kccu7aHwW2d/XY7v/NimcIzeNGy
	llKVDGDxX+TMtfokjA/9jC1C/HuDhmvL68oSiXLY45w+LOc0VYfS8aiyMM8bOg6BmqI5fpRiXOX
	CJmlwPTd5iLzw32zD3Qa+gPK1uOuuV8X7sVVtRodvcnrXNgf4GQMM+qoCHB5QaFwnwwCQrLTGLt
	F9v1O9Hof9Gf/Jsi49kLOwBO44V7cx7G+A/3VFRqRbJeFaNMGtlflx4D8XwGxzRC3fBxYYcjIIk
	=
X-Received: by 2002:a05:600c:c162:b0:4a0:1b77:db0 with SMTP id 5b1f17b1804b1-4a0276b86b5mr102814875e9.35.1791037791041;
        Sat, 03 Oct 2026 07:29:51 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm146494905e9.0.2026.10.03.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:29:50 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:29:48 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Alexander Sverdlin <alex@sverdlin.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Message-ID: <asEQ9o6etFua8Hof@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
 <179103680648.1402591.2581152276872666183@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179103680648.1402591.2581152276872666183@kernel.org>

On Sat, Oct 03, 2026 at 02:13:26PM +0100, netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.

The rx_mode_work lifetime issue was found during an LLM-assisted review
of the 6.12.112-rc1 stable series.

Reviewing the same probe error path in dual-EMAC mode then exposed the
older secondary-netdev cleanup bug.

Thanks,
Karl
