Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AD473C6A
	for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817309; cv=none; b=rFdReYYVCah2KGWO9vrtiGvzz3RRXI7NUkFkc7V5L7dKR3OXtJSz6CRY8+OPw0+NemLmgGlYMmizq/JC+ZwEie+6gfiZHwPZ5QxqSWAFSYAm1r+9Wbe6WmSKvVldvENdkyVcT84XlqI0MD6FxU8FrtioSsf4DCn8JQ2lGEMy02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817309; c=relaxed/simple;
	bh=m9SnMkUX1tTQB6NO65dVN/roFkfDpAoBwsExIR6ZDZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaOWRjRrSGRppxWVafR44LLOjhjsfFBy2cqXaKTvDDughBFGhocwqYbgWQuCT7gcGm7/WbHmPP0rurb6mk03Wnnile3JuwLg/KMHuSnW5POjBRhfPWph6aHMpatfUFd80ij6e5QoEkc1YbPddz9IYvkYNHAdnGMTZYIOp+m4RNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inZzuX28; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFIxQxKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inZzuX28";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFIxQxKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784817304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2njy+/zspbCzy0izhWL1wi7/dDBKbdf0HpY/B2TDfoY=;
	b=inZzuX28a7X0PnO3PerjK3Ma1UyDm3N3HNoG5cSg5HyHoI82p/7+E+Eqec2Bq8pCI8hQl+
	MhNTSgkYupebODPEXs00zjN3+KW5/L40aLQ3yKtnMsK9EzOAXV3rq6EwSdt6Fuu+4/WqTZ
	aoUJb9tlxaEhDUr/2mDPBmGSPq071g8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-W_HOk2w_PdyuwLtlwROoJQ-1; Thu, 23 Jul 2026 10:33:38 -0400
X-MC-Unique: W_HOk2w_PdyuwLtlwROoJQ-1
X-Mimecast-MFC-AGG-ID: W_HOk2w_PdyuwLtlwROoJQ_1784817218
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907c59bd65aso12956786d6.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784817218; x=1785422018; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2njy+/zspbCzy0izhWL1wi7/dDBKbdf0HpY/B2TDfoY=;
        b=UFIxQxKvshLj6Ov7uMzFME4atQc5u7W64zO12Z8b2SRYQgMB54b9cZIa1cXP7Chf9K
         IvCaj+TkG7B9r11P0iBmuo1iln8tHE+WwQA7OR96c2crMwBYnzLjANbUtbzDm6QXUFS5
         duFfwKGT/0LhO1Jp+r3FFqqHfHoRFvrIPnuadW14Z9f1R3rfhGWVrlM84khYI8c3EfcF
         MapV7dKNfqR0qBN5ajsN2+6fhd9uxUVNbvczGZJpjJpk+P49VlByocb8B6FIHbXNnnmY
         zb4L16bMrHvqL58xQqpCBjGsyvsW1xWhN5GyS3IJwDcZY/c4GaEfZboMQVkNXmgGBJfS
         uieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817218; x=1785422018;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2njy+/zspbCzy0izhWL1wi7/dDBKbdf0HpY/B2TDfoY=;
        b=UgtbE3VhLIH7diwPojXuGTH+gqOPlVno7TvQo1iOJ5ASDdOwPNg7RlBqd0KbvVhm8x
         n4a0OSHVTgT4GElcF7InCqGjmNbcmSOGPJPIWLgBCyvpGbUWvMGDGUcNu/W1TDXiGGg3
         /qPOlBbl9HovVp7I8ABEFJDsKZGFK/Y03+Kysf5+LwjlkccJGPRFqunY3VTVZ7Y1VXBG
         CpUSAlRCWrG7rbY1fCGDOWyllXtzgz2liq0jOpSKg9pZejOLPe5907w/Qzk7M14Xd2pn
         L2mO4kL+it5WWhOpA1KwzWv6y4HsmMnGkM269jcE+90YrPDBm1yXXS0XGOgjsT3i5hfP
         NViw==
