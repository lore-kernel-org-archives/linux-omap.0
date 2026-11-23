Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439104;
	b=wbbPfReP0YCoXfayT4+whZd221eZCuPWTQ1fFEDGE6Fp5RAo+u0MVBRex1CmRdeDQJ9j
	 Sl4ACKC40X0RJ9Iohid9p5uj1CFzU/uTd1BvF/wl02Faadzb88bLShlgUQVM0gWNmDpGX
	 GjSAaTCcubn8DapEeRJ9twkayPKuiYgH3qY4daCRP2ctY8ID+zt8FoNKLmAyAD19pxlKA
	 qgntQXWiYEdzVSM2x9MZdjW9ABcO9Z+WownAWcZ0yuYETqFnIlOzhxx+TlYT57gJ4YNsY
	 edgOoyWs+Gpq8Yj36fGpnNNmlmMkUE8cu+tk8tzCYVZ+kwIhivDae+rZYhKGORsAQTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JqwOi7/BVktI2ZHP/U/3Nu9WMQA6oh0lX3SVmULq8WU=;
	b=leci8Q0LHhPCp1jgy7Pd8vJBPj2i0+TPDiz4UwAb7u5JypM0IeQFLfWLvdW88eeA+QCk
	 X2dy4fGJ3w6HtISQb+kiOrkP4ihy0prho5mPhDqqkvL3KRsuUX0ODJKHb+8gEgYV8k7Rl
	 kHx4BDPODzAw30YA88LQvcqxzBi6/1F4zfEkQiIfEiUy4ZjzXEB8eQ041mpbMzsMH23UF
	 O7vH5q449d9xKDP50oY7x2aln6JqT3amfyHPDjSLQrX3u9LliOqEEpJjQLEJuwEuu84Gg
	 PIk21B5jtSXSZStOQWzK9yUG0DQ33jSBBSd2rbiXndYkSPgBC8pnNdsyA62xpuGr2mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=d1TUo5jS;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884D606A32D
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 13:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6884D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=d1TUo5jS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=JqwO
	i7/BVktI2ZHP/U/3Nu9WMQA6oh0lX3SVmULq8WU=; b=d1TUo5jS4ydnerrVYxvi
	FOjyUW9RHzWhbtnnBffSPtASsbJMFsiv2MCg3IkhHaErxN3gA2dn3rL8LLU1d7vm
	9EAulY1oJj1QcWGIkXUfPmEWzZak6Ti8hjczVubxJGe7SsO0y8SuWOuT8lWTCHSS
	ctrkKGhkKr9favHNjoFIas+G3xyEjXWnFI5bep1ogTFtjl7XNpDghdBIolOU2r4h
	X/EZrjj1l6DYqNZOn9Y47MUbxHZOzm8yIXSWwyMqLR7or4/92nno7LzV7XiB7t+l
	Yv6tp4CxjmX1j76x6bTN2KbORQwh1B4hwdvMiuJrwH77CaukBcvyuJwzutTTaINY
	BA==
Received: (qmail 2734062 invoked from network); 23 Nov 2026 14:05:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Nov 2026 14:05:00 +0100
X-UD-Smtp-Session: l3s3148p1@oH7GPfFgdo0ujnsu
Date: Mon, 23 Nov 2026 14:05:00 +0100
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
Subject: Re: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
Message-ID: <awQ5_Fjh6hKTx9Qo@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
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
In-Reply-To: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>

On Thu, Nov 19, 2026 at 02:40:35PM +0100, Geert Uytterhoeven wrote:
> Clocks obtained through of_clk_get_from_provider() show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> Add a new variant dev_clk_get_from_provider() that also takes a consumer
> device, so callers can provide it, and consumer's name will be shown in
> the clk_summary output.
> 
> Reimplement of_clk_get_from_provider() on top of
> dev_clk_get_from_provider().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Very minor: Maybe of_dev_clk_get_from_provider? It is still OF specific.
But in general:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

