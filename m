Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A5426D1A
	for <linux-omap@vger.kernel.org>; Wed,  4 Feb 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218432; cv=none; b=ZlEEs1Yhil22vPSgUv3sJ4Vdv5RhIzIfKcYPkPyvdf1wKDPehhZFRV3Gdn4a2cw07Q0oWQwNJQFLqX48vU6L8Gim9B26RXzGhAf2zSU9O76X5+hINgyokIJlP3a8pzIU1dNRKrwpkWx8t8R/byOkKsSV7JqRnvCFAEP/zDIRIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218432; c=relaxed/simple;
	bh=3Mc+zdxjfpLuAFVKDsgtCMFWFsEgf5FkiUfh7gh8+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfaWOfQvLteaAQSXWwwsbTSXBr000gnWcbg3ewbe2Mtc7trmNEanDmshJhBUJDW8lUVU0VqqP/4+hPVX3KMQwlmEfn3PE31q0eLUTt2K/Y3Ry8Mzx96KSxX4OfJE+VNc9MUocjihjtaBegaiQ8R28ZugpD1OZg7rykGF1Dtgt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iDpy+5Wf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iDpy+5Wf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5kVD
	7ZK9Rq23Qxm48/E+ZFq7Pb5/q5q9CtWAw8ENk6E=; b=iDpy+5WfmKVMGBdFV1J0
	TTN9JXlJV5HJke6dbOTEr1Pm5y8G154f9cmqBmOXADSN2kRoD3SpaCHWXLPXP61Y
	/fp+4soTFLjWl9pPqXaROxx3PsbYP0S0db4hULK5VH3birII1GsFakt1p1ox2W6s
	sxjwWEgA4KDUOpUSkSNqYy617igJtb0LCGgG5Wal49PxWywiM759fVT+T2EtzsM3
	YH2NGM38qRfytJh6kerYU4wAW0Pmwb+NytZSaLf41PqSM8iEZl1Op209hizKS6oP
	C/L9xLKMoGbMEW3RVVQn6V3Z3+o+tr8zETZbaCfINoqAMrJSWBXYr0vJjflnD6r3
	eQ==
Received: (qmail 2409086 invoked from network); 4 Feb 2026 16:20:29 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:20:29 +0100
X-UD-Smtp-Session: l3s3148p1@jBqoGAFK5LAqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:20:28 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 6/7] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Message-ID: <aYNjvPS6FVQ3JDmc@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-6-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-6-024ea405863e@solid-run.com>

On Tue, Feb 03, 2026 at 03:01:39PM +0200, Josua Mayer wrote:
> Add mux controller support for data or control lines that are muxed
> between a host and multiple cards.
> 
> There are several devices supporting a choice of eMMC or SD on a single
> board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
> SolidRun RZ/G2L SoM.
> 
> In-tree dts for the Renesas boards currently rely on preprocessor macros
> and gpio hogs to describe the respective cards.
> 
> By adding mux-states property to sdhi controller description, boards can
> correctly describe the mux that already exists in hardware - and drivers
> can coordinate between mux selection and probing for cards.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

