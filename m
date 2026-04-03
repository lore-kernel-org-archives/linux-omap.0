Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255C625;
	Fri,  3 Apr 2026 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255226; cv=none; b=j1BG/miG5E/qCsQHGSITmznFMTLkQO4Q2eGxfoF2ejuMPv9wHNtqQoMfkafOqGVGOqyae+yhm4LY6egKdgS2wT5FY3nUBD0inadYRfnZABkgM29CSY80i4mupQorYvqn3fhBRp1EHf1XSSyTD75lf5YmwsDbwbNACfMgYov0VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255226; c=relaxed/simple;
	bh=EGENpa5hXMx51+JFW9sTYnI8fHqdQEj7f0bOMMDP5VE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Kc5Rcu6SM3vExF+gQCig5GcNsLYqOsx5xJ4p0eGW+1wo97AhUhskvGzbCtCHbC8We95j0V2UtSNv0UK3pyOfKNxSsGak9VUu1Xsswo1eiYU+ClMo0piQV3g71FnHIlf6X3KPXl5MO+8G3REVshJpCfo7NMnqlX8/+iqV2b0GrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=plMHtBc7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="plMHtBc7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB3D5A588E;
	Sat,  4 Apr 2026 00:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775255222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a0bQNKBcJn/PrX6uyv77LW4HGRjds1gfzyAUohZF7aI=;
	b=plMHtBc74S9+kN7pTaO8ZklnVFF2tz/Liay0e5c7teGEkrvFKcgFFh3V2LSRj3TxQmaCEN
	9F3TfbY8EpXAaJgO3p2Mqz2BjVZN/2OarL86haijgaPh5Yx8uNDH0em1tZjKT8BGlKOwDM
	Q1RQAw3gc8P8cvM7mEus8O+3EF5bY444FJSSqVVJWRsMenYt4cNGZBBYkM66Nu2hCyULTi
	wV92PSBMqn8VbNZtqDA7ys1Gh5kn0Yhp4ZNFJ04aCx1ebPOwNxs4fcL0R5O6M7OFLg2NKZ
	ApMuUp8GI5gGWlKgz1dHlNU9rXDDwrdCbev+OJBnngY2UvgRnpf+iC1oNxXFwQ==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Apr 2026 00:27:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: Add schema for LAN75XX compatible
 USB Ethernet controllers
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
Message-ID: <ba7931c4bd597195d56e30d6d20940cf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 3.4.2026 21:02, Thomas Richard wrote:
> Create schema for LAN75XX compatible USB Ethernet controllers. The 
> smsc75xx
> driver only supports LAN7500 and LAN7505 devices.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 
> ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git 
> a/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml 
> b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
> new file mode 100644
> index 
> 0000000000000000000000000000000000000000..b84022976044ffec2024cff9fc0aa5016723abed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
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
> +  Device tree properties for LAN75XX compatible USB Ethernet 
> controller.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - usb424,7500
> +          - usb424,7505
> +
> +  reg:
> +    maxItems: 1
> +
> +  local-mac-address: true
> +  mac-address: true
> +  nvmem-cells: true
> +  nvmem-cell-names: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

nit: not required by the example

> +
> +    usb {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@1 {
> +            compatible = "usb424,7500";
> +            reg = <1>;
> +            local-mac-address = [00 00 00 00 00 00];
> +        };
> +    };

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
