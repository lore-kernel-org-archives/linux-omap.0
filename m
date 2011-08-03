From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Wed, 03 Aug 2011 11:26:26 -0700
Message-ID: <87ty9y5p2l.fsf@ti.com>
References: <1312360088-3117-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312360088-3117-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Wed, 3 Aug 2011 13:58:08 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

[adding Ben Dooks, in the future, please be sure to put maintainers To/Cc]

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Currently for OMAP4 the I2C_WE is not programmed.
> This patch enables the programming for OMAP4.
>
> This patch fixes a bad conflict resolution.
> This effectively restores the following commit
>
> Commit 120bdaa47[i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup]
>
> which got changed by
>
> Commit a3a7acbc[I2C: OMAP2+: address confused probed version naming]
>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Reported-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> TODO:
> Currently all the wakeup sources are enabled.
> There is scope of optimising the same. Will revisit it.
> Rebased on for_3.1/i2c-andy

Thanks, adding to my for_3.1/i2c-fixes queue for v3.1-rc.

Ben, with your ack, I'm willing to queue these.

Kevin