X-Forwarded-Encrypted: i=1; AHgh+Rp16oOraRh5oIiVb8vSTn8eHaVeFaKWkA4Psw7SujSzBtodmNyXJ18dCKve6RwPw4wPcE0vTbQP0WHH@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4R0VwJenfbSZ5AtqR0IxBzuZyMXchiJbct2OvRSnBGPY2t7f
	sIqYcF7SAzcH99585jakLJ2JT9PjJpSbsuxUn6u6G5JHnqCQN/+PgNC8AkpActVriEDbt2BCaH2
	MgUdkbb4+H9+h9081/YTsxMYwka/vq5uKJfVnFWNcw6s9x6Vk1M4pwD8kM2J3hvA=
X-Gm-Gg: AR+sD11+txDzKKqKVDPRlsixFVr/ZftUdnbkT+6yyT2ywqyMCfWQT8cjCQYmAyA1aYx
	o8y+3GK5yCTu6BBd6XVdcuwcgv88h7elIH5FPJBJjGX15qbhRJSnF2XWNxFxebiCCoTTwT/jYGh
	lA9meO4sSyOHGGChdxmq6kRBzxqFcGowGM2uIndL0HzgqYanusYOOklJl3SxNzq12bQW4GmwbxA
	Lco8NDsipumpb0tZ3lk/aEQntilaygCtGoWuXz6CM2HR9BNIrDmeZRgatw+DBrOstC6DyJczrKs
	JSTihfS/6taAzVQsqZ9bi3BWPWx5JhvVjDkwzG4wrzkJZVeoPWoeDhjvYdjTgQuZZeeeT6pNMHH
	7TWBg6CrCj4LHsdn8IYCR/CFvdAIy0yLKgDk=
X-Received: by 2002:a05:6214:2aa5:b0:907:aec2:6cdf with SMTP id 6a1803df08f44-907ca363063mr40225966d6.8.1784817218167;
        Thu, 23 Jul 2026 07:33:38 -0700 (PDT)
X-Received: by 2002:a05:6214:2aa5:b0:907:aec2:6cdf with SMTP id 6a1803df08f44-907ca363063mr40225316d6.8.1784817217491;
        Thu, 23 Jul 2026 07:33:37 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b5f85sm46744846d6.2.2026.07.23.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:33:36 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:33:35 -0400
From: Brian Masney <bmasney@redhat.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH] clk: clean-up simple provider misuse of the consumer API
Message-ID: <amImP6sFlv-sNhMh@redhat.com>
References: <20260723-clk-provider-simple-clean-v1-1-0c9668240467@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-clk-provider-simple-clean-v1-1-0c9668240467@baylibre.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Thu, Jul 23, 2026 at 03:20:59PM +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
> 
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist:
> * __clk_get_name() -> clk_hw_get_name()
> * __clk_is_enabled() -> clk_hw_is_enabled()
> * clk_get_rate() -> clk_hw_get_rate()
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> The change being very simple, I did not think it was necessary
> to split it into multiple changes. If you prefer it to be split,
> just let me know how.
> ---
>  drivers/clk/mvebu/clk-cpu.c            |  2 +-
>  drivers/clk/qcom/clk-hfpll.c           |  4 ++--
>  drivers/clk/qcom/clk-krait.c           |  2 +-
>  drivers/clk/qcom/clk-rcg.c             |  4 ++--
>  drivers/clk/qcom/clk-rcg2.c            |  2 +-
>  drivers/clk/renesas/r9a06g032-clocks.c |  2 +-
>  drivers/clk/rockchip/clk-pll.c         | 24 ++++++++++++------------
>  drivers/clk/st/clkgen-pll.c            | 20 ++++++++++----------
>  drivers/clk/tegra/clk-tegra210.c       |  2 +-
>  drivers/clk/ti/clockdomain.c           |  2 +-
>  10 files changed, 32 insertions(+), 32 deletions(-)

This looks good to me however can you split this up by clk subsystem at
the very least so that the various submaintainers can pick up these up?

With that:

Reviewed-by: Brian Masney <bmasney@redhat.com>

