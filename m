From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: Move the remove constraint
Date: Wed, 14 Nov 2012 16:55:34 +0530
Message-ID: <50A37FAE.9050004@ti.com>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com> <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com> <20121114105734.GE5954@pengutronix.de> <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 14 November 2012 04:33 PM, Jean Pihet wrote:
>>> Acked-by: Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>
>> >
>> > Since I just reverted the QoS patch, I suppose this gets merged into the
>> > original patch when resent?
> The best for now is to re-submit a new patch that moves the constraint
> release in the original code. Later the PM QoS patch will be applied
> on the new code base.
>
> What do you think? I can provide a patch if needed.
Will resubmit this.

> Regards,
> Jean
>
