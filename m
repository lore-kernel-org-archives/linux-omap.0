From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 23/35] drivers/mfd: Convert remaining uses of pr_warning
 to pr_warn
Date: Thu, 23 Mar 2017 10:52:11 +0000
Message-ID: <20170323105211.kf7slyiv4rdqhqfw@dell>
References: <cover.1487314666.git.joe@perches.com>
 <a6c827c14d0b9f4be42e549ec4c629245516e979.1487314667.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a6c827c14d0b9f4be42e549ec4c629245516e979.1487314667.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for drivers/mfd
> 
> Prior to this patch, there were 4 uses of pr_warning and
> 9 uses of pr_warn in drivers/mfd
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mfd/db8500-prcmu.c  | 2 +-
>  drivers/mfd/sta2x11-mfd.c   | 4 ++--
>  drivers/mfd/twl4030-power.c | 7 ++-----
>  3 files changed, 5 insertions(+), 8 deletions(-)

Applied.

(... and I corrected the $SUBJECT line on your behalf)

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index ca38a6a14110..5c739ac752e8 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -2377,7 +2377,7 @@ static void ack_dbb_wakeup(void)
>  
>  static inline void print_unknown_header_warning(u8 n, u8 header)
>  {
> -	pr_warning("prcmu: Unknown message header (%d) in mailbox %d.\n",
> +	pr_warn("prcmu: Unknown message header (%d) in mailbox %d\n",
>  		header, n);
>  }
>  
> diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
> index 9292202039ee..3aeafa228baf 100644
> --- a/drivers/mfd/sta2x11-mfd.c
> +++ b/drivers/mfd/sta2x11-mfd.c
> @@ -60,8 +60,8 @@ static struct sta2x11_mfd *sta2x11_mfd_find(struct pci_dev *pdev)
>  	struct sta2x11_mfd *mfd;
>  
>  	if (!pdev && !list_empty(&sta2x11_mfd_list)) {
> -		pr_warning("%s: Unspecified device, "
> -			    "using first instance\n", __func__);
> +		pr_warn("%s: Unspecified device, using first instance\n",
> +			__func__);
>  		return list_entry(sta2x11_mfd_list.next,
>  				  struct sta2x11_mfd, list);
>  	}
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 1beb722f6080..8be023ba8e3e 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -502,9 +502,7 @@ static int load_twl4030_script(const struct twl4030_power_data *pdata,
>  	}
>  	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
>  		if (!order)
> -			pr_warning("TWL4030: Bad order of scripts (sleep "\
> -					"script before wakeup) Leads to boot"\
> -					"failure on some boards\n");
> +			pr_warn("TWL4030: Bad order of scripts (sleep script before wakeup) Leads to boot failure on some boards\n");
>  		err = twl4030_config_sleep_sequence(address);
>  	}
>  out:
> @@ -929,8 +927,7 @@ static int twl4030_power_probe(struct platform_device *pdev)
>  		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
>  				      TWL4030_PM_MASTER_CFG_P123_TRANSITION);
>  		if (err) {
> -			pr_warning("TWL4030 Unable to read registers\n");
> -
> +			pr_warn("TWL4030 Unable to read registers\n");
>  		} else if (!(val & SEQ_OFFSYNC)) {
>  			val |= SEQ_OFFSYNC;
>  			err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
