From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: Issues with GPIO and wake from sleep
Date: Fri, 17 Jan 2014 12:24:50 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout11.bt.lon5.cpcloud.co.uk ([65.20.0.131]:17054 "EHLO
	smtpout11.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276AbaAQM37 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 07:29:59 -0500
Received: from MARCM-SBS2011.marcmltd.local (87.112.217.12) by smtpout11.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as marcmltd@btinternet.com)
        id 52B4985601651D67 for linux-omap@vger.kernel.org; Fri, 17 Jan 2014 12:24:55 +0000
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have resisted contacting the list with regards to an issue I am havin=
g trying to get what should be a simple part of my system working but I=
 cannot find any documentation or other posts to help.
=20
I am using 3.6 kernel but have tried 3.12 to see if the issue has been =
addressed in that but its exactly the same.
=20
I am attempting to get a GPIO to wake my AM3517 system up from a suspen=
d to memory.  I have tried with a few different options for GPIO=92s
I have available GPIO-10, GPIO-28 and GPIO-30.
=20
I started by using GPIO-28 and that would configure nicely and I set up=
 the interrupt handler and could see my debug when triggering the input=
 (brilliant) but for some reason I cannot use it  to wake the system as=
 it is not in the correct group for wakeup.  There is a note in the Tec=
h Ref Man -

Only gpio_1, gpio_9, gpio_10, gpio_11, gpio_30, and gpio_31 can be used=
 to generate a direct wake-up event.

So have to use a different one. GPIO-30 cannot be used as that holds th=
e system in reset, so all that is left is GPIO-10.
All seems to be good for initialisation;
=20
In the omap_board_mux I define
=20
    OMAP3_MUX(SYS_CLKOUT1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
              OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
              OMAP_PIN_OFF_WAKEUPENABLE),
=20
Then the init function and interrupt handler;
=20
/**********************************************************************=
******
*
* Board wakeup interrupt
*
***********************************************************************=
*****/
#define IGNITION_GPIO 10
=20
static irqreturn_t detect_irq(int irq, void *_data)
{
    printk("%s: irq\n", __func__);
=20
    return IRQ_HANDLED;
}
=20
static void enable_board_wakeup_source(void)
{
    int irq;
    int ret;
    /* GPIO_10 interrupt line */
=20
    gpio_request(IGNITION_GPIO, "gpio_10");
    gpio_direction_input(IGNITION_GPIO);
    omap_mux_init_gpio(IGNITION_GPIO, OMAP_PIN_INPUT_PULLUP |
                       OMAP_PIN_OFF_WAKEUPENABLE);
=20
       irq =3D gpio_to_irq(IGNITION_GPIO);
    if (request_irq(irq, detect_irq, IRQF_TRIGGER_RISING, "ignition",
                    NULL)) {
            pr_err("********* %s: request_irq() failed\n", __func__);
            return;
    }
=20
    if (enable_irq_wake(irq)) {
            pr_err("********* %s: irq_set_irq_wake() failed\n", __func_=
_);
            return;
    }
=20
    pr_err("************** %s: set irq %u\n", __func__, irq);
}
=20
But when I try and trigger the input there is no IRQ handled and I also=
 cannot export the gpio in sys/class/
=20
If I have a look at the mux it seems to be OK
# cd /debug/omap_mux/
# cat sys_clkout1
name: sys_clkout1.gpio_10 (0x48002a1a/0x9ea =3D 0x411c), b ag25, t NA
mode: OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE=
4
signals: sys_clkout1 | NA | NA | NA | gpio_10 | NA | NA | safe_mode
=20
There is definitely a problem as when I look at the state it says its h=
igh, when the input is definitely 0V
# cat /debug/gpio
GPIOs 0-31, gpio:
gpio-0   (mpu6050-irq         ) in  lo
gpio-10  (gpio_10             ) in  hi
gpio-25  (USB1 PHY reset      ) out hi
=20
I think there is something else taking over the pin, maybe the clock se=
tup for sys_clkout1.
=20
Is there any way to make it just work for my config or make GPIO-28 wor=
k to wake the system ?
=20
Hope you have seen this before.
=20
Kind Regards
Marc--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
