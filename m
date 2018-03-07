From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: tps65218: Reorder tps65218_regulator_id enum
Date: Wed, 7 Mar 2018 13:00:17 +0000
Message-ID: <20180307130017.m6swph3mlupu6g76@dell>
References: <20180216041705.6340-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216041705.6340-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 15 Feb 2018, Dave Gerlach wrote:

> Commit 2dc4940360d4 ("regulator: tps65218: Remove all the compatibles")
> changes the probe function of drivers/regulator/tps65218-regulator.c so
> that it iterates through all available regulators and assumes that the
> regulator IDs are sequential and match the order present in the enum
> tps65218_regulator_id. However, for some reason the much older commit
> c0ea88b890d6 ("regulator: tps65218: add support for LS3 current
> regulator") updated all arrays with LS3 at the end but added it second
> to last for the enum.
> 
> Because of this long standing mismatch in order between the
> tps65218_regulator_id enum and the regulator_desc array in the tps65218
> regulator driver, the new probe function causes the strobe values to be
> associated with the wrong regulator ID. This causes LDO1 to fail to
> suspend in tps65218_pmic_set_suspend_disable due to not having anything
> probes for its strobe value. Fix the order in the enum so the probe
> function works as the update intended.

This sounds super fragile.

I'm willing to accept this patch if it 'makes stuff work', but we
should look into why a dynamically assigned enum is sensitive to
ordering.  At the very least you should consider providing a comment
with working to that effect.

> Fixes: 2dc4940360d4 ("regulator: tps65218: Remove all the compatibles")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  include/linux/mfd/tps65218.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
