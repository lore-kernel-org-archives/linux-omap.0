From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3] i2c: omap: Move the remove constraint
Date: Sat, 17 Nov 2012 23:15:18 +0530
Message-ID: <CAM=Q2cuX4j1uELVOurtSuDfN3CtEn3VejYUdMS24yaO7ru=Mdg@mail.gmail.com>
References: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
	<20121116142006.GG7313@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121116142006.GG7313-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 16, 2012 at 7:50 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Nov 15, 2012 at 02:19:21PM +0530, Shubhrajyoti D wrote:
>> Currently we just queue the transfer and release the
>> qos constraints, however we do not wait for the transfer
>> to complete to release the constraint. Move the remove
>> constraint after the bus busy as we are sure that the
>> transfers are completed by then.
>>
>> Acked-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> Applied to for-next. Please let me know if it should go to for-current.

I feel for-next should be fine.

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
