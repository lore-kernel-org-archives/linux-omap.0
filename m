Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7F17B418;
	Fri, 14 Aug 2026 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686219; cv=none; b=QSyHPzW8JTwjsJWO1JRv2bK/XlmXHkInAoFsndtBuWoanDjlsM0FSIbhwM3uAFnbqHJTHgJbl7Vd0C8Y7oIIjrlDTq1uGYV5rJJN1+JbYuZ2JglLbb5g1YRIDSkszuyLu6HbXAMljyVWVOIP37JVqVlVZXfAFFfmHPJmi+99K2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686219; c=relaxed/simple;
	bh=5eUGeD9MBIznRqlDZKv7/JXiKu6nkgN5M1MzO4SC7aI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aOHzpalu9kU/+s6Qb2KzrYB4QMoqk5rRe5+uQQPlVrMWf3sMx2dlWTe4Va9eRCi7fuwb0nDP2kuNsdQGIM5TtEtd1ywX2muElkW17apK4TjXwRj4VcMmcXJmVHLcqDMAVgIKcDkYPvmxFHSZSk8bhOJn2O62mUbn6AXSKdeYZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5IonrBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5IonrBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F7D1F000E9;
	Fri, 14 Aug 2026 05:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786686217;
	bh=5eUGeD9MBIznRqlDZKv7/JXiKu6nkgN5M1MzO4SC7aI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=T5IonrBBr6gP2fitpahTuhZBvs/Yf1NNzvCltOv+8ik+xfOjV+gFc5TljbAJkdRRw
	 xbSCfBV2i6vqwkH51WYF3Vp5v9+YTrsCkg6ePavRo+Q4ykSfREYlaI1n14OdqzyRRn
	 R9dXCW86KwAq8XRpM+RB1Z6D8D3jEDRu9JtNoYA4XwP7F5xymtuWHpc0tWXgYyKpaA
	 lCp0pMewG9iUs8VICOnoUnw2NLSbybmjpCufZadwtG+MzeGcaAvWPAspUdXVXOJG3u
	 j0KnfTR7x1erUya+H6lXA58XMOzCaeYH7gXWx751Pgk+1Ph+T8alWeBdSjUiOEwNbJ
	 G6S6htOkNP5ug==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com> <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index, not by name
From: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: Brian Masney <bmasney@redhat.com>, Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <kristo@kernel.org>, Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Aug 2026 22:43:36 -0700
Message-ID: <178668621615.5897.4771960464095747530@lazor>
User-Agent: alot/0.12

Quoting Mathieu Dubois-Briand (2026-07-27 00:41:40)
> Resolve parent clocks by their index into the device tree "clocks"
> property rather than matching names as strings. Name-based matching is
> fragile because a clock's "clock-output-names" value in its provider
> node can differ from the name used to reference it in a consumer node,
> and because names must be globally unique across all clock providers.
>=20
> On AM335x, this caused broken clock trees where some clocks failed to
> enable because their parents could not be found.
>=20
> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> .index to the array position.
>=20
> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Applied to clk-next
