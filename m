Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138847;
	b=vlqVWyVx3IcNuVeBGoMDUU6LVybJjMTZFfd7A+VE3FrnRQBeA8luQ8gaJDzqUyrmCH7Z
	 j/HO1pj54rht6CBnUs7JVuX1dDGyHxX1mrbXyAg7bcvODalp3ALCUVvKt1SqSLaWui54j
	 fOlC3ifjoI5wGeN/dli8Ru0n/Y9u5geIOj1x7GrKWNE5NzbV2aD1+xRvB2ecTl/E1DFAL
	 AP60Bj6/HTjLJi45VFjghhJULa7QyDtZjWdExn0lYiuNXZtexjKgLPgVjBc2XYS4cdhmN
	 wbcG9R06s2Hk4eRBDfN9jBtp9ZaSOUzw1Uz+2wcw329BiCHJostAn6oaBgQQefVsw4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138847;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XHUsb0Xtaw6Jq3ZXOlI1gdrz1ttBLZ57v7PE2vNJerY=;
	b=ctp7n8U+UH4lQx1qD8TLIMfenWOmQFksN+v+UbiPDP71+91pDs6WU1PsHAjuamdrRjB1
	 /Zul/RoNKrlP/Va4QhrTDgmqhHCNRAYrZG/l/3hW6E9WfFhTsKvfoqWE4Dc77lK3a0MLW
	 yrhdGFZTY7exA7mpLe70yd+XLE3y0yV5hOjkObl/1xfmdbS/WVHFm7pigXG3h8eOy4kXE
	 /+lJ2PG3KPtQZLeWKkk2bYRTKzUbFbz7TaO064mR7fQPITUk+Td5Htrnz1gglrTuCXcYX
	 HV5mV43AZ8fuSaFOFq07esDzoEkK+o4GzavPEEkcGfuIm71l0fmVh/u1wQzkKBTza/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0YUc57e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02186606A320;
	Fri, 20 Nov 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0YUc57e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152CF1F000CF;
	Fri, 20 Nov 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138846;
	bh=XHUsb0Xtaw6Jq3ZXOlI1gdrz1ttBLZ57v7PE2vNJerY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=W0YUc57edZeG2Y6/hqlHJhhl41/gafd+T0NW3lQi3zCbK0OQ7sBEJhGlifHaujcie
	 EITdRwmzmgDZgklRGPDMDDcBM1rIrLt0Hd05C678Wc18jURvd8orYq+S0Dohsn/r9z
	 X9hnFDED24ktVwgAOH55wtKm6YhHipDka8rjRx1zeYjdHMcJUaFSnpEzgdmpbzPsvk
	 tpCCUBVoIqku91yz5lbyxeQSw3OuyMNqy1WTu64HvbGY2+jr4b0Othq9u5ekumaZoT
	 OQp0FtZMvmFBIvokuV2tMussXvosFMgj5TkQipTvmEJYSaco6vltRTb1bKEukpXNpn
	 eTAd+jeSii/OQ==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882272.284394.5255700296836474521.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=565; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=6zJGmBMLssq21U23/Bgo8QkI6kNUxjlR9Sy14J5yfUI=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+LxW8Ns1Y/1VJ9huOYqsvN/TmCc14dU74RbjaV/u6W
 9vNDYTKO0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZjI1iyG/6ELNDYWGjFMXyef
 +e6E+P7o5zVsKwNd1t+ZV1mokPdh13VGhqXZUoyvr3W1X+3d/vHpLF+R2wmFM6ZO+KskvufN/F1
 7krkA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

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

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
