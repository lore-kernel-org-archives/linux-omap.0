Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024021;
	b=3rSBDpJoBooO92WUfSOQUU1g4+da/hcpGB0g9MFRTfpQLt5CbV+F/PQeOp2T2rf7R6K9
	 ET0jkuhjLM23SAjGPAMk38Gsz9IqJHKL2Nn9Cb5n57NOzNX5rx4TJWua/2wvvO2WPfH6V
	 vy6wcaDBIW5YbYDmhLX+tNVeLQfIHxH2tH/DUeq5jEN7gLwCWcjFgaRUelMMv1c/PQNMF
	 VxKIuZJHaVD8sgKYGNXcTyDePPNhef7DPWtBjqfwl70kjxtSEn57MGg+xYrBmk4mFYq4B
	 LHTAU7XaUm/L82CMcnCtW2mMh0OtbXrbY32rRY/8prR+0uh5bAcJ91BS+FVIzMRhsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wSHGtw/aKGvewYnq0uEOj9CkZTKDscYMPxssMGVdAi8=;
	b=UwB4qqIXv/lxetPHzOcLSDqVWrkK+nxNTYEWS9fqKTcA5DJMDmegzVd4fIh+vCIIfTn6
	 BQyFQzKggafJ2yrEHIfcp98RLqm54N81Nx/1mBj9v3+3YLDAUo/OOzB6J+nZ+vDNJGUYK
	 VJRAzfcbLzwhxtjwyW4bZpZ+8Qwtgv6pP2eG7hgAabcmPCZuRIpIzpwxIOKUIfF8MI3bG
	 WLhyy8prC+e2F6VZjhu2mfDbSyJjvwBkyOSqk+iv7zrAXbIqaiXdPwsRUUs8JIrnOSuJz
	 +mjnSJAF/JCr96R1GVUhy0nc+fJBXhGatXE6XOVJjJ8qAxETkoKlj1itmpSkxoprgHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BAAB/r4g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D4606A31C;
	Wed, 18 Nov 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAAB/r4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766E71F000C4;
	Wed, 18 Nov 2026 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024021;
	bh=wSHGtw/aKGvewYnq0uEOj9CkZTKDscYMPxssMGVdAi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BAAB/r4g7SbK9wGRfRJif4tI1sNCle78CfWYKHiw9MQqlqwOY7HVtmoWj2w7j2+oj
	 XDX5WWl0gTNIjOlp5cHGQXaorpbXH3hRv2hGDT10OOh/kCRy/AdDcJ4ojI/4+ZwzVj
	 UEJIeLc2CZAAI+z3CKqp33GmxC/vYE0a1K/eEQqmMGw/xlropYbyXvSosmt/Dt7p2l
	 dJGDurfIR7OY1gCrEMIh9/+2BRUtpXsoXFu78aqRQDBX/oRpKW5HucyAydY0VswU5x
	 5Qz7jicBCGYSM+qEND6ia5YyAsF0bI524ptQ295yUxJIUqXnQoEJLNBjRG6xHkkW+t
	 WhFz2zgqW/fHA==
Date: Wed, 18 Nov 2026 17:46:56 +0000
From: Lee Jones <lee@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: mfd@lists.linux.dev, tony@atomide.com, linux-omap@vger.kernel.org,
	tharvey@gateworks.com, support.opensource@diasemi.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mfd: tps65219: Fix out-of-bounds access in tps65214
 IRQ map
Message-ID: <20261118174656.GF98456@joneslee-macbookpro.roam.internal>
References: <202611071607376342uPiYA9rHRC7ZI9Ix-8xh@zte.com.cn>
 <20261107160743097R9VvfD_5S5vK286ZLzPhG@zte.com.cn>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107160743097R9VvfD_5S5vK286ZLzPhG@zte.com.cn>

On Sat, 07 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The tps65214_sub_irq_offsets[] array has only seven entries (bits 0-5
> and 7; INT_SOURCE bit 6 is reserved) while the corresponding IRQ chip
> advertises num_main_status_bits = 8.  regmap-irq's read_irq_data()
> indexes sub_reg_offsets with the main-status bit number, so whenever
> bit 7 of INT_SOURCE is set (the power-button interrupt) it reads past
> the end of the seven-element array and uses garbage offset/num_regs
> values to compute status_buf indices, which can also lead to an
> out-of-bounds status_buf access.
> 
> Add an empty placeholder entry for the reserved bit 6 so that the array
> lines up with the bit numbering and bit 7 hits the power-button entry.
> 
> Fixes: 7947219ab1a2 ("mfd: tps65219: Add support for TI TPS65214 PMIC")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index f8c08dd86618..4f4bfc49542c 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -268,6 +268,7 @@ static const struct regmap_irq_sub_irq_map tps65214_sub_irq_offsets[] = {
>  	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit3_offsets),
>  	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit4_offsets),
>  	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit5_offsets),
> +	{ .num_regs = 0 },	/* INT_SOURCE bit 6 is reserved */
>  	REGMAP_IRQ_MAIN_REG_OFFSET(tps65214_bit7_offsets),

This is fragile and `num_regs` is already zero, so it's also pointless.

A better solution would be to specify each element.

Why not use REGMAP_IRQ_REG(), which lets you do this?

Or, add a new, cleaner one:

  #define REGMAP_IRQ_MAIN_BIT_OFFSET(bit, arr)        \
  	[bit] = REGMAP_IRQ_MAIN_REG_OFFSET(arr)


-- 
Lee Jones
