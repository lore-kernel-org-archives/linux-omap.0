From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 14/16] OMAP2+: UART: Take console_lock in suspend path
 if not taken
Date: Thu, 13 Oct 2011 06:41:37 +0530
Message-ID: <CAAL8m4zacdFDLKSe67_4-pLPZN2Sxp92OaFvre2oxXJZW-+z_w@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <1317380561-661-5-git-send-email-govindraj.raja@ti.com> <87sjmz1hfm.fsf@ti.com>
 <CAAL8m4zrveqqS3vq=dqMkS2gT24_=1UO+ukbxnQVf+AX4TBaVQ@mail.gmail.com> <87mxd5n55y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87mxd5n55y.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 13, 2011 at 5:17 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Wed, Oct 12, 2011 at 12:31 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> In suspend path the console_lock is taken by uart_port_suspend
>>>> however when no_console_suspend is used console_lock is not taken.
>>>>
>>>> During system wide suspend omap_pwr_domain hooks cut all
>>>> clocks that are left enabled. So its unsafe to proceed printing af=
ter
>>>> clocks are cut by pwr_domain hooks.
>>>
>>> As I've mentioned in previous reviews, when no_console_suspend is
>>> enabled, the user has explicitly requested console output during
>>> suspend. =A0In order to support that, we should not be cutting cloc=
ks at
>>> all in that mode.
>>>
>>> One way to address this would be to just disable runtime PM in the
>>> ->prepare method of the driver if no_console_suspend is enabled.
>>>
>>
>> Okay fine exploring this option, right API's would be to use
>> pm_runtime_forbid/allow.
>
> Yes.
>
>> <<SNIP>>
>>
>> +static int serial_omap_runtime_prepare(struct device *dev)
>> +{
>> + =A0 =A0 =A0 if (!console_suspend_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_forbid(dev);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void serial_omap_runtime_complete(struct device *dev)
>> +{
>> + =A0 =A0 =A0 if (!console_suspend_enabled)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_allow(dev);
>> +}
>> +
>> =A0static const struct dev_pm_ops serial_omap_dev_pm_ops =3D {
>> =A0 =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_=
omap_resume)
>> =A0 =A0 =A0 =A0 SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seri=
al_omap_runtime_resume, NULL)
>> + =A0 =A0 =A0 .prepare =3D serial_omap_runtime_prepare,
>> + =A0 =A0 =A0 .complete =3D =A0serial_omap_runtime_complete,
>> =A0};
>
> OK, but please add comments to these functions about exactly why they
> are needed.
>
>>
>> But to either use runtime forbid or disable we have ensure that
>> power_domain hooks don't go ahead and disable
>> the clocks with omap_device_idle as *runtime forbid or disable will
>> not set runtime_status to RPM_SUSPENDED*
>> and will stay in RPM_ACTIVE if we call runtime disable or forbid fro=
m
>> active state.
>
> Correct.
>
>> in power_domain hooks we just check the pm_runtime_status_suspended
>> this will be false even if
>> we do runtime disable/forbid and it will cut uart clocks always.
>>
>> So we may need below check also:
>>
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
>> index 26aee5c..286a534 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -592,7 +592,8 @@ static int _od_suspend_noirq(struct device *dev)
>>
>> =A0 =A0 =A0 =A0 ret =3D pm_generic_suspend_noirq(dev);
>>
>> - =A0 =A0 =A0 if (!ret && !pm_runtime_status_suspended(dev)) {
>> + =A0 =A0 =A0 if (!ret && pm_runtime_enabled(dev) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !pm_runtime_status_sus=
pended(dev)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_generic_runtime_suspend(dev) =
=3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_idle(pde=
v);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->flags |=3D OMAP_=
DEVICE_SUSPENDED;
>
> This isn't right either because devices that may not yet be initializ=
ed
> (or loaded) may not have runtime PM enabled, so those devices may not
> be properly idled.
>
> We have an omap_device API to disable this feature at the PM domain l=
evel:
> omap_device_disable_idle_on_suspend(). =A0All you should have to do i=
s to
> use this API in the device init code on the console UART if
> no_console_suspend has been enabled.


Yes seems okay to me,

Will check if no_console_suspend is used then set
omap_device_disable_idle_on_suspend
in serial.c.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
