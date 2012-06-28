From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
Date: Thu, 28 Jun 2012 16:55:08 -0500
Message-ID: <87lij7nltv.fsf@ti.com>
References: <1340761532-27231-1-git-send-email-khilman@ti.com>
	<CAM=Q2cuLCT2VzcUgrpyRWiX61t1F+iWchO9iLC=Ka9MFVm4_bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cuLCT2VzcUgrpyRWiX61t1F+iWchO9iLC=Ka9MFVm4_bQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Shubhrajyoti Datta's message of "Wed, 27 Jun 2012 11:41:47 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Shubhrajyoti,

Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Hi Kevin,
> Thanks for the patch ,
> a doubt below

Thanks for the review.

> On Wed, Jun 27, 2012 at 7:15 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>> In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
>> failure.
> So the failure means that the usecount is incremented. However the
> device was not
> enabled.=20

Correct.

> In that case could we consider
>
>    void pm_runtime_put_noidle(struct device *dev);
>     - decrement the device's usage counter
>
> Which will only decrement the counter and does not try to disable it.

No, that is not needed.

> However I am not sure what happens if you try to disable an already
> disabled device.

The runtime PM core already knows that the device is not enabled so wil=
l
not need to call the disable hooks.  It already needs this functionalit=
y
to support the _get_noresume() and _put_noidle() calls.

I tested this on 3730/OveroSTORM where I was seeing this i2c xfer
failure (and thus a failure in MMC suspend, which uses I2C to control
the regulator.)

Hope that helps clarify,

If so, Wolfram, can you queue this up in your i2c-embedded/for-next
branch since this problem was introduced there.

Thanks,

Kevin

>>
>> Without this, after a failed xfer, the runtime PM usecount will have
>> been incremented, but not decremented
>
> Agree.
>
>> causing the usecount to never
>> reach zero after a failure. =C2=A0This keeps the device always runti=
me PM
>> enabled which keeps the enclosing power domain active, and prevents
>> full-chip retention/off from happening during idle.
>>
>> Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> ---
>> This patch applies to current i2c-embedded/for-next branch
>>
>> =C2=A0drivers/i2c/busses/i2c-omap.c | =C2=A0 =C2=A02 +-
>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index 9895fa7..b105733 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -582,7 +582,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D pm_runtime_get_sync(dev->dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR_VALUE(r))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omap_i2c_wait_for_bb(dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r < 0)
>> --
>> 1.7.9.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
