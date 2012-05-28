From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
Date: Mon, 28 May 2012 15:29:18 +0530
Message-ID: <4FC34C76.402@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com> <1335969135-20858-3-git-send-email-shubhrajyoti@ti.com> <87wr3zkjp7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wr3zkjp7.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 26 May 2012 03:27 AM, Kevin Hilman wrote:
> Looks right.
>
> Can you be more specific in the changelog about when the errors/warning
> happens?
By the way the count cribs Unbalanced pm_runtime_enable!
is what happens.

I found it by review, I did the testing with this patch.

Since there was an access without get_sync I was seeing
some other issues.

Did not test with the fix and without this patch.
>   e.g. why pm_runtime_enable() is called again?  Is this on
> module unload/reload?
>
> Other than that
>
> Acked-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Thanks.
