From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/17] Big OMAP I2C Cleanup
Date: Thu, 14 Jun 2012 16:53:50 +0530
Message-ID: <CAMQu2gxG9ojz4fCCwdYQY8oYZyv0vu9oDuvhuPFVdY29F6w5=g@mail.gmail.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339669250-9183-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi guys,
>
> I have dropped a few patches from the series and also
> tested every single patch on my pandaboard. I2C messages
> are still working fine with panda after each patch.
>
> There's still lots of work to be done on the i2c-omap.c
> driver but it's now easier to read, IMO.
>
Great cleanup. Have reviewed the entire series based on
limited knowledge i have about the OMAP i2c driver.
Apart from those comments, the series looks good to me.

We may to take similar dig at MMC and SPI driver one day :-p

Regards
santosh
