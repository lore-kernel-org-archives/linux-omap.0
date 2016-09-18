From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Sun, 18 Sep 2016 15:14:02 +0300
Message-ID: <14745757.ahNt4Zeunj@avalon>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160912153947.k4gnggur6usyujii-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 12 Sep 2016 08:39:49 Tony Lindgren wrote:
> Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> for 2430 glue layer") moved PHY enable/disable calls to happen from
> omap2430_musb_enable/disable(). That broke enumeration for several
> devices as PM runtime in the PHY will never enable it.
> 
> The root cause of the problem is unpaired calls from musb_core.c to
> musb_platform_enable/disable in musb_core.c as reported by
> Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>.
> 
> As musb_platform_enable/disable are being called from various functions,
> let's not attempt to make them paiered immediately. This would require
> fixing all the callers like musb_remove.
> 
> Instead, let's first fix the regression in a minimal way by removing
> the initial call to musb_platform_disable.
> 
> AFAIK the initial musb_platform_disable call has always been just an
> attempted workaround for the 2430 glue layer announcing itself too
> early before the gadgets are configured. And that issue finally
> got fixed with commit a118df07f5b1 ("usb: musb: Don't set d+ high
> before enable for 2430 glue layer").
> 
> We now also need to fix the twl4030-phy accordingly making it's
> PM runtime call only needed in twl4030_phy_power_on and have it
> autosuspend. The cable state will keep the phy active when connected.
> 
> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> for 2430 glue layer")
> Reported-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> Acked-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

FYI, while this patch allows me to boot my Panda board with NFS over usbnet, 
it only works with cold boots. A warm reboot results in the following warning, 
and no ethernet traffic going through. The USB device is detected by the host 
though.

I'm not sure whether this is a regression introduced by commit a83e17d0f73b 
("usb: musb: Improve PM runtime and phy handling for 2430 glue layer") or an 
entirely different issue;

[    5.509918] ------------[ cut here ]------------
[    5.509918] WARNING: CPU: 0 PID: 1 at 
/home/laurent/src/kernel/omap4/linux-2.6/drivers/bus/omap_l3_noc.c:147 
l3_interrupt_handler+0x220/0x348
[    5.528137] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read): 
Data Access in User mode during Functional access
[    5.539825] Modules linked in:
[    5.539825] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc2-00806-
g37c4efacd6b9 #4
[    5.539825] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    5.551361] [<c01101b0>] (unwind_backtrace) from [<c010c10c>] 
(show_stack+0x10/0x14)
[    5.565826] [<c010c10c>] (show_stack) from [<c048ca40>] 
(dump_stack+0xa8/0xe0)
[    5.565826] [<c048ca40>] (dump_stack) from [<c0137910>] (__warn+0xd8/0x104)
[    5.565826] [<c0137910>] (__warn) from [<c01379e4>] 
(warn_slowpath_fmt+0x38/0x48)
[    5.588623] [<c01379e4>] (warn_slowpath_fmt) from [<c04befd0>] 
(l3_interrupt_handler+0x220/0x348)
[    5.588623] [<c04befd0>] (l3_interrupt_handler) from [<c019ec7c>] 
(__handle_irq_event_percpu+0x98/0x3ec)
[    5.588623] [<c019ec7c>] (__handle_irq_event_percpu) from [<c019efec>] 
(handle_irq_event_percpu+0x1c/0x58)
[    5.588623] [<c019efec>] (handle_irq_event_percpu) from [<c019f060>] 
(handle_irq_event+0x38/0x5c)
[    5.627380] [<c019f060>] (handle_irq_event) from [<c01a24e0>] 
(handle_fasteoi_irq+0xcc/0x1a4)
[    5.627380] [<c01a24e0>] (handle_fasteoi_irq) from [<c019e490>] 
(generic_handle_irq+0x18/0x28)
[    5.636352] [<c019e490>] (generic_handle_irq) from [<c019e5a4>] 
(__handle_domain_irq+0x64/0xdc)
[    5.654541] [<c019e5a4>] (__handle_domain_irq) from [<c010152c>] 
(gic_handle_irq+0x48/0x9c)
[    5.654541] [<c010152c>] (gic_handle_irq) from [<c0872af0>] 
(__irq_svc+0x70/0x98)
[    5.654541] Exception stack(0xee8b7d18 to 0xee8b7d60)
[    5.676483] 7d00:                                                       
00000001 ee8b5328
[    5.676483] 7d20: 00000000 ee8b4d80 60000153 eee28010 eee28010 60000153 
00000002 c1603ae4
[    5.693664] 7d40: c0d029cc 0000016b c0f19314 ee8b7d68 c019268c c0872788 
20000153 ffffffff
[    5.693664] [<c0872af0>] (__irq_svc) from [<c0872788>] 
(_raw_spin_unlock_irqrestore+0x34/0x44)
[    5.711303] [<c0872788>] (_raw_spin_unlock_irqrestore) from [<c069b260>] 
(musb_gadget_queue+0x128/0x4ac)
[    5.711303] [<c069b260>] (musb_gadget_queue) from [<c06a9ae4>] 
(usb_ep_queue+0x38/0x1d4)
[    5.729766] [<c06a9ae4>] (usb_ep_queue) from [<c06aba40>] 
(rx_submit+0xc8/0x19c)
[    5.737548] [<c06aba40>] (rx_submit) from [<c06abb90>] (rx_fill+0x7c/0xa0)
[    5.737548] [<c06abb90>] (rx_fill) from [<c06abbdc>] (eth_start+0x28/0x48)
[    5.751983] [<c06abbdc>] (eth_start) from [<c06abe7c>] (eth_open+0x6c/0x7c)
[    5.751983] [<c06abe7c>] (eth_open) from [<c0778c2c>] 
(__dev_open+0x9c/0x104)
[    5.766815] [<c0778c2c>] (__dev_open) from [<c0778ea0>] 
(__dev_change_flags+0x88/0x150)
[    5.775238] [<c0778ea0>] (__dev_change_flags) from [<c0778f88>] 
(dev_change_flags+0x18/0x48)
[    5.775238] [<c0778f88>] (dev_change_flags) from [<c0c515d4>] 
(ip_auto_config+0x194/0x1148)
[    5.792907] [<c0c515d4>] (ip_auto_config) from [<c0101870>] 
(do_one_initcall+0x3c/0x174)
[    5.792907] [<c0101870>] (do_one_initcall) from [<c0c00eb0>] 
(kernel_init_freeable+0x204/0x2e0)
[    5.792907] [<c0c00eb0>] (kernel_init_freeable) from [<c086b8e4>] 
(kernel_init+0x8/0x118)
[    5.810577] [<c086b8e4>] (kernel_init) from [<c0108430>] 
(ret_from_fork+0x14/0x24)
[    5.819183] ---[ end trace e721ca4e3e3c1d62 ]---

