From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
Date: Wed, 11 Apr 2012 18:40:45 +0530
Message-ID: <CAM=Q2ct=_VEGkv9Rfu5_YNn250qcS=gMoQNCEC1nnsNbnPdc2g@mail.gmail.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
	<1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
	<20120411113537.GG12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411113537.GG12064-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Wed, Apr 11, 2012 at 5:05 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
>> Use SET_RUNTIME_PM_OPS macro to set runtime functions.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 11 ++++-------
>> =A01 files changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index dd65416..28de1d2 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct de=
vice *dev)
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> +#endif
>>
>> =A0static struct dev_pm_ops omap_i2c_pm_ops =3D {
>> - =A0 =A0 .runtime_suspend =3D omap_i2c_runtime_suspend,
>> - =A0 =A0 .runtime_resume =3D omap_i2c_runtime_resume,
>> + =A0 =A0 SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_i2c_runtime_re=
sume, NULL)
>> =A0};
>> -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
>> -#else
>> -#define OMAP_I2C_PM_OPS NULL
>> -#endif
>
> I think you should keep this define, otherwise the pm pointer will
> always be valid.

Will correct it .
Thanks,

>
> --
> balbi
