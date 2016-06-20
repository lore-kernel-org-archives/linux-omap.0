From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 2/5] power_supply: tps65217-charger: Fix NULL deref
 during property export
Date: Mon, 20 Jun 2016 15:23:14 +0200
Message-ID: <CAJKOXPd87nM=7nPsact67TNHVhr45MJxP9=LKvv-esTQsg2A-A@mail.gmail.com>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com> <20160620105056.25843-3-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160620105056.25843-3-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2016 at 12:50 PM, Marcin Niestroj
<m.niestroj@grinn-global.com> wrote:
> This bug leads to:
>
> [    1.906411] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> [    1.914878] pgd = c0004000
> [    1.917786] [0000000c] *pgd=00000000
> [    1.921536] Internal error: Oops: 5 [#1] SMP ARM
> [    1.926357] Modules linked in:
> [    1.929556] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.4.5 #18
> [    1.936006] Hardware name: Generic AM33XX (Flattened Device Tree)
> [    1.942383] Workqueue: events power_supply_changed_work
> [    1.947842] task: de2c41c0 ti: de2c8000 task.ti: de2c8000
> [    1.953483] PC is at tps65217_ac_get_property+0x14/0x28
> [    1.958937] LR is at tps65217_ac_get_property+0x10/0x28
>
> Driver was trying to use drv_data in property get handler. However drv_data
> was not set, so it caused NULL pointer dereference. This patch properly
> sets drv_data during probe by power_supply_config parameter, so the
> property get handler works as desired.
>
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Changes v1 -> v4: none

This should crash on first try (get_property() is called just after
power supply register)... I wonder how was it working before...
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Fixes: 3636859b280c ("power_supply: Add support for tps65217-charger.")
Cc: <stable@vger.kernel.org>

Best regards,
Krzysztof
