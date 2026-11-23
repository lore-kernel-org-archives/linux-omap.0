Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439168;
	b=M8yOJBX6etBDTxHFXdGre6BgRE37crTsTbpy/YMgGtek4MaAAB4MxtEoA1yrMgCUq1xw
	 +Mg6XmM87gW5G2ZkWTWnlvwdrJit3z8QCoUKQmu5LtEFw8PRuyvpy5rM8Q8XWfxuOE0CF
	 V3nOT/5z1EHViypEuvthgZ1xS8eb2uUP71nL+qd4qilfPmCjuUgxkNl8W1NrqgX7tl4N2
	 Z1rkOp3ewXH1W+QYmfTjRFw1Y3cpQMxSwsl8HL0SN6S4CW34MRDMZ5IkkwptmAdVv0sCw
	 WuFH/Rt6giAuxdbsgVfBVFb0IJBGRHMs6Lb9yWXrRoUUcM++XaLa9pCou9Wz90lNNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eBZpwWyrav8yuFoA0vlExqV8f7U0LYTnP7ApT9lXYes=;
	b=finHutDsmTJ0/V0bqjw6Fd4YSHbibYu+GDFjaWqJt61PWVOGj5geCuCy2NBEdLvnPlCU
	 EB9l5IxzBofrK1mH0VZCwvw22vRfRZ0k2BA3rFX5qJE0mQhDjY6M60CN22BzSarDQoELz
	 uM3ScXtCwPtw1kIXFtrHhUuZM0TPkZUxSHaHNherHz8Hk9iZd84HyEUfhmOtyRiS9wTNh
	 TJta2S3/LRJxa6fMTuWPdna4Hr3DJZxrLotQohv3GrML2Xi8hSX4dDGAKNLmxriT71NE6
	 3Nae3uRxPnTII7F7IDhcjkAq3GgvDmjODa66v4GOe1UF08iLDfTQ1s5SLQS0LwxNHDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=HLUfPuM9;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B2606A31E
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 13:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B37B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=HLUfPuM9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=eBZp
	wWyrav8yuFoA0vlExqV8f7U0LYTnP7ApT9lXYes=; b=HLUfPuM9FNCHsI3arcOG
	sl5EvTAt3bcHjlDovFKX/t97wlVwrtFgMHUR3JNa6i6XRTqmtPCmZuDXXwwg/Cq3
	DxQjcCOdLyZfUx96gTCglcABU40lcoLqg8+7HqUgzPNFhaaWgvnHYust6tPnpSRd
	BY4swjsM0Zg05+BAOSsugoBxu8p2jBsrFTXwa7yysVkTm6U5ILkZqhyAo7uDdLPP
	Jrl/6LXbqS+QWDBbGN4IaDsjTxSLYhUicuYZ39pyC1B2/PJTcqCBvjTrIt1qG0KY
	NAAJTXeqVetCqNfCOPmpOdYhJ6ttWd3Qd+Cm+1Hi9AaDf8uUr1QaMD7c75/lGndr
	Qw==
Received: (qmail 2734891 invoked from network); 23 Nov 2026 14:06:05 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Nov 2026 14:06:05 +0100
X-UD-Smtp-Session: l3s3148p1@lz2nQfFgPr8ujnsu
Date: Mon, 23 Nov 2026 14:06:05 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
Message-ID: <awQ6PXdLz88kI9wQ@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
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
In-Reply-To: <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>

On Thu, Nov 19, 2026 at 02:40:36PM +0100, Geert Uytterhoeven wrote:
> Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
> clocks used for power management, so the latter show up as "deviceless"
> in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Sample clk_summary change snippet on R-Car H1 Marzen:
>     - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
>     + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on R-Car H1 and H3.

Tested on RZ/A1 (Genmai) and RZ/N1D (demo board).

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

