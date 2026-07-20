Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88639022A;
	Mon, 20 Jul 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530271; cv=none; b=fIWbw008hE+DB5uDY/Cw6tZWIJBWmi9/Olm70ZnCGUy5PnllfEeFzxomijYZ4CycjaYWODdbp2rUc05UXFa8AFuuykH9mW/dmxu4RkLDPAaykTV+uhINno8XyDMsGKHgx26A7vBVQSm6Q6spgwem7THsQWPJ0FP/i+DmwIH8oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530271; c=relaxed/simple;
	bh=A3GH/3d3Lsn5/hA/NcJDxHu/XxbcpbYtvaPkP7lfkrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7pI8uwvCOWOAKRxg4jHfwNdrK8sO8UlmZe3BVaBW5fin/U3kiOq22qlM+mKgWKmPoXDXP5dJo3RUDOO9DbHUObUCsevwVjSfIHGLKSOW+KXo2nRF+u5hgOtD75UiFXSgRDMagE8f5ckpysnShMZKhSOE7VJZo2eHqg3KlZ+fJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9z2zFJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9z2zFJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75891F000E9;
	Mon, 20 Jul 2026 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784530270;
	bh=mB4VfrE4IPaRs5nWbuzDw2hUqa4EvbcO2Mbi+Mnfh38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h9z2zFJcev5nFSleKWKEEGP1WC0USJTYp/ds3ksIT9XTrXc876yk9of+EyhDRb6/o
	 HTi3k1KLFLHnOFmNtf0XuWleGTtQp1xydZQ0fKUdRSkg6yyy2VEoGxzcD4n+bIbc3a
	 HccDZMOxnkwoIovCQXcXApmWfR3GDTN7BI7ffUQ5frKEIhUmxunWthxzGY2zJGk0y3
	 K4tJp+nSqoDWqcKydFei7hHb25al8SvoJiDuSuzhl+4Cs3cIQA8oAbtJSrotLMIyBv
	 rcHYLWyY89SQ0tngY+/0rJC8tcDHCFdN9YpGhAcOOuG6+FqH2HT/weNY6s6qb9VNCI
	 7lXnNPtC0ZAcg==
Date: Mon, 20 Jul 2026 08:51:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <20260720-brilliant-pastoral-oryx-cbe49f@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>

On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
>  .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
>  2 files changed, 42 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

