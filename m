From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] input: misc: Add generic input driver to read
 encoded GPIO lines
Date: Fri, 12 Aug 2016 13:59:47 -0500
Message-ID: <20160812185947.GA14685@rob-hp-laptop>
References: <20160812045229.29241-1-vigneshr@ti.com>
 <20160812045229.29241-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160812045229.29241-2-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2016 at 10:22:28AM +0530, Vignesh R wrote:
> Add a driver to read group of GPIO lines and provide its status as a
> numerical value as input event to the system. This will help in
> intefacing devices, that can be connected over GPIOs, that provide input
> to the system by driving GPIO lines connected to them like a rotary dial
> or a switch.
> 
> For example, a rotary switch can be connected to four GPIO lines. The
> status of the GPIO lines reflect the actual position of the rotary
> switch dial. For example, if dial points to 9, then the four GPIO lines
> connected to the switch will read HLLH(0b'1001 = 9). This value
> can be reported as an ABS_* event to the input subsystem.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
>  drivers/input/misc/Kconfig                         |  12 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/gpio_decoder.c                  | 128 +++++++++++++++++++++
>  4 files changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
>  create mode 100644 drivers/input/misc/gpio_decoder.c
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-decoder.txt b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> new file mode 100644
> index 000000000000..efd947f52cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> @@ -0,0 +1,23 @@
> +* GPIO Decoder DT bindings
> +
> +Required Properties:
> +- compatible: should be "gpio-decoder"
> +- gpios: a spec of gpios (atleast two) to be decoded to a number with
> +  first entry representing the MSB.
> +
> +Optional Properties:
> +- gpio-decoder,max-value: Maximum possible value that can be reported by

Just "decoder-max-value".

With that, the binding looks fine to me:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
