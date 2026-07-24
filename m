Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A204908B9;
	Fri, 24 Jul 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873185; cv=none; b=aRmkptgtxkuOpHw+WIWN8nLm2KPfVhDG3Mh2pZ9Pf7bqHknv9yH/A6sME1r9OqPbM3dRQxfOrJBxuaov1YHjwgS3HczVjsWpmkF3M8RgObfGQ6pcSt3Do0I5iBZ4yWL2BnNACdbNcU5JcQ+jM3wtCuLaTI+e0l4pWG+2zFdvbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873185; c=relaxed/simple;
	bh=cz4Rgyk6SE0Jy5yJIOzM0jLexd77fECOgRTELOCiN/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivuzxx3x570oqsH8ZjCgnyM5Oa32mtNaJ+o7d43UHKQV6CvMGoQXZ1J7rcrG0sPxZiqJQVFYjrEBQqSHlndqBLmf5kWRtXgn/Qc+D1h3kNRaFjFwWxXwtSf5eDGMFRE07KNrWv4mWQbQDpvqL09oGz6F+o+NpbdHbfW6spToI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUdDw2Vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUdDw2Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721BF1F000E9;
	Fri, 24 Jul 2026 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784873184;
	bh=sR2SdUSKgTFGbEVS0wvxdwiXMBvONMXt7n2+RC5+RK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUdDw2VjHIGIpf5xZK2NH4yo+1pJFxeBM9CgSPqyS6NiRHacehwh09nsBV6fNg1eK
	 MMkWLPbRC2B4g+e/aTFz/G5tXpi2D6rAzlUXc7keNTiku/42ixQmhkqNrj+Wx/93Hl
	 u/iYAa2fslepTR0QxkJQnhPlWR0fk6ykIegJzvuX5lrjxNak42E0JDaEJb8ZpuZXtG
	 Jke/u3BfXWPnp9mQ7jIPE6eqJOO+3uqgHhXvETEkoKh5168x8GpZ3DUAmmtc4/oXBK
	 iTtAOhgrb5TKP6xiADv9ObVv0/VfEHeC+VTcKDR0W5XlpngyWA0kZ1lCsqpcv4wBT/
	 FYKWsMIZBeYsg==
Date: Fri, 24 Jul 2026 08:06:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, 
	simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
Message-ID: <20260724-gentle-starfish-of-fantasy-cbb2a3@quoll>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-5-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>

On Thu, Jul 23, 2026 at 10:06:02AM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
>   which are used by the boards but were missing from the old txt
>   binding.
> - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
>   and 'ti,pmic-shutdown-controller' properties, which are used by the
>   am335x boards and read by the driver.
> 
> The regulator/tps65217.txt binding documented the same 'ti,tps65217'
> compatible and is superseded by this schema, so remove it as well.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

