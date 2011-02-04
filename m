From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/20] mach-omap2: pm: world-writable debugfs timer files
Date: Fri, 04 Feb 2011 14:53:48 -0800
Message-ID: <874o8jl8cj.fsf@ti.com>
References: <cover.1296818921.git.segoon@openwall.com>
	<aabede4db6c913bc7ab7c289d09eb272594e2290.1296818921.git.segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aabede4db6c913bc7ab7c289d09eb272594e2290.1296818921.git.segoon@openwall.com>
	(Vasiliy Kulikov's message of "Fri, 4 Feb 2011 15:23:16 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, security@kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vasiliy Kulikov <segoon@openwall.com> writes:

> Don't allow all users to change timer settings.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile the driver, so it is not tested at all.

Acked-by: Kevin Hilman <khilman@ti.com>


>  arch/arm/mach-omap2/pm-debug.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 125f565..a5a83b3 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -637,14 +637,14 @@ static int __init pm_dbg_init(void)
>  
>  		}
>  
> -	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
> +	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
>  				   &enable_off_mode, &pm_dbg_option_fops);
> -	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
> +	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUSR, d,
>  				   &sleep_while_idle, &pm_dbg_option_fops);
> -	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
> +	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
>  				   &wakeup_timer_seconds, &pm_dbg_option_fops);
>  	(void) debugfs_create_file("wakeup_timer_milliseconds",
> -			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
> +			S_IRUGO | S_IWUSR, d, &wakeup_timer_milliseconds,
>  			&pm_dbg_option_fops);
>  	pm_dbg_init_done = 1;
