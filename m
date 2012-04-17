From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 04/18] I2C: OMAP: I2C register restore only if context
 is lost
Date: Tue, 17 Apr 2012 20:38:40 +0530
Message-ID: <CAM=Q2cvGFgNtvCX=TXAioAUKH9z+VzeKW2ZHhpxUC+s2_yS1QA@mail.gmail.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com>
	<1334235995-6727-5-git-send-email-shubhrajyoti@ti.com>
	<87d376zd2v.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d376zd2v.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Kevin,
Thanks for your review,

On Tue, Apr 17, 2012 at 7:15 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
>> =A0Currently i2c register restore is done always.
>> =A0Adding conditional restore.
>> =A0The i2c register restore is done only if the context is lost.
>
> OK, minor comment below.
>
>> =A0Also remove the definition of SYSS_RESETDONE_MASK and use the
>> =A0one in omap_hwmod.h.
>
> The definition is removed, but I don't see any of the users removed.
> If the users were cleaned up earlier in the series, then the removal =
of
> this should be done with that, or as a separate patch. =A0I don't see=
 why
> it belongs with this patch.

I have not removed the users actually the macro was redefined.
I have instead used the definition in omap_hwmod.h which gets added
when I include omap_device.h

Let me know if you prefer a  separate patch?

>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0| =A0 =A03 ++
>> =A0drivers/i2c/busses/i2c-omap.c | =A0 52 ++++++++++++++++++++++++++=
--------------
>> =A0include/linux/i2c-omap.h =A0 =A0 =A0| =A0 =A01 +
>> =A03 files changed, 38 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
>> index db071bc..4ccab07 100644
>> --- a/arch/arm/plat-omap/i2c.c
>> +++ b/arch/arm/plat-omap/i2c.c
>> @@ -179,6 +179,9 @@ static inline int omap2_i2c_add_bus(int bus_id)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (cpu_is_omap34xx())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->set_mpu_wkup_lat =3D omap_pm_set_=
max_mpu_wakeup_lat_compat;
>> +
>> + =A0 =A0 pdata->get_context_loss_count =3D omap_pm_get_dev_context_=
loss_count;
>> +
>> =A0 =A0 =A0 pdev =3D omap_device_build(name, bus_id, oh, pdata,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct omap_i2c_b=
us_platform_data),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0, 0);
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-=
omap.c
>> index a882558..45389db 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -43,6 +43,7 @@
>> =A0#include <linux/slab.h>
>> =A0#include <linux/i2c-omap.h>
>> =A0#include <linux/pm_runtime.h>
>> +#include <plat/omap_device.h>
>>
>> =A0/* I2C controller revisions */
>> =A0#define OMAP_I2C_OMAP1_REV_2 =A0 =A0 =A0 =A0 0x20
>> @@ -157,9 +158,6 @@ enum {
>> =A0#define OMAP_I2C_SYSTEST_SDA_I =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =
1) =A0 =A0 =A0 =A0/* SDA line sense in */
>> =A0#define OMAP_I2C_SYSTEST_SDA_O =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =
0) =A0 =A0 =A0 =A0/* SDA line drive out */
>>
>> -/* OCP_SYSSTATUS bit definitions */
>> -#define SYSS_RESETDONE_MASK =A0 =A0 =A0 =A0 =A0(1 << 0)
>> -
>> =A0/* OCP_SYSCONFIG bit definitions */
>> =A0#define SYSC_CLOCKACTIVITY_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 <=
< 8)
>> =A0#define SYSC_SIDLEMODE_MASK =A0 =A0 =A0 =A0 =A0(0x3 << 3)
>> @@ -184,6 +182,7 @@ struct omap_i2c_dev {
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 latency; =A0=
 =A0 =A0 =A0/* maximum mpu wkup latency */
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*set_mpu_wk=
up_lat)(struct device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long latency);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*get_context_=
loss_count)(struct device *dev);
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed; =A0 =A0=
 =A0 =A0 =A0/* Speed of bus in kHz */
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dtrev; =A0 =A0=
 =A0 =A0 =A0/* extra revision from DT */
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags;
>> @@ -206,6 +205,7 @@ struct omap_i2c_dev {
>> =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syscstate;
>> =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 westate;
>> =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errata;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_lost_count=
;
>> =A0};
>>
>> =A0static const u8 reg_map_ip_v1[] =3D {
>> @@ -1025,6 +1025,7 @@ omap_i2c_probe(struct platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->speed =3D pdata->clkrate;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->flags =3D pdata->flags;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->set_mpu_wkup_lat =3D pdata->set_mpu=
_wkup_lat;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->get_context_loss_count =3D pdata->get=
_context_loss_count;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dtrev =3D pdata->rev;
>> =A0 =A0 =A0 }
>>
>> @@ -1151,12 +1152,32 @@ omap_i2c_remove(struct platform_device *pdev=
)
>> =A0}
>>
>> =A0#ifdef CONFIG_PM_RUNTIME
>> +static void omap_i2c_restore(struct omap_i2c_dev *dev)
>> +{
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate)=
;
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate)=
;
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>> + =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN)=
;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Don't write to this register if the IE state is 0 as =
it can
>> + =A0 =A0 =A0* cause deadlock.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dev->iestate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, d=
ev->iestate);
>> +
>> +}
>> =A0static int omap_i2c_runtime_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev)=
;
>> =A0 =A0 =A0 struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev)=
;
>> =A0 =A0 =A0 u16 iv;
>>
>> + =A0 =A0 if (_dev->get_context_loss_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 _dev->dev_lost_count =3D _dev->get_context=
_loss_count(dev);
>> +
>> =A0 =A0 =A0 _dev->iestate =3D omap_i2c_read_reg(_dev, OMAP_I2C_IE_RE=
G);
>> =A0 =A0 =A0 if (_dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_IP_V2_=
IRQENABLE_CLR, 1);
>> @@ -1179,24 +1200,19 @@ static int omap_i2c_runtime_resume(struct de=
vice *dev)
>> =A0{
>> =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev)=
;
>> =A0 =A0 =A0 struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev)=
;
>> + =A0 =A0 int loss_cnt;
>>
>> - =A0 =A0 if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG,=
 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG,=
 _dev->pscstate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG=
