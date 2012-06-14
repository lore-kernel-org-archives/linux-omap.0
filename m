From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 15/17] i2c: omap: always return IRQ_HANDLED
Date: Thu, 14 Jun 2012 16:48:56 +0530
Message-ID: <CAMQu2gzbK+ObetarwRiEz9A7=awEffAhrMMAqSMfiv4H6BZAuw@mail.gmail.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com> <1339669250-9183-16-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339669250-9183-16-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> otherwise we could get our IRQ line disabled due
> to many spurious IRQs.
>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index fc5b8bc..5b78a73 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1015,7 +1015,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} while (stat);
>
> - =A0 =A0 =A0 return count ? IRQ_HANDLED : IRQ_NONE;
> + =A0 =A0 =A0 return IRQ_HANDLED;

no sure if this is correct. if you have IRQ flood and instead of _actua=
lly_
handling it, if you return handled, you still have interrupt pending, r=
ight?

 if (count++ =3D=3D 100) {
                        dev_warn(dev->dev, "Too much work in one IRQ\n"=
);
                        break;
                }
ofcourse we do get warning message already, so as such the change
should be fine.

Just want to understand the change bit more.

Regards
Santosh



Regards
santosh
