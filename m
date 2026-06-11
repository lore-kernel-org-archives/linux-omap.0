Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382C2EEE76;
	Thu, 11 Jun 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195497; cv=none; b=GGJGQRVp7ZbvWGkOFjtllpcM1fqvB5V4g9tENBaHT3R0RDpGz6D5GjxD9HiLFOeASyiTR/Xl06GdU0oIhgkJmxJtS9p+DIrpLyrvEa7smJq0lt6q2gFMhb/wIHk07E+tKNj9KmNNW1NfdV1IY1MYFx+tP+852LwBVwGWLOjSAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195497; c=relaxed/simple;
	bh=jFBe0ulhCY69u+lrTC6KHwARtkSWpRjbJw5LHfJrNyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKzTSKjxDor+kM2+pL3dxeINkNW0sYbdVS4GoFjUfkhpu47py518j744p6RL41i8T3wDcd7U3MwPPSb5FbpUhHwOgWNr0SMUqjIGF3OhUs0WoYoiUlX3aZHB7/Eh1/3NwmUJMwTK/vltwf4bNMmnlcDKHcwGUvNWViAwchhnD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0uumjh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0uumjh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A8C1F00893;
	Thu, 11 Jun 2026 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195496;
	bh=pKDVwyUq0CfLwiBc7EZM23dtINCGheBjdXmyBg9xwrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M0uumjh+p4nAPbpKbVRwo/kjRcGl6JijzEhlgl6Mwhp3IiRN66lcTt3GBOXTOrsVF
	 hcRKTVsUGRL30UM52xA9Qg3vCHlG9esMsVmLx+gisSsnAPsjFXCvT36gwcEJNdNggp
	 fDBzqELKVi/CZHRuNSkuC9hkspueepE7bg+zenJ49qg9Mp4ReazlAjSd9Ct/JykU1R
	 RCeI8lJVoi0ipH6dhfPj+3Qxtd07P/mUo4vst/GqlPeoXdj67aH2Y4oC7P7te3g1D1
	 GXHgVRZFkeamw7Glci8gEdJ6s7ifGatjWqb/dGKg02V/s64VfmCPA4rCVT0FNwIid0
	 pI9gPR8JR+xLg==
Date: Thu, 11 Jun 2026 11:31:35 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: syscon: Drop custom select for
 older dtschema
Message-ID: <20260611163135.GA2913196-robh@kernel.org>
References: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
 <20260608-n-dt-bindings-simple-bus-syscon-v3-2-4eba9ec1212a@oss.qualcomm.com>
 <20260609-vertical-antarctic-e18a7ec91685@spud>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-vertical-antarctic-e18a7ec91685@spud>

On Tue, Jun 09, 2026 at 05:28:21PM +0100, Conor Dooley wrote:
> On Mon, Jun 08, 2026 at 10:44:25PM +0200, Krzysztof Kozlowski wrote:
> > Older dtschema <2024.02 required custom select to avoid applying this
> > binding to anything having "syscon" compatible.  That's not the case
> > anymore and this additional select has two headaches:
> > 
> > 1. Duplicates all the compatibles listed in the schema.
> > 
> > 2. Is error-prone, because it requires contributor to add the compatible
> >    in two places, otherwise the schema will be silently ignored.
> >    The select list already misses mentioning compatibles:
> >    mediatek,mt8365-infracfg-nao and renesas,r9a08g046-lvds-cmn (with the
> >    latter being reverted for different reasons).
> > 
> > This requires bumping minimum dtschema requirement to v2024.04, which
> > feels old enough to be a safe requirement.
> 
> I agree, seems reasonable enough given it's a jump from 2023.09 and not
> some large jump.
> The diff is nice too!
> I assume Rob will be taking it, but just in case..
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I expect Lee to take this. I suspect syscon.yaml has other conflicting 
changes.

Rob
