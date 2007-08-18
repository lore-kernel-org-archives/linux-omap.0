From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [10/17 PATCH] MMC: OMAP: Modifications at N800 MMC board
	specific file to works MMC multislot support.
Date: Sat, 18 Aug 2007 14:39:26 +0530
Message-ID: <5d5443650708180209g49ef571eib03e202deecba52e@mail.gmail.com>
References: <46C5F0B1.7090000@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46C5F0B1.7090000@indt.org.br>
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
> From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
>
> Modifications at board-n800-mmc.c file to works with MMC multislot support.
>
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>
> Modifications at board-n800-mmc.c file to works with MMC multislot support.
>
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
>
> Index: linux-omap/arch/arm/mach-omap2/board-n800-mmc.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/board-n800-mmc.c        2007-08-13 13:19:59.000000000 -0400
> +++ linux-omap/arch/arm/mach-omap2/board-n800-mmc.c     2007-08-13 13:25:47.000000000 -0400
> @@ -13,13 +13,14 @@
>  #include <asm/arch/menelaus.h>
>  #include <asm/arch/gpio.h>
>
> +#include <asm/mach-types.h>
> +#include <linux/delay.h>
> +
>  #ifdef CONFIG_MMC_OMAP
>
>  static const int slot_switch_gpio = 96;
> -static const int slot1_wp_gpio = 23;
> -static const int slot2_wp_gpio = 8;
> -static int slot1_cover_closed;
> -static int slot2_cover_closed;
> +static int slot1_cover_open;
> +static int slot2_cover_open;
>  static struct device *mmc_device;
>
>  /*
> @@ -158,18 +159,31 @@ static int n800_mmc_get_cover_state(stru
>         slot++;
>         BUG_ON(slot != 1 && slot != 2);
>         if (slot == 1)
> -               return slot1_cover_closed;
> +               return slot1_cover_open;
>         else
> -               return slot2_cover_closed;
> +               return slot2_cover_open;
>  }
>
>  static void n800_mmc_callback(void *data, u8 card_mask)
>  {
> -       if (card_mask & (1 << 1))
> -               slot2_cover_closed = 0;
> +       int bit, *openp, index;
> +
> +       if (machine_is_nokia_n800()) {
> +               bit = 1 << 1;
> +               openp = &slot2_cover_open;
> +               index = 1;
> +       } else {
> +               bit = 1;
> +               openp = &slot1_cover_open;
> +               index = 0;
> +       }

What is the use of "else" above. You are executing on n800 machine
specific code only when above callback gets built, or am I smelling
something :)

> +
> +       if (card_mask & bit)
> +               *openp = 1;
>         else
> -               slot2_cover_closed = 1;
> -        omap_mmc_notify_cover_event(mmc_device, 1, slot2_cover_closed);
> +               *openp = 0;
> +
> +        omap_mmc_notify_cover_event(mmc_device, index, *openp);
>  }
>
>  void n800_mmc_slot1_cover_handler(void *arg, int state)
> @@ -177,13 +191,13 @@ void n800_mmc_slot1_cover_handler(void *
>         if (mmc_device == NULL)
>                 return;
>
> -       slot1_cover_closed = state;
> +       slot1_cover_open = !state;
>         omap_mmc_notify_cover_event(mmc_device, 0, state);
>  }
>
>  static int n800_mmc_late_init(struct device *dev)
>  {
> -       int r;
> +       int r, bit, *openp;
>
>         mmc_device = dev;
>
> @@ -202,10 +216,23 @@ static int n800_mmc_late_init(struct dev
>         if (r < 0)
>                 return r;
>
> -       if (r & (1 << 1))
> -               slot2_cover_closed = 1;
> +       if (machine_is_nokia_n800()) {
> +               bit = 1 << 1;
> +               openp = &slot2_cover_open;
> +       } else {
> +               bit = 1;
> +               openp = &slot1_cover_open;
> +               slot2_cover_open = 0;
> +       }
> +
> +       /* All slot pin bits seem to be inversed until first swith change */
> +       if (r == 0xf || r == (0xf & ~bit))
> +               r = ~r;
> +
> +       if (r & bit)
> +               *openp = 1;
>         else
> -               slot2_cover_closed = 0;
> +               *openp = 0;
>
>         r = menelaus_register_mmc_callback(n800_mmc_callback, NULL);
>
> @@ -253,12 +280,6 @@ void __init n800_mmc_init(void)
>                 BUG();
>         omap_set_gpio_dataout(slot_switch_gpio, 0);
>         omap_set_gpio_direction(slot_switch_gpio, 0);
> -       if (omap_request_gpio(slot1_wp_gpio) < 0)
> -               BUG();
> -       if (omap_request_gpio(slot2_wp_gpio) < 0)
> -               BUG();
> -       omap_set_gpio_direction(slot1_wp_gpio, 1);
> -       omap_set_gpio_direction(slot2_wp_gpio, 1);
>  }
>
>  #else
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>


-- 
--Trilok Soni
