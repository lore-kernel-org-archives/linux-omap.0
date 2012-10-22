From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/8] i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
Date: Mon, 22 Oct 2012 14:27:20 +0200
Message-ID: <50853BA8.8000200@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <1350899218-13624-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350899218-13624-6-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 10/22/2012 11:46 AM, Felipe Balbi wrote:
> on OMAP4+ we want to read IRQSTATUS_RAW register,
> instead of IRQSTATUS. The reason being that IRQSTATUS
> will only contain the bits which were enabled on
> IRQENABLE_SET and that will break when we need to
> poll for a certain bit which wasn't enabled as an
> IRQ source.
> 
> One such case is after we finish converting to
> deferred stop bit, we will have to poll for ARDY
> bit before returning control for the client driver
> in order to prevent us from trying to start a
> transfer on a bus which is already busy.
> 
> Note, however, that omap-i2c.c needs a big rework
> on register definition and register access. Such
> work will be done in a separate series of patches.

Do you need OMAP_I2C_IP_VERSION_3 for OMAP4?

OMAP_I2C_IP_VERSION_2 was already introduced to detect OMAP3630 vs
omap4430 because they were sharing the same IP version..

/* I2C controller revisions present on specific hardware */
#define OMAP_I2C_REV_ON_2430            0x36
#define OMAP_I2C_REV_ON_3430_3530       0x3C
#define OMAP_I2C_REV_ON_3630_4430       0x40

So in theory you should not need an extra version.

Regards,
Benoit
