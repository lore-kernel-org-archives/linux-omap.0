Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EC3EDE43;
	Fri,  4 Sep 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530065; cv=none; b=L3w2G18JYz2XUAQnpuQpzevW3UqTdwOKA3sP1UWYaoIzHK9yPCgxdQ4DI7J5Xb1iHdTz9dOQvAthTIap+13B8oPjy/LHHkAzHwXhp5PLiaeAz/hEIxqJnnwo5QHxvKndiIyBkolZXBmJiXwwQgHKjaSpCCt+103FI2iqRerUh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530065; c=relaxed/simple;
	bh=Ee5WotXsG53dXbgPzaqVJOPsRKVUX98QUK8V9RVbFvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WCk1yjNblLl6Qv5QOkuFc6VfSgupE+Mr/E3eV/pVXWx5q3zmiK+HNYTbDs7HpkjZDH2zERaiwaKzcHmofNzxS0dZsJjorq9FHPPx5X4iTUzO5VkFMrq6/0KZ0tSQnKU4zBxjtdwzXkhbYwpbBNy2fDPBsd2thPiwyzJLlIHKwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIy+NGL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIy+NGL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BAA1F00A3F;
	Fri,  4 Sep 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530064;
	bh=WBr6VkV85qxI/eaaoZQl1/8BXogm8ILkbKgicKhaQbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DIy+NGL3PsMayLCrDWLRl7lxQEaR9TUzOlAmYm7P3HiGTeyrmYQKPtEYrKEuEwpsi
	 wGEa612IPundBT4fmCAafP2v3wW/FptVQZJgMuEsqAUw2VbHjGrvFU5Qi52+vf8OyX
	 r243hEoQgooig+fjU9jEg/DnsEystz8Eld7g2q21xJn8y804SkZBx0/IJt6H8ESmUr
	 +s/P3k5fShmBVPsF/vJ2v8xja6tLU5yy4EePTKBDJCBuSiceBk23QR14zS7kOWIif8
	 TaI6oAaAyQPZ0TkO+mLXLr/XkvWvwHnrzEpYB86dMKMHOV2z9ToJp1DybFrpoqSxLq
	 1gT15GYp2mDEw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Kevin Hilman <khilman@baylibre.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Peter Griffin <peter.griffin@linaro.org>, Roger Quadros <rogerq@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
 imx@lists.linux.dev, linux-omap@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
Subject: Re: (subset) [PATCH v3 0/7] ARM: dts: Replace clock-frequency in
 camera sensor nodes
Message-Id: <178853005570.24079.11001651675507374897.b4-ty@b4>
Date: Fri, 04 Sep 2026 15:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 10 Aug 2026 21:05:57 +0300, Laurent Pinchart wrote:
> This patch series contains the leftovers from "[PATCH v2 00/72] media:
> i2c: Reduce cargo-cult" ([1]). All driver patches have been merged, but
> DT changes for ARM platforms were postponed to the next kernel release
> and ended up being forgotten.
> 
> To refresh everybody's memory, a large number of camera sensor drivers
> directly use the "clock-frequency" property to retrieve the effective or
> desired external clock rate. This is standard behaviour on ACPI
> platforms that don't implement MIPI DisCo for Imaging, but usage of the
> property has leaked to OF-based platforms, due to a combination of
> historical reasons (using "clock-frequency" was initially considered
> right until before the introduction of "assigned-clock-rates") and plain
> cargo-cult.
> 
> [...]

Applied, thanks!

[1/7] ARM: dts: samsung: exynos4210-i9100: Replace clock-frequency in camera sensor node
      https://git.kernel.org/krzk/linux/c/449cb9bcbabf4f862ec8d0107587fbdfde357ee5
[2/7] ARM: dts: samsung: exynos4412-midas: Replace clock-frequency in camera sensor node
      https://git.kernel.org/krzk/linux/c/9d33825126bd8908037be997a9b4cfde92b9c5a1

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

