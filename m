From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH 1/3] serial: mctrl_gpio: restrict MCTRL initialization
Date: Fri, 28 Jul 2017 10:42:22 +0200
Message-ID: <CAGm1_ktkN6_7jD_mdcC=No=pNTW_aGrKE7D+U8av5b2R7BFqSA@mail.gmail.com>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
 <1501161456-13367-2-git-send-email-yegorslists@googlemail.com> <1501164092.29303.270.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501164092.29303.270.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 27, 2017 at 4:01 PM, Andy Shevchenko
<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Thu, 2017-07-27 at 15:17 +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
>> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> GPIOs specified for serial port can be used either as GPIO driven
>> MCTRL
>> or as a wakeup-source. Use the latter property to abort the MCTRL
>> initialization.
>
> Please, elaborate on a choice of error code for this (-ENOSYS).

Something like this:

Return -ENOSYS as this would just skip mctrl initialization in the
case of wakeup source usage and not disable the port completely due to
failed serial8250_register_8250_port().

Yegor

>>
>> Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> Suggested-by: I suppose.
>
> I dunno about documentation part for this property, I leave it for DT
> people to decide. Below part looks good to me.
>
>> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> ---
>>  drivers/tty/serial/serial_mctrl_gpio.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c
>> b/drivers/tty/serial/serial_mctrl_gpio.c
>> index d2da6aa..dce661c 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/termios.h>
>> +#include <linux/property.h>
>>  #include <linux/serial_core.h>
>>  #include <linux/module.h>
>>
>> @@ -118,6 +119,9 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct
>> device *dev, unsigned int idx)
>>       struct mctrl_gpios *gpios;
>>       enum mctrl_gpio_idx i;
>>
>> +     if (device_property_present(dev, "wakeup-source"))
>> +             return ERR_PTR(-ENOSYS);
>> +
>>       gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
>>       if (!gpios)
>>               return ERR_PTR(-ENOMEM);
>
> --
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
