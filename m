Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435064;
	b=Q2d7ZsWnEOweEadkwJ016FQBGDh2W43j972e2ngvcvsM3nZe+ubgtYrSYi33DFDIln+2
	 cgbxktEJis7hP8wgEWPaVTIpJOpo1Eg1KLxSh50ubLnOgW14muqEiex1mS0Id9A1kFR4Q
	 EA2dJuclP1APeFy1MYlK4yrmwS4Z2a18rmhObXfWFIpN4h8FzxcHqmNSlKPIjXlbt0ek6
	 t5P5/lHojonA4RXMX0DdUXu9xlySWY/e5F7dlhYICGYLwDb8T/PFggJhOk+bagaNvBL72
	 CGYITlT9XtI1F0N8yx4CS9b7SRr71NwiNYx3oytLzm8KYqA4MOc2QA1rkFCqB3Qpjgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gryCa6dA+lhICDuTwDc1VEr42gzjx2FjRQqqEL1hpa4=;
	b=D9tX7Gn7whhmC1ufcuTynHfjxou0LECno4Ey39Y+8304ocwQ7r5at+9JF7WuckErke3i
	 vS3HX9qrdel3qqgApKm5vaki4i5fwllNNaJZKEnnkx/yFvxMDncagmYAoL+VcW4adNrY/
	 EWSA3zbIpVEybp5bYt+wsT9uGDyMW9QBOtr4mHuAOPLNYo1z+QqFa/aHeCSVNEMTL3ju+
	 BliIhGrWVoeiYJT1swbLDq8kNBwU0WW/sQnKwJ9k9VrpV/5NrNQpQbBsRLVAPdbHOz9+F
	 W5zhWna6eD1PuFbd58zrjsRO/+KqraCkNtpAtkRtkLtplJVcdndcD7mleT8KF1UfBNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+yze4e0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E3606A31A;
	Mon, 23 Nov 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+yze4e0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1101F000C0;
	Mon, 23 Nov 2026 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435063;
	bh=gryCa6dA+lhICDuTwDc1VEr42gzjx2FjRQqqEL1hpa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E+yze4e0jJwuWCsMCz1b4Ja9PfPFagSriL1nUxhgD8+/fpK4gOHrG2vfUPSpGQiyh
	 43pXgeIUZ42z5F/tho1NXODnQHOYhu4h2TtuFlNqTbGSauHObK/JFjfma8YvNCA3Qb
	 QcyFuA4/lyHgyNWauRBCDS01asbsxEpY33fquklAQvy00EOI5mIdoBpbpgia6oLZfz
	 kr6kWmQ2nzplllGfCtqMvEusPuVZH+XOlgNsu4cyVjM6AX9oNYucOiVHj8mE+V+sTk
	 WhZ2z7/abVN8Wa2WdxLAUyoVT4kkcdIAcss7HZ7+ioFjqBkDKAFPRh/a2rFKLnLwIp
	 uILGPkQ4XWQIA==
Date: Mon, 23 Nov 2026 12:57:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chrispine Tinega <dev@chrispinetinega.com>
Cc: Lee Jones <lee@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi, 
	andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, 
	jerome.neanne@baylibre.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-omap@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: ti,tps65219: Add
 ti,no-warm-shutdown
Message-ID: <20261123-winged-curious-sunfish-d1b8f7@quoll>
References: <20261116185811.1907811-1-dev@chrispinetinega.com>
 <20261116185811.1907811-3-dev@chrispinetinega.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116185811.1907811-3-dev@chrispinetinega.com>

On Mon, Nov 16, 2026 at 09:58:10PM +0300, Chrispine Tinega wrote:
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> index 7c64e588a..22aea7f61 100644
> --- a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> @@ -62,6 +62,15 @@ properties:
>        where the board has a button wired to the pin and triggers
>        an interrupt on pressing it.
>  
> +  ti,no-warm-shutdown:
> +    type: boolean
> +    description: |

Do not need '|' unless you need to preserve formatting.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

