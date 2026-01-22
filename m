Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390643DB757;
	Thu, 22 Jan 2026 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124848; cv=none; b=Ydn2ZQE+uq7FG/r7XgTMFuyo37JVLbJNaIwMPkejtOYPDosnVFO7eSQVxg8sQDGDKAGiLXP1O8t8ksmjXUYi2lZNHiXbJ/utOcV/OcxR54KIjfbvRYpxQkNSRaDP/IBK2ElpHhff3pE7H2DjgaKJHQSJ67KdFbuX/3T2U1h/gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124848; c=relaxed/simple;
	bh=p/6yioS4UUYOkHdgzh+4CtAIpFXk6Ku7adka0gET+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG5R5AgfHIPVA0zA0fltxjwYJpQSX5FnrS6iWRf6MgoD2qhQZgVz7YOi4miS/79eDqgqo8dBI4fBJxykeORh5S9lsoOr8hSNPEy7umCpQEHRx7q3DfZUTwMq29ZbX/D6fRiu8OuDELuRh6kNTM3I8d3VVWz+lNDZiSwZ0Qvr1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptB9NR8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptB9NR8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93C1C116C6;
	Thu, 22 Jan 2026 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769124846;
	bh=p/6yioS4UUYOkHdgzh+4CtAIpFXk6Ku7adka0gET+jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptB9NR8l/QTiZ9mmU78HCKmRpf+bAL7GCg6CPgaPRcMVIgy7jdlU4gJzevsEp5E7M
	 sZBiA+Pt5s6Dx58uRBA2xXHoSs7LAhM85mjxoSejhKdAwZ9hs1va9xAYBqlSpbfYVJ
	 TwKuQAjNlYPDw0AuVbAYlIZDIo7/vvsaGHYuR0teZc1dTiyzokAICu9YDitR69smYA
	 jOjFfhnrCBUZq6Q4EmcNh0G3YKq+/QCdOBJUxOdrMn/Xkf78/PbwGNnaIcb6SJdj99
	 TWIA/raypBSL9qLBSygGknD/xUx89xy7W2ARqW9kJ90AnTddX3yt/BD0kRzvRItoII
	 kQnY1QLnbX5jA==
Date: Thu, 22 Jan 2026 17:34:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: phy: ti,control-phy-otghs: convert
 to DT schema
Message-ID: <176912484532.3737425.3268044409618489057.robh@kernel.org>
References: <20260122-ti-phy-v3-0-751619729433@gmail.com>
 <20260122-ti-phy-v3-3-751619729433@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-ti-phy-v3-3-751619729433@gmail.com>


On Thu, 22 Jan 2026 17:52:59 +0000, Charan Pedumuru wrote:
> Convert TI OMAP Control PHY binding to DT schema.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../bindings/phy/ti,control-phy-otghs.yaml         | 99 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/phy/ti-phy.txt   | 98 ---------------------
>  2 files changed, 99 insertions(+), 98 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

