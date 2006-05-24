From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP5912 OSK & GPIO
Date: Wed, 24 May 2006 18:09:29 +0200
Message-ID: <44748539.4030200@gmail.com>
References: <009d01c67f49$47f84170$642aa8c0@Buffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <009d01c67f49$47f84170$642aa8c0@Buffy>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard Copeman wrote:
> Hi,
> 
> Does anybody have any examples for configuring and using the GPIO pins?
> I'm trying to toggle GPIO7. I set the data direction bit to output and set
> the output pin register bit to high. I have not changed the default pin
> muxing, so I assume I should be getting a signal on pin L15, which according
> to my schematics is pin 25 on connector P12. I put a scope on there and
> don't see anything ;-(

Try to use GPIO framework. See for example

/arch/arm/mach-omap1/leds.c
/arch/arm/mach-omap1/leds-osk.c

#include <asm/arch/gpio.h>
#include <asm/arch/mux.h>

omap_cfg_reg(P18_1610_GPIO3);  // request pin from pinmux, 
depends on chip
if (omap_request_gpio(3) == 0)      // request GPIO
    omap_set_gpio_direction(3, 0);   // set it to output
omap_set_gpio_dataout(3, 1);        // set it

Regards

Dirk
