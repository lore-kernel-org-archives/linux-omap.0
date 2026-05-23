Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A815B971;
	Sat, 23 May 2026 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499068; cv=none; b=q/3Mt2uy0L1kgB2tUsj3jfYHpJ51IQJhsVUWFFjPtmD6mzghKy/CcyztnhfJxTnEkm9iTj1kl7l3uOJbyPcX2J/8zOtVa0ZkH1QJjveVsn3jOh05OaGfHKS0Gah0GobjaL1PnsTdp/voRKCtQwuLi/zFtuwoIWrbw5R1AcDPuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499068; c=relaxed/simple;
	bh=dO3zXTzmwUSskeBLmpVxGmQPSV+yLgtT8f+5DJ/75F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKhTbZydkDAl3sw8z3oOJGhCk4HzVfp6u4rDWkZsldp6EpI8dk+e73HIpLb26TSeZ8zqHfycYNfQeMJ60vJBO/05T7fmjpW6ecfiRTS0Co7AEKKcGqUVR095nRXkEFnXYCdwRKnJLXGjx1UeuQLnSelXnY1xc/4/iLJa5hxUpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN9bHPFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN9bHPFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C44A1F000E9;
	Sat, 23 May 2026 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499066;
	bh=HgG/WK4w3DmgQeJigoCOVGTZUreRd8ANchlOeI9Sask=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UN9bHPFU251YKJIEQ6b68/REcbApvPpea4AqPunrvaf0B5eHUiZ6rWBwKtmkUnzcu
	 O8Q9N3jZxaZ1u7WXAJPP4cxt4oupewzOjy1TKcQrUfPBXNtSscgKsSJfZ2T2bw29yG
	 YKTupMsk4bp2hiqanw8s67ClVh9s7ijpqoco8GA1tYT+wYdunu8EdCD6As7uhSl5sA
	 uhTvbsg67bvxUEfJL9/PG3JPRGd30ZapdGBEB9ZmAqxsdfiR3tFMX8PkBdVNqr/Zth
	 o5NfNCu+yqV82zPDeNVt+nCTjnyqXmy9diKuEw42XzMogEae/E596Z3dOezD50wGFR
	 bf2gf9TSGRyjw==
Date: Fri, 22 May 2026 18:17:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Message-ID: <20260523011741.GC520407@ax162>
References: <20260522233036.12277-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522233036.12277-1-bavishimithil@gmail.com>

On Fri, May 22, 2026 at 04:30:36PM -0700, Mithil Bavishi wrote:
> With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
> because omap_pm_ops.finish_suspend points directly to the assembly
> routine omap4_finish_suspend, which lacks the expected KCFI type
> metadata.
> 
> Annotate omap4_finish_suspend with SYM_TYPED_FUNC_START so the assembly
> routine carries the KCFI type metadata.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm/mach-omap2/sleep44xx.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> index f09c91978..0b48df6fc 100644
> --- a/arch/arm/mach-omap2/sleep44xx.S
> +++ b/arch/arm/mach-omap2/sleep44xx.S
> @@ -58,7 +58,7 @@
>   * stack frame and it expects the caller to take care of it. Hence the entire
>   * stack frame is saved to avoid possible stack corruption.
>   */
> -ENTRY(omap4_finish_suspend)
> +SYM_TYPED_FUNC_START(omap4_finish_suspend)
>  	stmfd	sp!, {r4-r12, lr}
>  	cmp	r0, #0x0
>  	beq	do_WFI				@ No lowpower state, jump to WFI
> @@ -223,7 +223,7 @@ skip_scu_gp_clear:
>  	isb
>  	dsb
>  	ldmfd	sp!, {r4-r12, pc}
> -ENDPROC(omap4_finish_suspend)
> +SYM_FUNC_END(omap4_finish_suspend)
>  
>  /*
>   * ============================
> -- 
> 2.43.0
> 

-- 
Cheers,
Nathan
