From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Wed, 15 Nov 2017 16:54:33 +0100
Message-ID: <CAK8P3a3ZtqXVobx5hdxUZyAQRYs2Y6Aw2Qpo2puSBb_AVa_aVA@mail.gmail.com>
References: <cover.1510759152.git.hns@goldelico.com> <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e1525e72afe890ea390fd153c1f3a1b0866c986.1510759152.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 4:19 PM, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>
> Use serdev API hooks to monitor and forward the UART traffic to /dev/GPSn
> and turn on/off the module. It also detects if the module is turned on (sends data)
> but should be off, e.g. if it was already turned on during boot or power-on-reset.
>
> Additionally, rfkill block/unblock can be used to control an external LNA
> (and power down the module if not needed).
>
> The driver concept is based on code developed by NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> but simplified and adapted to use the new serdev API introduced in 4.11.
>
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>

I'm a bit confused by the concept here. Did I understand it right that this
attaches to a tty_port and then registers another tty_driver with one
tty_port for the first port?

> +static int w2sg_probe(struct serdev_device *serdev)
> +{
> +       struct w2sg_pdata *pdata = NULL;
> +       struct w2sg_data *data;
> +       struct rfkill *rf_kill;
> +       int err;
> +       int minor;
> +
> +       pr_debug("%s()\n", __func__);
> +
> +       minor = 0;
> +       if (w2sg_by_minor[minor]) {
> +               pr_err("w2sg minor is already in use!\n");
> +               return -ENODEV;
> +       }
> +
> +       if (serdev->dev.of_node) {
> +               struct device *dev = &serdev->dev;
> +               enum of_gpio_flags flags;
> +
> +               pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +               if (!pdata)
> +                       return -ENOMEM;

This looks like it's a leftover from pre-DT days, but it doesn't
actually work without DT in the current form. How about
merging the contents of w2sg_pdata into w2sg_data?

> +
> +       /* initialize the tty driver */
> +       data->tty_drv->owner = THIS_MODULE;
> +       data->tty_drv->driver_name = "w2sg0004";
> +       data->tty_drv->name = "ttyGPS";
> +       data->tty_drv->major = 0;
> +       data->tty_drv->minor_start = 0;
> +       data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
> +       data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
> +       data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
> +       data->tty_drv->init_termios = tty_std_termios;
> +       data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
> +                                             HUPCL | CLOCAL;
> +       /*
> +        * optional:
> +        * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
> +                                       115200, 115200);
> +        * w2sg_tty_termios(&data->tty_drv->init_termios);
> +        */
> +       tty_set_operations(data->tty_drv, &w2sg_serial_ops);

While I'm still not sure about why we want nested tty port, it
seems that we should have only one tty_driver that gets initialized
at module load time, rather than one driver structure per port.

> +       /* register the tty driver */
> +       err = tty_register_driver(data->tty_drv);
> +       if (err) {
> +               pr_err("%s - tty_register_driver failed(%d)\n",
> +                       __func__, err);
> +               put_tty_driver(data->tty_drv);
> +               goto err_rfkill;
> +       }
> +
> +       tty_port_init(&data->port);
> +       data->port.ops = &w2sg_port_ops;
> +
> +/*
> + * FIXME: this appears to reenter this probe() function a second time
> + * which only fails because the gpio is already assigned
> + */
> +
> +       data->dev = tty_port_register_device(&data->port,
> +                       data->tty_drv, minor, &serdev->dev);

This seems to be a result of having nested tty ports, and both
ports point to the same device.

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
