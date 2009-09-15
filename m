From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Tue, 15 Sep 2009 09:23:51 -0700
Message-ID: <87y6ogp46g.fsf@deeprootsystems.com>
References: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com>
	<1251444297-13577-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:49021 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbZIOQXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 12:23:50 -0400
Received: by pxi27 with SMTP id 27so3248890pxi.15
        for <linux-omap@vger.kernel.org>; Tue, 15 Sep 2009 09:23:54 -0700 (PDT)
In-Reply-To: <1251444297-13577-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 28 Aug 2009 12\:54\:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> MPU power domain bank 0 bits are displayed in position of bank 1
> in PWRSTS and PREPWRSTS registers. So read them from correct
> position
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
> Patch refresh issue.
>
>  arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 2594cbf..6c5fee9 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  		return -EEXIST;
>  
>  	/*
> +	 * In 3430, for MPU domain bank 0 status bits
> +	 * are displayed in the position of bank1 status bits
> +	 * in PWST  . So the hack. Think of a cleaner
> +	 * way of doing this
> +	 */
> +	if (cpu_is_omap34xx())
> +		if (!strcmp("mpu_pwrdm", pwrdm->name))

Rather than a string compare, you chould check

               if (pwrdm->prcm_offs == MPU_MOD)

                     
> +			bank = 1;
> +
> +	/*
>  	 * The register bit names below may not correspond to the
>  	 * actual names of the bits in each powerdomain's register,
>  	 * but the type of value returned is the same for each

This comment should also be changed because based on this patch, it
doesn't seem to be true.

Paul, are you OK with Thara's proposed change?

Otherwise, seems like the right fix is to have the shift value for
each bank encoded into the struct powerdomain.  Looks like the would
all be identical except MPU.

The patch below is a proposal/hack for how this could look, but it was
only done for the MPU powerdomain.  The others would need to be
completed.

Kevin


commit 7b4c705dc524b7c002284b2bf644ffc664d30b04
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Tue Sep 15 09:16:14 2009 -0700

    OMAP3: powerdomain: encode per-bank shift values for memory state
    
    The current and previous state of a powerdomains memory state are
    encoded in the PM_PWSTST and PM_PREPWSTST registers.  For most
    powerdomains, the shift values are the same for each bank, but for
    some they may be different.
    
    This patch adds the per-bank shift values for each powerdomain to the
    struct powerdomain so the code to read the values can be the same
    across all powerdomains.

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2594cbf..5181adc 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -970,29 +970,8 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK;
-		break;
-	case 1:
-		m = OMAP3430_L1FLATMEMSTATEST_MASK;
-		break;
-	case 2:
-		m = OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK;
-		break;
-	case 3:
-		m = OMAP3430_L2FLATMEMSTATEST_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
+	m = pwrdm->pwrsts_mem_shift[bank];
+	WARN_ON(!m);
 
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST, m);
 }
@@ -1017,29 +996,8 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
-	/*
-	 * The register bit names below may not correspond to the
-	 * actual names of the bits in each powerdomain's register,
-	 * but the type of value returned is the same for each
-	 * powerdomain.
-	 */
-	switch (bank) {
-	case 0:
-		m = OMAP3430_LASTMEM1STATEENTERED_MASK;
-		break;
-	case 1:
-		m = OMAP3430_LASTMEM2STATEENTERED_MASK;
-		break;
-	case 2:
-		m = OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
-		break;
-	case 3:
-		m = OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
-		break;
-	default:
-		WARN_ON(1); /* should never happen */
-		return -EEXIST;
-	}
+	m = pwrdm->pwrsts_mem_shift[bank];
+	WARN_ON(!m);
 
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP3430_PM_PREPWSTST, m);
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index aa557b2..960cc84 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -191,6 +191,9 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
+	.pwrsts_mem_shift = {
+		[0] = OMAP3430_L2CACHESTATEST_SHIFT,
+	},
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,
 	},
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 6271d85..8a0c41d 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -106,6 +106,9 @@ struct powerdomain {
 	/* Number of software-controllable memory banks in this powerdomain */
 	const u8 banks;
 
+	/* Memory state shift value for each bank */
+	const u8 pwrsts_mem_shift[PWRDM_MAX_MEM_BANKS];
+
 	/* Possible memory bank pwrstates when pwrdm in RETENTION */
 	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
 
