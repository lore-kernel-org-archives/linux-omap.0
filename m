Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BF81A682F;
	Wed,  8 Apr 2026 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652071; cv=none; b=pNvpTuTQgq+aj2D4TxYqx9iDsYtN3aGirQUhtRR2XsTG54GumGkpuiOUpmFEWEtu/bdS5HywRB2SGscnFb8w+6kbhasX3CfeVDU2AGbPH8iqkZtPDw85eLJ0nKMVHTW3LAmmdvlM66ZObpwrZJFIwlKdEtv0fASRqS4ejp8HUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652071; c=relaxed/simple;
	bh=yG+GD+DKVlRR8h9AAdBTP0gvOABYebEQjBc11MJEBsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWGgxyIe59R4rkuy0B8UQF7Je2dVZzl5NeLj7znBKKGdkAlltc/jas8u5PoE0ft8Ea9FwXHjNP76WzQgQkUceeDXMPVnRde1iI19eGGk/KNWvL7byItAB4/2nr1gftZ+sXenuUsMwrotowSAUS+nQPq0FXr29c4UD2y6uNMDp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/t7rH+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/t7rH+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB47C19421;
	Wed,  8 Apr 2026 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652070;
	bh=yG+GD+DKVlRR8h9AAdBTP0gvOABYebEQjBc11MJEBsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/t7rH+fGC9Mhf210oh9OG+gYxThs3+Y7aWWKkdEZ8MZM2+U5k91MlrI4bMxv8rfe
	 5tEvj1WTwdmfRQe3sXvfMqnsfFaIU59C9zJsie0XX1RTPo2DE+0zL64x+XJAnUAgBJ
	 sw7yW5N+P/EQ+oOS5XfzywFfEpKYZkOppl/RvZ+eH/tB1hJORvYjbvwwtFqKsTnsDP
	 cWDVygvVnHzEhzITaf0Odq1kEl43BR24QsE6Qqru+snZSxMrv+R3FgVFXkUDyjOWlV
	 WtvfJDICdgF7h33QEfHdeJNSiwlZhlc8+OKULMSo7ko5TlZekJ8GTTHz3j6q3TX00d
	 fRNtlgdBKZIKw==
Date: Wed, 8 Apr 2026 07:41:09 -0500
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
Subject: Re: [PATCH v2 02/11] dt-bindings: regulator: ti,pbias-regulator: Add
 pbias_sim_omap4 regulator
Message-ID: <20260408124109.GB1864812-robh@kernel.org>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
 <20260330-omap4-fix-usb-support-v2-2-1c1e11b190dc@bootlin.com>
 <20260331-funny-impetuous-bobcat-eb56af@quoll>
 <9d76f827-3967-4ab6-b6f0-77d1bd564278@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d76f827-3967-4ab6-b6f0-77d1bd564278@bootlin.com>

On Wed, Apr 08, 2026 at 09:58:15AM +0200, Thomas Richard wrote:
> Hello Krzysztof,
> 
> On 3/31/26 10:22 AM, Krzysztof Kozlowski wrote:
> > On Mon, Mar 30, 2026 at 03:43:59PM +0200, Thomas Richard wrote:
> >> Define pbias_sim_omap4 regulator for OMAP4. This regulators drives SIM_VDDS
> >> supply and allows to unlock USB I/O cell.
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>  Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> >> index 3e020d87701b..908fbb46b5cf 100644
> >> --- a/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/ti,pbias-regulator.yaml
> >> @@ -89,6 +89,7 @@ allOf:
> >>                contains:
> >>                  enum:
> >>                    - pbias_mmc_omap4
> >> +                  - pbias_sim_omap4
> > 
> > Names cannot be fixed, because they represent different board naming.
> > Why growing the deprecated style?
> 
> Okay, so I'll drop all if statements, add a regex which matches
> regulator names and fix the regulator name in the driver.

If a driver depends on the names, you can't change them.

Rob
