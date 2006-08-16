From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: Interrupts on Omap5912
Date: Tue, 15 Aug 2006 23:13:59 -0700 (PDT)
Message-ID: <20060816061400.91213.qmail@web55815.mail.re3.yahoo.com>
References: <20060816031218.23244.qmail@web50504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060816031218.23244.qmail@web50504.mail.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OJ Ravadilla <ojravadilla@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi OJ,

> Is there anyone who knows about interrupts on OMAP?
> How are interrupts implemented in omap5912?

I have made an example on howto request interrupt
using a gpio. (take note that this example is for
gpio)

Interrupt input by gpio pin#3
#include <asm/arch/gpio.h>

omap_request_gpio(3);    /* Request for gpio pin */
omap_set_gpio_direction(3,0);

*Setting up pin for interrupt */
set_irq_type(OMAP_GPIO_IRQ(3),IRQT_RISING); 

request_irq(OMAP_GPIO_IRQ(3), (void *)&my_int_handler,
SA_SHIRQ,....);

* Do stuff, handle interrupts in 
my_int_handler */
                
free_irq(OMAP_GPIO_IRQ(3),&id); /*  Freeing interrupt
and gpio pin */
omap_free_gpio(3); 

> Do you have to check the status register 

Dirk Behme answered me this before:
There are level and edge triggered GPIO interrupts,
depends 
on your HW configuration. If you have edge, you
normally 
don't need to acknowledge anything. If you have level,
you 
have to check if you have to acknowledge the interrupt
in 
the external unit issuing the irq on GPIO pin to make
the 
level go away before exiting the ISR.

But this is with regards to gpio. You can see
Documentation/arm/interrupts for more info. Just need
some readings.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
