From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: Kconfig help descriptions
Date: Thu, 21 Jul 2011 16:49:32 +0530
Message-ID: <CAJ6a13bGkxkWbqQ_=GrFBmyBRZxk5TA-w+UCN5wU3HAVBw_3xQ@mail.gmail.com>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk>
	<20110721095702.GP23253@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60748 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964Ab1GUL1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:27:34 -0400
Received: by mail-iw0-f170.google.com with SMTP id 36so1783423iwn.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 04:27:33 -0700 (PDT)
In-Reply-To: <20110721095702.GP23253@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, balbi@ti.com

Hello Russel,

MADC stands for monitoring ADC. It is part of TWL4030 power IC.
TWL4030 is only on OMAP3 and hence not applicable for OMAP4.

The driver is split accross mfd and hwmon. Generic ADC
reading part is in mfd and exposing the individual ADC channel
sysfs nodes is part of hwmon. I apologize for missing this
information in KConfig help. I will post a patch to update this.

On Thu, Jul 21, 2011 at 3:27 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Jul 21, 2011 at 10:22:21AM +0100, Russell King - ARM Linux wr=
ote:
>> Some of the Kconfig help descriptions aren't very useful - for examp=
le:
>>
>> | CONFIG_TWL4030_MADC:
>> |
>> | This driver provides support for triton TWL4030-MADC. The
>> | driver supports both RT and SW conversion methods.
>> |
>> | This driver can be built as a module. If so it will be
>> | named twl4030-madc
>>
>> What is madc? =A0What does it do? =A0Do I enable it for the OMAP 443=
0SDP ?
>
> the problem seems to be worse then you thought:
>
> $ git ls-files drivers/ =A0| grep madc
> drivers/hwmon/twl4030-madc-hwmon.c
> drivers/mfd/twl4030-madc.c
>
> Both from the same author:
>
> $ git grep -e MODULE_AUTHOR drivers/mfd/twl4030-madc.c drivers/hwmon/=
twl4030-madc-hwmon.c
> drivers/hwmon/twl4030-madc-hwmon.c:MODULE_AUTHOR("J Keerthy");
> drivers/mfd/twl4030-madc.c:MODULE_AUTHOR("J Keerthy");
>
> but added on different commits:
>
> commit f99c1d4f94f91fd3a20bd2eaa3be9c5e7d2668eb
> Author: Keerthy <j-keerthy@ti.com>
> Date: =A0 Tue Mar 1 19:12:26 2011 +0530
>
> =A0 =A0mfd: Add twl4030 madc driver
>
> =A0 =A0Introducing a driver for MADC on TWL4030 powerIC. MADC stands =
for monitoring
> =A0 =A0ADC. This driver monitors the real time conversion of analog s=
ignals like
> =A0 =A0battery temperature, battery cuurent etc.
>
> =A0 =A0Signed-off-by: Keerthy <j-keerthy@ti.com>
> =A0 =A0Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>
> commit 0070bddfe7275e5bc763884a8ac59651f4e79eab
> Author: Keerthy <j-keerthy@ti.com>
> Date: =A0 Tue Mar 1 19:12:36 2011 +0530
>
> =A0 =A0hwmon: twl4030: Hwmon Driver for TWL4030 MADC
>
> =A0 =A0This driver exposes the sysfs nodes of the TWL4030 MADC module=
=2E
> =A0 =A0All the voltage channel values are expressed in terms of mV. C=
hannel 13
> =A0 =A0and channel 14 are reserved. There are channels which represen=
t
> =A0 =A0temperature and current the output is represented by celcius
> =A0 =A0and mA respectively.
>
> =A0 =A0Signed-off-by: Keerthy <j-keerthy@ti.com>
> =A0 =A0Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> =A0 =A0Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
>
>
> --
> balbi
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
