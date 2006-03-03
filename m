From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMC: Move set_power to platform data
Date: Fri, 3 Mar 2006 12:47:57 -0800
Message-ID: <20060303204757.GN4398@atomide.com>
References: <20060303132421.46104.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060303132421.46104.qmail@web32909.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060303 05:25]:
> Tony,
> 
> Attached patch moves the set_power function to specific board-*.c
> files. For OMAP24xx-H4 I have to used __raw_* functions instead of
> OMAP_MMC_WRITE, as it is in local omap.h inside drivers/mmc directory.
> 
> Tested on H4, it is able to detect the MMC atleast :) and builds for
> innovator_1510, h2 and h3. 24xx custom boards needs to be updated if
> they are not using powerpin gpio. 
> 
> I am not able to find defconfig for apollon board, so if Kyungmin Park
> confirms the changes then I can add h4 like setpower function to
> board-apollon.c in the next patch. Thanx.

Yeah, let's do some testing before we apply this. One comment below:
 
>  /*
>   * Turn the socket power on/off. Innovator uses FPGA, most boards
>   * probably use GPIO.
>   */
>  static void mmc_omap_power(struct mmc_omap_host *host, int on)
>  {
> -	if (on) {
> -		if (machine_is_omap_innovator())
> -			innovator_fpga_socket_power(1);
> -		else if (machine_is_omap_h2())
> -			tps65010_set_gpio_out_value(GPIO3, HIGH);
> -		else if (machine_is_omap_h3())
> -			/* GPIO 4 of TPS65010 sends SD_EN signal */
> -			tps65010_set_gpio_out_value(GPIO4, HIGH);
> -		else if (cpu_is_omap24xx()) {
> -			u16 reg = OMAP_MMC_READ(host->base, CON);
> -			OMAP_MMC_WRITE(host->base, CON, reg | (1 << 11));
> -		} else
> -			if (host->power_pin >= 0)
> -				omap_set_gpio_dataout(host->power_pin, 1);
> -	} else {
> -		if (machine_is_omap_innovator())
> -			innovator_fpga_socket_power(0);
> -		else if (machine_is_omap_h2())
> -			tps65010_set_gpio_out_value(GPIO3, LOW);
> -		else if (machine_is_omap_h3())
> -			tps65010_set_gpio_out_value(GPIO4, LOW);
> -		else if (cpu_is_omap24xx()) {
> -			u16 reg = OMAP_MMC_READ(host->base, CON);
> -			OMAP_MMC_WRITE(host->base, CON, reg & ~(1 << 11));
> -		} else
> -			if (host->power_pin >= 0)
> -				omap_set_gpio_dataout(host->power_pin, 0);
> -	}
> +	if (host->set_power)
> +		host->set_power(host->base, on);
> +	else if (host->power_pin >= 0)
> +		omap_set_gpio_dataout(host->power_pin, on);
>  }

AFAIK nn 24xx the power function is same for all boards as it uses MMC
registers. It should be kept in mmc_omap_power().

Tony
