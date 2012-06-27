From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/11] I2C: OMAP: Handle error check for pm runtime
Date: Wed, 27 Jun 2012 14:31:45 +0530
Message-ID: <CAM=Q2cuBh-YT454T7ZtqkcOSCGQLT5Ehp=J8rvj+6=0Gzct84Q@mail.gmail.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
	<1338288983-15026-8-git-send-email-shubhrajyoti@ti.com>
	<874npxv8aj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874npxv8aj.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 27, 2012 at 7:13 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
>> If PM runtime get_sync fails return with the error
>> so that no further reads/writes goes through the interface.
>> This will avoid possible abort. Add a error message in case
>> of failure with the cause of the failure.
>>
>> Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> This patch introduced a regression where the runtime PM usecount will
> never reach zero and so CORE retention is prevented after any xfer
> failures...
>
>> ---
>> -v10 Use IS_ERR_VALUE
>> -v9 Fix the error handling
>>
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 14 +++++++++++---
>> =A01 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index 44e8cfa..c39b72f 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
>> =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 int r;
>>
>> - =A0 =A0 pm_runtime_get_sync(dev->dev);
>> + =A0 =A0 r =3D pm_runtime_get_sync(dev->dev);<
>> + =A0 =A0 if (IS_ERR_VALUE(r))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>
> This return should be 'goto out' so the runtime PM usecount is
> decremented by the 'put'. =A0Otherwise, after failure, the usecount
> remains non-zero, so the device is considered 'active' and keeps the
> containing power domain active.
>
> I found this on a 3730/OveroSTORM where the suspend/resume of MMC fai=
ls
> because I2C is already suspended. =A0After the suspend though, the CO=
RE
> powerdomain never again hits retention, and I tracked it down to this=
=2E
>
> I'll send a separate patch to fix this shortly.

Thanks,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
