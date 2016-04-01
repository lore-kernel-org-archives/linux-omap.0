From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH V2] extcon: palmas: Drop stray IRQF_EARLY_RESUME flag
Date: Fri, 1 Apr 2016 17:45:17 +0300
Message-ID: <56FE897D.3040107@ti.com>
References: <1459518767-20382-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459518767-20382-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 01/04/16 16:52, Nishanth Menon wrote:
> Palmas extcon IRQs are nested threaded and wired to the Palmas
> interrupt controller. So, this flag is not required for nested
> IRQs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
> nested_thread irqs over system suspend") was merged. However, the
> fix in commit ae64e42cc2b3 ("extcon: palmas: Drop IRQF_EARLY_RESUME
> flag") missed a stray flag causing the following crash on resume on
> BeagleBoard-X15 platform:
> 
> [   53.670141] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> [..]
> [   53.670141] [<c04ae734>] (omap_set_gpio_triggering) from [<c04aeb94>] (omap_gpio_unmask_irq+0xc0/0xc4)
> [   53.670141] [<c04aeb94>] (omap_gpio_unmask_irq) from [<c01a0b88>] (irq_enable+0x30/0x44)
> [   53.670141] [<c01a0b88>] (irq_enable) from [<c019ebd8>] (__enable_irq+0x54/0x78)
> [   53.670141] [<c019ebd8>] (__enable_irq) from [<c01a4e60>] (resume_irqs+0xe8/0x100)
> [   53.670141] [<c01a4e60>] (resume_irqs) from [<c0514840>] (syscore_resume+0x94/0x298)
> [   53.670141] [<c0514840>] (syscore_resume) from [<c01981cc>] (suspend_devices_and_enter+0x790/0x9e4)
> [   53.670141] [<c01981cc>] (suspend_devices_and_enter) from [<c0198a60>] (pm_suspend+0x640/0x75c)
> [   53.670141] [<c0198a60>] (pm_suspend) from [<c0196bec>] (state_store+0x64/0xb8)
> [   53.670141] [<c0196bec>] (state_store) from [<c0307944>] (kernfs_fop_write+0xc0/0x1bc)
> [   53.670141] [<c0307944>] (kernfs_fop_write) from [<c028acb0>] (__vfs_write+0x1c/0xd8)
> [   53.670141] [<c028acb0>] (__vfs_write) from [<c028bba0>] (vfs_write+0x90/0x16c)
> [   53.670141] [<c028bba0>] (vfs_write) from [<c028c8c0>] (SyS_write+0x44/0x9c)
> [   53.670141] [<c028c8c0>] (SyS_write) from [<c0107840>] (ret_fast_syscall+0x0/0x1c)
> [..]
> 
> Fixes: ae64e42cc2b3 ("extcon: palmas: Drop IRQF_EARLY_RESUME flag")
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
> based on v4.6-rc1
> Changes in V2:
> 	- commit message updates for:
> 		- Trimming the crash log down to base stack trace
> 		- Fix up a few typos
> 		- Update commit log to indicate that this is a completion of
> 		  previously attempted fix .
> 
> V1: https://patchwork.kernel.org/patch/8718431/
> 
>  drivers/extcon/extcon-palmas.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
> index 841a4b586395..8b3226dca1d9 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -348,8 +348,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
>  						palmas_vbus_irq_handler,
>  						IRQF_TRIGGER_FALLING |
>  						IRQF_TRIGGER_RISING |
> -						IRQF_ONESHOT |
> -						IRQF_EARLY_RESUME,
> +						IRQF_ONESHOT,
>  						"palmas_usb_vbus",
>  						palmas_usb);
>  		if (status < 0) {
> 
