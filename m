From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 07/10] I2C: OMAP: Handle error check for pm runtime
Date: Mon, 28 May 2012 16:52:50 +0530
Message-ID: <4FC3600A.7010407@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com> <1335969135-20858-8-git-send-email-shubhrajyoti@ti.com> <87likfkjar.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87likfkjar.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 26 May 2012 03:36 AM, Kevin Hilman wrote:
>> +	r = pm_runtime_get_sync(dev->dev);
>> > +	if (r < 0)
>> > +		return r;
> nit: please use IS_ERR_VALUE() 
Will fix that and resend.
> Kevin
