Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E037268F;
	Tue, 21 Jul 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641875; cv=none; b=bgLXeLQMwqz8N/e3/KCC5W7XR5CRV4EK9mJcRibtSVckB30z2Tr0KYOmDnzJR/7t7WCA5e7BTqEmQFLF5G5Qa5B82z9oWP0Hl6A4UTDPTwAM9rwsacRGyQtyJ5OPHWvbWMlC8+ItqDYYu27H1dMfvpbluHST2gGOy3G7WIvflUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641875; c=relaxed/simple;
	bh=T3LvCtPVbxsKH7cnNvx3C8Kvt9q5HvinRYxz9/Q8mJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Z8opbb0BtaDtvDclKPyI6M09EJyNQux5xU0h0rfU0+zYHYuYc5ysuM0ZbAM+04OGQS+JZqel6IYaG27Jc75E93eYCWvunVmUkqc8bo+Y/EuX/3uTM0Sxiz+3/z7qmjchUa0QXsYoEEQ0id/MdvoIBhqDa31fUIOcFCXAoJI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSCBu0jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSCBu0jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D176B1F000E9;
	Tue, 21 Jul 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641874;
	bh=/kN/Id2p6Vej6ZuKU6tzN79T2RHhQJzM6Hc7pJtHxag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bSCBu0jhvPn2Y+1B+tP4uxPOTEBqAFXSgCFZXHh/1sZaII56C5KxZOhJ/zF4f79WI
	 226MkdMOcWqNQmBi4Agor1qSEFyzkqSKTG8KhlhYi2i4tHv1w3KDS71g4d9TW37vkR
	 ku/b8jYSZVB2+OxzE3uO21PGVzmOnrvMsS+6bRpRBg4kYqFUEI0U0DqhMdrMckcU38
	 lVj2kIS1x5AGZny5kmItmZkeRx7RRDNYNZw7v+ZQMUQSVVAQNZl9ZsKi/0vkn6S15f
	 tWEkHLMqA9qye7226gimMj5QK0oBtIYJagHDKgaLQtJjO/v7UPQIlxCM7Zb4MJXnjV
	 aPutGlRmSvucA==
Date: Tue, 21 Jul 2026 08:51:13 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Eduard Bostina <egbostina@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-rtc@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com,
	simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Convert TI Palmas RTC to DT schema
Message-ID: <20260721135113.GA3438134-robh@kernel.org>
References: <20260719141008.3562347-1-egbostina@gmail.com>
 <20260719141008.3562347-2-egbostina@gmail.com>
 <202607191456398730de31@mail.local>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607191456398730de31@mail.local>

On Sun, Jul 19, 2026 at 04:56:39PM +0200, Alexandre Belloni wrote:
> On 19/07/2026 14:10:07+0000, Eduard Bostina wrote:
> > Convert the Texas Instruments Palmas RTC controller bindings
> > to DT schema.
> > 
> > As part of the conversion, declare 'wakeup-source: true'.
> > This documents the Palmas PMIC's capability to wake the system.
> > 
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> >  .../devicetree/bindings/rtc/rtc-palmas.txt    | 32 -----------
> >  .../bindings/rtc/ti,palmas-rtc.yaml           | 57 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 32 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> >  create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt b/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> > deleted file mode 100644
> > index c6cf37758a77..000000000000
> > --- a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> > +++ /dev/null
> > @@ -1,32 +0,0 @@
> > -Palmas RTC controller bindings
> > -
> > -Required properties:
> > -- compatible:
> > -  - "ti,palmas-rtc" for palma series of the RTC controller
> > -- interrupts: Interrupt number of RTC submodule on device.
> > -
> > -Optional properties:
> > -
> > -- ti,backup-battery-chargeable: The Palmas series device like TPS65913 or
> > -	TPS80036 supports the backup battery for powering the RTC when main
> > -	battery is removed or in very low power state. The backup battery
> > -	can be chargeable or non-chargeable. This flag will tells whether
> > -	battery is chargeable or not. If charging battery then driver can
> > -	enable the charging.
> > -- ti,backup-battery-charge-high-current: Enable high current charging in
> > -	backup battery. Device supports the < 100uA and > 100uA charging.
> > -	The high current will be > 100uA. Absence of this property will
> > -	charge battery to lower current i.e. < 100uA.
> > -
> > -Example:
> > -	palmas: tps65913@58 {
> > -		...
> > -		palmas_rtc: rtc {
> > -			compatible = "ti,palmas-rtc";
> > -			interrupt-parent = <&palmas>;
> > -			interrupts = <8 0>;
> > -			ti,backup-battery-chargeable;
> > -			ti,backup-battery-charge-high-current;
> > -		};
> > -		...
> > -	};
> > diff --git a/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> > new file mode 100644
> > index 000000000000..ac64f0589c84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/ti,palmas-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments Palmas RTC
> > +
> > +maintainers:
> > +  - Eduard Bostina <egbostina@gmail.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/rtc/rtc.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,palmas-rtc
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  wakeup-source: true
> > +
> > +  ti,backup-battery-chargeable:
> > +    type: boolean
> > +    description:
> > +      The backup battery can be chargeable or non-chargeable. This flag
> > +      indicates whether the battery is chargeable. If present, the driver
> > +      can enable charging.
> > +
> 
> It would be great to convert to the genric proeprty which is
> aux-voltage-chargeable from rtc.yaml
> 
> > +  ti,backup-battery-charge-high-current:
> > +    type: boolean
> > +    description:
> > +      Enable high current charging in the backup battery.
> > +      Device supports the < 100uA and > 100uA charging. The high current will
> > +      be > 100uA. Absence of this property will charge battery to lower
> > +      current i.e. < 100uA.
> 
> 
> I guess we could make trickle-resistor-ohms fit or get a new generic
> property for this.

Would be nice, but this is an existing binding on old h/w. We're stuck 
with it.

Rob
