From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: gpio Interrupt handling for omap5912
Date: Sun, 13 Aug 2006 16:15:23 +0200
Message-ID: <44DF33FB.3050003@gmail.com>
References: <20060804024947.80936.qmail@web55802.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060804024947.80936.qmail@web55802.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

to avoid that things like HowTo below are lost, what do you 
think is the best place to store them?

I can imagine

- Documentation/arm/OMAP/GPIO
- http://tree.celinuxforum.org/CelfPubWiki/OSK
- ?

Cheers

Dirk

Arnold wrote:
> Here's the a little of what I know on howto for gpio.
> There may be an error, so feel free to edit/modify.
> 
> GPIO API's How To.
> 
> INCLUDE
> #include <asm/arch/gpio.h>
> 
> I. GPIO Modules/Banks
>         A.) GPIO MODULE/BANK 0 - PIN  0-15
>         B.) GPIO MODULE/BANK 1 - PIN 16-31
>         C.) GPIO MODULE/BANK 2 - PIN 32-47
>         D.) GPIO MODULE/BANK 3 - PIN 48-63
> 
> II. GPIO API's
> A.) omap_request_gpio(int gpio)
>      Description:
>      Parameter:
>      > int gpio - GPIO PIN (Pin 0-63)
>      Note:
>      >Using this function, you dont have to worry
> about
>        banks/modules where the gpio pin is.
> B.) omap_set_gpio_direction(int gpio, int is_input)
>     Description:
>      > This function is responsible for setting the
>        gpio pin direction(input or output).
>     Parameter:
>      > int gpio - GPIO PIN (Pin 0-63)
>      > int is_input - pin direction (0=output,
> 1=input)
> 
> C.) omap_set_gpio_dataout(int gpio, int enable)
>     Description:
>      > This function is responsible for writing to a  
>                  pin.
>     Parameter:
>      > int gpio - GPIO PIN (Pin 0-63)
>      > int enable - pin value (0 or 1)
> D.) omap_get_gpio_datain(int gpio)
>     Description:
>     > This function is responsible for reading pin
> values.
>     Parameter:
>     > int gpio - GPIO PIN (Pin 0-63)
> E.) omap_free_gpio(int gpio)
>     Description:
>     > This function is responsible for freeing the pin
> used.
>     Parameter:
>     > int gpio - GPIO PIN (Pin 0-63)
> F.) OMAP_GPIO_IRQ(int gpio)
>     Description:
>     > Returns the Interrupt number for the specified
> gpio pin.
>     Parameter:
>     > int gpio - GPIO PIN (Pin 0-63)
> G.) set_irq_type(unsigned int irq, unsigned int type)
>     Description:
>     > This function is responsible for setting the
> type of interrupt(RISING or FALLING).
>     Parameter:
>     > unsigned int irq - The interrupt number for the
> gpio pin.
>     > unsigned int type - (IRQT_RISING = rising,
> IRQT_FALLING= falling)
> 
> 
> Example:
> 1.) Writing to gpio pin#3 a value 1. and reading the
> value of gpio pin#3.
>         Request for gpio pin
>                 omap_request_gpio(3);
>         Writing a 1 to gpio pin # 3:
>                 omap_set_gpio_direction(3,0);
>                 omap_set_set_dataout(3,1);
>         Reading the value of pin # 3;
>                 ret = omap_get_datain(3);
>                 printk("value of pin # 3 = %d\n",ret);
>         Freeing gpio pin # 3;
>                 omap_free_gpio(3);
> 
> 2.) Interrupt
>         Request for gpio pin
>                 omap_request_gpio(3);
>         Setting up pin for interrupt
>          omap_set_gpio_direction(3,0);
>          set_irq_type(OMAP_GPIO_IRQ(3),IRQT_RISING);  
>     
>          request_irq(OMAP_GPIO_IRQ(3),(void
> *)&my_int_handler,SA_SHIRQ,....);
>         Freeing interrupt and gpio pin
>                 free_irq(OMAP_GPIO_IRQ(3),&id);
>                 omap_free_gpio(3);
> 
> 
> I dont know if this will help. Thanks for all the
> help.
