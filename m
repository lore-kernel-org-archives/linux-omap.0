From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/13] tty: serial: omap: switch over to platform_get_resource
Date: Wed, 23 Apr 2014 12:27:59 -0300
Message-ID: <CAOMZO5AUn7FsUXbY4NBfkZyZUbRNm3hcP3DC6vOYHi89xbaVYw@mail.gmail.com>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
	<1398265117-11793-8-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398265117-11793-8-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 23, 2014 at 11:58 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:

> @@ -1658,12 +1657,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>                 omap_up_info = of_get_uart_port_info(&pdev->dev);
>                 pdev->dev.platform_data = omap_up_info;
>         } else {
> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -               if (!irq) {
> -                       dev_err(&pdev->dev, "no irq resource?\n");
> -                       return -ENODEV;
> -               }
> -               uartirq = irq->start;
> +               uartirq = platform_get_irq(pdev, 0);
> +               if (uartirq < 0)
> +                       return -EPROBE_DEFER;


Maybe you could just do a 'return uartirq' here instead.
