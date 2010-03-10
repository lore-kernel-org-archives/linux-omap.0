From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Wed, 10 Mar 2010 10:04:41 -0800
Message-ID: <87k4tkf3ye.fsf@deeprootsystems.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
	<6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
	<20100109183321.GH2879@atomide.com>
	<6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
	<20100112012814.GK5055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100112012814.GK5055-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message of "Mon\, 11 Jan 2010 17\:28\:15 -0800")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> * Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100109 10:34]:
>> On Sat, Jan 9, 2010 at 10:33 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> >
>> > Let's plan on adding this into omap-testing branch next week so
>> > we can make sure things are OK for the other platforms.
>> >
>> > Then assuming no issues, let's ask Ben can queue it.
>> >
>> 
>> Excellent, thank you!
>
> Applied to omap-testing with the following fix. Can you please merge
> it into your original patch?

Unfortunately, Tony's additional fix did not make it into the version
that was merged to mainline, which results in a crash during
probe when using v2.6.34-rc1.

Ben, can you queue the fix below from Tony for -rc2?

Kevin


>
> Tony
> From 5b640a850de9fb87b9e9e6dd2cfeb7144ada8053 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 11 Jan 2010 17:22:21 -0800
> Subject: [PATCH] i2c-omap: Fix reg_shift init
>
> Otherwise register access won't work during probe
> for omap_i2c_unidle.
>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 913abd7..9c3ce4d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -894,6 +894,12 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev->idle = 1;
>  	dev->dev = &pdev->dev;
>  	dev->irq = irq->start;
> +
> +	if (cpu_is_omap7xx())
> +		dev->reg_shift = 1;
> +	else
> +		dev->reg_shift = 2;
> +
>  	dev->base = ioremap(mem->start, resource_size(mem));
>  	if (!dev->base) {
>  		r = -ENOMEM;
> @@ -925,11 +931,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		dev->b_hw = 1; /* Enable hardware fixes */
>  	}
>  
> -	if (cpu_is_omap7xx())
> -		dev->reg_shift = 1;
> -	else
> -		dev->reg_shift = 2;
> -
>  	/* reset ASAP, clearing any IRQs */
>  	omap_i2c_init(dev);
>  
