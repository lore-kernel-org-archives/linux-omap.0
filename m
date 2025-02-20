Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE319AD8D;
	Thu, 20 Feb 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036225; cv=none; b=YB3c6+x3GvbZnr6WoVxc7QsYBdniLB8Vk3gIFGMHCxMCETF31VXNXCLUv6Ut6DVXIGJTrnlIc7CnxJ4cqtlKOxnSMylZrAXZhKp6tiNDmpWrGSb9+0qNEMwTyfcRzxNhgSEw7qmjcBlXhKrmZOGjrfnDp1XP/NIlWWOOwi5jdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036225; c=relaxed/simple;
	bh=coKTrJXRY5YJVty/ywvDgaPfSuPlIir5d4ohg0YS5i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaRgOqrkKZ0BBLEZuhK8jgyhAeYm2qwID1iiAR4oog3pBg60BaUecfMcQftyAgW+jApSBZD/4Cylgv14eIArbpUv+a5rOlgEYhIhFe43wdtpuaVWGrKivigeSibS6O5NcJNG010FE1lns1AI7fcJHtnseYrCLsGR99MeiDvaqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HtZulXJv; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HtZulXJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eZakjKfpdd5q/kOY1YxjEFOCLh8Mn5U9WJBrLFqWMoU=;
	b=HtZulXJvCYpp6bfr1Cb1q57qdDU/Er9FqWwOrtMwATooCFvidhbTNuZJX9gL7O
	KXUV9PwUIrDoEOLYsQ2V/h7z2ntDNgBQewP+JB0TK50V2pS6Tpd/MMY5yLPrYLyt
	evbjfJGlwDs5IBZkFZwkhijtRW95OeRGmq+2tn7D9JGk4=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHrBFK2LZnqKBgCQ--.19831S3;
	Thu, 20 Feb 2025 15:22:52 +0800 (CST)
Date: Thu, 20 Feb 2025 15:22:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nxp: vf: Align GPIO hog name with bindings
Message-ID: <Z7bYShssqtqLusX0@dragon>
References: <20250115211659.194072-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115211659.194072-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Mc8vCgDHrBFK2LZnqKBgCQ--.19831S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVcTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgr5ZWe202UXKgAAse

On Wed, Jan 15, 2025 at 10:16:58PM +0100, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warning:
> 
>   vf610-zii-dev-rev-c.dtb: eth0_intrp: $nodename:0: 'eth0_intrp' does not match '^.+-hog(-[0-9]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

