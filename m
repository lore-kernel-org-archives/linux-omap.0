From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] tty/serial/8250: add DT bindings description for
 mctrl_gpio helpers
Date: Thu, 3 Aug 2017 17:26:04 -0500
Message-ID: <20170803222604.ec5o756d5hjx2l22@rob-hp-laptop>
References: <1501161456-13367-1-git-send-email-yegorslists@googlemail.com>
 <1501161456-13367-4-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501161456-13367-4-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 27, 2017 at 03:17:36PM +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> Describe {rts,cts,dtr,dsr,rng,dcd}-gpios usage.
> 
> Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index 419ff6c..1c09db2 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -48,6 +48,16 @@ Optional properties:
>  - tx-threshold: Specify the TX FIFO low water indication for parts with
>    programmable TX FIFO thresholds.
>  - resets : phandle + reset specifier pairs
> +- rts-gpios:
> +- cts-gpios:
> +- dtr-gpios:
> +- dsr-gpios:
> +- rng-gpios:
> +- dcd-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
> +  line respectively. It will use specified GPIO instead of the peripheral
> +  function pin for the UART feature. If unsure, don't specify this property.

These are already described in serial.txt.

> +  If "wakeup-source" property is specified for the device this GPIO
> +  initialization will be aborted.

Why? Many GPIOs can function as wake-up sources. You would need get the 
IRQ for the GPIO. Also, some UARTs wake-up from the RX line. Not sure 
about any 8250 flavors, but is probably implementation specific what is 
the trigger for wake-up.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
