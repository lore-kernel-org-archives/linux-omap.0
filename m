From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Sun, 28 Oct 2012 09:41:05 +0530
Message-ID: <508CB059.8000203@ti.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com> <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com> <508BBC59.60504@ti.com> <alpine.DEB.2.00.1210271545390.16409@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1210271545390.16409-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 27 October 2012 09:29 PM, Paul Walmsley wrote:
> On Sat, 27 Oct 2012, Santosh Shilimkar wrote:
>
>> Another alternative, which I will recommend to just make use of the
>> read*/wrire* instead __raw versions. The barriers are taken care
>> already and driver point of view, it is transparent.
>
> Those barriers will disappear if CONFIG_ARM_DMA_MEM_BUFFERABLE is set to
> N, so that's probably not the right thing to do in this case.  The barrier
> here isn't DMA-related, it's needed due to the design of the driver.
>
Good point.

> In fact the wmb() is probably overkill, since only a compiler reordering
> barrier is needed.  It can probably just be barrier().
>
I agree. Just barrier() is enough to avoid compiler re-ordering.

Regards
Santosh
