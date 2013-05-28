From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: initialize before using oh_name
Date: Tue, 28 May 2013 22:20:44 +0100
Message-ID: <51A51FAC.5090606@gmail.com>
References: <1369722288-15592-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369722288-15592-1-git-send-email-afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org


On 28/05/13 07:24, Afzal Mohammed wrote:
> of_property_read_string_index(...,&oh_name) in omap_dm_timer_init_one
> does not alter the value of 'oh_name' even if the relevant function
> fails and as 'oh_name' in stack may have a non-zero value, it would
> be misunderstood by timer code that DT has specified "ti,hwmod"
> property for timer. 'oh_name' in this scenario would be a junk value,
> this would result in module not being enabled by hwmod API's for
> timer, and in turn crash.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index f8b23b8..8e0c390 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -220,7 +220,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  					 int posted)
>  {
>  	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
> -	const char *oh_name;
> +	const char *oh_name = NULL;
>  	struct device_node *np;
>  	struct omap_hwmod *oh;
>  	struct resource irq, mem;

Thanks!

Acked-by: Jon Hunter <jgchunter@gmail.com>

Cheers
Jon
