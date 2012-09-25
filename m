From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints
Date: Mon, 24 Sep 2012 17:48:07 -0700
Message-ID: <878vbzj5bs.fsf@deeprootsystems.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet-l0cyMroinI0@public.gmane.org> (Jean Pihet's
	message of "Thu, 20 Sep 2012 18:08:03 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org> writes:

> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
>
> Signed-off-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>

Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
