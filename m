From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Thu, 18 Apr 2013 15:47:39 +0300
Message-ID: <516FEB6B.80100@ti.com>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com> <87sj2rbguv.fsf@linaro.org> <516D46CC.3080705@ti.com> <20130416190703.19887.10780@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34212 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab3DRMsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 08:48:17 -0400
In-Reply-To: <20130416190703.19887.10780@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

On 04/16/2013 10:07 PM, Mike Turquette wrote:
> Quoting Andrii Tseglytskyi (2013-04-16 05:40:44)
>> On 04/16/2013 12:53 AM, Kevin Hilman wrote:
>>> In addition to Mike's comments (which I completely agree with), it =
would
>>> be very helfpul to see how this is actually used.  e.g, how the
>>> regulators are chained together, how the proper ordering is managed=
,
>>> etc. etc.
>> We would like to handle voltage scaling in the following way:
>>
> I expanded the example below to include the SR AVS regulator.
>
>> cpufreq_cpu0
>> clk_set_rate(cpu0)
>>       |
>>       |-->set_voltage(ABB regulator)
>>                   |
>>                   |-->set_voltage(AVS)
>>                              |
>>                              |-->set_voltage(smps123 regulator)
> Hi Andrii,
>
> Why was regulator chaining chosen over a simple sequence of calls to
> regulator_set_voltage?  Instead of nested calls into the regulator
> framework, why don't you just make the calls serially?  E.g:
>
> regulator_set_voltage(abb_reg, foo_volt);
> regulator_set_voltage(avs_reg, bar_volt);
> regulator_set_voltage(smps123_reg, baz_volt);
>
> It is still to be determined where these calls originate from; maybe
> from clock notifiers, maybe directly from the cpufreq driver's .targe=
t()
> callback, or maybe somewhere else.  Regardless, I do not see why
> regulator chaining is truly necessary here.  You are just calling
> regulator_set_voltage in sequence on a few regulators, right?
>
> I think it would help me a lot to understand why regulator chaining i=
s a
> requirement for this to work properly.
>
> Thanks,
> Mike
Hi Mike, Kevin

I'd like to provide some explanation regarding proposed TI DVFS design=20
which we
would like to follow (regulator chaining is part of it).
The following two patch series was intended to prove the possibility of=
 its
implementation:
   - this one  'ARM: OMAP3+: Introduce ABB driver"
   - and http://www.spinics.net/lists/linux-omap/msg90022.html -
      [RFC v1 0/1] introduce regulator chain locking scheme
but, seems, we started to make it public from "tail" instead of 'head"
  - sorry for that.

While trying to move forward with TI DVFS we've taken into account foll=
owing
major points:
- only DT should be used to configure DVFS;
- no xxx_initcall, cpu_is_xx() function should be used;
- DVFS should be scalable  to fit wide SoC/platform=E2=80=99s and
   multiplatform kernel requirements;
- minimize creation of TI specific API;

Now, there are two entry points for DVFS in kernel:
- CPUFreq - currently it's been decided to use cpufreq-cpu0 for
   all OMAPs in Main line;
- CCF callbacks - have RFC DVFS implementation introduced here
   http://lwn.net/Articles/540422/.

In both cases, the only one regulator need to be provided for CCF
or CPUFreq for voltage changing proposes, so DVFS can done
in the following way:

   |------------|   |------------|
--| RegulatorY |<--|     DVFS   |
   |------------|   |------------|
    \           \
     \           \_____________________________
      \                                        \
      |-------------------|  |---------------|  |---------|
    --| RegulatorX (PMIC) |--| Regulator AVS |--| ABB LDO |--
      |-------------------|  |---------------|  |---------|
         /|\                     |
          |______________________|
          Voltage adjustment


1) The following use-cases have been taken into account:
- SoC/Platform don't need ABB/AVS (supports MPU OPPLOW/OPPNOM for examp=
le) -
   any regulator (VC-VP/I2C/SPI/GPIO ..) may be connected to DVFS
- SoC/Platform need ABB -
   build chain in DT device->CCF->abb_regulator->any=20
regulator(VC-VP/I2C/SPI..)
- SoC/Platform need ABB+AVS -
   build chain in DT device->CCF->abb_regulator->avsX->any=20
regulator(VC-VP/I2C..)

2) Implementation of each part of Voltage scale chain as Regulator will=
=20
allow:
- add each item one by one;
- don't expose too much of custom TI API;
- handle multi-voltage scaling requests to one rail (ganged rails)=20
automatically
  (handled by regulator FW already).

3) The "regulator chaining" will allow:
- easily configure DVFS form DT depending on current SoC/platform needs
   (using xxx-supply standard binding in DT);
- continue use cpufreq-cpu0 for all OMAP to scale MPU domain;
- use RFC DVFS implementation from http://lwn.net/Articles/540422/ for =
other
   domains (with some modifications - the most difficult thing will be=20
multi-freq
   requests handling to one clock).

In case, if "regulator chaining" approach is not accepted:
- yes, it's possible to create some "Super" TI regulator which will
   handle ABB+AVS+VC/VP for most of current TI SoCs.

- No, for the newest TI SoCs (like DRA7xxx without VC/VP) any regulator=
=20
can be
   used as power supply (I2C/SPI/GPIO) and ABB is needed.
   a) As result, it will be impossible to use cpufreq-cpu0 driver for i=
t,
   at least, and will need to drop cpufreq-cpu0 support for OMAPs
   and roll-back to omap-cpufreq.

   b) for other domains it's possible to create omap_dvfs.c in the simi=
lar
   way as it done in dvfs.c and hack it to handle ABB+AVS+I2C regulator=
=2E

- will need to add custom TI bindings to handle SoC/Platform dependent
configuration;

Thanks for you time.

Regards
-grygorii
>>
>> This simple model will be extended to handle AVS as a part of the ch=
ain.
>> smps123 regulator may be changed to VP/VC regulator.
>>
>> Following example is from integration branch, which already has smps=
123
>> regulator.
>> It demonstrates an example of linkage to chain. ABB regulator is lin=
ked
>> with smps123 and cpu0 inside device tree.
>> cpu0 calls set_voltage() function for ABB, and then ABB calls
>> set_voltage() function for smps123 to do actual voltage scaling.
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.=
dtsi
>> index bb5ee70..c8cbbee 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -36,7 +36,7 @@
>>           cpus {
>>                   cpu@0 {
>>                           compatible =3D "arm,cortex-a15";
>> -                       cpu0-supply =3D <&smps123_reg>;
>> +                       cpu0-supply =3D <&abb_mpu>;
>>                           operating-points =3D <
>>                                   /* kHz    uV */
>>                                   /* Only for Nominal Samples */
>> @@ -94,6 +94,7 @@
>>                   reg =3D <0x4ae07cdc 0x8>,
>>                         <0x4ae06014 0x4>;
>>                   ti,tranxdone_status_mask =3D <0x80>;
>> +               avs-supply =3D <&smps123_reg>;
>>                   operating-points =3D <
>>                           /* uV   ABB */
>>                           880000  0
>>
>> This RFC patch series is verified together with:
>> https://patchwork.kernel.org/patch/2445091/
>>
>> Kevin, what do you think about this model in general? Does it fit to
>> regulator framework?
>>
>> Thank you.
>>
>> Regards,
>> Andrii
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
