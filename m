Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567092;
	b=XHRjyVwuR3pMcY2q3RhVKb7nDy38AWRP7zcWwoLc6wr+5x90KIGrggGrjkIIfNhvp7xA
	 KohI1THWcY2VEwLUMhOqwDMB5nj+eFNSVgW22t4swSRlJtRIFgVMnRwSRl9HyK9lvHnQ1
	 +Ypl6vHnAY2GdCjlYvL82krgk6RAo0tBK2Xkq3i2t/Cc8dH8UcWp3ts/Ib2XkmabQ1AyK
	 US4rr6FbkmioR2uYHgm0NFYTFa40TyzNqC4fqI6Ot/PrLUVcO9qzpOMi6kJBTK/y7yrkM
	 LPmTdOC1RGIMGbfa8jEuJxL81SRq22Wk6+RdwwuRfjAKMXRezRWrTDTcm0/ehsQbkEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567092;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lNfFaUTSdkkBp8Tqa8Jl9FkXvNAOBU8E/OtT28v8o88=;
	b=rfGPCFjZdW9igw1bUyrX/LMQ4tHETFwx2LiqviM42ies4LhaCDSanUmVxFRfgUgyhOW+
	 a1G0GRHRfGYrHmTNyImxvU4Xf6ugZ9aXg7XlNDqU+suOijkt6TNjy3zxgyQWxIa87KNtV
	 seWpx0LoMCxR/U6oHBAOv6N+3kdB/50L+J/cbs/AO9xvK3Rp7VlfU3doY++B76FlNqOhi
	 MnjbTd5Y15jVxU8pE9qMu6H9gLJzj4voHv4dAwK9yjx850GqAVXvejEXJgO6kEmTFvODe
	 T5nNmv2fwOAmRKd63ALRxkYt5fI1u3aVkz2auQT9boZYbZQLhvSmu9COD3Dy5i2DbAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlRJBaQm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558960A261B;
	Fri, 13 Nov 2026 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlRJBaQm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC41F000C4;
	Fri, 13 Nov 2026 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567091;
	bh=lNfFaUTSdkkBp8Tqa8Jl9FkXvNAOBU8E/OtT28v8o88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UlRJBaQmQsw5V/e5FTX6HfETAEv29/bV0GS27Myu2wd/Eq5Ds8M6UK8inUYzgZH7f
	 /VCTquaPd86OuW+bAWWd5Dz7SAribwihhYFyCj5yy+Pv8KWUqBnRohOo/d51oJem3x
	 IqUUrAllfdPMTBB35z909mMmI6Lvld+Gp1+DpjZCSQPMkv8W5f2q8iInxUfGoxWaJH
	 wrYhnecoEubyuD7yEvJ9K5WXE9FBMlK16lCBUDoLQzPECbvKpgp4LsMN9+w8AZJHaH
	 d7LLatUaHUpjgp3BF0kI6oz1B7JPgCSVK69qZnixgNFcHy0TYFk0+miS/wwegYxM2X
	 RJlbDZzBYvBGw==
Date: Fri, 13 Nov 2026 11:51:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Mark Jackson <mpfj@newflow.co.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: arm: omap: document BeagleBone family
 board compatibles
Message-ID: <20261113-burgundy-malkoha-of-art-eba2fc@quoll>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
 <20261111-ti-omap-dts-fix-v1-3-19022d1ff4b4@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-ti-omap-dts-fix-v1-3-19022d1ff4b4@gmail.com>

On Wed, Nov 11, 2026 at 01:22:33AM +0530, Bhargav Joshi wrote:
> Several AM335x boards derive from the original BeagleBone or BeagleBone
> Black and chain multiple board compatibles before "ti,am33xx", causing
> dtbs_check warnings against omap.yaml.
> 
> Document BeagleBone family boards (BeagleBone Black, PocketBeagle, Bosch
> SHC), BeagleBone Black variants (OSD3358-SM-RED, SanCloud BeagleBone
> Enhanced, BeagleBone Black Wireless, BeagleBone Green), and BeagleBone
> Green Wireless.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/omap.yaml | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