> ---
> 
> Changes since v1: Updated description
> 
> This is needed as a regression fix for the v4.8-rc cycle please.
> 
> ---
>  drivers/phy/phy-twl4030-usb.c | 4 ++--
>  drivers/usb/musb/musb_core.c  | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -447,8 +447,6 @@ static int twl4030_phy_power_off(struct phy *phy)
>  	struct twl4030_usb *twl = phy_get_drvdata(phy);
> 
>  	dev_dbg(twl->dev, "%s\n", __func__);
> -	pm_runtime_mark_last_busy(twl->dev);
> -	pm_runtime_put_autosuspend(twl->dev);
> 
>  	return 0;
>  }
> @@ -465,6 +463,8 @@ static int twl4030_phy_power_on(struct phy *phy)
>  		twl4030_i2c_access(twl, 0);
>  	twl->linkstat = MUSB_UNKNOWN;
>  	schedule_delayed_work(&twl->id_workaround_work, HZ);
> +	pm_runtime_mark_last_busy(twl->dev);
> +	pm_runtime_put_autosuspend(twl->dev);
> 
>  	return 0;
>  }
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2142,7 +2142,6 @@ musb_init_controller(struct device *dev, int nIrq,
> void __iomem *ctrl) }
> 
>  	/* be sure interrupts are disabled before connecting ISR */
> -	musb_platform_disable(musb);
>  	musb_generic_disable(musb);
> 
>  	/* Init IRQ workqueue before request_irq */

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
