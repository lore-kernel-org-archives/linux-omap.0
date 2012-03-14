From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Wed, 14 Mar 2012 22:08:17 +0100
Message-ID: <4F6108C1.2060004@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com> <1330707024-23730-2-git-send-email-b-cousson@ti.com> <87pqcegapk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56695 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758550Ab2CNVI0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 17:08:26 -0400
In-Reply-To: <87pqcegapk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

On 3/14/2012 9:59 PM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> From: Felipe Balbi<balbi@ti.com>
>>
>> With sparse IRQs the driver shouldn't depend at all on
>> any IRQ values coming from board-file.
>>
>> Remove every occurences of pdata->irq_base/end.
>
> Well, not quite *every*. :)

Hehe, good catch, thanks.

> If the driver isn't going to use those fields anymore, they should also
> be removed from the pdata struct too[1].  Also, the remaining board/init
> code that is initializing those fields should be removed as well[2], since
> it obviously has no effect.
>
> The first patch below should probably be folded into this one, and then
> the 2nd patch removes all the users.

We should probably remove all the users before removing the attribute? 
It looks like your patches are ordered in the opposite way.

I'll add that in the series and repost the pull request.

Regards,
Benoit

>
> Kevin
>
> [1]
>  From 70a1833ca20142ef5b6b96dbc92a63c7f8ef9a04 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman<khilman@ti.com>
> Date: Wed, 14 Mar 2012 13:55:31 -0700
> Subject: [PATCH 1/2] mfd: twl-core: remove pdata->irq_base/end
>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   include/linux/i2c/twl.h |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 2463b61..fa76006 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -697,7 +697,6 @@ struct twl4030_audio_data {
>   };
>
>   struct twl4030_platform_data {
> -	unsigned				irq_base, irq_end;
>   	struct twl4030_clock_init_data		*clock;
>   	struct twl4030_bci_platform_data	*bci;
>   	struct twl4030_gpio_platform_data	*gpio;

