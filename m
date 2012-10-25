From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/7] i2c: omap: wait for transfer completion before
 sending STP bit
Date: Thu, 25 Oct 2012 18:31:58 +0530
Message-ID: <50893846.3020106@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <1351167915-15079-1-git-send-email-balbi@ti.com> <1351167915-15079-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351167915-15079-6-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> Later patches will come adding support for
> reporting amount of bytes transferred so that
> client drivers can count how many bytes are
> left to transfer.
>
> This is useful mostly in case of NACKs when
> client driver wants to know exactly which
> byte got NACKed so it doesn't have to resend
> all bytes again.
>
> In order to make that work with OMAP's I2C
> controller, we need to prevent sending STP
> bit until message is transferred. The reason
> behind that is because OMAP_I2C_CNT_REG gets
> reset to original value after STP bit is
> shifted through I2C_SDA line and that would
> prevent us from reading the correct number of
> bytes left to transfer.
>
> The full programming model suggested by IP
> owner was the following:
>
> - start I2C transfer (without STP bit)
> - upon completion or NACK, read I2C_CNT register
> - write STP bit to I2C_CON register
> - wait for ARDY bit
>
> With this patch we're implementing all steps
> except step #2 which will come in a later
> patch adding such support.
>
Will this not break the bisect since CNT and
NACK, completion is added in later patch

> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
Apart from above, rest of the change follow
the change log and looks fine tome. The
change is quite drastic so hopefully it
has gone through wider testing.

Regards
santosh
