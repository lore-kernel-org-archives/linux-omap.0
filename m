From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 07:41:08 +0200
Message-ID: <524125F4.4060608@collabora.co.uk>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk> <CACRpkdb35DouKsZ+9aWfQmER1vmAaK1dR7VXjoFHTLRR+hBezg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdb35DouKsZ+9aWfQmER1vmAaK1dR7VXjoFHTLRR+hBezg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 10:15 PM, Linus Walleij wrote:
> On Sun, Sep 22, 2013 at 4:40 PM, Javier Martinez Canillas
> <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> wrote:
> 
>> To use a GPIO pin as an interrupt line, two previous configurations
>> have to be made:
>>
>> a) Map the GPIO pin as an interrupt line into the Linux irq space
>> b) Enable the GPIO bank and configure the GPIO direction as input
>>
>> Most GPIO/IRQ chip drivers just create a mapping for every single
>> GPIO pin with irq_create_mapping() on .probe so users usually can
>> assume a) and only have to do b) by using the following sequence:
>>
>> gpio_request(gpio, "foo IRQ");
>> gpio_direction_input(gpio);
>>
>> and then request a IRQ with:
>>
>> irq = gpio_to_irq(gpio);
>> request_irq(irq, ...);
> 
> I guess I have to live with this approach, but I'd like to - if possible -
> address my pet issue.
> 
> - It is OK that the HW get set up as GPIO input by the IRQ
>   request function alone. (Through gpio_irq_type I guess).
> 

Yes, this is how is made on this patch indeed.

> - When a second caller calls omap_gpio_request() it should
>   be OK as well, but only if the flags corresponds to the
>   previously enabled input mode. Else it should be
>   disallowed.
> 
> - The same should happen for _set_gpio_direction() if a pin
>   previously set up for IRQ gets a request to be used as
>   output.
> 
> If this cannot be tracked in the driver, it is certainly a candidate
> for something that gpiolib should be doing. And then I'm open to
> solutions to how we can do that.
> 

Ok, this can be tracked in the driver, will add it when posting v2 soon.

> If this needs to be applied pronto to fix the regression I'm
> happy with that too, if we add a big boilerplate stating the above
> problem and that it needs to be *fixed* at some point.
> 
> But in either case I want this to be tested on OMAP1 before
> I apply it, as in a Tested-by tag.
>

Agreed. Even though this is a fix for a long standing issue I prefer it to be
tested extensively than applying the patch in a rush just to learn that causes
regressions and have to be reverted as it happens last time.

So as you said let's wait until we have a few Tested-by tags by people using
different OMAP platforms specially OMAP1.

> Yours,
> Linus Walleij
> 

Thanks a lot and best regards,
Javier

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
