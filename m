Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F43502A5;
	Mon,  3 Aug 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792444; cv=none; b=TzlQh1ht1ymT5JRvvvcRxJTkVH4bU64a5SEcPl8NZCANcXn+YBg982kVgcJIsh9CItbmcEg431/s6ydl085UQBxMqWn29j71XZpzOWWGpHtUbIbWXHf/oUJnYsEgA2INToImUIpxQvZYn5g2vNsxzb8ll97LSYP/lqw6yj1U4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792444; c=relaxed/simple;
	bh=seMLHlEDZy+mTM071EV4Zyx3Om5Ke3BlahHFB9AoDCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMmT5OaDFOEnhSnR3BjPeJKgT0Mn5t2a+tsj+/IVUV9HDkKrI9n7rGUMeSli6MJvXUZ6VR1xOcQ3ZI6HDcSMuMBFEMZrhfCRw4OApsUpZZu1z9C3x1fK2jYKiLti32kpVy1JMRGh9JExyumkZRkxV8r2OlhxKVm0Om6oJRRPgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO90NxIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO90NxIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17951F000E9;
	Mon,  3 Aug 2026 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792442;
	bh=dwJt0rr7dx2w5IxYaj+TelwjH2Zy2+tzGR2gR9KtOjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZO90NxIjy1QY3zlcoc7etg3cfMu08gPNV1gaTxKuf7h/aB2zxMRFnxNdr1IxlhJfW
	 N+aHJDOqf0oVk+f630apkufwabyykuWgJmYBrwUpTwbu9FSY4w6mAVC7Sv3u/hUyLs
	 Fy9yTSeVssHowVZ92O5bdhGZOrVwHaTYTw0/ldI8lTDS81j4SUEQDCaCkuK7XmbU2v
	 cNQIWvjmJajZQWF/M8atTpGPIPqy0zBLeCEAhcV1winFG170h/4lS81agy20lbeTdd
	 ol2lTzsKz5fbtoRYpGkCYB83PNGCgsucPZ1TPWFX3XMlV9IIrHdxLiH95yCX4pUn8J
	 45U+ph5GO47Ww==
Date: Mon, 3 Aug 2026 16:27:22 -0500
From: Rob Herring <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
	simona.toaca@nxp.com
Subject: Re: [PATCH v2 3/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT
 schema
Message-ID: <20260803212722.GA575926-robh@kernel.org>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
 <20260725-ti-omap-rtc-v2-3-13f765ca96b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725-ti-omap-rtc-v2-3-13f765ca96b3@gmail.com>

On Sat, Jul 25, 2026 at 02:31:58AM +0530, Bhargav Joshi wrote:
> Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
> the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
> as it is no longer used, it is kept to support legacy boards.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
>  .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 149 +++++++++++++++++++++
>  2 files changed, 149 insertions(+), 53 deletions(-)
> 

> diff --git a/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
> new file mode 100644
> index 000000000000..326d5ad97292
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,omap-rtc.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/ti,omap-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP Real Time Clock
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +  - Afzal Mohammed <afzal@ti.com>
> +
> +description:
> +  The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock with
> +  century-range alarm matching, driven by the 32kHz clock.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,da830-rtc
> +      - const: ti,am3352-rtc

am3352 is either compatible with da830 or it isn't. You can't have both. 
I would drop this entry. You don't have the fix the .dts (or can do that 
separately).

> +      - items:
> +          - const: ti,am3352-rtc
> +          - const: ti,da830-rtc
> +      - items:
> +          - const: ti,am4372-rtc
> +          - const: ti,am3352-rtc
> +          - const: ti,da830-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  system-power-controller:
> +    type: boolean
> +    description:
> +      Indicates that this RTC controls system power via the pmic_power_en pin.
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: ext-clk
> +          - const: int-clk
> +      - items:
> +          - const: ext-clk
> +      - items:
> +          - const: int-clk

This can be just:

minItems: 1
items:
  - enum [ ext-clk, int-clk ]
  - const: int-clk


> +
> +  pinctrl-0:
> +    description:
> +      Phandle to pin configuration for the external wakeup pins.
> +
> +  pinctrl-names:
> +    minItems: 1
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Name of the hwmod associated with the RTC.
> +    const: rtc
> +    deprecated: true
> +
> +patternProperties:
> +  "^ext-wakeup(-[0-9]+)?$":
> +    type: object
> +
> +    description:
> +      Child node describing external wakeup pin configuration.
> +
> +    properties:
> +      pins:
> +        enum:
> +          - ext_wakeup0
> +          - ext_wakeup1
> +          - ext_wakeup2
> +          - ext_wakeup3

pattern: '^ext_wakeup[0-3]$'

