From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH] arm: omap2: board-generic: use omap4_local_timer_init for
 AM437x
Date: Fri, 6 Nov 2015 13:35:16 +0530
Message-ID: <563C5F3C.5090900@ti.com>
References: <1445375159-22234-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445375159-22234-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 21 October 2015 02:35 AM, Felipe Balbi wrote:
> AM437x-based boards, can use omap4_local_timer_init()
> just fine. Let's use that instead.

This is breaking AM43x-epos board.
Today's Linux next: http://pastebin.ubuntu.com/13122620/
Reverting this patch: http://pastebin.ubuntu.com/13122621/

Thanks and regards,
Lokesh

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index fc107bdeb8ca..04a56cc04dfa 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -276,7 +276,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
>  	.init_late	= am43xx_init_late,
>  	.init_irq	= omap_gic_of_init,
>  	.init_machine	= omap_generic_init,
> -	.init_time	= omap3_gptimer_timer_init,
> +	.init_time	= omap4_local_timer_init,
>  	.dt_compat	= am43_boards_compat,
>  	.restart	= omap44xx_restart,
>  MACHINE_END
> 