, _dev->scllstate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG=
, _dev->sclhstate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG,=
 _dev->bufstate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG=
, _dev->syscstate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, =
_dev->westate);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG,=
 OMAP_I2C_CON_EN);
>> + =A0 =A0 if (_dev->get_context_loss_count) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 loss_cnt =3D _dev->get_context_loss_count(=
dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (loss_cnt < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return loss_cnt;
>
> To avoid messing up driver state, upon error, you should probably
> restore context, not abort.
Agreed , will fix this.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (_dev->dev_lost_count =3D=3D loss_cnt &=
& _dev->dev_lost_count)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Why the non-zero check?

Actually the driver probe-->omap_i2c_init

here
<snip>
                dev->pscstate =3D psc;
                dev->scllstate =3D scll;
                dev->sclhstate =3D sclh;
                dev->bufstate =3D buf;
<snip>

variables are updated and the first write happens in the handler.

>
> Seems like all you need to check is if (_dev->dev_lost_count !=3D los=
s_cnt).
>
> Kevin
>
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Don't write to this register if the IE state is 0 as =
it can
>> - =A0 =A0 =A0* cause deadlock.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 if (_dev->iestate)
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, =
_dev->iestate);
>> + =A0 =A0 if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_restore(_dev);
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
>> index 92a0dc7..c76cbc0 100644
>> --- a/include/linux/i2c-omap.h
>> +++ b/include/linux/i2c-omap.h
>> @@ -35,6 +35,7 @@ struct omap_i2c_bus_platform_data {
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 rev;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 flags;
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*set_mpu_wkup_lat)(struct d=
evice *dev, long set);
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*get_context_loss_count)(stru=
ct device *dev);
>> =A0};
>>
>> =A0#endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
