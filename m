From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
Date: Mon, 25 Jul 2011 11:59:10 -0500
Message-ID: <CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com> <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36585 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776Ab1GYQ7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 12:59:30 -0400
Received: by mail-gy0-f176.google.com with SMTP id 11so2626131gyb.7
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 09:59:30 -0700 (PDT)
In-Reply-To: <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin <khilman@ti.com>, Colin <ccross@google.com>, l-a <linux-arm-kernel@lists.infradead.org>, l-o <linux-omap@vger.kernel.org>

On Mon, Jul 25, 2011 at 03:42, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Sun, Jul 24, 2011 at 11:52:37AM -0500, Nishanth Menon wrote:
>> SmartReflex should be disabled while entering low power mode due to
>> the following reasons:
>> a) SmartReflex values are not defined for retention voltage.
>> b) With SmartReflex enabled, if the CPU enters low power state, FSM
>> =A0 =A0will try to bump the voltage to current OPP's voltage for whi=
ch
>> =A0 =A0it has entered low power state, causing power loss and potent=
ial
>> =A0 =A0unknown states for the SoC.
>> Since we are sure to attempt entering the lowest possible power stat=
e
>> during suspend operation, SmartReflex needs to be disabled for the
>> voltage domains in suspend path before achieving auto retention volt=
age
>> on the device.
>>
>> Traditionally, this has been done with interrupts disabled as part o=
f
>> the common code which handles the idle sequence. Instead, by using t=
he
>> fact that we have to disable SmartReflex for sure during suspend
>> operations, we can opportunistically disable SmartReflex in device
>> standard pm ops, instead of disabling it as part of the code which
>> executes with interrupts disabled and slave CPU{s} shutdown. This
>> allows the system to do other parallel activities(such as suspending
>> other devices in the system using slave CPU{s}) and save the time
>> required to achieve suspend and resume from suspended state as a
>> sequential activity.
>>
>> However, by being opportunistic as described above, we also increase
>> the likelihood of SmartReflex library access functions being invoked=
 in
>> parallel contexts *after* SmartReflex driver's suspend handler (duri=
ng
>> suspend operation) or *before* resume handler (during resume operati=
on)
>> have been invoked (Example: DVFS for dependent devices, cpufreq for
>> MPU etc.). We prevent this by using a flag to reject the callers in
>> the duration where SmartReflex has been disabled.
>
> while at that, SR's IRQ is never freed on exit path, could fix it whi=
le
> you're already there ?

This is not really related to this patch is it? IMHO IRQ handling is
broken badly. Current support is for SmartReflex class3 - which does
not use the IRQ, Class2 and Class1.5 use it, but the current code
requires major fixes which I dont intend to support in this series.

>
>> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct pl=
atform_device *pdev)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static int omap_sr_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct omap_sr_data *pdata;
>> + =A0 =A0 struct omap_sr *sr_info;
>> +
>> + =A0 =A0 pdata =3D dev_get_platdata(dev);
>
> I'm not sure you need to use platform data here...
see below
>
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: platform data missing\n"=
, __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sr_info =3D _sr_lookup(pdata->voltdm);
>
> this field is held on struct omap_sr. Can't you:
>
> =A0 =A0 =A0 =A0struct omap_sr =A0*info =3D dev_get_drvdata(dev);
>
> ?? I see that a platform_set_drvdata() is missing from the driver, bu=
t
> maybe you should add that instead of accessing platform_data.
omap_sr_data is added in arch/arm/mach-omap2/sr_device.c

With the current handling - it needs sr_data from which sr_info is
pulled out. in the current implementation, sr_data contains the voltdm
pointer from which sr_info is pulled out.

>
>> =A0static struct platform_driver smartreflex_driver =3D {
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D omap_sr_remove,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "smartreflex",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &omap_sr_dev_pm_ops,
>
> this should not be valid in case CONFIG_PM isn't enabled.
a) arch/arm/plat-omap/Kconfig
CONFIG_OMAP_SMARTREFLEX depends on PM.
b) SmartReflex is PM feature

I dont see a need to add redundant code here.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
