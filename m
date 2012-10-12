From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC
 when idle
Date: Sat, 13 Oct 2012 01:00:04 +0530
Message-ID: <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350067225-24589-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 13, 2012 at 12:10 AM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>
> Currently, runtime PM is used to keep the device enabled only during
> active transfers and for a configurable runtime PM autosuspend timout
> after an xfer.
>
> In addition to idling the device, driver's ->runtime_suspend() method
> currently disables device interrupts when idle.  However, on some SoCs
> (notably OMAP4+), the I2C hardware may shared with other coprocessors.
> This means that the MPU will still recieve interrupts if a coprocessor
> is using the I2C device.  To avoid this, also disable interrupts at
> the MPU INTC when idling the device in ->runtime_suspend() (and
> re-enable them in ->runtime_resume().)  This part based on an original
> patch from Shubhrajyoti Datta.  NOTE: for proper sharing the I2C with
> a coprocessor, this driver still needs hwspinlock support added.
>
> This change is also meant to address an issue reported by Kalle
> Jokiniemi where I2C bus interrupt may be enabled before an I2C device
> interrupt handler (e.g. just after noirq resume phase) causing an
> interrupt flood on the I2C bus interrupt before the device interrupt
> is enabled (e.g. interrupts coming from devices on I2C connected PMIC
> before the PMIC chained hanlder is enabled.)  This problem is addresed
> by ensuring that the I2C bus interrupt left disabled until an I2C xfer
> is requested.

Looks good to me.
Will wait for Kalle though.

>
> Cc: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
> Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Cc: Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>,
> Cc: Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..e6413e8 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1255,6 +1255,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>                 /* Flush posted write */
>                 omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
>         }
> +       disable_irq(_dev->irq);
>
>         return 0;
>  }
> @@ -1275,6 +1276,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
>                 omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>         }
>
> +       enable_irq(_dev->irq);
> +
>         /*
>          * Don't write to this register if the IE state is 0 as it can
>          * cause deadlock.
> --
> 1.7.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
