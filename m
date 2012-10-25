From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: omap: make reset a seperate function
Date: Thu, 25 Oct 2012 19:17:28 +0530
Message-ID: <508942F0.7060100@ti.com>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com> <1351160586-12306-3-git-send-email-shubhrajyoti@ti.com> <20121025105516.GH21217@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121025105516.GH21217-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 25 October 2012 04:25 PM, Felipe Balbi wrote:

>  overflow, underflow
these are data errors personally feel may be removed.

>  and arbitration lost) 
will investigate.
> and try to make sure if
> actually need to reset the controller all the time. I find it really odd
> that we're always resetting the IP in every error condition without
> actually trying to figure out what's wrong with the driver (if there is
> something wrong with the driver, of course).
