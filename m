Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524684;
	b=Rm3mm5qYnnsDfGUuJX0Yt8jbt5Qz6Pkh29lWB5xWFmuSO1XDIwovUqd7l+k4D2jqu7tc
	 rpTp2Ev5/z48JRGlHiRxSiFYImX0y+cqvvHVKdiGxXXmRX3bzkPh2eI2nzIm6mkbKTuti
	 7bPQalJzHs4LhJicsFtvyQjvAdCLQYqC55OTcDTj8RQB1w5Q8NknRwH5pVcjinG5Zbklm
	 OwQzGDCz3PWJuLO9V+OstfPPWANIQeBIsdn0lWx/qgy+VKhFrxlFnoE0Bfok/Y3x/3YJC
	 Yny342TBl3DI44X/RyLjIJJUJuragVacGGN+sAB64zYvvMPVz3fahGx47eCOEPZu8EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524684;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o4aNYTMptGQMBl7Yiutpd7PzxfU9v0zqLqzMKVQ6frQ=;
	b=40v+2WloUuMSPzrKfoMPHFy2Oxlt5e573jaRq2zUYRxmN07dF3dycwdpcSOrJjyU9jvF
	 Q97yIEzRCsgsYydJLUEOBCWYSOcLOtHpwW2X0LhMIHKo304tHpXCs9ugmjd3eUr5U9Gnb
	 ph0YNhaLqOgOgS+MrXt7w/MrYkPjQihss8TaSHvdfS4hc7qMSRGPzJjx094FliOCbbfP/
	 oV+FF8S1sbO3tdt63N20wcTHeP9Nq7dGTdJjW34IZhtbMDulQFZoqWFASWodCqTEqymLD
	 rGtC2P6pfCvoPHUFJcMtW6lYFKpwWM6BzX8GLnRlzjhNTztF3wO9m38LA4QrSAQJxMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp0nzvxh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA11606A8B5;
	Thu, 12 Nov 2026 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dp0nzvxh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DCE1F000C4;
	Thu, 12 Nov 2026 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524684;
	bh=o4aNYTMptGQMBl7Yiutpd7PzxfU9v0zqLqzMKVQ6frQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dp0nzvxhEIjDNB/l7Cj5UjgjZ7xRCsZGxHLYre5B0JjA7qBQEI0ziUZvBKzA8YweW
	 vedF4k+dRdxkiGT/xs8XR/8OZEC5TXnkM9bTk8oNaKpTn7UVQ4w4R4X3ndIj8tY/jl
	 VpX93r5ZXSbDjTeb3+QmPsPI0wUCjze12NtMy2cCpYHt9zbYeaDodo1gq5bs7Jhs6s
	 iYu+HSxOtWJqqMRTLEGw9MCrCvK5DIQJc7abFyfSAjphD3O+UHUdN0noAxE5oI4Odc
	 YCg0qarG/cx2s6V5WsGgZ0VeQyZe3vaHpxDXX+2qFhQMwfwJmPxeSFP8BkbRJLLWty
	 9/KZdqkDd1CUg==
Date: Thu, 12 Nov 2026 17:04:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, daniel.baluta@gmail.com,
	linux-omap@vger.kernel.org, Sricharan R <r.sricharan@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>, simona.toaca@nxp.com,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, goledhruva@gmail.com,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>, m-chawdhry@ti.com
Subject: Re: [PATCH v4 3/3] dt-bindings: bus: ti,omap-l3-noc: Convert to DT
 schema
Message-ID: <179452468163.1934371.9660861014638910090.robh@kernel.org>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
 <20261113-ti-l3-noc-v4-3-5084dcf4ffb4@gmail.com>
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
In-Reply-To: <20261113-ti-l3-noc-v4-3-5084dcf4ffb4@gmail.com>


On Fri, 13 Nov 2026 00:24:04 +0530, Bhargav Joshi wrote:
> Convert the TI OMAP L3 NoC binding from text to DT schema. Drop
> deprecated ti,hwmods as it is not used anymore.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/arm/omap/l3-noc.txt        | 22 -------
>  .../devicetree/bindings/bus/ti,omap-l3-noc.yaml    | 71 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 22 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

