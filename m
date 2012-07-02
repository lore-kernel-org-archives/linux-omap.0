From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 06/17] i2c: omap: split out [XR]DR and [XR]RDY
Date: Mon, 2 Jul 2012 17:30:02 +0530
Message-ID: <CAM=Q2cu+OBAEWvx_jPZXi2Z_9xrzWdh1T8fZ96xiz2Wbo_RbtA@mail.gmail.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
	<1340964817-8599-7-git-send-email-shubhrajyoti@ti.com>
	<20120702115620.GD2730@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120702115620.GD2730-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 2, 2012 at 5:26 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Jun 29, 2012 at 03:43:26PM +0530, Shubhrajyoti D wrote:
>> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>
>> While they do pretty much the same thing, there
>> are a few peculiarities. Specially WRT erratas,
>> it's best to split those out and re-factor the
>> read/write loop to another function which both
>> cases call.
>>
>> This last part will be done on another patch.
>>
>> While at that, also avoid an unncessary register
>> read since dev->fifo_len will always contain the
>> correct amount of data to be transferred.
>
> this statement isn't valid anymore, but I'd like it to be. See below
>
>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |  126 ++++++++++++++++++++++++++++++----------
>>  1 files changed, 94 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 359ee08..45bd731 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -820,36 +820,64 @@ complete:
>>                       return IRQ_HANDLED;
>>               }
>>
>> -             if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>> +             if (stat & OMAP_I2C_STAT_RDR) {
>>                       u8 num_bytes = 1;
>>
>> +                     if (dev->fifo_size)
>> +                             num_bytes = (omap_i2c_read_reg(dev,
>> +                                             OMAP_I2C_BUFSTAT_REG) >> 8)
>> +                                             & 0x3F;
>
> I wanted to avoid reading registers if we don't have to. This value will
> be sitting in dev->buf_len.

Yes will fix this and resend.

>
> --
> balbi
