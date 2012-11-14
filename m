From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: Move the remove constraint
Date: Wed, 14 Nov 2012 12:03:35 +0100
Message-ID: <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg@mail.gmail.com>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
	<CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
	<20121114105734.GE5954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121114105734.GE5954-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Wolfram, Shubhrajyoti,

On Wed, Nov 14, 2012 at 11:57 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
>> > Currently we just queue the transfer and release the
>> > qos constraints, however we donot wait for the transfer
>> > to complete to release the constraint. Move the remove
>> > constraint after the bus busy as we are sure that the
>> > transfers are completed by then.
>> >
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>
>> Good catch, the change definitely makes sense. Feel free to add:
>>
>> Acked-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
>
> Since I just reverted the QoS patch, I suppose this gets merged into the
> original patch when resent?
The best for now is to re-submit a new patch that moves the constraint
release in the original code. Later the PM QoS patch will be applied
on the new code base.

What do you think? I can provide a patch if needed.

Regards,
Jean

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
