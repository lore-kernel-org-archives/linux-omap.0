From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints
Date: Fri, 21 Sep 2012 11:50:52 +0530
Message-ID: <CAM=Q2ct+6g1WR-U5e+s=ySAypnkc2SO4kKtDPmTsau+mx1HmbA@mail.gmail.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 20, 2012 at 9:38 PM, Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org> wrote:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
Agree thanks for doing that.

>
> Signed-off-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
> ---
> Rebased on git://git.pengutronix.de/git/wsa/linux.git, branch
> i2c-embedded/for-next
thanks ,
tested with i2c tools  on omap4sdp and omap3sdp

Acked-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

> ---
>  arch/arm/plat-omap/i2c.c      |   21 ---------------------
>  drivers/i2c/busses/i2c-omap.c |   32 ++++++++++++++++++--------------
>  include/linux/i2c-omap.h      |    1 -
>  3 files changed, 18 insertions(+), 36 deletions(-)
>
