Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640198;
	b=27XznEqwSNRhr6DyhyES4Z+xQ6Wn0pA8VtkachNGUiLsMcNH6U7T2xoODerLWv48TAV/
	 sUbRpjccyI2ChGBqok+Epx1cxduw0Eny4dkRYQpKrEO8C3kZP1IfE13nzKA9vHxbTExP9
	 Yt4U1TmISeOA5aZHluV1oYLnKSshtlHO4l4/R0+gLp79oT4DqEO5DsJUMDjCkNvp3V+Dl
	 kOg5uzs+WLnKq3B3TFBMlEBAExE9sHg0974/tadqDLbZvAloYkfXxSHnG8VGRzguCQzs0
	 LEYdDzjW/NgFGavLlk9azV5Wxfa8MYkoGYmQlfacGRoh/nmLiLV8J0NOyF4YsmopKhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640198;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1kRROKKosl/yXIFPGvtByySBNrtF9KbT7CipojNr2Ac=;
	b=Bon33A08XE95+CAM1XPUWDhbYnj9QYq1uNJ29+rF21IMeq5/xLoX084fwGIOo7aDIwPa
	 a+WTGCvtURn/LCsyde1DbEIV37yLoTT0ZVtm4Tc+EqoRlTpfp0qiW7yT9g5w+T2Gbm3Dd
	 p2U4kkEroKB54bYgoWgmUtE14w7L+7/ksX8KN0+XzBavneVHzZEG70aiw/x3+RwwA7E+N
	 nw2MapcdAs0qvN6NadQtwASKidbCH4ijxJP8b29Ksc0IP14ERtre0j3RyUUwJjg2/sS0V
	 jemrbjC5l8HD6n7lT4roKEWo29ekyEnDK4hXequ7fei1OpFLzvzFr40Z9qO5GiTqczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IC5AH4wH;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19981606A326
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 20:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19981606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IC5AH4wH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1kRR
	OKKosl/yXIFPGvtByySBNrtF9KbT7CipojNr2Ac=; b=IC5AH4wH8ctwgU1Tad8s
	xxEe94U8RhC8pxG9PqWsbXeD8GVt2Y+5Mvs31bENX9y38nSyIDNndU9Y1PG0a7NN
	W+BuKm74LzsdGg6JApTSoC+1xeN6L07eXNsFtuL+Sij08GFgJ8UJumuydRlNXvxu
	jM3vqfO2wWK8nSQKrAUPz730IdfB47eT8S8imuHjYRXMHCIItemfb0v/lCesvMz7
	LJZSN3QJrAXQqhy1pqUb6z/kHft2RKTw7xem2GTTITZu3xnp8TApeA/ATHOUGM53
	MbBSbQhwqERI4NeMSCtkHF8ddkv/OFIAFw+dYxneDk3fgbvDvYfaWtwnCdpMjPiV
	uA==
Received: (qmail 1132956 invoked from network); 25 Nov 2026 21:56:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 21:56:32 +0100
X-UD-Smtp-Session: l3s3148p1@ZOnQDyBhXuAujnvc
Date: Wed, 25 Nov 2026 21:56:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
Message-ID: <awdLgHC8WvGsgQAk@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
 <awQ6PXdLz88kI9wQ@ninjato>
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
In-Reply-To: <awQ6PXdLz88kI9wQ@ninjato>

On Mon, Nov 23, 2026 at 02:06:05PM +0100, Wolfram Sang wrote:
> On Thu, Nov 19, 2026 at 02:40:36PM +0100, Geert Uytterhoeven wrote:
> > Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
> > clocks used for power management, so the latter show up as "deviceless"
> > in the consumer column of the clk_summary file in debugfs.
> > 
> > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > the consumer device, too.
> > 
> > Sample clk_summary change snippet on R-Car H1 Marzen:
> >     - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
> >     + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Tested on R-Car H1 and H3.
> 
> Tested on RZ/A1 (Genmai) and RZ/N1D (demo board).
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

And now also on RZ/G3S (G3S SMARC) using the rzg2l driver.

