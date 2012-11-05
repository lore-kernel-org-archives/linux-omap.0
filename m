From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 3/7] i2c: omap: remove the dtrev
Date: Mon, 5 Nov 2012 14:14:48 +0530
Message-ID: <50977C80.8090000@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com> <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com> <20121105075320.GD32468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121105075320.GD32468-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 05 November 2012 01:23 PM, Felipe Balbi wrote:
> Hi,
>
> On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
>> The dtrev is used only for the comments. Remove the same and use
>> the scheme instead to know if it is version2.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> I would drop dtrev completely and not use scheme to "emulate" it.
However for ver2 ie omap4plus and previous versions the
register map is different.

So the scheme may still be required.
>  dtrev
> is wrong and unnecessary; it was only created due to the wrong
> assumption that HW revision register was wrong. Looks like that
> assumption was made based on the driver which is clearly wrong wrt
> revision detection.
>
> Also, when dropping dtrev, also drop it from platform_data and
> omap_hwmod database (could be done on a separate patch).
OK would do that.
>
