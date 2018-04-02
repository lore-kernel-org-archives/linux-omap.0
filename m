From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
Date: Mon, 2 Apr 2018 17:01:22 +0300
Message-ID: <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
References: <20180402122037.2710-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402122037.2710-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 2, 2018 at 3:20 PM, Vignesh R <vigneshr@ti.com> wrote:

> +       pm_runtime_get_sync(dev);

> +       if (!device_may_wakeup(dev))
> +               priv->wer = 0;

Can it be

priv->wer = device_may_wakeup(dev);

?

> +       serial_out(up, UART_OMAP_WER, priv->wer);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);

-- 
With Best Regards,
Andy Shevchenko
