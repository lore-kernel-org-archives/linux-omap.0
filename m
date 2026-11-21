Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795252472;
	b=IJgSz8npJnKmY/JPX8Dsef0Sykd+FOdhQcW0ealZQ6rwx31/WM9O5BnfObAXtSHpxFQm
	 +QBKB8axs7LbNhLX8hgJMI9CE1ssgVrwZTIMHNjqeLsfbv+NBZ8V3VxENEKVgw4MlGJ9Y
	 R7WtFpypCacuJy6zAvK/HVbiPjXcVCjxdnyc/5yhjAdfHxKeWZnwnxdl1qtVzYFJLFyKv
	 dzLK/wSpOtXHr0zms+wPSOjaCdVI/5Jo87arYx/3WDuEY788lEUQvyGGAacIbFxoRs78Q
	 iqK0nhBHmZRG/bpZaA1oeBLzLctzm6QjAKS2XBVWXkxnhlQia4KBUV2sXk3d1TDld1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252472;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6OcAPrJ07kcXpY39GtMpsqyPmuhgl4voskQQPXP2nhw=;
	b=R0NPo8fo32BjpE7BAlO4OoxQcgp96ndzFCkMSqBQtcOVd7n9Wy4eNPkY2POevFzPm+Im
	 xIaNtM2sL16CC80/XCA+TV+spcH4zoFjCCZIBT1GswycXQIh3UOjjbkSvDN8gxDuQPj+/
	 Ond7A5ZEnNDOcq0B6mV8NvxePjYUEC0elAzua9N3g1WATwdXjjcjGo+zkfaHnpbG6zxu6
	 0SF7G7JCGegBsg7s3BrsVPFWGXAQT63uQ828M/6YAuVgDEtv8Gz+tStz3Db4Gsbw/lpO3
	 3x7Kh5l4WJWqiX3scMIfCxbhGivD22zgW1seWL0BZLwWo9SekRnITfk8Dq+ew14t0lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=rhGgxjM7;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04155606A320;
	Sat, 21 Nov 2026 09:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04155606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=rhGgxjM7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=6OcAPrJ07kcXpY39GtMpsqyPmuhgl4voskQQPXP2nhw=; t=1795252471; x=1796462071; 
	b=rhGgxjM7z25zXdQMMDMlfNP+/rJqs3WDL9ACuFxqyi0ce9SJpiwgDpcpkoKuOsTqnLzIki196H+
	cERmBDnhV/9mwkCTSX2Et3GzOx8SU1XyeOD2jYszt7yt9NVL3sWWzMkUcgV0d/v3sndY0T6woffvj
	m/AAF1QOYhEsp3TDakZeODhRlFoLuSJgIVKdt4WiC4UGZd/S4V0wFIIi91YC9CB10P/m//vpaqUKD
	o7fbATAs8LamiQUyxuSr3FzNM2VQmpJ5xm7ZxpqrsaUpWvSsXp8ANaw4HQOg1mQCINqYDNJ/Be7a6
	wugLjjw4wsQ1EjBeq0eJLRGuEMVFZpwqu+tQ==;
Date: Sat, 21 Nov 2026 10:14:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Santosh Shilimkar
 <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
 simona.toaca@nxp.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: bus: ti,omap3-l3-smx: Convert to DT
 schema
Message-ID: <20261121101424.22e24149@kemnade.info>
In-Reply-To: <20261113-ti-l3-noc-v4-2-5084dcf4ffb4@gmail.com>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
	<20261113-ti-l3-noc-v4-2-5084dcf4ffb4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 00:24:03 +0530
Bhargav Joshi <j.bhargav.u@gmail.com> wrote:

> Convert TI OMAP3 L3 interconnect from text to DT schema. In text binding
> this was grouped with omap4+ L3 noc interconnect but since it uses
> different hardware IP (SMX). Add SMX variant in new schema.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/arm/omap/l3-noc.txt        |  5 +-
>  .../devicetree/bindings/bus/ti,omap3-l3-smx.yaml   | 68 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> index 161448da959d2..66548395fbdeb 100644
> --- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> @@ -4,10 +4,9 @@ This version is an implementation of the generic NoC IP
>  provided by Arteris.
>  
>  Required properties:
> -- compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
> -               Should be "ti,omap4-l3-noc" for OMAP4 family
> +- compatible : Should be "ti,omap4-l3-noc" for OMAP4 family
>                 Should be "ti,omap5-l3-noc" for OMAP5 family
> -	       Should be "ti,dra7-l3-noc" for DRA7 family
> +	           Should be "ti,dra7-l3-noc" for DRA7 family
>                 Should be "ti,am4372-l3-noc" for AM43 family
>  - reg:	Contains L3 register address range for each noc domain.
>  - ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
> diff --git a/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml b/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml
> new file mode 100644
> index 0000000000000..3fc5fae7b37ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti,omap3-l3-smx.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/ti,omap3-l3-smx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI OMAP3 L3 (SMX) Interconnect
> +
> +maintainers:
> +  - Santosh Shilimkar <santosh.shilimkar@ti.com>
> +  - Sricharan R <r.sricharan@ti.com>
> +
> +description:
> +  The L3 interconnect for OMAP3 is based on the SonicsMX (SMX) architecture.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,omap3-l3-smx
> +      - const: simple-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: l3-dbg-irq
> +      - description: l3-app-irq
> +
> +  ti,hwmods:
> +    description: hwmod names for each domain.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    const: l3_main
> +    deprecated: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus@68000000 {
> +        compatible = "ti,omap3-l3-smx", "simple-bus";
> +        reg = <0x68000000 0x10000>;
> +        ranges;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupts = <9>, <10>;
> +        ti,hwmods = "l3_main";
> +    };
> 

