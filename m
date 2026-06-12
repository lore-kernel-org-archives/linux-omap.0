Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8A3E2771;
	Fri, 12 Jun 2026 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281329; cv=none; b=Siign4GPjd0EE2NgsIOmwGGhe9y3Aw2p76bU5+W7VHT5HAM/L4AcjI9r2nBRn/7JWuNHhxpvF8GN1Ab1p/GBPlPyBfUwawObiv4Eabq1Tqtl2qjniKyKQJLjewe+E5nGzkT1M1cB/Y8WrBos9JDY0tT0sBc/S/0u+g9SKT2syws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281329; c=relaxed/simple;
	bh=Xzg+sP8tWjGIluh75XfD2CMDorPVjg4yfYtja3AgQDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=butUTZDriKFx3kpAlJVj9eqGqDuQd+uUXsfE9qTeTGmSWZRCNoCdFZCV7uiAvvHSxksr7xoRmc5FUbNh3W/bGcnwA2VY69tCjrv+cXZ9b9JcQdCFSb9GlpEejUsfXJyRMhH+aV37r5Ilc5OwESh82CaKpji/746+pT+qSesysEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z22YVM6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z22YVM6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B1E1F00A3A;
	Fri, 12 Jun 2026 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281323;
	bh=X7p2Kiie/VwPTVeZsZUYTTjk6TXHw3XumFkCp16/1eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z22YVM6WMIASp6bj1/Lj5CY65UT+3UNWrBON6qYWNpw0F0ROXkocPb7+mxyQK9JXv
	 XPhj7R63As+LKNe48ExXO+TlZCvteRV2aCuTZJYYDOLZynJgw42IRVmzFln5mPS+B9
	 W0aeKwkDtkcyMvTAMJ3T7pbJNaE6vqwB67v7GFkRfQ/p0PPxLYu0BNrTtrGo8LG3X6
	 D1uFff4UvovL0WBLq7iZRvv12GLKLps4GmetJoUDJI0z9UwdMukaGnsxzZ7BLxz5ZP
	 pmf8rKWC/hKZSQb/2iYXEwLi/86TiQqEpUcRqfSfI7L336oBRhWagti2L1hzgefXZy
	 f667hOdnhLW7A==
Date: Fri, 12 Jun 2026 11:22:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Roger Quadros <rogerq@kernel.org>, linux-omap@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Shan-Chun Hung <schung@nuvoton.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: syscon: Disallow simple-bus
 with syscon
Message-ID: <178128132175.1153833.2573734544472661843.robh@kernel.org>
References: <20260608-n-dt-bindings-simple-bus-syscon-v3-0-4eba9ec1212a@oss.qualcomm.com>
 <20260608-n-dt-bindings-simple-bus-syscon-v3-1-4eba9ec1212a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-n-dt-bindings-simple-bus-syscon-v3-1-4eba9ec1212a@oss.qualcomm.com>


On Mon, 08 Jun 2026 22:44:24 +0200, Krzysztof Kozlowski wrote:
> "syscon" is a system controller with registers having their own
> functions, thus not really a trivial MMIO simple bus.  "simple-bus" on
> the other hand is just a bus on which multiple devices sit and the
> "simple" means no functions are allowed here.
> 
> Combination of both "syscon" and "simple-bus" is abuse of DT for easier
> instantiating of Linux device drivers so add a schema to disallow that.
> 
> Unfortunately there are a few old cases of that patterns, so add
> exceptions:
> 
> 1. "cznic,turris1x-cpld" and "img,pistachio-cr-periph" are already used
>    in upstream DTS.
> 
> 2. TI has several DTSI with a child of SCM device (e.g. "ti,am3-scm")
>    using "syscon" and "simple-bus" but without a dedicated compatible
>    documented anywhere.  Add new compatibles for such cases.
> 
> Additionally, add comments around code enforcing two or three
> compatibles: it is similar safeguard detecting incorrect bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v3:
> 1. s/ti,omap5-scm-conf/ti,omap5-sysc-padconf-global/ because it is more
>    appropriate (specific)
> 2. Add comments, why simple-mfd+syscon has dedicated if:then:
> 
> Changes in v2:
> 1. Complete patch. I accidentally sent only part of it, built on top of
>    internal WIP which I forgot to squash.
>    I received Ack from Rob, but change is significant, so please kindly
>    re-review.
> ---
>  .../devicetree/bindings/mfd/syscon-common.yaml     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

