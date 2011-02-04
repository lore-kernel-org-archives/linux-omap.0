From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/20] mach-omap2: smartreflex: world-writable debugfs voltage files
Date: Fri, 04 Feb 2011 14:54:14 -0800
Message-ID: <87zkqbjtrd.fsf@ti.com>
References: <cover.1296818921.git.segoon@openwall.com>
	<96a2b24548af3a68fde712c68b49e856e53ea1fc.1296818921.git.segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96a2b24548af3a68fde712c68b49e856e53ea1fc.1296818921.git.segoon@openwall.com>
	(Vasiliy Kulikov's message of "Fri, 4 Feb 2011 15:23:20 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, security@kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vasiliy Kulikov <segoon@openwall.com> writes:

> Don't allow everybody to change voltage settings.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile the driver, so it is not tested at all.

Acked-by: Kevin Hilman <khilman@ti.com>


>  arch/arm/mach-omap2/smartreflex.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index c37e823..95ac336 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -900,7 +900,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		return PTR_ERR(dbg_dir);
>  	}
>  
> -	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
> +	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, dbg_dir,
>  				(void *)sr_info, &pm_sr_fops);
>  	(void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
>  			&sr_info->err_weight);
> @@ -939,7 +939,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		strcpy(name, "volt_");
>  		sprintf(volt_name, "%d", volt_data[i].volt_nominal);
>  		strcat(name, volt_name);
> -		(void) debugfs_create_x32(name, S_IRUGO | S_IWUGO, nvalue_dir,
> +		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
>  				&(sr_info->nvalue_table[i].nvalue));
>  	}
