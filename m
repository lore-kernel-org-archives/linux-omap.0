Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219255;
	b=JGLMpaFupSingS4NQMlrHZFdPG3P5oeKMXNXDcRj6VYxR//v5UIzyh9J7t3ZRSggRQlw
	 UTvvIhTza+pGdYx+qpcxYZE+R8UmkYIe33makn/XvHAiAJ3I4CqMuANQ2f6fujbOwB+Ts
	 kUu2OnolED+S0lNO66+Wh66YyTmHc6HdSbJGkwU2S4QPfcR1u/dL/sWDg5rk80R0BCL6n
	 ilo/mckd+pkp/UZll6QjlT6dxeBsKyK5hV/y0WvZKv/PN9L+RpL4M8xOQ9hLuwxfuOj5Y
	 2lFt8VCy+V+02DwuSIQYn8OSnCRt0SH6lt9vj92qJ/Td2zGWm3x+ru/rRpyYzIuq4+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219255;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8cMCw3CAhEINOW92Wo9264P7jdinCb60stuyaNoH9a0=;
	b=ptna49Df7zsKzMtneK85iBCFPn43CQZ87oKI4Wv9OuSFyxp9BBXyArkTYxaVdfnipG/C
	 N0mf79rCDWNZvdEHctt8JJqQsfhBuCawSSQ6xL3rvbam+jLLJy2xBdVmPgzNDyux1KGQS
	 IlCLdrPrhDMN9m1ePGPsOE8NullRJIxvmxX1wmFYGoGONLxnbB2U0//sXUZqxGaKaNOuE
	 JwwBX5E55YdzY35N/1HtykaiKiDoJ+mUyei8/3hagdl0fC+Q3Xb5ctTafB0TqP5geJUVA
	 z2OcVrDv0MjEYWFg8aaTsnp+54Qxlabj+GEXOLotKrSqlHUMkMjsY3/RJcuVx+ag/WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=iXcf3gdN;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E532606A31D;
	Wed, 28 Oct 2026 20:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E532606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=iXcf3gdN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=8cMCw3CAhEINOW92Wo9264P7jdinCb60stuyaNoH9a0=; t=1793219254; x=1794428854; 
	b=iXcf3gdNCyEKy1QKShdkFG4Bqxxg6nD0yp99TLYl+lsyEX7zDqn85GnpdQjhzVbj1tZ3s69tprg
	eNpIAN1pTFXbCfybjq02krlXhHrlNj3ownIBEfUrFXbgKA84sNYeBQyN7QJy+DF5ViOdVeBSwAYdw
	+XLh0mnxCWHtMQMgfgqKDW39T8biqsKavdBGkK5UPOTTGtETNtcj77lKU+3Rknt1ERQq0F6FDXdRZ
	VQmJmkyrIjBILuHJ+XB+WzB/VolYa5/FxgIRbgVYdiRfzGOFu+9TKmpQSN2Rrgbob8dlZ8kg5xREN
	lZZxq/yXa1IRRwKOGdcwlLu7tye58ZpuVCSQ==;
Date: Wed, 28 Oct 2026 21:27:18 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, absicsz@gmail.com
Subject: Re: [PATCH 1/2] ARM: omap: cpuidle34xx: balance cpu_pm_enter/exit()
Message-ID: <20261028212302.75ec622e@kemnade.info>
In-Reply-To: <20261028-susp2-v1-1-174b52857d89@kemnade.info>
References: <20261028-susp2-v1-0-174b52857d89@kemnade.info>
	<20261028-susp2-v1-1-174b52857d89@kemnade.info>
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

On Wed, 28 Oct 2026 20:15:11 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> These calls are usually done in a balanced way, so allow notifiers to
> assume that these calls are balanced under all circumstances.
> Seen some spurios vfp issues probably connected to this.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Looked again at some discussions with Sicelo testing such things:
He had observed a NEON off count 1 but MPU 0 in /sys/kernel/debug/pm_debug/count.
Probably more involved, but lets not freak out things here.
So that is definitively a real problem fixed by this. vfp_pm_resume()
would not be called to restore the state without a patch like this.

So this is

Fixes: 1cd96478cf150 ("ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()")

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 2ab5dcbfb7f6..e42dcf8c03a3 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -139,8 +139,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  	 * Call idle CPU PM enter notifier chain to restore
>  	 * VFP context.
>  	 */
> -	if (cx->mpu_state == PWRDM_POWER_OFF &&
> -	    pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
> +	if (cx->mpu_state == PWRDM_POWER_OFF)
>  		cpu_pm_exit();
>  
>  out_clkdm_set:
> 

