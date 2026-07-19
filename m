Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D971F427C;
	Sun, 19 Jul 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473017; cv=none; b=kU/p/wT6X2EdSZX+eWis2TRAiUSxyw7FbT149IVYMkZDEu0lVdsPkO5D0TY5CMGyCD6QhDDaxYmjLBRK8VAvFqxjU5H+Eqe5PgFYKVd0vdmdRTWHjQezfqpALZMGGjODOP3p48+IrG/ercXAgcR74fwaU4uheO8ZyMYJzFwFjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473017; c=relaxed/simple;
	bh=2s7kwBO2kbTXuCbnAKbmNtkLDNAupTyVU3LlUE3MzYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbI5AxRJC/pNzWymAYdIoWSV1PcirBqDW+rSxTRWUHyRrqgr7kzxPv1VO/NlocxIoQBKNeeWbodxaLObR94cj3wLlRtzpZDsgtnW18pSb2+E1eYj/m3nLltKDLHIRGN2V+FjLMJz/srWcDbXDSM7lwLuUXhoBqzB857ar8SK/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iPhbhiid; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iPhbhiid"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 71FDA1A10D9;
	Sun, 19 Jul 2026 14:56:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2FEF1601A5;
	Sun, 19 Jul 2026 14:56:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26BC511BD0158;
	Sun, 19 Jul 2026 16:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784473004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ynNcPxPXyZlRa+EHFb9XVlCnx8pqFltjRJq0sIxgaeo=;
	b=iPhbhiidJ8ANasDEkzcjwOsDcSgVvlrD29BoEUQsRwMk8B6QSv5VLG4ecWsDT6BKZMlpqX
	qyEjPxTL1M5aJOUR+QvOiEdSBLl+tv54GFboNVKuXeowa8fzECYhPYZkQJe0Ha0p0I4K0N
	+kPnIpSfwPfq4384j6+pAPpk89qv+CcU/rdCkzpxn00q+e2mE0zh3KBsJTv4hMf75R2nwr
	qn3CicuLfsrnaz+0d+YJHLtjtpUGREhFors2K3/1p7kiGkjYOoM3hc/SS+BuzFUKbEIBSu
	g4XLAU9K06pG/bzI7DrzKzvjADEnyP/foenGUUl1sZk62qeLL3sBTqKnyNd9pw==
Date: Sun, 19 Jul 2026 16:56:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT schema
Message-ID: <202607191456398730de31@mail.local>
References: <20260719141008.3562347-1-egbostina@gmail.com>
 <20260719141008.3562347-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719141008.3562347-2-egbostina@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 19/07/2026 14:10:07+0000, Eduard Bostina wrote:
> Convert the Texas Instruments Palmas RTC controller bindings
> to DT schema.
> 
> As part of the conversion, declare 'wakeup-source: true'.
> This documents the Palmas PMIC's capability to wake the system.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
>  .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt b/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> deleted file mode 100644
> index c6cf37758a77..000000000000
> --- a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Palmas RTC controller bindings
> -
> -Required properties:
> -- compatible:
> -  - "ti,palmas-rtc" for palma series of the RTC controller
> -- interrupts: Interrupt number of RTC submodule on device.
> -
> -Optional properties:
> -
> -- ti,backup-battery-chargeable: The Palmas series device like TPS65913 or
> -	TPS80036 supports the backup battery for powering the RTC when main
> -	battery is removed or in very low power state. The backup battery
> -	can be chargeable or non-chargeable. This flag will tells whether
> -	battery is chargeable or not. If charging battery then driver can
> -	enable the charging.
> -- ti,backup-battery-charge-high-current: Enable high current charging in
> -	backup battery. Device supports the < 100uA and > 100uA charging.
> -	The high current will be > 100uA. Absence of this property will
> -	charge battery to lower current i.e. < 100uA.
> -
> -Example:
> -	palmas: tps65913@58 {
> -		...
> -		palmas_rtc: rtc {
> -			compatible = "ti,palmas-rtc";
> -			interrupt-parent = <&palmas>;
> -			interrupts = <8 0>;
> -			ti,backup-battery-chargeable;
> -			ti,backup-battery-charge-high-current;
> -		};
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> new file mode 100644
> index 000000000000..ac64f0589c84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/ti,palmas-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas RTC
> +
> +maintainers:
> +  - Eduard Bostina <egbostina@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/rtc/rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,palmas-rtc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  ti,backup-battery-chargeable:
> +    type: boolean
> +    description:
> +      The backup battery can be chargeable or non-chargeable. This flag
> +      indicates whether the battery is chargeable. If present, the driver
> +      can enable charging.
> +

It would be great to convert to the genric proeprty which is
aux-voltage-chargeable from rtc.yaml

> +  ti,backup-battery-charge-high-current:
> +    type: boolean
> +    description:
> +      Enable high current charging in the backup battery.
> +      Device supports the < 100uA and > 100uA charging. The high current will
> +      be > 100uA. Absence of this property will charge battery to lower
> +      current i.e. < 100uA.


I guess we could make trickle-resistor-ohms fit or get a new generic
property for this.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
