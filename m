Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0F3DDDC7;
	Thu, 14 May 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748512; cv=none; b=s/Tl8x/mJkJ2n1xLkYrXP8XSKC1i/uIKqEkny8xRdlsWz37deMn2UKSjOPeQD2zq9bZWgFQiHeoRb5mRZUzhB59QozSORfkdRjUjCwCc/dwAJfuPSrfaUtrySsgG2F9TbCHbc/KKttRZQyFGqz9ecO94iCDPSGqvCQqQwnfPH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748512; c=relaxed/simple;
	bh=cDlg5h8GbzkWsoINCi1kYk/V1GGhwvzfQGRKFmT6clQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffd8jZOc6m8oZkf4wLtnk04ggJkDCufoI15LHK0NkyBHJvXQ/dCnX6ciw87F8nDP673BejA9fevluSHA+i1K/s3QA0H+KcnlCA0CuqrZnBH26JPeKAqJqPSNNfx8ZwEfLwXVZMJQejE0/2F6v+BCGplhEskZB/KceHu45gRX21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=mWaS6qmQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="mWaS6qmQ"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C87FF1F81F;
	Thu, 14 May 2026 10:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1778748498;
	bh=HZEwhfuwdNVexFrFTdU5gwZTTzUcljfMdkapLcnZDSo=;
	h=Received:From:To:Subject;
	b=mWaS6qmQnYx/ZCTCxx9evkpzt+l3B8mSkZp0S4cfMOOLQjHIHmcRaayuEENre+o/x
	 p3Nen8SJ/f6BMKYsMKFGDyydZD8p8lW3YUafKOrOSA2zTZnuR+vm0AipmffH+to4VE
	 kzf5WDlJGGz+3B1+vVTIBTwe9u2Mvg4lEeQJxLnqw9A9iVemqI3gF1BjDM+Qoi7+uU
	 SXWPMvou8kfUbb9SjEZlSYAgqDqGFxQI9sRYrZRBtMm/9625qhxEPGwiWBjvM5ToU3
	 9JpsguorySQOANkQIlL0+2Pj8KJcvIbhGvQGhZB8BsnP0Q52WiuLDxkE/QZYdJsYTw
	 6FxCQ1vQu6HCQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 7C23A7FA92; Thu, 14 May 2026 10:48:18 +0200 (CEST)
Date: Thu, 14 May 2026 10:48:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] regulator: tps65219: fix irq_data.rdev not being assigned
Message-ID: <agWMUrNZjscW2JtT@gaggiata.pivistrello.it>
References: <20260513160706.1096845-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513160706.1096845-1-alexander.sverdlin@siemens.com>

Hello Alexander,
thanks for the patch

On Wed, May 13, 2026 at 06:07:04PM +0200, A. Sverdlin wrote:
...
>   Internal error: Oops: 0000000096000004
>   pc : regulator_notifier_call_chain
>   lr : tps65219_regulator_irq_handler
>   Call trace:
>    regulator_notifier_call_chain
>    tps65219_regulator_irq_handler
>    handle_nested_irq
>    regmap_irq_thread
>    irq_thread_fn
>    irq_thread
>    kthread
>    ret_from_fork
...

> Link: https://lore.kernel.org/all/aBDSTxALaOc-PD7X@gaggiata.pivistrello.it/
> Fixes: 64a6b577490c ("regulator: tps65219: Remove debugging helper function")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Is this a fix for the issue I reported long ago? If yes, it should be

Reported-by: Francesco...
Closes: https://lore.kernel.org/all/aBDSTxALaOc-PD7X@gaggiata.pivistrello.it/
Cc: stable...

and remove the Link:

Francesco

