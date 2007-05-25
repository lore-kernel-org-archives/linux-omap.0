From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP: Kill compile warnings
Date: Fri, 25 May 2007 16:12:16 -0700
Message-ID: <20070525231215.GL21314@atomide.com>
References: <782515bb0705251604l20d57f49h45584f2ab7f28f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <782515bb0705251604l20d57f49h45584f2ab7f28f36@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* nishanth menon <menon.nishanth@gmail.com> [070525 16:05]:
> Got the subject wrong last time.. Sorry..
> kill warning1: remove link to .init.text
> omap_timer refers to __init omap2_gp_timer_init function causing a warning
> while the linking is done
>
> Signed-off-by: Nishanth Menon <menon.nishanth@gmail.com>
> ---
> arch/arm/mach-omap2/timer-gp.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c 
> b/arch/arm/mach-omap2/timer-gp.c
> index 8f380a1..f4cf6fe 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -175,6 +175,6 @@ static void __init omap2_gp_timer_init(void)
> 	omap2_gp_clocksource_init();
> }
>
> -struct sys_timer omap_timer = {
> -	.init	= omap2_gp_timer_init,
> +struct sys_timer omap_timer __initdata = {
> +	.init	 = omap2_gp_timer_init,
> };
> -- 

This warning is wrong, and we cannot mark sys_timer as initdata. See
other mails related to this on this list. I'd assume this will get fixed
once sys_timer is added to the list of things to ignore.

Tony
