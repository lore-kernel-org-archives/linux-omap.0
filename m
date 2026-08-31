Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F15429CD6;
	Mon, 31 Aug 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184180; cv=none; b=eDnRfQ0RnGUKU4TkkfVrvKwwLqxOOkiggwlCx4bLJuosq68PWUjL/cGqUVJ1BKyTvR881QNIBbGqVGsmnoxvrbRSWXk8kegQwgRBN0usJy5P/kAeqcJ2cj9BeBsqUaKLT1rdyKXu4Bvb/05Hczj5jlb2dtpw5tp5aaSc47nd+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184180; c=relaxed/simple;
	bh=8zPePSa3Wg0zKdjo5hJrOUrideOW8gX/mXbmzv/Buqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgdfXYrbKDl5fz3FuElx0wp1OpNm+11oUnWRQlt9/hANWUd3qwGGbzm1f054U/5k7FlGkdD4SVKKfJuFKrhqTsANdVhrTrrS7dIwn9Wh1qxHw9TSVpWy87M5ppdUPZEUkD0NxmZcl+KvF/ewCrQuP3/Gu8Te6LG+JE0U40LgFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIV+6Nkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIV+6Nkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E2B1F00A3F;
	Mon, 31 Aug 2026 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184179;
	bh=8dkjGXjjiy2qO5+OPGt9h4bb+ufyCUXSkHX+tJjWxSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIV+6Nkpy+WS9pCaGSw6vBV9mD/4UBopCvDp+kYbjwwbYko4/v9n9k6N8JP5ZyPl8
	 U++gknhzExHIQTADC6S+SYsQJr8ZX8ZIHn5ECW5tZRysAIuwLbOPboRBH4BmlYSNVs
	 Pm39+/CxnsUB2yktiNroBWJ3PjdDW8bmfn9G3rvARe+xSTpkK8gRLnfE/zfw6c3aBI
	 ZTVQmwQbmDzBJbVKAGWksh8tCix130c7NaztBkRzYFBP/67940hAAhIrasGi8Xgc9g
	 XZwhzWImnQZH3nAiEp9M5V7cwZuoLauAAuW9cLN26xKny2kT6aR9NuKtCNWWGPo7O4
	 hm9j+H3CDVN1Q==
Date: Mon, 31 Aug 2026 08:49:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: goledhruva@gmail.com, dmaengine@vger.kernel.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Kumar Gupta <ajay.gupta@ti.com>, devicetree@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-phy@lists.infradead.org, m-chawdhry@ti.com,
	linux-usb@vger.kernel.org, daniel.baluta@gmail.com,
	Vinod Koul <vkoul@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Ravi B <ravibabu@ti.com>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>, simona.toaca@nxp.com,
	Frank Li <Frank.Li@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: ti,am335x-usb-phy: Convert to
 DT schema
Message-ID: <178818417774.757369.190007408390454150.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-2-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-2-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:44 +0530, Bhargav Joshi wrote:
> Convert the TI AM335x USB PHY text bindings to DT schema.
> Add undocumented vcc-supply property to match existing DTS usage.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,am335x-usb-phy.yaml | 49 ++++++++++++++++++++++
>  .../devicetree/bindings/usb/am33xx-usb.txt         |  9 ----
>  2 files changed, 49 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

