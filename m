From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Tue, 5 Jun 2012 08:19:02 -0500
Message-ID: <4FCE0746.2090505@ti.com>
References: <4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com> <20120531012923.GB8506@mudshark.cambridge.arm.com> <4FC7B465.60703@ti.com> <87r4u0ytd9.fsf@ti.com> <4FC7E161.1080400@ti.com> <87d35kyo3v.fsf@ti.com> <4FC7F87C.9080709@ti.com> <87obp3vptz.fsf@ti.com> <4FC8D4F0.6040806@ti.com> <20120602164228.GA14903@mudshark.cambridge.arm.com> <4FCD2C30.8000106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760726Ab2FENTI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 09:19:08 -0400
In-Reply-To: <4FCD2C30.8000106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Will,

On 06/04/2012 04:44 PM, Jon Hunter wrote:

[...]

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> index 2334bf8..8ffbb09 100644
> --- a/arch/arm/kernel/pmu.c
> +++ b/arch/arm/kernel/pmu.c
> @@ -13,6 +13,8 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/pmu.h>
>  
> @@ -22,15 +24,17 @@
>  static unsigned long pmu_lock[BITS_TO_LONGS(ARM_NUM_PMU_DEVICES)];
>  
>  int
> -reserve_pmu(enum arm_pmu_type type)
> +reserve_pmu(struct arm_pmu *armpmu)
>  {
> -	return test_and_set_bit_lock(type, pmu_lock) ? -EBUSY : 0;
> +	pm_runtime_get_sync(&armpmu->plat_device->dev);
> +	return test_and_set_bit_lock(armpmu->type, pmu_lock) ? -EBUSY : 0;
>  }
>  EXPORT_SYMBOL_GPL(reserve_pmu);
>  
>  void
> -release_pmu(enum arm_pmu_type type)
> +release_pmu(struct arm_pmu *armpmu)
>  {
> -	clear_bit_unlock(type, pmu_lock);
> +	clear_bit_unlock(armpmu->type, pmu_lock);
> +	pm_runtime_put_sync(&armpmu->plat_device->dev);
>  }
>  EXPORT_SYMBOL_GPL(release_pmu);

I have realised that there is a slight bug in the above
pm_runtime_get/put. The calls to pm_runtime_get/put need to be
symmetrical otherwise the if we call _get more than _put the pmu will
stay on. So in the reserve_pmu, I should only call pm_runtime_get if we
acquire the lock.

Anyway, let me know what you think of this approach. An alternative is
to put the calls pm_runtime_get/put outside of the reserve/release_pmu,
which would be a simpler change, but I was thinking that the above maybe
more aligned with your thinking.

Cheers
Jon
