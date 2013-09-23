From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Mon, 23 Sep 2013 10:14:12 -0600
Message-ID: <524068D4.5040909@wwwdotorg.org>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379860848-29020-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jon Hunter <jgchunter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/22/2013 08:40 AM, Javier Martinez Canillas wrote:
> To use a GPIO pin as an interrupt line, two previous configurations
> have to be made:
> 
> a) Map the GPIO pin as an interrupt line into the Linux irq space
> b) Enable the GPIO bank and configure the GPIO direction as input
> 
> Most GPIO/IRQ chip drivers just create a mapping for every single
> GPIO pin with irq_create_mapping() on .probe so users usually can
> assume a) and only have to do b) by using the following sequence:
> 
> gpio_request(gpio, "foo IRQ");
> gpio_direction_input(gpio);
> 
> and then request a IRQ with:
> 
> irq = gpio_to_irq(gpio);
> request_irq(irq, ...);
> 
> Some drivers know that their IRQ line is being driven by a GPIO
> and use a similar sequence as the described above but others are
> not aware or don't care wether their IRQ is a real line from an
> interrupt controller or a GPIO pin acting as an IRQ.
> ...

I think that explanation is a bit like retro-actively implying that
drivers /should/ be aware of whether their IRQ is a GPIO or not, and
should be acting differently. However, they should not.

I would much rather see a simpler patch description along the lines of:

The OMAP GPIO controller HW requires that a pin be configured in GPIO
mode in order to operate as an interrupt input. Since drivers should not
be aware of whether an interrupt pin is also a GPIO or not, the HW
should be fully configured/enabled as an IRQ if a driver solely uses IRQ
APIs such as request_irq, and never calls any GPIO-related APIs. As
such, add the missing HW setup to the OMAP GPIO controller's irq_chip
driver.

The code change looks like it does what I would expect though.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
