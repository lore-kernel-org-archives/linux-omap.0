Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DF56C634;
	Mon, 31 Aug 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184106; cv=none; b=sLl321Gs93yycx5DAVj6D1ReuAA+RiZsdgT7HCZbpG7bFf2ewFvZ/aBvDir1fXVWxBQJ/HcZtm3sK1Gd5B+SXVw1skT67jqbs9lFJx4V2BoXRS06Y+avKgEk5ddWsCure15rnWOwY/LDXJC3eYfxhEjGmShwd3U1h+jDsFRNFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184106; c=relaxed/simple;
	bh=yBaSaM5g6nYdAQw8v5Byml+3Xg5e4QK6cEjOHqaSsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFA86hlRJEgR4m7i6i9qarCH4LJ6ooCcJUPWASHM28xScbktZdNGxlcX1uxDqpt+BtjMKM5iF3Quu3oKiX6teuYTElrptH0BVFocF4DFAx659ylJKm/LTdLp+L++yrjFaVT9v072uT9cu4RF7wrkri1Iiysq3Q+6epJFjYJIn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4t+0c6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4t+0c6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FD81F00A3D;
	Mon, 31 Aug 2026 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184104;
	bh=Uk2bfsWBqIOKDY5IOy+LzNuDq986xnkLRGje+YX7MIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4t+0c6vwrVPLkV3wIdx5fWJsiDvmlsQ9BjoZtlcDpxm/yB+ixqhe59tBxkwmQVNk
	 XaRA1W00l7nT5A9OgNs5IQt+iX7KQjOJtWUVHw4Yh1G3tWsxzv30RmKhjUPyZEzpSB
	 p+0zG7t7NyqJlJL+h2fq1PzQG2PDGAQAKvFebdE+YXQ7/0z618SHBRMV2HtqiKpcbp
	 GATaMtn0Pm/Y1KjRt00KiyIxPkUPexC2YensDJo6ZLyu2qEp89/+e8DV1TafoI6P7w
	 OQcikH298PL88SCvCjvr8b0Z3+JUPH3y6SeRVZKNi24+r4tnTdzpDUgVkdIZnbxtff
	 eGa5UKRoQpJkg==
Date: Mon, 31 Aug 2026 08:48:23 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Siewior <bigeasy@linutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-omap@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH v2 0/7] dt-bindings: usb: ti: Convert AM33xx/DA8xx MUSB
 bindings to DT schema
Message-ID: <20260831134823.GB733140-robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>

On Tue, Aug 18, 2026 at 07:58:42PM +0530, Bhargav Joshi wrote:
> This patch series converts the legacy TI AM33xx, DM816, and DA8xx
> USB/MUSB text bindings to modern DT schema.
> 
> The legacy am33xx-usb.txt and da8xx-usb.txt bindings was historically
> structured as a single, monolithic file that documented the entire USB
> subsystem (the wrapper, core MUSB controller, PHY, and control module)
> all together. This series converts that monolithic text binding into
> proper, distinct DT schema files for each hardware component.
> 
> Patches in this series:
> 1. dt-bindings: dma: ti,cppi41: Convert to DT schema
> 2. dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema
> 3. ARM: dts: ti: am335x: Fix redundant interrupts property in USB nodes
> 4. dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
> 5. dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
> 6. dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
> 7. dt-bindings: usb: ti,da830-musb: Convert to DT schema
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
> Changes in v2:
> - patch 1: add interrupts as required property for am335x-cppi41
> - patch 4,7: add pattern constraint for dma-names
> - patch 6: remove deprecated property ti,hwmods from required
> - Link to v1: https://lore.kernel.org/r/20260818-ti-am33-usb-v1-0-69ac5f92df45@gmail.com
> 
> ---
> Bhargav Joshi (7):
>       dt-bindings: dma: ti,cppi41: Convert to DT schema
>       dt-bindings: phy: ti,am335x-usb-phy: Convert to DT schema

These 2 can be sent on their own.

>       ARM: dts: ti: am335x: Fix redundant interrupts property in USB nodes
>       dt-bindings: usb: ti,musb-am33xx: Convert to DT schema
>       dt-bindings: usb: ti,am335x-usb-ctrl-module: Convert to DT schema
>       dt-bindings: usb: ti,am33xx-usb: Convert to DT schema
>       dt-bindings: usb: ti,da830-musb: Convert to DT schema
