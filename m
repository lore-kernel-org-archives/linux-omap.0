Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640339;
	b=Ci//aCS+wv/zp6r7TIPesC55r4wTun5is8++UtCvMqCNCP2mrUnJFMhCDZOQ3Qc2FsZo
	 gWJDW4/uxoneelRqCzUMXM6VBxKRzHa8znvlj2QS9mhiWJvWxfXOAs16ebBsRgPHcv+U1
	 8JlpN9qQU+gqkB5uIs6m0YwfLHiyoXZLP/hFnylhxXcrSd1j24X4S8HaMSOOSB3xsrr9y
	 iihUFAEzYbyJcBsp4P23GRYffuq27mU960x0iCQEcGKUwxCpW761YigEhehu4RNP8wVXR
	 N7+kpzocIV+cLpkLmlFYyZk4FeCgA9ePb1G7LffNA0lcnKHyUwh4Bg7m1NqvxTJaljw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640339;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Yi8HbY7avl9S/WCaQ0l/DLFnbsp+kW/rpAuDBKM+Wwk=;
	b=cHKCvh8XI1OhGAuhEfXOcnQyTLEb+RkxrmhvYhnISEgwWO8V3mwf6GySPgfWlGqEZE+T
	 M9ii15RAAG+y0h4MEKPcx4tVbIr+9/Q+Z1UT2nKqaM4/h8PILx5+5LVBDt6HPToLmb32X
	 9TJhMAvmqOaJ5pMMl80TIgn62OaKGvM9rugvxeWHWLNHm3z2CqRIGfj6j0EF+w+3TvgOS
	 3KZEPUvOMsgalYaMOCYOl2eNb6H76l//jte6QFZM+TVIpPaLttfgY4sHrhtpj1enfvpAV
	 fLZOKSMGDS7Pcio6UNJNjzL7Qj7DzPi6WOjxM2Q/dN4lkYEvC/y5sibuESGolLUROzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Z16QyKYT;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF041606A323
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2026 20:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF041606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Z16QyKYT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Yi8H
	bY7avl9S/WCaQ0l/DLFnbsp+kW/rpAuDBKM+Wwk=; b=Z16QyKYTJXiCk1GBl7qp
	8OSv/TFvPsvbxjRerrVgd8aSkTHmaLr61YpEJktg9X+4ADStTJECdOT4ahpnz1Yc
	7eU63v6K7T4fpS3/snmspxQ0itWHB7Pk7i9r1Xz58BeNI/EG9thweohVbkbxdSID
	krbLBkJlkNs7VcbnIKLMyLV+ME40bAsEWG1Zf8QtMGZYdkzMt4DBzRujIN/4bS/h
	309VFtXc8H6DFmzzhXSygyAjU1ebEHgczZW68rtq6ZYq2r13xwBTZstawhD9f+xz
	WXQKTwNPHbWl2feGv18UhJwSAdk28vH5pmDnv4/tQoXzPaAY9JtVZ5WTw8o0biHF
	+A==
Received: (qmail 1133866 invoked from network); 25 Nov 2026 21:58:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 21:58:56 +0100
X-UD-Smtp-Session: l3s3148p1@MnZjGCBhIOoujnvc
Date: Wed, 25 Nov 2026 21:58:56 +0100
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
Subject: Re: [PATCH 6/6] [RFC] pmdomain: renesas: r8a78000: Convert to
 dev_clk_get_from_provider()
Message-ID: <awdMEJReSkI-YEdo@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <81de8a7aadf587377916763d24181c44b5d13775.1795094688.git.geert+renesas@glider.be>
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
In-Reply-To: <81de8a7aadf587377916763d24181c44b5d13775.1795094688.git.geert+renesas@glider.be>

On Thu, Nov 19, 2026 at 02:40:39PM +0100, Geert Uytterhoeven wrote:
> The R-Car X5H clock domain callback uses of_clk_get_from_provider() to
> obtain clocks used for power management, so the latter show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Sample clk_summary change snippet on R-Car X5H Ironhide:
>     - hscif0 1 1 0 0 0 0 50000 Y deviceless      dev_clk_get_from_provider
>     + hscif0 1 1 0 0 0 0 50000 Y c0710000.serial dev_clk_get_from_provider
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works fine.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

