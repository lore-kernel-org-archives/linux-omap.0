Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59323EAAB;
	Wed,  8 Apr 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651895; cv=none; b=p7aX4tcdowGgMjMRKJmnwHDgeHuFxkBCtWbEf0qp83G9wA1i4Si3UG2KrVIEe6TnlOc2/DelH9JjrlkybZDr9KEXxKQuzsEAPRPpmX5/TWlC2HnGWBXi2bDYQGeCHS5U+96HIG2SWuqrbZnKehK1Vr/T0AEMhZlgG3MMMxSaezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651895; c=relaxed/simple;
	bh=Q7WD5TqwsE+nB1erhCRTEU2h8dmXrctSRjrz48M9WlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/ar8+ffD/gSOLi68XDek25g21g61Wni5SMXowb1J0D+P9qDaeRJI4gM7jRzoF3s8FSNtFUavgBMuoTQ4W0EKF8qM06rvqs5mHZtuj36zlZVvccsybx88OqQhCW6c/YpJeL8fsGsVPOJhVNkocigkCBz6wX8O9D5EiOawCRynLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNpn+x1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNpn+x1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502D4C19421;
	Wed,  8 Apr 2026 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651894;
	bh=Q7WD5TqwsE+nB1erhCRTEU2h8dmXrctSRjrz48M9WlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNpn+x1Ts1E7YTZTNBo8Z+f3ZedyqHKaKhcOhMvlA3PPj/2j91d3MjAQSLbSDcmhY
	 oeeR+fcJHWC1jjx+egVba6wV+ACEVZxS1TusHJmVER+bZv8ssdFQvf6gWwxFeSMoqi
	 tv7sWDtzBRZZLm1I5PXUZ05Pf4ho0wotGGBZEE0A0K21b1Ojrigx6v7rn6BY8NX+jj
	 U6b+ubSSgDiqpD36EHc7OOeicFhXqnZdhPi0IXb/s+9Qk2Bo9oiaKHnL6y1FHlzi0u
	 FuEVVRvw1igUr8Om/hXjORBRwJrnapVyhNVJu7gnWPP7haS7BEY8XMgQG55NEV0ODk
	 vFhewgaYv6m7Q==
Date: Wed, 8 Apr 2026 07:38:12 -0500
From: Rob Herring <robh@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: regulator: ti,pbias-regulator:
 Convert to DT schema
Message-ID: <20260408123812.GA1864812-robh@kernel.org>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-1-1c1e11b190dc@bootlin.com>
 <20260331-demonic-boisterous-spider-5ed5c6@quoll>
 <6b637950-2018-41d8-bdd2-27382a9b67d8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b637950-2018-41d8-bdd2-27382a9b67d8@bootlin.com>

On Wed, Apr 08, 2026 at 09:57:20AM +0200, Thomas Richard wrote:
> Hello Krzysztof,
> 
> On 3/31/26 10:21 AM, Krzysztof Kozlowski wrote:
> > On Mon, Mar 30, 2026 at 03:43:58PM +0200, Thomas Richard wrote:
> >> +$id: http://devicetree.org/schemas/regulator/ti,pbias-regulator.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: PBIAS internal regulator
> >> +
> >> +maintainers:
> >> +  - Thomas Richard <thomas.richard@bootlin.com>
> >> +
> >> +description: |
> > 
> > Do not need '|' unless you need to preserve formatting.
> > 
> >> +  PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - enum:
> >> +          - ti,pbias-dra7
> >> +          - ti,pbias-omap2
> >> +          - ti,pbias-omap3
> >> +          - ti,pbias-omap4
> >> +          - ti,pbias-omap5
> >> +      - const: ti,pbias-omap
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  syscon:
> >> +    description: Phandle of the system control module
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +
> >> +patternProperties:
> >> +  '^pbias_*':
> > 
> > That wasn't in old binding and underscore is not allowed, so this needs
> > explanation. Old binding mentioned only the names.
> 
> I did it to match existing devicetrees.
> I guess I should define properties like 'pbias-mmc' and 'pbias-sim',
> then update node names in devicetrees to match binding.

For this ancient stuff, I would just leave the dts files alone. Just 
explain that in the commit message.

Your pattern should be '^pbias_' though.

Rob
