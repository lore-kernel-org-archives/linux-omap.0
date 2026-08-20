Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2C48424D;
	Thu, 20 Aug 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261319; cv=none; b=FRXaSdjuWde14DCzzNRiaySz8d0KLFvepeG73Iq9SlllZ95FFJKz6ci3Acvy4KceuI9lAle8z5kxHHJ4o1/0O40v9MjAqeqGedtEhWG8Ei+MxrcEd9YaHtYM2FUZ95KBIGsyeW7OMw1+5gmX1Spc8MyDGXPzWbWplpoK+S2Uyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261319; c=relaxed/simple;
	bh=o7295kt3qJEeZGrmBSwwWKs6o7oTiWTiUU34tK3HQh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIZSmGIcsXiT51qLKtAovRuQRKtS/tJPAoYzoVe1oNxPsB29sQnzvmPZXtzKnpvSPGRijXM+mi4uNXmI7JqcUvMWQx2/OYk9CqVxsW0UOR27Z0GtiU6wFkM+ZJbdsC7WzdHLlySK5LY9lGBKjOsPmsERenyGZNNaWJd8XolrvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zg006nvv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zg006nvv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A3D41A1774;
	Thu, 20 Aug 2026 21:28:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C4105FF59;
	Thu, 20 Aug 2026 21:28:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAF9411C7687F;
	Thu, 20 Aug 2026 23:28:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m1hLosDWZqhLB08wEctXr6igwRB04noshK/R2q7Ysr4=;
	b=zg006nvvn2vecosZHLRaGhtqtzd/1gLlPNGa1NQW8Q9x7KlffXAL2T2VTHfCLVo0ALmm9i
	bh9+2mk6PrpalbRRyzFkdKmprtqcHkjHY0vDJoqso96q6uXoXtVe8+8QGOWVZRXFSj8W7k
	2FUn6W4kBNHH/5oMU6C31gCMKXsKfNOjqs0UI5koeJoDQMVqogthnjVCKXIH0EwMFGUw4b
	HUeKERWNjocX6H8JJyIj7PQBbFVR/zHCTzPJwo9gynSFmmPvirFGkEGEvDdD5dtcBIDsGz
	8Hy8WADf9y2iKAjxWEdz2Aea85kaRI/l1z/gH49JerjS5NITk+w/PK1sldpzVg==
Date: Thu, 20 Aug 2026 23:28:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: Re: (subset) [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to
 DT schema
Message-ID: <178726066528.423710.6314624989099111119.b4-ty@b4>
References: <20260719141008.3562347-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719141008.3562347-2-egbostina@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 19 Jul 2026 14:10:07 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments Palmas RTC controller bindings
> to DT schema.
> 
> As part of the conversion, declare 'wakeup-source: true'.
> This documents the Palmas PMIC's capability to wake the system.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT schema
      https://git.kernel.org/abelloni/c/4d31434fea51

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
