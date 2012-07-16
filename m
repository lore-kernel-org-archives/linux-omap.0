From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH RFT 1/2] regulator: twl: Fix the formula to calculate
 vsel and voltage for twl6030ldo
Date: Mon, 16 Jul 2012 14:41:06 +0530
Message-ID: <5003DAAA.2070301@ti.com>
References: <1341804151.14367.1.camel@phoenix> <1341831686.4343.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:60480 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751122Ab2GPJLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 05:11:13 -0400
Received: by obbuo19 with SMTP id uo19so8036657obb.25
        for <linux-omap@vger.kernel.org>; Mon, 16 Jul 2012 02:11:12 -0700 (PDT)
In-Reply-To: <1341831686.4343.7.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>

Hi Axel,

My apologies for the delay in responding to this one.

On Monday 09 July 2012 04:31 PM, Axel Lin wrote:
> =E6=96=BC =E4=B8=80=EF=BC=8C2012-07-09 =E6=96=BC 11:22 +0800=EF=BC=8C=
Axel Lin =E6=8F=90=E5=88=B0=EF=BC=9A
>> In twl6030ldo_set_voltage, current code use below formula to calcula=
te vsel:
>>          vsel =3D (min_uV/1000 - 1000)/100 + 1;
>> This is worng because when min_uV is 1000000 uV, vsel is 1.
>> It should be 0 in this case.

Why? Do you know of any documentation which states this?
I am referring to the twl6030 Top Functional spec version 1.18
and Table - 223 "LDO Output Voltage Selection Code" clearly
states that the vsel should be 1 when voltage expected is 1000000 uV.

Also refer to equation 3 "LDO Output Voltage Selection Code" in the
same document and you will see this mentioned..
Absolute Voltage value =3D 1.0V + 0.1V * (binary value =E2=80=93 000000=
01)

>> Fix it by change the equation to: (This equation is common for linea=
r mapping)
>>          vsel =3D DIV_ROUND_UP(min_uV - rdev->desc->min_uV, rdev->de=
sc->uV_step);
>>
>> In twl6030ldo_get_voltage, current code use below formula to calcula=
te voltage:
>>          mV =3D 1000mv + 100mv * (vsel - 1)
>> This is worng because when vsel is 0, mV is 900mV. Note the min_uV i=
s 1000mV.
>> Fix it by change the equation to: (This equation is common for linea=
r mapping)
>>          return rdev->desc->min_uV + vsel * rdev->desc->uV_step;
>
> While I'm thinking I need to rework this patch so that it doesn't use
> rdev->desc->min_uV and rdev->desc->uV_step and then can be applied
> to current Linus' tree.
>
> But while I am tracking back to commit 3e3d3be79c
> Author: Rajendra Nayak<rnayak@ti.com>
> Date:   Thu Apr 22 14:18:32 2010 +0530
>
>      twl6030: regulator: Remove vsel tables and use formula for
> calculation
>
>      All twl6030 regulators can be programmed from 1.0v to 3.3v
>      with 100mV steps.
>      The below formula can be used to calculate the vsel values
>      to be programmed in the VREG_VOLTAGE registers.
>
>      Voltage(in mV) =3D 1000mv + 100mv * (vsel - 1)
>
>      Ex: if vsel =3D 0x9, mV =3D 1000 + 100 * (9 -1) =3D 1800mV.
>
>      This patch removes all existing VSEL tables for twl6030 adjustab=
le
>      regulators and just uses the formula directly for vsel calculati=
ons
>      after verifing they fall in the allowed range.
>
>      Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> I found a problem that before commit 3e3d3be79c, the voltage tables w=
ere
> not linear mapping. So why we can convert these voltage mapping table=
 to
> Voltage(in mV) =3D 1000mv + 100mv * (vsel - 1)?
>
> Did I miss something?

All voltage tables before commit '3e3d3be79c' for twl6030 regulators
were clearly wrong. They assumed similarity with twl4030 regulators
which was not right.

regards,
Rajendra

>
> Regards,
> Axel
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
