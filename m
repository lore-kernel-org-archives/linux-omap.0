From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/4] ARM: dts: am437x boards: Correct tps65218 irq type
Date: Mon, 23 Apr 2018 16:01:02 +0530
Message-ID: <5423d98d-6c32-56f4-d228-bd1d33d9dff1@ti.com>
References: <20180420113822.17577-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420113822.17577-1-peter.ujfalusi@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, tony@atomide.com
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Friday 20 April 2018 05:08 PM, Peter Ujfalusi wrote:
> Hi,
> 
> In linux-next I started to see: https://pastebin.com/wrDdptzh
> [    2.813985] ------------[ cut here ]------------
> [    2.818746] WARNING: CPU: 0 PID: 19 at /home/ujfalusi/work/kernel/github.omap-audio.linux-audio/drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0xd4/0xec
> [    2.833311] Modules linked in:
> [    2.836417] CPU: 0 PID: 19 Comm: kworker/0:2 Not tainted 4.17.0-rc1-next-20180420-00057-gffd03ee19b9b #182
> [    2.846113] Hardware name: Generic AM43 (Flattened Device Tree)
> [    2.852073] Workqueue: events deferred_probe_work_func
> ...
> 
> Becasue most of the am437x boards had IRQ_TYPE_NONE for tps65218.
> 
> According to the datasheet [1] the interrult line is low active, so fix up the board
> DTS files.
> 
> Interestingly the am437x-sk-evm had IRQ_TYPE_LEVEL_HIGH, which is not matching
> with the datasheet.
> 
> [1] http://www.ti.com/lit/ds/symlink/tps65218.pdf, page 8.

For the series:

Reviewed-by: Keerthy <j-keerthy@ti.com>

Also Boot tested on AM437X-GP-EVM with the patch 1 of the series and i
do not see the error above.

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (4):
>   ARM: dts: am437x-gp-evm: Correct tps65218 irq type
>   ARM: dts: am437x-cm-t43: Correct tps65218 irq type
>   ARM: dts: am437x-epos-evm: Correct tps65218 irq type
>   ARM: dts: am437x-sk-evm: Correct tps65218 irq type
> 
>  arch/arm/boot/dts/am437x-cm-t43.dts  | 2 +-
>  arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
>  arch/arm/boot/dts/am437x-sk-evm.dts  | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
