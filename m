From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/7] drivers/gpio: Add and export gpiod_lookup[_index]
Date: Thu, 26 Jan 2017 16:24:21 +0100
Message-ID: <CACRpkdadyUt+bJZ92dZZqFfVrnTgnstoZ7Bx7B7PhK3kL6kZRw@mail.gmail.com>
References: <20170125000641.25520-1-furquan@chromium.org> <20170125000641.25520-7-furquan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-7-furquan@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Furquan Shaikh <furquan@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 1:06 AM, Furquan Shaikh <furquan@chromium.org> wrote:

> Sometimes (as the case with fixed regulator) we only want to look up,
> but not necessarily reserve right away, GPIO. gpiod_lookup() and
> gpiod_lookup_by_index() allow us doing just that.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Furquan Shaikh <furquan@chromium.org>

Overall if this solves the GPIO regulator mess, I'd be happy
to apply it.

But overall it is a bit scary with looking up something struct gpiod *
that does not at all have the same semantics as a gpiod *
you get from gpiod_get().

We need to make sure that a gpiod looked up this way does not
work and tick and cannot perform operations as one obtained
with a proper gpiod_get().

>  /**
> + * gpiod_lookup - look up a GPIO for a given GPIO function
> + * @dev:       GPIO consumer, can be NULL for system-global GPIOs
> + * @con_id:    function within the GPIO consumer
> + *
> + * Return the GPIO descriptor corresponding to the function con_id of device
> + * dev, -ENOENT if no GPIO has been assigned to the requested function, or
> + * another IS_ERR() code.
> + */
> +struct gpio_desc *__must_check gpiod_lookup(struct device *dev,
> +                                           const char *con_id)
> +{
> +       return gpiod_lookup_index(dev, con_id, 0);
> +}
> +EXPORT_SYMBOL_GPL(gpiod_lookup);

Make this a static inline in the <linux/gpio/consumer.h> header instead.
Saves a lot of trouble.

>  /**
> - * gpiod_get_index - obtain a GPIO from a multi-index GPIO function
> + * gpiod_lookup_index - look up a GPIO from a multi-index GPIO function
>   * @dev:       GPIO consumer, can be NULL for system-global GPIOs
>   * @con_id:    function within the GPIO consumer
>   * @idx:       index of the GPIO to obtain in the consumer
> - * @flags:     optional GPIO initialization flags
> - *
> - * This variant of gpiod_get() allows to access GPIOs other than the first
> - * defined one for functions that define several GPIOs.
>   *
> - * Return a valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
> - * requested function and/or index, or another IS_ERR() code if an error
> - * occurred while trying to acquire the GPIO.
> + * Return a valid GPIO descriptor, or -ENOENT if no GPIO has been assigned to
> + * the requested function and/or index, or another IS_ERR() code.
>   */

What a mess in the patch. Not your fault but format-patch created this
mess.0

> -struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
> -                                              const char *con_id,
> -                                              unsigned int idx,
> -                                              enum gpiod_flags flags)
> +struct gpio_desc *__must_check gpiod_lookup_index(struct device *dev,
> +                                                 const char *con_id,
> +                                                 unsigned int idx)
>  {
>         struct gpio_desc *desc = NULL;
> -       int status;
>         enum gpio_lookup_flags lookupflags = 0;
>
>         dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
> @@ -3285,16 +3294,50 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>                 desc = gpiod_find(dev, con_id, idx, &lookupflags);
>         }
>
> -       if (IS_ERR(desc)) {
> +       if (IS_ERR(desc))
>                 dev_dbg(dev, "lookup for GPIO %s failed\n", con_id);
> +
> +       /*
> +        * Configure static flags based on lookup data (such as
> +        * "active low", "open drain", etc.)
> +        */
> +       gpiod_configure_flags(desc, con_id, lookupflags, 0);

So what about setting some special flag from
gpiolib.h like
set_bit(FLAG_ONLY_LOOKUP, &desc->flags);
here numbing all
operations on the returned gpiod, by a check in
VALIDATE_DESC() and VALIDATE_DESC_VOID()
so that no real operations fall through?

Then that flag will just be forcibly cleared by
gpiod_get[_index]() later.

Yours,
Linus Walleij
