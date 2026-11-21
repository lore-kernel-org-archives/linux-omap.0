Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795252474;
	b=DFwt+v/QOs7HwgC7Md5yGlDBf5xbOocY7MEeQZfrhvekIezA8x5Vp3w7IHbTa6xzIBKM
	 OG1nzokZ3zIWhM2A72GQUB4FKUlf0Ir1v+NqebrVJwNqlGVk+Wjz1wnvIYPFYxTsFONWC
	 c8la1jV1ygm2mETEtKmYs/f7jFHjl59N9xub1kzP6DesQVm7rPafeUeUJwVQDpA0eg2s3
	 yRNdJ92QKy0hvwlMFayC6XVW2VuHiP+lrOiUKOznS/X2lNyvq208IJZkgAXQ7IVOG0dSF
	 oSx5l4s7drIaPV8icL66bKB1XqV3b7zDGy77N89qh0Pv8QNnYAbWkjnqflie4jfTo1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795252474;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nXNLRbJHp6+SBvzs7NFLuhWVjsszeMyRzNWbmMO8hdg=;
	b=ninU7ajCjiu31SFg9aUbf0NLNlR1NXUxr40zAH7JrZ7PgepsNsjEPAUyT/2/iXyMuBJM
	 X7j2BeLV0+yro+1tUGSgWpswyAWObduWLskxJGIGtlrSqCQsK4Wix+q/P62JM+I4Tc7Z1
	 lmiM4tjlAh35G8q4c5o358xpA5mGao1tSbIARyHR8XamvZhNR/Pq99QJGehjmwgYMq9Jt
	 whDEPNDys5RKCWv5Ay6ZnOrseW6Uh5nrNw6jkNnk5WbsTBY5Sx1E5Qrqq7gPlvyoZKhSr
	 3iJk0PNnMBVmh3pTsdSEvJywsuc2gJsWJ3nPKNQbZ2Gzi9/jtPFx6TKlpxHzed4ZwFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="PD/2zq3t";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98437606A337;
	Sat, 21 Nov 2026 09:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98437606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=PD/2zq3t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=nXNLRbJHp6+SBvzs7NFLuhWVjsszeMyRzNWbmMO8hdg=; t=1795252473; x=1796462073; 
	b=PD/2zq3tnnrroV90Irg7//6o7wWolMV9AT7lP3xATjNQFvvPScWCQhBxqjmx9WjJPwjB3EMswc1
	tYUs++LL1lMNX+jOxuHSvfZORVy6xP2FWwU/8tNSjXD2BKcsRgSUrBnDheXT93GcMxcE4LcHcOnSj
	xcvjjuWzEltkY3F4UKvSr1RvfcPQUzkwWh7opfee+dkUPqS4AqDnwxdvnAiw/9FDNhplk6/ku957Z
	YUG53AVexc/VoecXtwGQqdEh8zUK9wtYNqVm1LypoaYLJ/TbfsEbmGLQrMz4XUSqMqCpbKsuP2C4o
	F7LIZaQDZaBEx68kZ0ZO7j4E8kyGg15SlHLA==;
Date: Sat, 21 Nov 2026 10:13:54 +0100
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
Subject: Re: [PATCH v4 3/3] dt-bindings: bus: ti,omap-l3-noc: Convert to DT
 schema
Message-ID: <20261121101354.4a1d5535@kemnade.info>
In-Reply-To: <20261113-ti-l3-noc-v4-3-5084dcf4ffb4@gmail.com>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
	<20261113-ti-l3-noc-v4-3-5084dcf4ffb4@gmail.com>
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

On Fri, 13 Nov 2026 00:24:04 +0530
Bhargav Joshi <j.bhargav.u@gmail.com> wrote:

> Convert the TI OMAP L3 NoC binding from text to DT schema. Drop
> deprecated ti,hwmods as it is not used anymore.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/arm/omap/l3-noc.txt        | 22 -------
>  .../devicetree/bindings/bus/ti,omap-l3-noc.yaml    | 71 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> deleted file mode 100644
> index 66548395fbdeb..0000000000000
> --- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -* TI - L3 Network On Chip (NoC)
> -
> -This version is an implementation of the generic NoC IP
> -provided by Arteris.
> -
> -Required properties:
> -- compatible : Should be "ti,omap4-l3-noc" for OMAP4 family
> -               Should be "ti,omap5-l3-noc" for OMAP5 family
> -	           Should be "ti,dra7-l3-noc" for DRA7 family
> -               Should be "ti,am4372-l3-noc" for AM43 family
> -- reg:	Contains L3 register address range for each noc domain.
> -- ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
> -
> -Examples:
> -
> -ocp {
> -	compatible = "ti,omap4-l3-noc", "simple-bus";
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> -};
> diff --git a/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
> new file mode 100644
> index 0000000000000..85f314f177379
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti,omap-l3-noc.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/ti,omap-l3-noc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI OMAP L3 Network On Chip (NoC) Interconnect
> +
> +maintainers:
> +  - Santosh Shilimkar <santosh.shilimkar@ti.com>
> +  - Sricharan R <r.sricharan@ti.com>
> +
> +description:
> +  The L3 interconnect is an implementation of the generic NoC IP provided by
> +  Arteris.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap4-l3-noc
> +      - ti,omap5-l3-noc
> +      - ti,dra7-l3-noc
> +      - ti,am4372-l3-noc
> +
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: L3_MAIN_1 / L3F
> +      - description: L3_MAIN_2 / L3S
> +      - description: L3_MAIN_3
> +
> +  interrupts:
> +    items:
> +      - description: l3-dbg-irq
> +      - description: l3-app-irq
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,omap4-l3-noc
> +              - ti,omap5-l3-noc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    l3-noc@44000000 {
> +        compatible = "ti,omap4-l3-noc";
> +        reg = <0x44000000 0x1000>,
> +              <0x44800000 0x2000>,
> +              <0x45000000 0x1000>;
> +        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> 

