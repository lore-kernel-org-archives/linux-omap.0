Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230484;
	b=5E5VG4C5XekNvcBYEtzFCOFnDAFR7ywObQQPstUXI1y57Q3qxSyUpqLZmEbPpVToNSxy
	 +o3UR7S3xvhDCH3DTH0+r1xsjKJ6CWQJ7XztIjlat9jEoQebFtbKDxr965fxXC76ah1H2
	 SDSilbIT1tNK80Mc496xBAVcBexu8d9D7l+OGfs1BuBnFX1reIMmIjr/gKvgPT2Ir+rfC
	 H8y5dS7xf0Ux1bsddirNLntjmSho5CGIfmppIcG/JVR5gBjdwWZEat/XDhrfqz5aP0agI
	 2uG5SSBd/G/OcydZ5JINSsy/D/ItgJKStLCOrJ1q4tKhnLyb8SxxuGLEaDgknOqF/Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230484;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dSDOttOUZlbRzOTWEjKBcPBDk84wy77ID43rCwcUDVI=;
	b=GWCxCLlltAIgJ6FNeTz36tvlaiDYWPvibF2jpnLuWOCdqLqwy++OyYiEhzdlVpH4sgsx
	 vzqFIYa9o+LFeU+s5dd7Avfl5QbMQsh+gyH3OAwV+4g/KKFmBciOMXhmlcfZC4l5Kzoj3
	 9SbeyDscACQ3L/0YzauQpTOyXukeklO8+RFnt9x/U0CBHnRwarMBOiPqfYfx17yinM+dl
	 QtfX3Em1oLpk/MsAAGMPl2Pr6tS3C2GaB7UsISuKAU6J8Tb9oR9wKX4KZaS9FUWcdftAk
	 O+pFCVro3EHXFbzf83dPE8KFIlNydOrBcF/M/tAOF9CT0uFsF2WcLErdk8KqEUx0PJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rnm2OZ43;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D48606A31C;
	Mon,  9 Nov 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rnm2OZ43
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF331F0089F;
	Mon,  9 Nov 2026 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230483;
	bh=dSDOttOUZlbRzOTWEjKBcPBDk84wy77ID43rCwcUDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rnm2OZ43+sNN2aJJ52eRSZhb+eqAhS0A4vIyS9o1EgF2JmB9rRXJJMj6l3lgx4wJg
	 AlxTQ5BR40MI2Hn9bUmUvgh1JoU7OMTQWgJY68SwtXc4y0UXSJDS3FsdS6LMCYbsNE
	 ptwUXL4uVBXJ60moWUQZClLUvLZAT6jg6TGMa62lc+OIndtPBAMfabo6Z1PLer2hva
	 s7Fl6mbCkFosCu+JvZ2k59W24/GVlgJkPB2y7lZrk/5eqfLsc/+VLPXvhIoNc/8PvL
	 qEK5U+ELNg52phl2lFHfIFr2YMT+6wvczJuVGV/pArLaL48EuEO6F5tutar1rpipAG
	 a5c6KfPcxQvjQ==
Date: Mon, 9 Nov 2026 14:21:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info, 
	khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com, jmkrzyszt@gmail.com, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Message-ID: <20261109-psychedelic-kudu-of-tenacity-b06ada@quoll>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
 <20261105200556.34240-3-apokusinski01@gmail.com>
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
In-Reply-To: <20261105200556.34240-3-apokusinski01@gmail.com>

On Thu, Nov 05, 2026 at 09:05:52PM +0100, Antoni Pokusinski wrote:
> Document the TX and RX DMA request channels featured
> by the OMAP I2C controller.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> index 58d32ceeacfc..ff946fdfaad3 100644
> --- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
> @@ -37,6 +37,16 @@ properties:
>    clock-names:
>      const: fck
>  
> +  dmas:
> +    items:
> +      - description: TX DMA channel phandle
> +      - description: RX DMA channel phandle
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

