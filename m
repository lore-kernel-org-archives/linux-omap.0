From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 2/3] OMAP: I2C: Remove the reset in the init path
Date: Fri, 2 Dec 2011 15:48:04 -0600
Message-ID: <4ED94794.2000705@ti.com>
References: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com> <1322817674-25384-3-git-send-email-shubhrajyoti@ti.com> <4ED94536.2080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ED94536.2080307-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Richard Woodruff <r-woodruff2-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Shubhrajyoti,

On 12/2/2011 15:37, Jon Hunter wrote:

[snip]
>> @@ -594,6 +545,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter
>> *adap,
>> return r;
>> if (r == 0) {
>> dev_err(dev->dev, "controller timed out\n");
>> + if (dev->device_reset) {
>> + r = dev->device_reset(dev->dev);
>> + if (r< 0)
>> + dev_err(dev->dev, "reset failed\n");
>> + }
>> omap_i2c_init(dev);
>
> Why put the reset here? The function omap_i2c_init is going to perform a
> soft reset. So why not replace the reset in that function?
>
> Furthermore does this work for omap1 devices? I think that you would
> need to remove the existing soft-reset from omap_i2c_init() into an omap1.

Sorry, I see you did remove the soft-reset in the omap_i2c_init(). 
However, why not just replace the reset in the omap_i2c_init() instead 
of moving it?

As for omap1, I see we don't perform a soft-reset so that is a don't care.

Cheers
Jon
