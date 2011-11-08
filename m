From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Tue, 08 Nov 2011 12:01:38 -0800
Message-ID: <8762iu1izh.fsf@ti.com>
References: <1320333428-23532-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1320333428-23532-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Thu, 3 Nov 2011 20:47:08 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Ben Dooks

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> Currently the fifo depth is set to zero for OMAP4 which disables
> the FIFO usage. This patch enables the FIFO usage for I2C transactions
> on OMAP4 also.
>
> Tested on omap4430 and 3430.
>
> Tested-and-Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Ben, please queue as a fix for the v3.2-rc.  It applies cleanly to
v3.2-rc1.

If you prefer a branch:
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/i2c

Thanks,

Kevin
