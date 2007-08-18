From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [05/17 PATCH] MMC: OMAP: Modifications at power functions to
	MMC multislot support.
Date: Sat, 18 Aug 2007 14:33:39 +0530
Message-ID: <5d5443650708180203t86888d7s3d27fc5f1f64f825@mail.gmail.com>
References: <46C5F09D.1020105@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46C5F09D.1020105@indt.org.br>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Carlos,

On 8/18/07, Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
> From: Juha Yrjola <juha.yrjola@solidboot.com>
>
> Modifications at power functions to MMC multislot support.
>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>
> Modifications at power functions to MMC multislot support.
>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>
> Index: linux-omap/drivers/mmc/host/omap.c
> ===================================================================
> --- linux-omap.orig/drivers/mmc/host/omap.c     2007-08-16 12:33:05.000000000 -0400
> +++ linux-omap/drivers/mmc/host/omap.c  2007-08-16 16:02:47.000000000 -0400
> @@ -997,54 +997,25 @@ static void mmc_omap_request(struct mmc_
>         mmc_omap_start_request(host, req);
>  }
>
> -static void innovator_fpga_socket_power(int on)
> +static void mmc_omap_set_power(struct mmc_omap_slot *slot, int power_on, int vdd)
>  {
> -#if defined(CONFIG_MACH_OMAP_INNOVATOR) && defined(CONFIG_ARCH_OMAP15XX)
> -       if (on) {
> -               fpga_write(fpga_read(OMAP1510_FPGA_POWER) | (1 << 3),
> -                    OMAP1510_FPGA_POWER);
> -       } else {
> -               fpga_write(fpga_read(OMAP1510_FPGA_POWER) & ~(1 << 3),
> -                    OMAP1510_FPGA_POWER);
> -       }
> -#endif
> -}
> +       struct mmc_omap_host *host;
> +
> +       host = slot->host;
>
> -/*
> - * Turn the socket power on/off. Innovator uses FPGA, most boards
> - * probably use GPIO.
> - */
> -static void mmc_omap_power(struct mmc_omap_host *host, int on)
> -{
> -       if (machine_is_sx1())
> -               sx1_setmmcpower(on);
> -       else if (on) {
> -               if (machine_is_omap_innovator())
> -                       innovator_fpga_socket_power(1);
> -               else if (machine_is_omap_h2())
> -                       tps65010_set_gpio_out_value(GPIO3, HIGH);
> -               else if (machine_is_omap_h3())
> -                       /* GPIO 4 of TPS65010 sends SD_EN signal */
> -                       tps65010_set_gpio_out_value(GPIO4, HIGH);
> -               else if (cpu_is_omap24xx()) {
> -                       u16 reg = OMAP_MMC_READ(host, CON);
> -                       OMAP_MMC_WRITE(host, CON, reg | (1 << 11));
> -               } else
> -                       if (host->power_pin >= 0)
> -                               omap_set_gpio_dataout(host->power_pin, 1);
> -       } else {
> -               if (machine_is_omap_innovator())
> -                       innovator_fpga_socket_power(0);
> -               else if (machine_is_omap_h2())
> -                       tps65010_set_gpio_out_value(GPIO3, LOW);
> -               else if (machine_is_omap_h3())
> -                       tps65010_set_gpio_out_value(GPIO4, LOW);
> -               else if (cpu_is_omap24xx()) {
> -                       u16 reg = OMAP_MMC_READ(host, CON);
> -                       OMAP_MMC_WRITE(host, CON, reg & ~(1 << 11));
> -               } else
> -                       if (host->power_pin >= 0)
> -                               omap_set_gpio_dataout(host->power_pin, 0);
> +       if (slot->pdata->set_power != NULL)
> +               slot->pdata->set_power(mmc_dev(slot->mmc), slot->id, power_on, vdd);
> +
> +       if (cpu_is_omap24xx()) {
> +               u16 w;
> +
> +               if (power_on) {
> +                       w = OMAP_MMC_READ(host, CON);
> +                       OMAP_MMC_WRITE(host, CON, w | (1 << 11));
> +               } else {
> +                       w = OMAP_MMC_READ(host, CON);
> +                       OMAP_MMC_WRITE(host, CON, w & ~(1 << 11));
> +               }
>         }
>  }

I am little bit surprised by above patch, as the similar patch was
rejected by Juha in March'06 [1]. Only downside for that patch was it
was modifying the board.h structure as some proprietary  bootloaders
(means Nolo?) doesn't support passing those pointers at that time and
suggested to implement voltage framework (which Amit Kucheria
submitted to linux-arm-kernel sometime back...but not yet accepted
upstream) so that we can use ref. voltage by name instead of function.

>
> @@ -1078,28 +1049,33 @@ static int mmc_omap_calc_divisor(struct
>
>  static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
> -       struct mmc_omap_host *host = mmc_priv(mmc);
> -       int dsor;
> -       int i;
> +       struct mmc_omap_slot *slot = mmc_priv(mmc);
> +       struct mmc_omap_host *host = slot->host;
> +       int i, dsor;
>
>         dsor = mmc_omap_calc_divisor(mmc, ios);
> -       host->bus_mode = ios->bus_mode;
> -       host->hw_bus_mode = host->bus_mode;
> +
> +       mmc_omap_select_slot(slot, 0);
> +
> +       if (ios->vdd != slot->vdd)
> +               slot->vdd = ios->vdd;
>
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
> -               mmc_omap_power(host, 0);
> +               mmc_omap_set_power(slot, 0, ios->vdd);
>                 break;
>         case MMC_POWER_UP:
> -               /* Cannot touch dsor yet, just power up MMC */
> -               mmc_omap_power(host, 1);
> -               return;
>         case MMC_POWER_ON:
> +               mmc_omap_set_power(slot, 1, ios->vdd);
>                 dsor |= 1 << 11;
>                 break;
>         }
>
> -       clk_enable(host->fclk);
> +       if (slot->bus_mode != ios->bus_mode) {
> +               if (slot->pdata->set_bus_mode != NULL)
> +                       slot->pdata->set_bus_mode(mmc_dev(mmc), slot->id, ios->bus_mode);
> +               slot->bus_mode = ios->bus_mode;
> +       }
>
>         /* On insanely high arm_per frequencies something sometimes
>          * goes somehow out of sync, and the POW bit is not being set,
> @@ -1107,6 +1083,7 @@ static void mmc_omap_set_ios(struct mmc_
>          * Writing to the CON register twice seems to do the trick. */
>         for (i = 0; i < 2; i++)
>                 OMAP_MMC_WRITE(host, CON, dsor);
> +       slot->saved_con = dsor;
>         if (ios->power_mode == MMC_POWER_ON) {
>                 /* Send clock cycles, poll completion */
>                 OMAP_MMC_WRITE(host, IE, 0);
> @@ -1115,7 +1092,7 @@ static void mmc_omap_set_ios(struct mmc_
>                 while ((OMAP_MMC_READ(host, STAT) & 1) == 0);
>                 OMAP_MMC_WRITE(host, STAT, 1);
>         }
> -       clk_disable(host->fclk);
> +       mmc_omap_release_slot(slot);
>  }
>
>  static int mmc_omap_get_ro(struct mmc_host *mmc)
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>

-- 
--Trilok Soni

[1]
http://linux.omap.com/pipermail/linux-omap-open-source/2006-March/006559.html
