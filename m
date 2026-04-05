Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42D21D3E4;
	Sun,  5 Apr 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775376417; cv=none; b=r2SArOekP5Hj3BV9xvPEqhWTLIfU3htVGMxUBtncGeLPtSF1cSzyEXyyo/KZsjBGF2OtmzO9EyDmI/kUamgBJzI4cwyf17Zrs33JxVbBJLmuf2CQZJi4pV2DtxeI1gLW5x0xVXDWwZv+5YDJWwz0qp5wifYmobJmCcbJMUBshM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775376417; c=relaxed/simple;
	bh=WnQxN+9En0IqvRhXJKWdmgHdRCUfghQVYb729H4BIPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr2aj+so99kytRzrV3G7CPP6p36P979movVW3EOFkEr/WARvmLwCzogcCUbPXdU0KcHMQ/kKLeAIu6cyTWXQAGD6mXeeo+MqrNQfp5OT7ODFthEcc2JyoCySrU1A5qWFWsVuRlnmAOYOnyfaNrag9vsJPLQ1EbkHAnC6hosmt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1Caimtc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1Caimtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0528C116C6;
	Sun,  5 Apr 2026 08:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775376417;
	bh=WnQxN+9En0IqvRhXJKWdmgHdRCUfghQVYb729H4BIPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1Caimtc8bv9UKdnt5rdjGqUNXIGMFeviubcn4DlNgzBELX4yEaJHKc+bNXtKOBwE
	 v01QONOmOmV2Mp9XvWZP9z72ilHCxNJYbaGVUh3t5uRk8KUZ5zZR2AXqHU5Lzusjeg
	 i3zDXzCe1TOd1EN0yNZYAmIrlJ+AVaviBVroXuk0Cl99EP8Fix7Mc7YgcWfr53hhTR
	 dlefUPWzbkM+La9ciqTN2sG8LS/RKl0xGiL1QBhSRQB+MgShO/nyv16QLLKgCcujE3
	 EGHWiAwEPq7lBYSLZhCx3uya6Dt6zXAO4+dI6SWDot/G5QsRIrctW6m7VMXrRhKTU/
	 oTXXLnafM1O0Q==
Date: Sun, 5 Apr 2026 10:06:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: Add schema for LAN75XX compatible
 USB Ethernet controllers
Message-ID: <20260405-smoky-spectacular-koel-dbfcda@quoll>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>

On Fri, Apr 03, 2026 at 09:02:23PM +0200, Thomas Richard wrote:
> Create schema for LAN75XX compatible USB Ethernet controllers. The smsc75xx
> driver only supports LAN7500 and LAN7505 devices.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..b84022976044ffec2024cff9fc0aa5016723abed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml

Rather microchip,lan7500.yaml. Wildcards don't really scale when you
have 75yy coming which does not fit into this binding.


> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan75xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN7500/LAN7505 USB Ethernet Controllers
> +
> +maintainers:
> +  - Thomas Richard <thomas.richard@bootlin.com>
> +
> +description:
> +  Device tree properties for LAN75XX compatible USB Ethernet controller.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items, that's enum directly.

> +      - enum:
> +          - usb424,7500
> +          - usb424,7505

But you should notice that this is exactly the same as 95xx, so why it
cannot go there? Because of the wildcard 95xx naming? That's not a
reason.

Best regards,
Krzysztof

