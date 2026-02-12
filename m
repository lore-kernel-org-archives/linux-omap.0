Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993735DD13
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914912; cv=none; b=hNKP77e4E/L7U/rfbOzM884q6lV6K2Us4pFU6S3icT0bYOy53LtiKmlSBd8CBrfEZmuRsdi6MmT7cf8AfRev36DOMbI+rWYIcMM7ep7ZTQA6On9QPsC6/W/n6Hrr9nXqVBDqMH5Ex6qRANtmsLA+25xg2bJKazladGjkTfilX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914912; c=relaxed/simple;
	bh=O/Wytqqrp4G6zJJ9cQaL2D4ioEYn15abIkQ/N8tlBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8we+7k505mXwfhe42Spyyw9v4i2vun2W9Y73p0ojMSNsHLgjvlPuRj/kIBHoogs11dB2R93cJqy9lz5KBAQ7XNaajl0j7jNcKb+TLtAvkEQYlULfD5E0zQJ9WGoNH6WpcN14yYvC5ClyRJGzt2DX+YgyYV6EE2Y+xz+nXLL138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqBezDup; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqBezDup"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483245a8547so35005e9.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 08:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770914908; x=1771519708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s35shHfPlRPLdZc28zpITEbCE57T/ice0Q0E5ta0TZU=;
        b=hqBezDupKhrZPI/AABm89hNDHYZZLsL5XgWsgyCtTPas5FxgwZXmAzy9rpunPKl+oH
         bU0kTm7CcZxvbA1tgxkbcDlhKphKzmPPz6pBizP8DFE3iDnEtAX9FnxoIzK+oa2CRVOs
         oBft4q7jofVA18UMnX1ffvueKCmagwCtt7MfWoqFs9c3oxK1FMcwJqFLaB3729HU057J
         6mK5/sZ6SiVgjdQG+7hvZ5Gh/EzyOXI4Y67RR6nviua49XJwR+4UYmNlkf4tB4DgSRQz
         KkXHAB56/7PeUqqaEH91GsvWi2hjPQdPMyrB1LtGJ5tBEhb8Lv2YNOObtqgVbDMEPZ/A
         O8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914908; x=1771519708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s35shHfPlRPLdZc28zpITEbCE57T/ice0Q0E5ta0TZU=;
        b=jcHOqEYf1/4AhA3S6/Gpc923XMI2MTzttH0nj3ZsHWkKSfUBg5p/VTu9bP83T82R7O
         jje+x+fQGeumdzpMiY5Gli79WnA5oilScPyduaik8X2GyHPaOVVlK1M8pedbdTxZ5rax
         rCRW/mr4C8ZLxR70qTYPeph1J2hRXzJkIYjszgkXgstkyw/FSNk7rIpU7eJMHOigpPbC
         FgA+67F4Cy4X/WC+A3F5vR/qSoeBqCfFoCiBHrxLBTR2hoiMxjyzIFFaNWyVxY3qVLdE
         9buSon8N/TgVJXAt+DVgvH7tQ4Zj/6Z/H5/CdQ9i1I8tfQkTpWgqKr28n6vrMym4T248
         XdDg==
X-Forwarded-Encrypted: i=1; AJvYcCXYug6SWkq/aucU2A/GXEcAgdBe2bi/8G2HvgySGRzBoHLIuWGvHEmU/AEVz7ApfVqv+Nv66wo25WD9@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoMuPPh44zh+F4PhcD1Ng8N8rdtlAI1BLQhrPiWOjDsHHVkys
	4hOw5BkmeKZsPxMiBIKbqlq0T/gpkpj16lY+L6U/GUmJIO2Mx9JZJwff
X-Gm-Gg: AZuq6aI8U4DR87RFBOKgLrKWdbikU+tITy4MDsE1BrF1tzn+Zezxtq01U8/2PsgTvlx
	Pb/lulcf/wbmEMhoCd9HRFR3tuBXwinfScgM8wj66W0z1JSik3YjR6hsyPezBDtcS+FBBLs/pEG
	ihC3pp+RHGppMuAt8+JpWugOCbCOAbFGg9UT7lXUhiXwGWWGsBdnhAWxl2+OIUGCjFu0sa/dxgn
	dyeE3DOg6+77UGo216yR4UO1fb1oHSbghpIiPvLBDIWRZ07BvrwDgtuh1hOxl/Vr/QIfyq6H6hb
	5PPuZOqVeRmTQ6JzhWc7ChwsZNHQ8jkg0FeRUV1lbn2WGEtYb3XCF5I/onQi4lAVt8VzjgbUOt6
	tAQAxZtQ7sKKEAnyPWBFrJjhA7aI9VAKt6RFnUq1mzrGwyZI4v9+qi/O5hDKl+GEk18f+M4Mw4G
	7PFZgRIvFH/HnKvuw=
X-Received: by 2002:a05:600c:1d9a:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-4836570e3c5mr29720595e9.3.1770914907561;
        Thu, 12 Feb 2026 08:48:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:2f75:bf70:f0b9:4586])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e0ed5sm192002555e9.5.2026.02.12.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 08:48:26 -0800 (PST)
Date: Thu, 12 Feb 2026 18:48:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <20260212164823.mbeycqwzsy2dfq6e@skbuf>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>

Hi Josua,

On Sun, Feb 08, 2026 at 05:38:56PM +0200, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
> 
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---

In the future, when you have a series with cross-tree dependencies,
please try to think of it as individual mini-series for each tree's
'next' branch, and specify clearly that you need stable tags (to be
pulled into other trees). Telling maintainers what is your expected
merge strategy helps avoid making mistakes.

For example, if you did that in this set, you wouldn't have missed the
fact that in linux-phy/next, phy-can-transceiver is _not_ the only
occurrence of devm_mux_state_get_optional(). There's another one in
drivers/phy/renesas/phy-rcar-gen3-usb2.c, and that should be also
handled in order for trees to not enter inconsistent states.
