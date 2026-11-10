Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342206;
	b=o/Ll2GPe/TsAzRwaiJ/dyARiiSCcVFP+BDzmYJ2Vc6vVuUzQGb9qKSWUZovxs4vTLIs1
	 00wzkdsHjCkWAon0+VHdVj8cYxCwT3P45UNCHfpUBNY/fd5OZxHYT3G3ENZ5QQKxjopxV
	 8GaYS/7tWKVGt4gD30A56J3dx3XQXcu626lVD+PDDYWSk3lIoll8vM6BBIg9uPNh6i9mK
	 YIePAvy/lFXZ6QW9DZy7HdooDrShI/W9UhS7FkeeLbFPXzAP3FJHu6Y0eRV/ZHpBKdNTD
	 Ns1EyO19Yox+QqsMGWUNMSqw17temdUlJ/DOlleBP51UVP0jx+zizpCAdMiAPXVb/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342206;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c7+UI0GUfDbfLEtSpboSlipdO1srQg2d508IiAHDWDw=;
	b=ftQ1Xbo/l37ubuFs3V+b1JyPumMMX7Epd66IB3bpmA7slR8G1sjt6lFz0QGzbVbCoWqH
	 KflPH3FjHKq9Q3/hVmpELASyx0zmYwwhrYVu9U25mlsynqy0nOquQ1SwcA99+W1FO7esj
	 lSXxvatOzxgzAlJcVp4SSsvbsPy103piisuKLFKo1nDeCmYIP14bu6HkiiSfnqox4Zw/e
	 assBY+JWrP9PPZn3gYJ1fCs2SthqQ72q6UFBOfxAqFLPfNWNoHi7+4bFmnxJffgRgngvF
	 Avp1Io8GnV6MzZqV3IgLHtIwooVFaAcQ2brUm7XDKw6v3j9m2qIVgOVw6wqEWuZBIKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=m5n63kw2;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8C606A8B8;
	Tue, 10 Nov 2026 20:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F8C606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=m5n63kw2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=c7+UI0GUfDbfLEtSpboSlipdO1srQg2d508IiAHDWDw=; t=1794342205; x=1795551805; 
	b=m5n63kw2aKhqfKiUlCrrWCgthNDX/7nDoantdmNh8aWF5ModxkcHhbsyLqbhWdYcC8LozKYfI2K
	4zMmU5hkc06IBHPPOlvK111SYkPZD+c4I0dC27xnInMIv3I9foHAS/XBg7G9FwMlaEHlFRxJrKkBV
	gd2jzy5y5toZcgf7X6Xo2mJ4woXtMVZdha5+zPoiXURiPu0qvtewaGvaAXf0SOsZvnYglc+Q7UibB
	bm6hR/RjTtA51Y08khVathBhjKqyKT8dsWkjrEOfeVmsx2F2IT68k4ULTv4w5eZJMQCA4yxsfciw0
	QIHbpSyRIf62vEIXegvY5wrPZFbR8uI7ue+g==;
Date: Tue, 10 Nov 2026 21:23:06 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, absicsz@gmail.com
Subject: Re: [PATCH 1/2] ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
Message-ID: <20261110212306.39327765@kemnade.info>
In-Reply-To: <7ha4ngv55s.fsf@baylibre.com>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
	<20261028-susp2-v1-1-174b52857d89@kemnade.info>
	<20261028212302.75ec622e@kemnade.info>
	<7ha4ngv55s.fsf@baylibre.com>
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

On Tue, 10 Nov 2026 11:48:47 -0800
Kevin Hilman <khilman@baylibre.com> wrote:

> Andreas Kemnade <andreas@kemnade.info> writes:
> 
> > On Wed, 28 Oct 2026 20:15:11 +0100
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >  
> >> These calls are usually done in a balanced way, so allow notifiers to
> >> assume that these calls are balanced under all circumstances.
> >> Seen some spurios vfp issues probably connected to this.
> >> 
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> >
> > Looked again at some discussions with Sicelo testing such things:
> > He had observed a NEON off count 1 but MPU 0 in /sys/kernel/debug/pm_debug/count.
> > Probably more involved, but lets not freak out things here.
> > So that is definitively a real problem fixed by this. vfp_pm_resume()
> > would not be called to restore the state without a patch like this.
> >
> > So this is
> >
> > Fixes: 1cd96478cf150 ("ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()")  
> 
> Even with this fix, I found on OMAP3 (beagle and beagle-xm) that there
> are still intermittent failures, and the NEON vs. MPU count mismatch was
> a good indicator to dig a little deeper.
> 
There seem to be different problems, cases where MPU sticks to INA
but does not go OFF (reported on N900), and that spurios vfp crash
I have seen on the GTA04.

> I think the fix here is to add the neon_clkdm -> mpu_clkdm wakeup
> dependency before the clockdomains are allowed to idle.  Otherwise NEON
> could idle immediately.
> 
sound same. I also looked at the wakeup dep, but only in the running system.

> With the patch below, I don't see any intermittent VFP crashes anymore
> with early testing.
> 
Thanks for that patch.

Then this ordeal comes to an end, I first thought that these are hw
issues. But then maybe it is time to reinit my automatic testing stuff.

> I'm still doing a few more tests, but will sent a proper patch with
> changelog after some more testing.
>
I will do that too. And then time to do some bisect to catch some omapdrm
bug. 8250_DMA also smells.

Regards,
Andreas
 
> Kevin
> 
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
> 
> 
> 

