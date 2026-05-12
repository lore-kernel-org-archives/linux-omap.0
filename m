Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD136F8FE;
	Tue, 12 May 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571288; cv=none; b=SvafrTXLzh3qMKpsnVsMaL12Lb786nzKZz3BLrV0LF18DXWLFxWscv6OS4Gr3hJP2Nzz5uzCyymXmGY6OVoaK5xYKBBfvRVNSBgiQZ6jEXJOn9twd9JhM61dYRSsy4tG7K4RDWXkBAGBgUQuzNuSUoK+iDbQf2gKZnka9f6NbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571288; c=relaxed/simple;
	bh=T/Fjk+Ia8FeTP20elfFPSEy0lY7bZ7cUA3AKIwU37ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nptquDpvyOhqeNc9+sGr6JQLv70SFlXyrcLRODaetX+1X/oSm+K8Oom1MmaVT3oenqRtoUX3GCqxUqt71JTWmTU2VPekHPfWR+KOE+BAAqB/S098tygOBprmnv2gfV+eyWW7RHhTDkEqiHUJD/xCLpux755+BIDfKeemqiv1qOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b41QgKN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b41QgKN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E27BC2BCB0;
	Tue, 12 May 2026 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778571287;
	bh=T/Fjk+Ia8FeTP20elfFPSEy0lY7bZ7cUA3AKIwU37ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b41QgKN8/pvSDbgptQLL7kDNut1BOUGA+W90IztVp/QJIz4DmjpHViUqgm/gWcQBz
	 /9/D2QNqr9SK4X+RbqudiJWkDEEVS9L3KwnOM4JC44SXAvdIFvUj7OSxK3CGgaRwDJ
	 nXTiq364Pe3yj5QXmN28eoof2LFc4DHIM8kFeMD02s2BfGrXaGWt1cshwD77t1G/07
	 MpzPeeblgO2xG2d5a+l0zl/boS90vAeUnnrnrfx4V7Zp1J8MfLyy+lzezR/GiLquHm
	 3en05WEMaCYfwHxwequ5zjGWKhCJV9dTxl6TKSXAnKpavL/VP33QA7T4GVZiKypF+D
	 +HPwrkBZaQQeg==
Date: Tue, 12 May 2026 16:34:42 +0900
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
Subject: Re: [PATCH] ARM: OMAP2+: Make OMAP4 finish_suspend callback CFI-safe
Message-ID: <20260512073442.GA570003@ax162>
References: <20260512042341.1452-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512042341.1452-1-bavishimithil@gmail.com>

On Tue, May 12, 2026 at 12:23:41AM -0400, Mithil Bavishi wrote:
> With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
> because omap_pm_ops.finish_suspend points directly to the assembly
> routine omap4_finish_suspend, which lacks the expected KCFI type
> metadata.

It sounds like omap4_finish_suspend() should be defined with
SYM_TYPED_FUNC_START then? Is that the case for all of the other
functions that are added to omap_pm_ops?

> Add a small C wrapper with the exact callback prototype and use it for
> finish_suspend.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index f18ef45e2..1c51b2f97 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -111,6 +111,11 @@ static struct cpu_pm_ops omap_pm_ops = {
>  	.hotplug_restart	= dummy_cpu_resume,
>  };
>  
> +static int omap4_finish_suspend_wrapper(unsigned long cpu_state)
> +{
> +	return omap4_finish_suspend(cpu_state);
> +}
> +
>  /*
>   * Program the wakeup routine address for the CPU0 and CPU1
>   * used for OFF or DORMANT wakeup.
> @@ -437,7 +442,7 @@ int __init omap4_mpuss_init(void)
>  	}
>  
>  	if (cpu_is_omap44xx()) {
> -		omap_pm_ops.finish_suspend = omap4_finish_suspend;
> +		omap_pm_ops.finish_suspend = omap4_finish_suspend_wrapper;
>  		omap_pm_ops.resume = omap4_cpu_resume;
>  		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
>  		omap_pm_ops.hotplug_restart = omap4_secondary_startup;
> -- 
> 2.43.0
> 

-- 
Cheers,
Nathan
