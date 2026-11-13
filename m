Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607612;
	b=t4omhk3Gmc3i6rCAvbI2oFx+3IeM9txF2AzVwz7LZ6XpeUrdF9oDlS22z729AL5hFpRQ
	 Q4DUQiqI8TAlu9yWq7oFIf5eOZQPR4pY9IZwMNSXud2odG1Ex7LMJv03/eoIHj2giu8uZ
	 Do6vXGsvlxWpGtZ3cXDh7OmlSUMLNB/0dXO3d6OG9UqkDO26L2BEEKsVhQnrd7GT5P5fC
	 krXnRS4Ev9OceELm6TYvHuQopET3sFKl9Y/0G63vlYJNAAMJ2ArG3e/TYJL/lZ6BOxKXV
	 00Qphv8P8iWF8HCr+It8WeVV415gv9+e58xXtxLVwmDPWaYrrUEErXgDyTrFbY1ypJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607612;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vdmEB9hxIyAN0h7tY4BnByy/5E+TrrNwykX7GIFe6RY=;
	b=SJC1KAjw+lTFSQXpU4uR++EoSPTQsEVDiEdOIMX2rSxCnJ1SBllIUDdWPbOeEmvwjdMb
	 r4TleO0Regf4lRUJG4tY29WXxpIg1Jg3Ocjn5RZ6j1P3K80B0avqsDBssrLaacWi6w2YE
	 Wt4NJEZnvaHmOMIdtTTBDFsbMURgEnZKlGtZ8CcrLgpXaB1x5k2QtN/Cijv96VP6u/YQy
	 7W0yRXqcPzLIQdjOYm21U8eSJal9ONoJh50Qv6MKG+jqns+eS7w+JOsnjIlc8eIoTxMlc
	 WPZRVVhlQ3egY87bzpi2zDfbSFuhm0vLCi350Y6O02z+d7MgwsmyqwUQ0YaLx9nSUDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="yw0/XLxK";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E5606A327
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 22:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64E5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=yw0/XLxK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=vdmEB9hxIyAN0h7tY4BnByy/5E+TrrNwykX7GIFe6RY=; t=1794607611; x=1795817211; 
	b=yw0/XLxK6g0LIH0wQI0KRy9KaPxvsyrw3QXtKFeV0VqymRW/+21RGk7CLTykYzgNcZI5wosMLW6
	sndbZ0C54mDVeS1fokgfi2wUZ0H94GhN1LYeRrxsk0brmRY6MyH4rPkHtWwMcqp0i4+U4O4RHdpp4
	9OLhBsVxSE3S8WhJ/2P5Gt45anhS5y9Rxx8R60bLmqMkZArknkv9dki5djYlE2kNMKWLDhOSvbsVi
	G0A9QEbdpb5UiPnELTVTr1h9TXpNzpOYPp66xCDd3WedLD0/tlrwW00dK215aRe5CD/kFLQa43/9x
	TKMxyEb7ehDh0we9+C2/BgBQeyxO891zYnDQ==;
Date: Fri, 13 Nov 2026 23:06:44 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger
 Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: OMAP2+: pm34xx: add NEON wakeup dependency before
 clockdomain idle
Message-ID: <20261113230644.237c39ed@kemnade.info>
In-Reply-To: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
References: <20261113-wip-omap3-vfp-neon-mismatch-v1-1-3f6f67b25251@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 10:11:05 -0800
"Kevin Hilman (TI)" <khilman@baylibre.com> wrote:

> On OMAP3630 (BeagleBoard-xM), about one boot in three dies early when
> a context switch touches the VFP, which traps as undefined.
> 
> The VFP is unreachable because NEON is powered off while the MPU runs.
> omap3_pm_init() sets NEON's next state to OFF/RET and lets all
> clockdomains idle before it adds the NEON -> MPU wakeup dependency, so
> NEON can power down immediately and stay off until the MPU next idles.
> This was visible in pm_debug, which showed neon_pwrdm OFF:1 while
> mpu_pwrdm OFF:0.
> 
> Add the wakeup dependency before the clockdomains are allowed to idle.
> 
> Tested on omap3-beagle-xm: 6/17 boots crashed before, none of 25 after;
> also ran 50 suspend/resume cycles each on omap3-beagle and -xm.
> 
> Fixes: fa3c2a4fc99f ("OMAP3: PM: handle PER/NEON/CORE in idle")
> Reported-by: Andreas Kemnade <andreas@kemnade.info>
> Closes: https://lore.kernel.org/r/20261028212302.75ec622e@kemnade.info
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

survived a git bisect + several other boots on GTA04. (tested the identical
change in a comment before)

Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04
> ---
> This patch combined with an omap_device fix from Andreas makes OMAP3
> very stable on suspend/resume, including off-mode for OMAP3630.
> c.f. https://lore.kernel.org/r/20261110211531.679943-1-andreas@kemnade.info
> ---
>  arch/arm/mach-omap2/pm34xx.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9992549c7336..d11967c2f4bf 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -510,6 +510,20 @@ int __init omap3_pm_init(void)
>  		goto err3;
>  	}
>  
> +	neon_clkdm = clkdm_lookup("neon_clkdm");
> +	mpu_clkdm = clkdm_lookup("mpu_clkdm");
> +	per_clkdm = clkdm_lookup("per_clkdm");
> +	wkup_clkdm = clkdm_lookup("wkup_clkdm");
> +
> +	/*
> +	 * Add the NEON wakeup dependency on the MPU before the clockdomains
> +	 * are allowed to idle: once pwrdms_setup() has programmed NEON's next
> +	 * state to OFF/RET, an idle NEON clockdomain otherwise lets NEON power
> +	 * down while the MPU keeps running, and VFP instructions then trap as
> +	 * undefined until NEON is woken.
> +	 */
> +	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
> +
>  	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
>  
>  	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
> @@ -523,11 +537,6 @@ int __init omap3_pm_init(void)
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
>  
> -	neon_clkdm = clkdm_lookup("neon_clkdm");
> -	mpu_clkdm = clkdm_lookup("mpu_clkdm");
> -	per_clkdm = clkdm_lookup("per_clkdm");
> -	wkup_clkdm = clkdm_lookup("wkup_clkdm");
> -
>  	omap_common_suspend_init(omap3_pm_suspend);
>  
>  	arm_pm_idle = omap3_pm_idle;
> @@ -562,7 +571,6 @@ int __init omap3_pm_init(void)
>  	if (IS_PM34XX_ERRATUM(PM_PER_MEMORIES_ERRATUM_i582))
>  		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
>  
> -	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>  		omap3_secure_ram_storage =
>  			kmalloc(OMAP3_SAVE_SECURE_RAM_SZ, GFP_KERNEL);
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261113-wip-omap3-vfp-neon-mismatch-ae585c1e8fe0
> 
> Best regards,
> --  
> Kevin Hilman (TI) <khilman@baylibre.com>
> 
> 

