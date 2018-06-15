From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] regulator: core: Enable voltage balancing
Date: Fri, 15 Jun 2018 04:29:16 -0700
Message-ID: <20180615112916.GK112168@atomide.com>
References: <20180605044554.GC5738@atomide.com>
 <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
 <1528886026-9457-1-git-send-email-m.purski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528886026-9457-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Maciej Purski <m.purski@samsung.com> [180613 10:39]:
> Call regulator_balance_voltage() instead of set_voltage_rdev()
> in set_voltage_unlocked() and in enabling and disabling functions,
> but only if the regulator is coupled.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> 
> ---
> Changes in v2:
> - fix compile errors
> - make debug messages more informative

Thanks for updating it. This series still hangs after loading
modules on beagleboard-x15:

[   26.679749] smps12: regulator_set_voltage: 3381
[   26.684529] smps12: regulator_set_voltage_unlocked:  3045
[   26.695616] smps12: _regulator_do_set_voltage: 2912
[   26.701275] smps12: regulator_set_voltage: 3381
[   26.706002] smps12: regulator_set_voltage_unlocked:  3045
[   26.712349] smps12: _regulator_do_set_voltage: 2912
[   26.719329] abb_mpu: regulator_set_voltage: 3381
[   26.724105] abb_mpu: regulator_set_voltage_unlocked:  3045

So it seems to be the abb_mpu where it hangs?

Regards,

Tony
